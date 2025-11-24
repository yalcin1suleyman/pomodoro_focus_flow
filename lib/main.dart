import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'features/settings/settings_sheet.dart';

import 'models/theme_models.dart';
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
      theme: ThemeData.dark(),
      home: const FocusFlowHomePage(),
    );
  }
}

/// Ana ekran
class FocusFlowHomePage extends StatefulWidget {
  const FocusFlowHomePage({super.key});

  @override
  State<FocusFlowHomePage> createState() => _FocusFlowHomePageState();
}

class _FocusFlowHomePageState extends State<FocusFlowHomePage> {
  // ---------- Aktif Tema ----------
  FocusTheme _theme = FocusThemes.cosmic;

  // ---------- Pomodoro Ayarları ----------
  TimerConfig config = const TimerConfig(
    focusMinutes: 46,
    shortBreakMinutes: 5,
    longBreakMinutes: 15,
  );

  AppLanguage _language = AppLanguage.tr;

  PomodoroMode _mode = PomodoroMode.focus;



  late int _totalSeconds;
  late int _remainingSeconds;

  bool _isRunning = false;
  Timer? _ticker;

  void _startTickerIfNeeded() {
    if (_ticker != null) return;

    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      _onTick();
    });
  }

  void _onTick() {
    if (!mounted) return;

    if (!_isRunning) {
      setState(() {});
      return;
    }

    if (_remainingSeconds <= 0) {
      _onSessionCompleted();
      return;
    }

    setState(() => _remainingSeconds--);
  }


  // ---------- Session Metrikleri ----------
  DateTime? _sessionStart;
  Duration _savedPaused = Duration.zero;
  DateTime? _currentPauseStart;
  final List<PauseEntry> _pauses = [];

  // ---------- History ----------
  final List<FocusSession> _history = [];


  // ---------- Motto ----------
  final List<String> _mottoPool = const [
    '"Well begun is half done."',
    '"Focus on the process, not the outcome."',
    '"Small steps every day."',
    '"Stay consistent, not perfect."',
    '"Deep work beats busy work."',
  ];

  String _motto = '"Well begun is half done."';

  void _shuffleMotto() {
    setState(() {
      final others = _mottoPool.where((m) => m != _motto).toList();
      others.shuffle();
      if (others.isNotEmpty) {
        _motto = others.first;
      }
    });
  }

  Future<void> _editMotto() async {
    final controller =
    TextEditingController(text: _motto.replaceAll('"', ''));

    final result = await showDialog<String>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Yeni motto"),
          content: TextField(
            controller: controller,
            maxLines: 2,
            decoration: const InputDecoration(
              hintText: "Bugünün mottosunu yaz",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("İptal"),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, controller.text.trim()),
              child: const Text("Kaydet"),
            ),
          ],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        _motto = '"$result"';
      });
    }
  }


  void _openSettingsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SettingsSheet(
          theme: _theme,
          config: config,
          language: _language,
          onApply: (themeType, newConfig, lang) {
            setState(() {
              _theme = FocusThemes.all.firstWhere((t) => t.type == themeType);
              config = newConfig;
              _language = lang;
              _resetForMode(_mode); // süreler değiştiyse timer’ı güncelle
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _resetForMode(_mode);
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _ticker = null;
    super.dispose();
  }


  // ---------------------------------------------------------
  //                     TIMER LOGIC
  // ---------------------------------------------------------

  void _resetForMode(PomodoroMode newMode) {
    _ticker?.cancel();
    _ticker = null;

    final seconds = config.getSecondsForMode(newMode);

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

    setState(() => _isRunning = true);

    // Oturum ilk kez başlıyorsa
    _sessionStart ??= DateTime.now();

    // Eğer daha önce duraklatılmışsa → pause süresini hesapla
    if (_currentPauseStart != null) {
      final now = DateTime.now();              // 🔥 HATA VEREN KISIM EKLENDİ
      final d = now.difference(_currentPauseStart!);  // 🔥 HATA VEREN KISIM EKLENDİ
      _savedPaused += d;

      final elapsedBeforePause = _totalSeconds - _remainingSeconds;

      _pauses.add(PauseEntry(
        timeLabel: "Paused at: ${_formatClockTime(_currentPauseStart!)}",
        durationSeconds: d.inSeconds,
        atSecond: elapsedBeforePause,
      ));

      _currentPauseStart = null;
    }

    // Timer başlatılıyor
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
        _onSessionCompleted();
        return;
      }

      setState(() {
        _remainingSeconds--;
      });
    });
  }



  void _pauseTimer() {
    if (!_isRunning) return;

    setState(() {
      _isRunning = false;
      _currentPauseStart ??= DateTime.now();
    });
  }


  void _resetTimer() => _resetForMode(_mode);

  void _onSessionCompleted() {
    final end = DateTime.now();
    final start = _sessionStart ?? end;
    final total = end.difference(start);
    final paused = _totalPauseDuration;
    final focus = total - paused;

    final session = FocusSession(
      mode: _mode,
      startTime: start,
      endTime: end,
      totalSeconds: total.inSeconds,
      focusSeconds: focus.inSeconds,
      wastedSeconds: paused.inSeconds,
      pauses: List.unmodifiable(_pauses),
    );

    setState(() {
      _isRunning = false;
      _ticker?.cancel();
      _history.add(session);
      _ticker?.cancel();
      _ticker = null;
    });

    _showFinishedDialog(session);
  }

  void _showFinishedDialog(FocusSession s) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Oturum tamamlandı"),
        content: Text(
            "Focus: ${(s.focusSeconds ~/ 60)}m\nWasted: ${(s.wastedSeconds ~/ 60)}m"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetTimer();
            },
            child: const Text("Tamam"),
          )
        ],
      ),
    );
  }

  void _openHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HistoryPage(history: _history)),
    );
  }

  // ---------------------------------------------------------
  //                     COMPUTED VALUES
  // ---------------------------------------------------------

  double get _progress {
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
    if (total.inSeconds == 0) return 100;

    final paused = _totalPauseDuration;
    final focus = total - paused;

    return (focus.inSeconds / total.inSeconds * 100).clamp(0, 100);
  }

  // ---------------------------------------------------------
  //                     UI HELPERS
  // ---------------------------------------------------------

  String _formatTime(int sec) {
    final m = sec ~/ 60;
    final s = sec % 60;
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  String _formatClockTime(DateTime t) {
    return "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}:${t.second.toString().padLeft(2, '0')}";
  }

  // ---------------------------------------------------------
  //                     BUILD METHOD
  // ---------------------------------------------------------

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
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                            HomeStatsSection(
                              efficiency: _realEfficiency,
                              wastedTime: _totalPauseDuration,
                              pauses: _pauses,
                              sessionProgress: _progress,
                              isRunning: _isRunning,
                              mottoText: _motto,
                              onEditMotto: _editMotto,
                              onShuffleMotto: _shuffleMotto,
                              accentColor: _theme.accent,
                              warningColor: _theme.warning,
                              totalSeconds: _totalSeconds,
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

  // ---------------------------------------------------------
  //                     TOP BAR
  // ---------------------------------------------------------

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _theme.card,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _theme.accent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.rocket_launch_rounded,
                size: 20, color: Colors.white),
          ),
          const SizedBox(width: 10),
          const Text(
            "FocusFlow",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          _topIcon(Icons.history, onTap: _openHistory),
          const SizedBox(width: 8),
          _topIcon(Icons.settings, onTap: _openSettingsSheet),

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

  // ---------------------------------------------------------
  //                     TIMER CARD
  // ---------------------------------------------------------

  Widget _buildTimerCard(Size size) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _theme.card,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          // Mode Chips
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _theme.innerCard,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              children: [
                _buildModeChip("Focus", PomodoroMode.focus),
                _buildModeChip("Short Break", PomodoroMode.shortBreak),
                _buildModeChip("Long Break", PomodoroMode.longBreak),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Timer Circle
          CircularPercentIndicator(
            radius: size.width * 0.35,
            lineWidth: 14,
            percent: _progress,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.black26,
            progressColor: _theme.accent,
            center: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatTime(_remainingSeconds),
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  _mode.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // State Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
                    color: _isRunning ? Colors.greenAccent : _theme.warning,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _isRunning ? "Focusing" : "Paused",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _resetTimer,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: _theme.innerCard,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.refresh, size: 20),
                ),
              ),
              const SizedBox(width: 32),
              GestureDetector(
                onTap: _isRunning ? _pauseTimer : _startTimer,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: _theme.accent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _theme.accent.withOpacity(0.5),
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
    final selected = _mode == mode;

    return Expanded(
      child: GestureDetector(
        onTap: () => _resetForMode(mode),
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
                color: selected ? Colors.white : Colors.white70,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
//                     HISTORY PAGE
// ---------------------------------------------------------

class HistoryPage extends StatelessWidget {
  final List<FocusSession> history;

  const HistoryPage({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Session History"),
      ),
      body: history.isEmpty
          ? const Center(
        child: Text("No sessions yet.", style: TextStyle(color: Colors.white70)),
      )
          : ListView.builder(
          itemCount: history.length,
          itemBuilder: (context, index) {
            final s = history[history.length - 1 - index];
            return ListTile(
              title: Text(
                "${s.mode.name} • ${s.focusSeconds ~/ 60}m focus",
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "Wasted: ${s.wastedSeconds ~/ 60}m\n${s.startTime}",
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            );
          }),
    );
  }
}
