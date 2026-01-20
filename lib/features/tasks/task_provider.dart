import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = true;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  TaskProvider() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? taskList = prefs.getStringList('tasks');

    if (taskList != null) {
      _tasks = taskList.map((e) => Task.fromJson(e)).toList();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> taskList = _tasks.map((e) => e.toJson()).toList();
    await prefs.setStringList('tasks', taskList);
    notifyListeners();
  }

  void addTask(String title, int estimatedPomodoros) {
    final newTask = Task(
      id: DateTime.now().toIso8601String(),
      title: title,
      estimatedPomodoros: estimatedPomodoros,
    );
    _tasks.insert(0, newTask);
    _saveTasks();
  }

  void toggleTaskCompletion(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      _saveTasks();
    }
  }

  void incrementPomodoro(String id) {
     final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].completedPomodoros++;
      
      // Auto-complete if target reached
      if (_tasks[index].completedPomodoros >= _tasks[index].estimatedPomodoros) {
        _tasks[index].isCompleted = true;
      }
      
      _saveTasks();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    _saveTasks();
  }
}
