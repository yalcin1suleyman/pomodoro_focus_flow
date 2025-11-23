import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'models/timer_models.dart';
import 'features/home/widgets/home_stats_section.dart';

void main() {
  runApp(const FocusFlowApp());
}

class FocusFlowApp extends StatelessWidget {
  const FocusFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF050816),
      ),
      home: const FocusFlowHomePage(),
    );
  }
}

class FocusFlowHomePage extends StatefulWidget {
  const FocusFlowHomePage({super.key});

  @override
  State<FocusFlowHomePage> createState() => _FocusFlowHomePageState();
}

class _FocusFlowHomePageState extends State<FocusFlowHomePage> {
  // ---------- Tema (Cosmic – mavi / mor) ----------
  final Color bgTop = const Color(0xFF050816);
  final Color bgBottom = const Color(0xFF020617);
  final Color cardColor = const Color(0xFF0B1120);
  final Color innerCardColor = const Color(0xFF020617);
  final Color accent = const Color(0xFF6366F1); // indigo
  final Color warning = const Color(0xFFFBBF24);

  // ---------- Pomodoro ayarları ----------
  TimerConfig config = const TimerConfig(
    focusMinutes: 46,
    shortBreakMinutes: 5,
    longBreakMinutes: 15,
  );

  PomodoroMode _mode = PomodoroMode.focus;

  late int _totalSeconds;
  late int _remainingSeconds;

  bool _isRunning = false;
  Timer? _ticker;

  // ---------- Session metrikleri ----------
  DateTime? _sessionStart;            // duvar saati başlangıç
  Duration _savedPaused = Duration.zero;
  DateTime? _currentPauseStart;
  final List<PauseEntry> _pauses = [];

  @override
  void initState() {
    super.initState();
    _resetForMode(_mode);
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  // ---------- TIMER LOGIC ----------

  void _resetForMode(PomodoroMode newMode) {
    final seconds = config.getSecondsForMode(newMode);
    _ticker?.cancel();

    setState(() {
      _mode = newMode;
      _totalSeconds = seconds;
      _remainingSeconds = seconds;
      _isRunning = false;

      // yeni mod = yeni oturum
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

    // İlk kez başlıyorsa session start
    _sessionStart ??= DateTime.now();

    // Eğer daha önce pause durumunda kalmışsa -> o duraklamayı kaydet
    if (_currentPauseStart != null) {
      final now = DateTime.now();
      final d = now.difference(_currentPauseStart!);
      _savedPaused += d;
      _pauses.add(PauseEntry(
        timeLabel: "Paused at: ${_formatClockTime(_currentPauseStart!)}",
        durationSeconds: d.inSeconds,
      ));
      _currentPauseStart = null;
    }

    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
        setState(() {
          _isRunning = false;
        });
        _showFinishedDialog();
        return;
      }

      setState(() {
        _remainingSeconds -= 1;
      });
    });
  }

  void _pauseTimer() {
    if (!_isRunning) return;
    _ticker?.cancel();

    setState(() {
      _isRunning = false;
      _currentPauseStart ??= DateTime.now();
    });
  }

  void _resetTimer() {
    _resetForMode(_mode);
  }

  void _showFinishedDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Oturum tamamlandı"),
        content: const Text("Harika! Bu odak oturumunu bitirdin."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetTimer();
            },
            child: const Text("Tamam"),
          ),
        ],
      ),
    );
  }

  double get _progress {
    if (_totalSeconds == 0) return 0;
    final done = _totalSeconds - _remainingSeconds;
    return (done / _totalSeconds).clamp(0.0, 1.0);
  }

  Duration get _totalPauseDuration {
    var d = _savedPaused;
    if (_currentPauseStart != null) {
      d += DateTime.now().difference(_currentPauseStart!);
    }
    return d;
  }

  double get _realEfficiency {
    if (_sessionStart == null) return 100;
    final now = DateTime.now();
    final total = now.difference(_sessionStart!);
    if (total.inSeconds <= 0) return 100;

    final paused = _totalPauseDuration;
    final focus = total - paused;
    final ratio = focus.inSeconds / total.inSeconds;
    return (ratio * 100).clamp(0, 100);
  }

  String _formatTime(int totalSec) {
    final m = totalSec ~/ 60;
    final s = totalSec % 60;
    final mm = m.toString().padLeft(2, '0');
    final ss = s.toString().padLeft(2, '0');
    return "$mm:$ss";
  }

  String _formatClockTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    final s = time.second.toString().padLeft(2, '0');
    return "$h:$m:$s";
  }

  String get _modeLabel {
    switch (_mode) {
      case PomodoroMode.focus:
        return "Focus";
      case PomodoroMode.shortBreak:
        return "Short Break";
      case PomodoroMode.longBreak:
        return "Long Break";
    }
  }

  // ---------- UI ----------

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [bgTop, bgBottom],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  children: [
                    _buildTopBar(),
                    const SizedBox(height: 12),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildTimerCard(size),
                            const SizedBox(height: 16),
                            // 🔵 ALTTAKİ İSTATİSTİKLER (YENİ WIDGET)
                            HomeStatsSection(
                              efficiency: _realEfficiency,
                              wastedTime: _totalPauseDuration,
                              pauses: _pauses,
                              sessionProgress: _progress,
                              isRunning: _isRunning,
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

  // ───────── TOP BAR ─────────

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.rocket_launch_rounded,
                size: 20, color: Colors.white),
          ),
          const SizedBox(width: 10),
          const Text(
            "FocusFlow",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          _topIconButton(Icons.history),
          const SizedBox(width: 8),
          _topIconButton(Icons.settings),
        ],
      ),
    );
  }

  Widget _topIconButton(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: innerCardColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: Colors.white),
    );
  }

  // ───────── TIMER CARD ─────────

  Widget _buildTimerCard(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          // Mode buttons
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: innerCardColor,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildModeChip("Focus", PomodoroMode.focus),
                _buildModeChip("Short Break", PomodoroMode.shortBreak),
                _buildModeChip("Long Break", PomodoroMode.longBreak),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Big circle
          CircularPercentIndicator(
            radius: size.width * 0.35,
            lineWidth: 14,
            percent: _progress,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.black26,
            progressColor: accent,
            center: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatTime(_remainingSeconds),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _modeLabel.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    letterSpacing: 1.5,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Paused / Focusing chip
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2937),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _isRunning ? Colors.greenAccent : warning,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _isRunning ? "Focusing" : "Paused",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Bottom buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Reset
              GestureDetector(
                onTap: _resetTimer,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: innerCardColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.refresh, size: 20),
                ),
              ),
              const SizedBox(width: 32),
              // Play / Pause
              GestureDetector(
                onTap: _isRunning ? _pauseTimer : _startTimer,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: accent.withOpacity(0.5),
                        blurRadius: 18,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Icon(
                    _isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    size: 32,
                    color: Colors.white,
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
    final isSelected = _mode == mode;

    return Expanded(
      child: GestureDetector(
        onTap: () => _resetForMode(mode),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: isSelected ? accent : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
