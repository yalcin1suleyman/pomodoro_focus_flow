import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyRecord {
  final String date; // Format: YYYY-MM-DD
  int minutesFocused;
  List<String> tasksWorkedOn;
  String? note;
  int? targetMinutes; // The goal at the time of recording

  DailyRecord({
    required this.date,
    this.minutesFocused = 0,
    this.tasksWorkedOn = const [],
    this.note,
    this.targetMinutes,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'minutesFocused': minutesFocused,
      'tasksWorkedOn': tasksWorkedOn,
      'note': note,
      'targetMinutes': targetMinutes,
    };
  }

  factory DailyRecord.fromJson(Map<String, dynamic> json) {
    return DailyRecord(
      date: json['date'],
      minutesFocused: json['minutesFocused'] ?? 0,
      tasksWorkedOn: List<String>.from(json['tasksWorkedOn'] ?? []),
      note: json['note'],
      targetMinutes: json['targetMinutes'],
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

  int getStatsForPeriod(DateTime start, DateTime end) {
    // Inclusive start and end
    final startKey = _dateToKey(start);
    final endKey = _dateToKey(end);
    
    int totalMinutes = 0;
    
    for (var record in _history) {
      if (record.date.compareTo(startKey) >= 0 && record.date.compareTo(endKey) <= 0) {
        totalMinutes += record.minutesFocused;
      }
    }
    return totalMinutes;
  }

  int getStatsForWeek(DateTime date) {
    // Assuming Monday start. 
    // date.weekday: 1 (Mon) -> 7 (Sun)
    // To get Monday: subtract weekday-1 days.
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    // Ensure we strip time for accurate comparison in getStatsForPeriod if needed, 
    // but _dateToKey handles YYYY-MM-DD so Time doesn't matter much there.
    // However, clean dates are safer.
    final start = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    final end = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day);
    
    return getStatsForPeriod(start, end);
  }

  Map<DateTime, int> getDailyRecordsForPeriod(DateTime start, DateTime end) {
    Map<DateTime, int> data = {};
    final startKey = _dateToKey(start);
    final endKey = _dateToKey(end);

    for (var record in _history) {
      if (record.date.compareTo(startKey) >= 0 && record.date.compareTo(endKey) <= 0) {
        // Parse back to DateTime for easier widget consumption
        final parts = record.date.split('-');
        final date = DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
        data[date] = record.minutesFocused;
      }
    }
    return data;
  }

  Future<void> logSession(int minutes, String taskTitle, int currentDailyGoal) async {
    final now = DateTime.now();
    final dateKey = _dateToKey(now);
    
    int index = _history.indexWhere((e) => e.date == dateKey);
    
    if (index != -1) {
      // Update existing record
      _history[index].minutesFocused += minutes;
      // Always update target to the latest one for today
      _history[index].targetMinutes = currentDailyGoal; 
      
      if (!_history[index].tasksWorkedOn.contains(taskTitle)) {
        _history[index].tasksWorkedOn.add(taskTitle);
      }
    } else {
      // Create new record
      _history.add(DailyRecord(
        date: dateKey,
        minutesFocused: minutes,
        tasksWorkedOn: [taskTitle],
        targetMinutes: currentDailyGoal,
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

  Future<void> updateDailyGoal(DateTime date, int goalMinutes) async {
    final dateKey = _dateToKey(date);
    int index = _history.indexWhere((e) => e.date == dateKey);
    
    if (index != -1) {
      _history[index].targetMinutes = goalMinutes;
    } else {
       _history.add(DailyRecord(
        date: dateKey,
        targetMinutes: goalMinutes,
      ));
    }
    await _saveHistory();
    notifyListeners();
  }

  String _dateToKey(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
