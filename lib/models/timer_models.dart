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

/// Zaman çizelgesinde göstereceğimiz tek bir duraklama kaydı
class PauseEntry {
  final String timeLabel; // "Paused at: 10:23:15" gibi
  final int durationSeconds;

  PauseEntry({
    required this.timeLabel,
    required this.durationSeconds,
  });
}

/// Tamamlanmış bir oturum kaydı (History için)
class FocusSession {
  final PomodoroMode mode;
  final DateTime startTime;
  final DateTime endTime;
  final int totalSeconds;   // duvar saati süresi (focus + pause)
  final int focusSeconds;   // gerçek odak süresi
  final int wastedSeconds;  // toplam duraklama süresi
  final List<PauseEntry> pauses;

  FocusSession({
    required this.mode,
    required this.startTime,
    required this.endTime,
    required this.totalSeconds,
    required this.focusSeconds,
    required this.wastedSeconds,
    required this.pauses,
  });
}
