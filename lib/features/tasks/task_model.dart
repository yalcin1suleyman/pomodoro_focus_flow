import 'dart:convert';

class Task {
  final String id;
  String title;
  int estimatedPomodoros;
  int completedPomodoros;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.estimatedPomodoros = 1,
    this.completedPomodoros = 0,
    this.isCompleted = false,
  });

  Task copyWith({
    String? id,
    String? title,
    int? estimatedPomodoros,
    int? completedPomodoros,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      estimatedPomodoros: estimatedPomodoros ?? this.estimatedPomodoros,
      completedPomodoros: completedPomodoros ?? this.completedPomodoros,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'estimatedPomodoros': estimatedPomodoros,
      'completedPomodoros': completedPomodoros,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      estimatedPomodoros: map['estimatedPomodoros'],
      completedPomodoros: map['completedPomodoros'],
      isCompleted: map['isCompleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
