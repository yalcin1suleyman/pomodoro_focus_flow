import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../models/theme_models.dart';
import '../../../models/timer_models.dart';
import '../../../models/task_models.dart';
import '../../settings/pages/settings_page.dart';
import '../../stats/pages/stats_page.dart';
import '../widgets/task_list_section.dart';
import '../../../core/localization/app_language.dart'; // ✅ DİL HELPER

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

    final msg = _mode == PomodoroMode.focus
        ? tt(_language, "Odak oturumu tamamlandı!", "Focus session completed!")
        : tt(_language, "Mola bitti!", "Break finished!");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
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
    final titleController = TextEditingController();
    final countController = TextEditingController();

    final result = await showDialog<Map<String, dynamic>?>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            tt(_language, "Yeni görev", "New task"),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText:
                  tt(_language, "Görev başlığı", "Task title"),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: countController,
                decoration: InputDecoration(
                  labelText: tt(
                    _language,
                    "Hedef pomodoro sayısı (opsiyonel)",
                    "Target pomodoros (optional)",
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: Text(
                tt(_language, "İptal", "Cancel"),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop<Map<String, dynamic>>(context, {
                  "title": titleController.text.trim(),
                  "target":
                  int.tryParse(countController.text.trim()),
                });
              },
              child: Text(
                tt(_language, "Ekle", "Add"),
              ),
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
      _theme =
          FocusThemes.all.firstWhere((t) => t.type == result.themeType);
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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

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
            child: isLandscape
                ? _buildLandscapeLayout(size)
                : ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: _buildPortraitLayout(size),
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────────── PORTRAIT LAYOUT ─────────────────────

  Widget _buildPortraitLayout(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        children: [
          _buildTopBar(),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTimerCard(size, isLandscape: false),
                  const SizedBox(height: 16),
                  TaskListSection(
                    language: _language,
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
    );
  }

  // ───────────────────── LANDSCAPE LAYOUT ─────────────────────

  Widget _buildLandscapeLayout(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        children: [
          _buildTopBar(),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: [
                // Sol: Timer alanı
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: _buildTimerCard(size, isLandscape: true),
                  ),
                ),
                const SizedBox(width: 20),
                // Sağ: Start/Reset + Tasks
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildStartResetRow(),
                      const SizedBox(height: 16),
                      Expanded(
                        child: TaskListSection(
                          language: _language,
                          tasks: _tasks,
                          onAddTask: _openAddTaskDialog,
                          onToggleDone: _toggleTaskDone,
                          accentColor: _theme.accent,
                          cardColor: _theme.card.withOpacity(0.96),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────── TOP BAR ─────────────────────

  Widget _buildTopBar() {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: SizedBox(
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                "FOCUS", // Logo gibi, sabit kalabilir
                style: theme.textTheme.titleLarge?.copyWith(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 8,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _topIcon(Icons.bar_chart_rounded, onTap: _openStats),
                  const SizedBox(width: 8),
                  _topIcon(Icons.settings, onTap: _openSettings),
                ],
              ),
            ),
          ],
        ),
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

  Widget _buildTimerCard(Size size, {required bool isLandscape}) {
    final theme = Theme.of(context);
    final shortestSide = size.shortestSide;
    final radius = isLandscape ? shortestSide * 0.26 : shortestSide * 0.32;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ÜST MOD BUTONLARI
          Row(
            children: [
              _buildModeChip(
                tt(_language, "Pomodoro", "Pomodoro"),
                PomodoroMode.focus,
              ),
              const SizedBox(width: 8),
              _buildModeChip(
                tt(_language, "Kısa Mola", "Short Break"),
                PomodoroMode.shortBreak,
              ),
              const SizedBox(width: 8),
              _buildModeChip(
                tt(_language, "Uzun Mola", "Long Break"),
                PomodoroMode.longBreak,
              ),
            ],
          ),
          const SizedBox(height: 24),

          CircularPercentIndicator(
            radius: radius,
            lineWidth: 18,
            percent: _progress,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.white.withOpacity(0.10),
            progressColor: _theme.accent,
            center: Text(
              _formatTime(_remainingSeconds),
              style: theme.textTheme.headlineLarge?.copyWith(
                fontFamily: 'SpaceGrotesk',
                fontSize: isLandscape ? 56 : 64,
                fontWeight: FontWeight.w700,
                letterSpacing: 6,
              ),
            ),
          ),
          const SizedBox(height: 20),

          if (_currentQuote.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                _currentQuote,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
            ),

          if (!isLandscape) ...[
            const SizedBox(height: 24),
            _buildStartResetRow(),
          ],
        ],
      ),
    );
  }

  // START / PAUSE + RESET satırı
  Widget _buildStartResetRow() {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: _isRunning ? _pauseTimer : _startTimer,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: _isRunning ? _theme.accent : Colors.white,
                border: Border.all(
                  color: _theme.accent,
                  width: 1.6,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isRunning
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    size: 18,
                    color: _isRunning ? Colors.white : _theme.accent,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isRunning
                        ? tt(_language, "DURAKLAT", "PAUSE")
                        : tt(_language, "BAŞLAT", "START"),
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color:
                      _isRunning ? Colors.white : _theme.accent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: _resetTimer,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _theme.innerCard.withOpacity(0.95),
              border: Border.all(
                color: Colors.white24,
                width: 1.2,
              ),
            ),
            child: const Icon(
              Icons.refresh_rounded,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModeChip(String label, PomodoroMode mode) {
    final selected = _mode == mode;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onModeChipPressed(mode),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color:
            selected ? Colors.white : Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: selected
                  ? Colors.white
                  : Colors.white.withOpacity(0.2),
              width: 1.4,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: selected ? _theme.accent : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
