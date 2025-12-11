import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:audioplayers/audioplayers.dart';

// Proje importları
import '../../../models/theme_models.dart';
import '../../../models/timer_models.dart';
import '../../../models/task_models.dart';
import '../../settings/pages/settings_page.dart';
import '../../stats/pages/stats_page.dart';
import '../widgets/task_list_section.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/content/quotes.dart';

class FocusFlowHomePage extends StatefulWidget {
  const FocusFlowHomePage({super.key});

  @override
  State<FocusFlowHomePage> createState() => _FocusFlowHomePageState();
}

class _FocusFlowHomePageState extends State<FocusFlowHomePage> {
  // ───────────────────── TASK-BOUND SESSION STATE ─────────────────────
  String? _activeTaskId;        // şu anki oturum hangi göreve bağlı
  int? _overrideFocusSeconds;   // görevten gelen custom süre (saniye)

  // ───────────────────── STATE ─────────────────────
  FocusTheme _theme = FocusThemes.cosmic;

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

  DateTime? _sessionStart;
  Duration _savedPaused = Duration.zero;
  DateTime? _currentPauseStart;
  final List<PauseEntry> _pauses = [];

  final List<FocusSession> _history = [];

  AppLanguage _language = AppLanguage.tr;
  bool _autoStartBreaks = false;
  bool _autoStartNextFocus = false;
  bool _tickingSound = false;
  bool _alarmSound = true;
  bool _useSystemNotification = false;

  final AudioPlayer _alarmPlayer = AudioPlayer();

  String _currentQuote = "";

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
    _alarmPlayer.dispose();
    super.dispose();
  }

  // ───────────────────── TIMER LOGIC ─────────────────────

  void _startTickerIfNeeded() {
    if (_ticker != null) return;

    // 1 saniyede bir tick
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

    final seconds = (newMode == PomodoroMode.focus && _overrideFocusSeconds != null)
        ? _overrideFocusSeconds!
        : _config.getSecondsForMode(newMode);

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

    if (_currentPauseStart != null) {
      final now = DateTime.now();
      final d = now.difference(_currentPauseStart!);
      _savedPaused += d;

      final elapsedBeforePause = _totalSeconds - _remainingSeconds;

      _pauses.add(
        PauseEntry(
          timeLabel: "Paused at: ${_formatClockTime(_currentPauseStart!)}",
          durationSeconds: d.inSeconds,
          atSecond: elapsedBeforePause,
        ),
      );

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

      // Göreve bağlı bir focus oturumu ise: görev ilerlemesini güncelle
      if (_mode == PomodoroMode.focus && _activeTaskId != null) {
        final index = _tasks.indexWhere((t) => t.id == _activeTaskId);
        if (index != -1) {
          final t = _tasks[index];
          final target = t.targetPomodoros ?? 0;
          if (target > 0) {
            final newCompleted =
            (t.completedPomodoros + 1).clamp(0, target);
            final done = newCompleted >= target;
            _tasks[index] = t.copyWith(
              completedPomodoros: newCompleted,
              isDone: done,
            );
          }
        }
      }

      // Oturum bitince görev bağını temizle
      _activeTaskId = null;
      _overrideFocusSeconds = null;
    });

    if (_alarmSound) {
      if (_useSystemNotification) {
        _showSystemNotification();
      } else {
        _playAlarm();
      }
    }

    final msg = _mode == PomodoroMode.focus
        ? tt(
      _language,
      "Odak oturumu tamamlandı!",
      "Focus session completed!",
    )
        : tt(
      _language,
      "Mola bitti!",
      "Break finished!",
    );

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

  // ───────────────────── GÖREV TABANLI BAŞLATMA ─────────────────────

  // Göreve tıklanınca çalışacak ana handler
  Future<void> _onTaskTap(FocusTask task) async {
    // Zaten sayaç çalışıyorsa yanlışlıkla tıklamayı engelle
    if (_isRunning) return;

    // Görev için geçerli bir hedef yoksa normal pomodoro başlat
    if (task.targetPomodoros == null ||
        task.targetPomodoros == 0 ||
        task.totalMinutes <= 0) {
      final shouldStart = await _showTaskCountdownDialog(task);
      if (!shouldStart) return;

      setState(() {
        _activeTaskId = null;
        _overrideFocusSeconds = null;
      });
      _resetForMode(PomodoroMode.focus);
      _pickQuoteForMode(PomodoroMode.focus);
      _startTimer();
      return;
    }

    // Geçerli hedef + toplam süre varsa: parçaya böl
    final remainingPomodoros =
    (task.targetPomodoros! - task.completedPomodoros)
        .clamp(0, task.targetPomodoros!);
    if (remainingPomodoros == 0) {
      // Zaten tamamlanmış
      return;
    }

    final chunkMinutes = _computeChunkMinutes(task);
    final shouldStart =
    await _showTaskCountdownDialog(task, minutes: chunkMinutes);
    if (!shouldStart) return;

    setState(() {
      _activeTaskId = task.id;
      _overrideFocusSeconds = chunkMinutes * 60;
    });

    _resetForMode(PomodoroMode.focus);
    _pickQuoteForMode(PomodoroMode.focus);
    _startTimer();
  }

  // Start butonuna basıldığında davranış
  Future<void> _onStartPressed() async {
    if (_isRunning) return;

    // Focus dışındaki modlarda veya hiç görev yoksa: direkt, ama yine de geri sayım ile
    if (_mode != PomodoroMode.focus || _tasks.isEmpty) {
      final dummy = FocusTask(
        id: 'none',
        title: tt(_language, "Görevsiz oturum", "Session without task"),
        totalMinutes: _config.focusMinutes,
      );
      final should = await _showTaskCountdownDialog(
        dummy,
        minutes: _config.focusMinutes,
      );
      if (!should) return;

      setState(() {
        _activeTaskId = null;
        _overrideFocusSeconds = null;
      });
      _resetForMode(_mode);
      _pickQuoteForMode(_mode);
      _startTimer();
      return;
    }

    // Görevler varsa: seçim sheet'i
    final choice = await showModalBottomSheet<_StartChoice>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return _StartChoiceSheet(
          language: _language,
          theme: _theme,
          tasks: _tasks,
        );
      },
    );

    if (choice == null) return;

    if (choice.withoutTask) {
      final dummy = FocusTask(
        id: 'none',
        title: tt(_language, "Görevsiz oturum", "Session without task"),
        totalMinutes: _config.focusMinutes,
      );
      final should = await _showTaskCountdownDialog(
        dummy,
        minutes: _config.focusMinutes,
      );
      if (!should) return;

      setState(() {
        _activeTaskId = null;
        _overrideFocusSeconds = null;
      });
      _resetForMode(PomodoroMode.focus);
      _pickQuoteForMode(PomodoroMode.focus);
      _startTimer();
    } else if (choice.task != null) {
      await _onTaskTap(choice.task!);
    }
  }

  // Görev için her pomodoro'nun süresini dakika olarak hesapla
  int _computeChunkMinutes(FocusTask task) {
    final target = task.targetPomodoros ?? 1;
    if (target <= 0) return _config.focusMinutes;
    if (task.totalMinutes <= 0) return _config.focusMinutes;

    final perChunk = (task.totalMinutes / target).round();
    return perChunk > 0 ? perChunk : _config.focusMinutes;
  }

  // 10 saniyelik geri sayım dialogu, kullanıcı iptal edebilir
  Future<bool> _showTaskCountdownDialog(FocusTask task, {int? minutes}) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return _CountdownDialog(
          taskTitle: task.title,
          minutes: minutes,
        );
      },
    ) ??
        false;
  }

  Future<void> _playAlarm() async {
    try {
      await _alarmPlayer.stop();
      await _alarmPlayer.play(
        AssetSource('sounds/ses1.wav'),
      );
    } catch (e) {
      debugPrint("Alarm play error: $e");
    }
  }

  Future<void> _showSystemNotification() async {
    final title = "FocusFlow";
    final body = _mode == PomodoroMode.focus
        ? tt(
      _language,
      "Odak oturumu tamamlandı!",
      "Focus session completed!",
    )
        : tt(
      _language,
      "Mola bitti!",
      "Break finished!",
    );
    debugPrint("System notification: $title - $body");
  }

  // ───────────────────── QUOTES & TASKS ─────────────────────

  void _pickQuoteForMode(PomodoroMode mode) {
    if (focusQuotes.isEmpty) {
      setState(() => _currentQuote = "");
      return;
    }

    final list = [...focusQuotes]..shuffle();
    final q = list.first;
    setState(() {
      _currentQuote = q.text(_language);
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

  /// Yeni görev ekleme / düzenleme için sheet
  void _openTaskSheet({FocusTask? editing}) async {
    final titleController = TextEditingController(
      text: editing?.title ?? "",
    );
    final targetController = TextEditingController(
      text: editing?.targetPomodoros?.toString() ?? "",
    );
    final minutesController = TextEditingController(
      text: (editing?.totalMinutes ?? 0) == 0
          ? ""
          : editing!.totalMinutes.toString(),
    );

    final result = await showModalBottomSheet<_TaskSheetResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 8,
          ),
          child: _TaskSheet(
            language: _language,
            accent: _theme.accent,
            isEditing: editing != null,
            titleController: titleController,
            targetController: targetController,
            minutesController: minutesController,
          ),
        );
      },
    );

    if (result == null) return;

    // silme
    if (result.delete && editing != null) {
      setState(() {
        _tasks.removeWhere((t) => t.id == editing.id);
      });
      return;
    }

    final title = titleController.text.trim();
    if (title.isEmpty) return;

    final target = int.tryParse(targetController.text.trim());
    final minutes = int.tryParse(minutesController.text.trim()) ?? 0;

    if (editing == null) {
      setState(() {
        _tasks.add(
          FocusTask(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            title: title,
            targetPomodoros: target,
            totalMinutes: minutes,
          ),
        );
      });
    } else {
      setState(() {
        final index = _tasks.indexWhere((t) => t.id == editing.id);
        if (index == -1) return;
        _tasks[index] = editing.copyWith(
          title: title,
          targetPomodoros: target,
          totalMinutes: minutes,
        );
      });
    }
  }

  void _toggleTaskDone(String taskId) {
    setState(() {
      final index = _tasks.indexWhere((t) => t.id == taskId);
      if (index == -1) return;
      final t = _tasks[index];
      _tasks[index] = t.copyWith(isDone: !t.isDone);
    });
  }

  // ───────────────────── SETTINGS & HELPERS ─────────────────────

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
          useSystemNotification: _useSystemNotification,
          onPreviewAlarm: _playAlarm,
        ),
      ),
    );

    if (result == null) return;

    setState(() {
      _theme = FocusThemes.all.firstWhere(
            (t) => t.type == result.themeType,
      );
      _config = result.config;
      _language = result.language;
      _autoStartBreaks = result.autoStartBreaks;
      _autoStartNextFocus = result.autoStartNextFocus;
      _tickingSound = result.tickingSound;
      _alarmSound = result.alarmSound;
      _useSystemNotification = result.useSystemNotification;

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

  // ───────────────────── BUILD (RESPONSIVE) ─────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_theme.bgTop, _theme.bgBottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;
              final isLandscape = width > height;
              final isTablet = width > 600 && !isLandscape;

              double timerRadius;
              if (isLandscape) {
                timerRadius = height * 0.35;
                if (timerRadius > 180) timerRadius = 180;
              } else {
                timerRadius = width * 0.38;
                if (timerRadius > 200) timerRadius = 200;
              }

              final double timerFontSize = timerRadius / 1.4;

              if (isLandscape) {
                return _buildLandscapeLayout(
                  width,
                  height,
                  timerRadius,
                  timerFontSize,
                );
              } else {
                return _buildPortraitLayout(
                  width,
                  height,
                  timerRadius,
                  timerFontSize,
                  isTablet,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // ───────────────────── PORTRAIT LAYOUT ─────────────────────

  Widget _buildPortraitLayout(
      double width,
      double height,
      double radius,
      double fontSize,
      bool isTablet,
      ) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isTablet ? 600 : 500),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
                children: [
                _buildTopBar(),
            const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildTimerCard(
                  radius,
                  fontSize,
                  isLandscape: false,
                  showControlsBelow: true,
                ),
                const SizedBox(height: 16),
                TaskListSection(
                  language: _language,
                  tasks: _tasks,
                  onAddTask: () => _openTaskSheet(),
                  onToggleDone: _toggleTaskDone,
                  onEditTask: (task) => _openTaskSheet(editing: task),
                  onTapTask: _onTaskTap,
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
    );
  }

  // ───────────────────── LANDSCAPE LAYOUT ─────────────────────

  Widget _buildLandscapeLayout(
      double width,
      double height,
      double radius,
      double fontSize,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          _buildTopBar(),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SOL: Timer + Modlar
                Expanded(
                  flex: 1,
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: _buildTimerCard(
                        radius,
                        fontSize,
                        isLandscape: true,
                        showControlsBelow: false, // butonlar sağda
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                // SAĞ: Start/Reset + Scrollable Görevler
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      _buildStartResetRow(),
                      const SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: TaskListSection(
                            language: _language,
                            tasks: _tasks,
                            onAddTask: () => _openTaskSheet(),
                            onToggleDone: _toggleTaskDone,
                            onEditTask: (task) =>
                                _openTaskSheet(editing: task),
                            onTapTask: _onTaskTap,
                            accentColor: _theme.accent,
                            cardColor: _theme.card.withOpacity(0.96),
                          ),
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

  // ───────────────────── COMMON WIDGETS ─────────────────────

  Widget _buildTopBar() {
    final theme = Theme.of(context);
    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            "FOCUS",
            style: theme.textTheme.titleLarge?.copyWith(
              fontFamily: 'SpaceGrotesk',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 8,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _topIcon(Icons.bar_chart_rounded, onTap: _openStats),
                const SizedBox(width: 12),
                _topIcon(Icons.settings, onTap: _openSettings),
              ],
            ),
          ),
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

  Widget _buildTimerCard(
      double radius,
      double fontSize, {
        required bool isLandscape,
        required bool showControlsBelow,
      }) {
    final theme = Theme.of(context);
    final double strokeWidth = (radius * 0.15).clamp(10.0, 25.0);

    final chipsRow = Row(
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
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLandscape)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: chipsRow,
          )
        else
          SizedBox(width: radius * 2.2, child: chipsRow),
        const SizedBox(height: 24),
        CircularPercentIndicator(
          radius: radius,
          lineWidth: strokeWidth,
          percent: _progress,
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.white.withOpacity(0.10),
          progressColor: _theme.accent,
          animation: true,
          animateFromLastPercent: true,
          animationDuration: 1000,
          center: Text(
            _formatTime(_remainingSeconds),
            style: theme.textTheme.headlineLarge?.copyWith(
              fontFamily: 'BarlowCondensed',
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              letterSpacing: 4,
              height: 1.0,
              color: Colors.white,
            ),
          ),
        ),
        if (_currentQuote.isNotEmpty) ...[
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                _currentQuote,
                key: ValueKey<String>(_currentQuote),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontFamily: 'SpaceGrotesk',
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
        if (showControlsBelow) ...[
          const SizedBox(height: 20),
          _buildStartResetRow(),
        ],
      ],
    );
  }

  Widget _buildStartResetRow() {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: _isRunning ? _pauseTimer : _onStartPressed,
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
                    size: 22,
                    color: _isRunning ? Colors.white : _theme.accent,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isRunning
                        ? tt(_language, "DURAKLAT", "PAUSE")
                        : tt(_language, "BAŞLAT", "START"),
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: _isRunning ? Colors.white : _theme.accent,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: _resetTimer,
          child: Container(
            width: 50,
            height: 50,
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
              size: 24,
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
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: selected ? Colors.white : Colors.white.withOpacity(0.2),
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

// ───────────────────── START CHOICE MODEL & SHEET ─────────────────────

class _StartChoice {
  final FocusTask? task;
  final bool withoutTask;

  const _StartChoice({this.task, this.withoutTask = false});
}

class _StartChoiceSheet extends StatelessWidget {
  final AppLanguage language;
  final FocusTheme theme;
  final List<FocusTask> tasks;

  const _StartChoiceSheet({
    required this.language,
    required this.theme,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty = tasks.isEmpty;
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: BoxDecoration(
          color: const Color(0xFF020617),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                tt(language, "Oturum başlat", "Start session"),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (!isEmpty)
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  separatorBuilder: (_, __) => const Divider(
                    height: 8,
                    color: Colors.white12,
                  ),
                  itemBuilder: (context, index) {
                    final t = tasks[index];
                    final progress = (t.targetPomodoros ?? 0) == 0
                        ? null
                        : "${t.completedPomodoros}/${t.targetPomodoros}";
                    return ListTile(
                      onTap: () =>
                          Navigator.pop(context, _StartChoice(task: t)),
                      title: Text(
                        t.title,
                        style: const TextStyle(fontSize: 14),
                      ),
                      subtitle: progress == null
                          ? null
                          : Text(
                        progress,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white70,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.play_arrow_rounded,
                        size: 20,
                      ),
                    );
                  },
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  tt(language,
                      "Henüz kayıtlı görev yok.", "No saved tasks yet."),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    const _StartChoice(withoutTask: true),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: theme.accent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                ),
                child: Text(
                  tt(language, "Görevsiz devam et", "Continue without task"),
                  style: TextStyle(color: theme.accent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────── TASK SHEET HELPERS ─────────────────────

class _TaskSheetResult {
  final bool delete;
  _TaskSheetResult({this.delete = false});
}

class _TaskSheet extends StatelessWidget {
  final AppLanguage language;
  final Color accent;
  final bool isEditing;

  final TextEditingController titleController;
  final TextEditingController targetController;
  final TextEditingController minutesController;

  const _TaskSheet({
    required this.language,
    required this.accent,
    required this.isEditing,
    required this.titleController,
    required this.targetController,
    required this.minutesController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF020617),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white12),
        ),
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              Text(
                isEditing
                    ? tt(language, "Görevi düzenle", "Edit task")
                    : tt(language, "Yeni görev", "New task"),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: titleController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: tt(language, "Görev başlığı", "Task title"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: targetController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: tt(
                          language,
                          "Hedef pomodoro",
                          "Target pomodoros",
                        ),
                        hintText: "8",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: minutesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: tt(
                          language,
                          "Toplam süre (dk)",
                          "Total minutes",
                        ),
                        hintText: "60",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (isEditing)
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          _TaskSheetResult(delete: true),
                        );
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: Colors.redAccent,
                      ),
                      label: Text(
                        tt(language, "Sil", "Delete"),
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(tt(language, "İptal", "Cancel")),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        _TaskSheetResult(delete: false),
                      );
                    },
                    child: Text(
                      isEditing
                          ? tt(language, "Kaydet", "Save")
                          : tt(language, "Ekle", "Add"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────── COUNTDOWN DIALOG ─────────────────────

class _CountdownDialog extends StatefulWidget {
  final String taskTitle;
  final int? minutes;

  const _CountdownDialog({
    required this.taskTitle,
    this.minutes,
  });

  @override
  State<_CountdownDialog> createState() => _CountdownDialogState();
}

class _CountdownDialogState extends State<_CountdownDialog> {
  int _seconds = 10;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_seconds <= 1) {
        t.cancel();
        Navigator.of(context).pop(true); // otomatik başlat
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: const Color(0xFF020617),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      title: Text(
        "Pomodoro başlatılsın mı?",
        style: theme.textTheme.titleMedium,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\"${widget.taskTitle}\"",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          if (widget.minutes != null)
            Text(
              "${widget.minutes} dakikalık pomodoro",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
            ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              _seconds.toString(),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Geri sayım bitmeden iptal edebilirsin.",
            style: TextStyle(
              fontSize: 11,
              color: Colors.white60,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            _timer?.cancel();
            Navigator.of(context).pop(false);
          },
          child: const Text("İptal"),
        ),
        TextButton(
          onPressed: () {
            _timer?.cancel();
            Navigator.of(context).pop(true);
          },
          child: const Text("Hemen başlat"),
        ),
      ],
    );
  }
}
