// lib/models/timer_models.dart

/// Pomodoro modları: Odak, Kısa Mola, Uzun Mola
enum PomodoroMode {
  focus,
  shortBreak,
  longBreak,
}

/// Zamanlayıcı ayarları (dakika cinsinden)
class TimerConfig {
  final int focusMinutes;
  final int shortBreakMinutes;
  final int longBreakMinutes;

  const TimerConfig({
    required this.focusMinutes,
    required this.shortBreakMinutes,
    required this.longBreakMinutes,
  });

  /// Seçilen moda göre toplam süreyi saniye cinsinden döndürür
  int getSecondsForMode(PomodoroMode mode) {
    switch (mode) {
      case PomodoroMode.focus:
        return focusMinutes * 60;
      case PomodoroMode.shortBreak:
        return shortBreakMinutes * 60;
      case PomodoroMode.longBreak:
        return longBreakMinutes * 60;
    }
  }
}
