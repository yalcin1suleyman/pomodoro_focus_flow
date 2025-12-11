class FocusTask {
  final String id;
  final String title;
  final int? targetPomodoros;
  final int completedPomodoros;
  final bool isDone;

  /// Kullanıcının bu görev için manuel girdiği toplam çalışma süresi (dakika)
  final int totalMinutes;

  const FocusTask({
    required this.id,
    required this.title,
    this.targetPomodoros,
    this.completedPomodoros = 0,
    this.isDone = false,
    this.totalMinutes = 0,
  });

  FocusTask copyWith({
    String? id,
    String? title,
    int? targetPomodoros,
    int? completedPomodoros,
    bool? isDone,
    int? totalMinutes,
  }) {
    return FocusTask(
      id: id ?? this.id,
      title: title ?? this.title,
      targetPomodoros: targetPomodoros ?? this.targetPomodoros,
      completedPomodoros: completedPomodoros ?? this.completedPomodoros,
      isDone: isDone ?? this.isDone,
      totalMinutes: totalMinutes ?? this.totalMinutes,
    );
  }
}
