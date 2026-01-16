import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyRecord {
  final String date; // Format: YYYY-MM-DD
  int minutesFocused;
  List<String> tasksWorkedOn;
  String? note;

  DailyRecord({
    required this.date,
    this.minutesFocused = 0,
    this.tasksWorkedOn = const [],
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'minutesFocused': minutesFocused,
      'tasksWorkedOn': tasksWorkedOn,
      'note': note,
    };
  }

  factory DailyRecord.fromJson(Map<String, dynamic> json) {
    return DailyRecord(
      date: json['date'],
      minutesFocused: json['minutesFocused'] ?? 0,
      tasksWorkedOn: List<String>.from(json['tasksWorkedOn'] ?? []),
      note: json['note'],
    );
  }
}

class HistoryProvider extends ChangeNotifier {
  List<DailyRecord> _history = [];
  bool _isLoading = true;

  List<DailyRecord> get history => _history;
  bool get isLoading => _isLoading;

  HistoryProvider() {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyString = prefs.getString('history');

    if (historyString != null) {
      final List<dynamic> jsonList = jsonDecode(historyString);
      _history = jsonList.map((e) => DailyRecord.fromJson(e)).toList();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(_history.map((e) => e.toJson()).toList());
    await prefs.setString('history', jsonString);
    notifyListeners();
  }

  DailyRecord getRecord(DateTime date) {
    final dateKey = _dateToKey(date);
    return _history.firstWhere(
      (e) => e.date == dateKey, 
      orElse: () => DailyRecord(date: dateKey),
    );
  }

  Future<void> logSession(int minutes, String taskTitle) async {
    final now = DateTime.now();
    final dateKey = _dateToKey(now);
    
    int index = _history.indexWhere((e) => e.date == dateKey);
    
    if (index != -1) {
      // Update existing record
      _history[index].minutesFocused += minutes;
      if (!_history[index].tasksWorkedOn.contains(taskTitle)) {
        _history[index].tasksWorkedOn.add(taskTitle);
      }
    } else {
      // Create new record
      _history.add(DailyRecord(
        date: dateKey,
        minutesFocused: minutes,
        tasksWorkedOn: [taskTitle],
      ));
    }
    await _saveHistory();
  }

  Future<void> updateNote(DateTime date, String note) async {
    final dateKey = _dateToKey(date);
    int index = _history.indexWhere((e) => e.date == dateKey);
    
    if (index != -1) {
      _history[index].note = note;
    } else {
       _history.add(DailyRecord(
        date: dateKey,
        note: note,
      ));
    }
    await _saveHistory();
  }

  String _dateToKey(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
