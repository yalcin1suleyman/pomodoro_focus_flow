// lib/models/timer_models.dart

/// Uygulamadaki üç ana mod:
/// - Odak (Focus)
/// - Kısa mola (Short Break)
/// - Uzun mola (Long Break)
enum PomodoroMode {
  focus,
  shortBreak,
  longBreak,
}

/// Kullanıcının ayarlayabildiği süreler (dakika)
class TimerConfig {
  final int focusMinutes;
  final int shortBreakMinutes;
  final int longBreakMinutes;

  const TimerConfig({
    required this.focusMinutes,
    required this.shortBreakMinutes,
    required this.longBreakMinutes,
  });

  /// Seçilen moda göre toplam saniye verir
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

  TimerConfig copyWith({
    int? focusMinutes,
    int? shortBreakMinutes,
    int? longBreakMinutes,
  }) {
    return TimerConfig(
      focusMinutes: focusMinutes ?? this.focusMinutes,
      shortBreakMinutes: shortBreakMinutes ?? this.shortBreakMinutes,
      longBreakMinutes: longBreakMinutes ?? this.longBreakMinutes,
    );
  }
}

/// Her duraklatma için kayıt
class Interruption {
  final String id;
  final DateTime timestamp;          // Duraklatmanın başladığı an
  final int elapsedSecondsAtPause;   // Timer kaçıncı saniyede durdu
  final int? pauseDuration;          // Bu duraklama toplam kaç saniye sürdü
  final DateTime? resumedAt;         // Ne zaman devam edildi

  Interruption({
    required this.id,
    required this.timestamp,
    required this.elapsedSecondsAtPause,
    this.pauseDuration,
    this.resumedAt,
  });

  Interruption copyWith({
    String? id,
    DateTime? timestamp,
    int? elapsedSecondsAtPause,
    int? pauseDuration,
    DateTime? resumedAt,
  }) {
    return Interruption(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      elapsedSecondsAtPause:
      elapsedSecondsAtPause ?? this.elapsedSecondsAtPause,
      pauseDuration: pauseDuration ?? this.pauseDuration,
      resumedAt: resumedAt ?? this.resumedAt,
    );
  }
}

/// Tam bir oturum kaydı (history + AI analiz için kullanılacak)
class Session {
  final String id;
  final PomodoroMode mode;
  final DateTime startTime;
  final DateTime? endTime;
  final int targetDurationSeconds; // planlanan süre
  final int actualFocusSeconds;    // gerçekten odaklanılan süre
  final List<Interruption> interruptions;

  Session({
    required this.id,
    required this.mode,
    required this.startTime,
    this.endTime,
    required this.targetDurationSeconds,
    required this.actualFocusSeconds,
    required this.interruptions,
  });

  Session copyWith({
    String? id,
    PomodoroMode? mode,
    DateTime? startTime,
    DateTime? endTime,
    int? targetDurationSeconds,
    int? actualFocusSeconds,
    List<Interruption>? interruptions,
  }) {
    return Session(
      id: id ?? this.id,
      mode: mode ?? this.mode,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      targetDurationSeconds:
      targetDurationSeconds ?? this.targetDurationSeconds,
      actualFocusSeconds: actualFocusSeconds ?? this.actualFocusSeconds,
      interruptions: interruptions ?? this.interruptions,
    );
  }

  /// Tüm duraklamaların toplam süresi
  int get totalPausedSeconds {
    return interruptions.fold(
      0,
          (sum, i) => sum + (i.pauseDuration ?? 0),
    );
  }

  /// Gerçek verim (0–100)
  double get efficiency {
    if (targetDurationSeconds == 0) return 0;
    return (actualFocusSeconds / targetDurationSeconds) * 100;
  }
}
