import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'models/timer_models.dart';

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
  // Timer ayarları (şimdilik sabit, ileride Settings ekranından gelecek)
  TimerConfig config = const TimerConfig(
    focusMinutes: 25,
    shortBreakMinutes: 5,
    longBreakMinutes: 15,
  );

  PomodoroMode _mode = PomodoroMode.focus;

  late int _totalSeconds;     // seçili modun toplam süresi (sn)
  late int _remainingSeconds; // kalan süre

  bool _isRunning = false;
  Timer? _ticker;

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

  void _resetForMode(PomodoroMode newMode) {
    final seconds = config.getSecondsForMode(newMode);
    setState(() {
      _mode = newMode;
      _totalSeconds = seconds;
      _remainingSeconds = seconds;
      _isRunning = false;
    });
    _ticker?.cancel();
  }

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });

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
    });
  }

  void _resetTimer() {
    _ticker?.cancel();
    _resetForMode(_mode);
  }

  void _showFinishedDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Oturum tamamlandı"),
        content: const Text("Harika! Bu oturumu bitirdin."),
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

  String _formatTime(int totalSec) {
    final m = totalSec ~/ 60;
    final s = totalSec % 60;
    final mm = m.toString().padLeft(2, '0');
    final ss = s.toString().padLeft(2, '0');
    return "$mm:$ss";
  }

  String get _modeLabel {
    switch (_mode) {
      case PomodoroMode.focus:
        return "Odak";
      case PomodoroMode.shortBreak:
        return "Kısa Mola";
      case PomodoroMode.longBreak:
        return "Uzun Mola";
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 8),

              // Üst başlık
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "FocusFlow",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.history),
                      SizedBox(width: 12),
                      Icon(Icons.settings),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Mod butonları
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildModeChip("Odak", PomodoroMode.focus),
                  _buildModeChip("Kısa Mola", PomodoroMode.shortBreak),
                  _buildModeChip("Uzun Mola", PomodoroMode.longBreak),
                ],
              ),

              const SizedBox(height: 32),

              // Dairesel timer
              Expanded(
                child: Center(
                  child: CircularPercentIndicator(
                    radius: size.width * 0.35,
                    lineWidth: 12,
                    percent: _progress,
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: Colors.grey.shade800,
                    center: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _modeLabel,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _formatTime(_remainingSeconds),
                          style: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isRunning ? "Çalışıyor..." : "Duraklatıldı",
                          style: TextStyle(
                            fontSize: 14,
                            color: _isRunning
                                ? Colors.greenAccent
                                : Colors.orangeAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Start / Pause / Reset butonları
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isRunning ? _pauseTimer : _startTimer,
                    child: Text(_isRunning ? "Durdur" : "Başlat"),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: _resetTimer,
                    child: const Text("Sıfırla"),
                  ),
                ],
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeChip(String label, PomodoroMode mode) {
    final isSelected = _mode == mode;
    return GestureDetector(
      onTap: () {
        _resetForMode(mode);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : const Color(0xFF141824),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[300],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
