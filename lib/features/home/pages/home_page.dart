import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../models/theme_models.dart';
import '../../../models/timer_models.dart';
import '../../../models/task_models.dart';
import '../../settings/pages/settings_page.dart';
import '../../stats/pages/stats_page.dart';
import '../widgets/task_list_section.dart';

class FocusFlowHomePage extends StatefulWidget {
  const FocusFlowHomePage({super.key});

  @override
  State<FocusFlowHomePage> createState() => _FocusFlowHomePageState();
}

class _FocusFlowHomePageState extends State<FocusFlowHomePage> {
  // Tema
  FocusTheme _theme = FocusThemes.cosmic;

  // Zamanlama
  TimerConfig _config = const TimerConfig(
    focusMinutes: 25,
    shortBreakMinutes: 5,
    longBreakMinutes: 15,
  );

  PomodoroMode _mode = PomodoroMode.focus;

  late int _totalSeconds;
  late int _remainingSeconds;

  bool _isRunning = false;
  Timer? _ticker;

  // Oturum zamanları
  DateTime? _sessionStart;
  Duration _savedPaused = Duration.zero;
  DateTime? _currentPauseStart;
  final List<PauseEntry> _pauses = [];

  // History (istatistikler için)
  final List<FocusSession> _history = [];

  // Ayar seçenekleri
  AppLanguage _language = AppLanguage.tr;
  bool _autoStartBreaks = false;
  bool _autoStartNextFocus = false;
  bool _tickingSound = false;
  bool _alarmSound = true;

  // Alıntılar
  final Map<PomodoroMode, List<String>> _quotesByMode = {
    PomodoroMode.focus: [
      '"Focus is the gateway to mastery." — Cal Newport',
      '"Small steps every day."',
      '"Deep work beats busy work."',
      '"Well begun is half done." — Aristotle',
    ],
    PomodoroMode.shortBreak: [
      '"Rest is part of the work." — John Lubbock',
      '"Short break, long progress."',
      '"Breathe. Relax. Reset."',
    ],
    PomodoroMode.longBreak: [
      '"Sometimes the most productive thing is to relax." — Mark Black',
      '"Step back to come back stronger."',
    ],
  };

  String _currentQuote = "";

  // Tasks
  final List<FocusTask> _tasks = [];

  @override
  void initState() {
    super.initState();
    _resetForMode(_mode);
    _pickQuoteForMode(_mode);
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  // ───────────────────── TIMER LOGIC ─────────────────────

  void _startTickerIfNeeded() {
    if (_ticker != null) return;

    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      _onTick();
    });
  }

  void _onTick() {
    if (!_isRunning) return;

    if (_remainingSeconds <= 0) {
      _onSessionCompleted();
      return;
    }

    setState(() {
      _remainingSeconds--;
    });
  }

  void _resetForMode(PomodoroMode newMode) {
    _ticker?.cancel();
    _ticker = null;

    final seconds = _config.getSecondsForMode(newMode);

    setState(() {
      _mode = newMode;
      _totalSeconds = seconds;
      _remainingSeconds = seconds;
      _isRunning = false;

      _sessionStart = null;
      _savedPaused = Duration.zero;
      _currentPauseStart = null;
      _pauses.clear();
    });
  }

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });

    _sessionStart ??= DateTime.now();

    // Pause'tan dönüyorsak pause süresini ekle
    if (_currentPauseStart != null) {
      final now = DateTime.now();
      final d = now.difference(_currentPauseStart!);
      _savedPaused += d;

      final elapsedBeforePause = _totalSeconds - _remainingSeconds;

      _pauses.add(PauseEntry(
        timeLabel: "Paused at: ${_formatClockTime(_currentPauseStart!)}",
        durationSeconds: d.inSeconds,
        atSecond: elapsedBeforePause,
      ));

      _currentPauseStart = null;
    }

    _startTickerIfNeeded();
  }

  void _pauseTimer() {
    if (!_isRunning) return;

    setState(() {
      _isRunning = false;
      _currentPauseStart ??= DateTime.now();
    });
  }

  void _resetTimer() {
    _resetForMode(_mode);
    _pickQuoteForMode(_mode);
  }

  void _onSessionCompleted() {
    final end = DateTime.now();
    final start = _sessionStart ?? end;
    final total = end.difference(start);
    final paused = _totalPauseDuration;
    final focus = total - paused;

    final wallEff =
    total.inSeconds == 0 ? 1.0 : (focus.inSeconds / total.inSeconds);
    final score = (wallEff * 100).clamp(0, 100).round();

    final session = FocusSession(
      mode: _mode,
      startTime: start,
      endTime: end,
      totalSeconds: total.inSeconds,
      focusSeconds: focus.inSeconds,
      wastedSeconds: paused.inSeconds,
      pauses: List.unmodifiable(_pauses),
      focusScore: score,
    );

    setState(() {
      _isRunning = false;
      _ticker?.cancel();
      _ticker = null;
      _history.add(session);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _mode == PomodoroMode.focus
              ? "Focus session completed!"
              : "Break finished!",
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    if (_mode == PomodoroMode.focus && _autoStartBreaks) {
      _resetForMode(PomodoroMode.shortBreak);
      _pickQuoteForMode(PomodoroMode.shortBreak);
      _startTimer();
    } else if (_mode != PomodoroMode.focus && _autoStartNextFocus) {
      _resetForMode(PomodoroMode.focus);
      _pickQuoteForMode(PomodoroMode.focus);
      _startTimer();
    }
  }

  Duration get _totalPauseDuration {
    var d = _savedPaused;
    if (_currentPauseStart != null) {
      d += DateTime.now().difference(_currentPauseStart!);
    }
    return d;
  }

  double get _progress {
    if (_totalSeconds == 0) return 0;
    final done = _totalSeconds - _remainingSeconds;
    return (done / _totalSeconds).clamp(0.0, 1.0);
  }

  // ───────────────────── QUOTES ─────────────────────

  void _pickQuoteForMode(PomodoroMode mode) {
    final list = _quotesByMode[mode];
    if (list == null || list.isEmpty) {
      setState(() {
        _currentQuote = "";
      });
      return;
    }

    list.shuffle();
    setState(() {
      _currentQuote = list.first;
    });
  }

  void _onModeChipPressed(PomodoroMode mode) {
    if (_mode == mode) {
      _pickQuoteForMode(mode);
      return;
    }
    _resetForMode(mode);
    _pickQuoteForMode(mode);
  }

  // ───────────────────── TASKS ─────────────────────

  void _openAddTaskDialog() async {
    final controller = TextEditingController();
    final countController = TextEditingController();

    final result = await showDialog<Map<String, dynamic>?>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("New task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: "Task title",
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: countController,
                decoration: const InputDecoration(
                  labelText: "Target pomodoros (optional)",
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop<Map<String, dynamic>>(context, {
                  "title": controller.text.trim(),
                  "target": int.tryParse(countController.text.trim()),
                });
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );

    if (result == null) return;

    final title = result["title"] as String;
    if (title.isEmpty) return;
    final target = result["target"] as int?;

    setState(() {
      _tasks.add(
        FocusTask(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: title,
          targetPomodoros: target,
        ),
      );
    });
  }

  void _toggleTaskDone(String taskId) {
    setState(() {
      final index = _tasks.indexWhere((t) => t.id == taskId);
      if (index == -1) return;
      final t = _tasks[index];
      _tasks[index] = t.copyWith(isDone: !t.isDone);
    });
  }

  // ───────────────────── SETTINGS & STATS ─────────────────────

  Future<void> _openSettings() async {
    final result = await Navigator.of(context).push<SettingsResult>(
      MaterialPageRoute(
        builder: (_) => SettingsPage(
          theme: _theme,
          config: _config,
          language: _language,
          autoStartBreaks: _autoStartBreaks,
          autoStartNextFocus: _autoStartNextFocus,
          tickingSound: _tickingSound,
          alarmSound: _alarmSound,
        ),
      ),
    );

    if (result == null) return;

    setState(() {
      _theme = FocusThemes.all
          .firstWhere((t) => t.type == result.themeType);
      _config = result.config;
      _language = result.language;
      _autoStartBreaks = result.autoStartBreaks;
      _autoStartNextFocus = result.autoStartNextFocus;
      _tickingSound = result.tickingSound;
      _alarmSound = result.alarmSound;

      _resetForMode(_mode);
      _pickQuoteForMode(_mode);
    });
  }

  void _openStats() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => StatsPage(history: _history),
      ),
    );
  }

  // ───────────────────── UI HELPERS ─────────────────────

  String _formatTime(int sec) {
    final m = sec ~/ 60;
    final s = sec % 60;
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  String _formatClockTime(DateTime t) {
    int hour12 = t.hour % 12;
    if (hour12 == 0) hour12 = 12;

    final h = hour12.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    final s = t.second.toString().padLeft(2, '0');
    return "$h:$m:$s";
  }

  // ───────────────────── BUILD ─────────────────────

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_theme.bgTop, _theme.bgBottom],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  children: [
                    _buildTopBar(),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildTimerCard(size),
                            TaskListSection(
                              tasks: _tasks,
                              onAddTask: _openAddTaskDialog,
                              onToggleDone: _toggleTaskDone,
                              accentColor: _theme.accent,
                              cardColor: _theme.card.withOpacity(0.96),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────────── TOP BAR ─────────────────────

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: _theme.card.withOpacity(0.98),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Text(
            "FocusFlow",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const Spacer(),
          _topIcon(Icons.bar_chart_rounded, onTap: _openStats),
          const SizedBox(width: 8),
          _topIcon(Icons.settings, onTap: _openSettings),
        ],
      ),
    );
  }

  Widget _topIcon(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: _theme.innerCard,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  // ───────────────────── TIMER CARD ─────────────────────

  Widget _buildTimerCard(Size size) {
    final modeTitle = _mode == PomodoroMode.focus
        ? "Pomodoro"
        : _mode == PomodoroMode.shortBreak
        ? "Short Break"
        : "Long Break";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      decoration: BoxDecoration(
        color: _theme.card.withOpacity(0.98),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            blurRadius: 32,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Mod butonları
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _theme.innerCard,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              children: [
                _buildModeChip("Pomodoro", PomodoroMode.focus),
                _buildModeChip("Short Break", PomodoroMode.shortBreak),
                _buildModeChip("Long Break", PomodoroMode.longBreak),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Dairesel timer
          CircularPercentIndicator(
            radius: size.width * 0.32,
            lineWidth: 16,
            percent: _progress,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.white.withOpacity(0.08),
            progressColor: _theme.accent,
            center: Text(
              _formatTime(_remainingSeconds),
              style: const TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Mod başlığı
          Text(
            modeTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),

          // Quote
          if (_currentQuote.isNotEmpty)
            Text(
              _currentQuote,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),

          const SizedBox(height: 22),

          // Reset + START/PAUSE
          Row(
            children: [
              GestureDetector(
                onTap: _resetTimer,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _theme.innerCard,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.refresh_rounded,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: GestureDetector(
                  onTap: _isRunning ? _pauseTimer : _startTimer,
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      color: _isRunning ? Colors.white : _theme.accent,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: _theme.accent.withOpacity(0.45),
                          blurRadius: 22,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _isRunning ? "PAUSE" : "START",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _isRunning ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModeChip(String label, PomodoroMode mode) {
    final selected = _mode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onModeChipPressed(mode),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? _theme.accent : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
