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
    focusMinutes: 25,
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

    // Timer başlatılıyor
    _startTickerIfNeeded();  // sadece bunu çağır


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

    // 🔢 Odak skoru (0–100) hesapla
    final wallEfficiency =
    total.inSeconds == 0 ? 100.0 : (focus.inSeconds / total.inSeconds * 100);
    final pauseCount = _pauses.length;

    // her duraklama ve toplam duraklama süresi için küçük ceza
    final pausePenalty =
    (pauseCount * 5 + paused.inSeconds / 30).clamp(0, 40); // max 40 ceza
    final score = (wallEfficiency - pausePenalty).clamp(0, 100).round();

    final session = FocusSession(
      mode: _mode,
      startTime: start,
      endTime: end,
      totalSeconds: total.inSeconds,
      focusSeconds: focus.inSeconds,
      wastedSeconds: paused.inSeconds,
      pauses: List.unmodifiable(_pauses),
      focusScore: score, //new
    );

    setState(() {
      _isRunning = false;
      _ticker?.cancel();
      _history.add(session);
      _ticker = null;
    });

    // Eski basit dialog yerine gelişmiş analiz ekranını aç
    _showSessionAnalysis(session);
  }


  void _openHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HistoryPage(history: _history)),
    );
  }

  void _showSessionAnalysis(FocusSession s) {
    final durationMin = (s.totalSeconds / 60).round();
    final wastedMin = (s.wastedSeconds / 60).round();
    final stops = s.pauses.length;

    final summaryText = _buildSessionSummary(s);
    final tips = _buildImprovementTips(s);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          backgroundColor: const Color(0xFF020617),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      const Icon(
                        Icons.insights_rounded,
                        color: Colors.purpleAccent,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Oturum Analizi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _resetTimer();
                        },
                        icon: const Icon(Icons.close, color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Skor kutusu
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "ODAK SKORU",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: _theme.card,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "${s.focusScore}",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: _theme.accent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Küçük istatistikler
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _miniStat(
                        label: "Oturum",
                        value: "${durationMin}m",
                        icon: Icons.timer_rounded,
                      ),
                      _miniStat(
                        label: "Duraklama",
                        value: "${wastedMin}m",
                        icon: Icons.hourglass_bottom_rounded,
                      ),
                      _miniStat(
                        label: "Kesinti",
                        value: "$stops",
                        icon: Icons.pause_circle_outline,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Özet",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    summaryText,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Gelişim İpuçları",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  for (int i = 0; i < tips.length; i++)
                    _tipItem(i + 1, tips[i]),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _theme.accent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _resetTimer();
                      },
                      child: const Text(
                        "Kapat",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _miniStat({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: _theme.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: Colors.white70),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }
  String _buildSessionSummary(FocusSession s) {
    final minutes = (s.totalSeconds / 60).clamp(1, 999);
    final pauseCount = s.pauses.length;
    final wasted = s.wastedSeconds;

    final wastedMin = wasted ~/ 60;
    final wastedSec = wasted % 60;

    final buffer = StringBuffer();

    if (s.mode == PomodoroMode.focus) {
      buffer.write(
          "$minutes dakikalık bir odak oturumunu tamamladın. ");

      if (pauseCount == 0) {
        buffer.write(
            "Oturum boyunca hiç kesinti yaşamaman çok iyi bir odaklandığını gösteriyor. ");
      } else {
        buffer.write(
            "$pauseCount kez durakladın ve toplam ");
        if (wastedMin > 0) {
          buffer.write("$wastedMin dakika ");
        }
        buffer.write("$wastedSec saniye kaybettin. ");
      }
    } else {
      buffer.write(
          "$minutes dakikalık bir mola oturumu tamamladın. Mola sürelerini de bilinçli kullanman genel verimini artırır. ");
    }

    if (s.focusScore >= 80) {
      buffer.write("Genel olarak oldukça iyi bir performans sergiledin, bu tempoyu korumaya çalış!");
    } else if (s.focusScore >= 50) {
      buffer.write("Bazı kesintiler olmuş ama yine de oturumu tamamlaman güzel bir adım. Bir sonraki sefer kesintileri biraz daha azaltmaya çalışabilirsin.");
    } else {
      buffer.write("Bu oturum biraz zor geçmiş olabilir. Önemli olan pes etmemek ve küçük iyileştirmelerle ilerlemek.");
    }

    return buffer.toString();
  }

  List<String> _buildImprovementTips(FocusSession s) {
    final tips = <String>[];

    final pauseCount = s.pauses.length;
    final wasted = s.wastedSeconds;

    if (pauseCount > 0) {
      tips.add(
          "Oturuma başlamadan önce telefon bildirimlerini kapatmak veya rahatsız etme modunu açmak kesintileri azaltmana yardımcı olabilir.");
    }

    if (wasted > 60) {
      tips.add(
          "Mola ihtiyacını tamamen bastırmak yerine, odak ve mola bloklarını net şekilde ayırmayı dene. Örneğin 40 dakika odak + 10 dakika bilinçli mola.");
    }

    if (s.mode == PomodoroMode.focus && s.focusScore < 80) {
      tips.add(
          "Oturumun ilk 5–10 dakikasını özellikle korumaya çalış. En çok dikkat dağılması genellikle oturumun başında yaşanır.");
    }

    if (tips.isEmpty) {
      tips.add(
          "Mevcut alışkanlıklarını korumaya devam et. İlerleyen dönemde daha uzun odak blokları deneyerek kendini zorlayabilirsin.");
    }

    return tips;
  }

  Widget _tipItem(int index, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$index.",
            style: const TextStyle(
              fontSize: 13,
              color: Colors.amberAccent,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
            ),
          )
        ],
      ),
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
    // 24 saatlik (0–23) saati 12 saatliğe çevir
    int hour12 = t.hour % 12;
    if (hour12 == 0) hour12 = 12;

    final h = hour12.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    final s = t.second.toString().padLeft(2, '0');
    return "$h:$m:$s";

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

                              showStats: _mode == PomodoroMode.focus,
                              showBreakMessage: _mode != PomodoroMode.focus,
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
