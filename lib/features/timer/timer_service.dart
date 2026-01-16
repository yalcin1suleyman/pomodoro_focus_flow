import 'dart:async';
import 'package:flutter/material.dart';

enum TimerStatus { initial, running, paused, completed }
enum TimerMode { pomodoro, shortBreak, longBreak }

class TimerService extends ChangeNotifier with WidgetsBindingObserver {
  Timer? _timer;
  TimerStatus _status = TimerStatus.initial;
  TimerMode _mode = TimerMode.pomodoro;
  
  // Default Initial Durations (will be updated by Settings)
  int _pomodoroMinutes = 25;
  int _shortBreakMinutes = 5;
  int _longBreakMinutes = 15;

  int _remainingSeconds = 1500; 
  int _initialSeconds = 1500;

  // Active Task Tracking
  String? _activeTaskId;
  String? _activeTaskTitle;
  
  // Backgound handling
  DateTime? _backgroundTime;

  // Callbacks
  Function(String? taskId)? onPomodoroComplete;

  TimerService() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  // Getters
  TimerStatus get status => _status;
  TimerMode get mode => _mode;
  int get remainingSeconds => _remainingSeconds;
  double get progress => _initialSeconds > 0 ? (1 - (_remainingSeconds / _initialSeconds)) : 0.0;
  String? get activeTaskId => _activeTaskId;
  String? get activeTaskTitle => _activeTaskTitle;
  
  String get timeString {
    final minutes = (_remainingSeconds / 60).floor();
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Sync Settings
  void updateSettings(int pomodoro, int short, int long) {
    bool changed = false;
    if (_pomodoroMinutes != pomodoro) { _pomodoroMinutes = pomodoro; changed = true; }
    if (_shortBreakMinutes != short) { _shortBreakMinutes = short; changed = true; }
    if (_longBreakMinutes != long) { _longBreakMinutes = long; changed = true; }

    // If settings changed and timer is not running, update current display
    if (changed && _status == TimerStatus.initial) {
      _updateDurationForMode(_mode);
      _remainingSeconds = _initialSeconds;
      notifyListeners();
    }
  }

  void _updateDurationForMode(TimerMode mode) {
    switch (mode) {
      case TimerMode.pomodoro:
        _initialSeconds = _pomodoroMinutes * 60;
        break;
      case TimerMode.shortBreak:
        _initialSeconds = _shortBreakMinutes * 60;
        break;
      case TimerMode.longBreak:
        _initialSeconds = _longBreakMinutes * 60;
        break;
    }
  }

  void startSessionForTask(String id, String title) {
    _activeTaskId = id;
    _activeTaskTitle = title;
    
    // Switch to Pomodoro Mode and RESET timer
    // This prevents "instant finish" if timer was at 00:00
    setMode(TimerMode.pomodoro); 
    
    notifyListeners();
  }

  void setActiveTask(String? id, String? title) {
    _activeTaskId = id;
    _activeTaskTitle = title;
    notifyListeners();
  }

  void setMode(TimerMode mode) {
    _mode = mode;
    stop();
    _updateDurationForMode(mode); // Use dynamic durations
    _remainingSeconds = _initialSeconds;
    notifyListeners();
  }

  void start() {
    if (_status == TimerStatus.running) return;
    
    // Ensure we start with correct duration if somehow not set
    if (_initialSeconds == 1500 && _pomodoroMinutes != 25) {
       _updateDurationForMode(_mode);
    }

    _status = TimerStatus.running;
    notifyListeners();

    // DEMO MODE: 10ms (Ultra Fast)
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        _complete();
      }
    });
  }

  void pause() {
    if (_status != TimerStatus.running) return;
    _timer?.cancel();
    _status = TimerStatus.paused;
    notifyListeners();
  }

  void stop() {
    _timer?.cancel();
    _status = TimerStatus.initial;
    _updateDurationForMode(_mode); // Reset to full duration
    _remainingSeconds = _initialSeconds;
    notifyListeners();
  }

  void _complete() {
    _timer?.cancel();
    _status = TimerStatus.completed;
    
    // Auto-increment task ONLY if in Pomodoro mode and a task is active
    if (_mode == TimerMode.pomodoro) {
      // Notify completion, even if no task is active (passed as null)
      onPomodoroComplete?.call(_activeTaskId);
      
      // Auto-switch to Short Break
      // This resets the timer to break duration and prevents "spamming" the finish
      setMode(TimerMode.shortBreak);
    }

    notifyListeners();
  }

  // Background Lifecycle Handling
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_status != TimerStatus.running) return;

    if (state == AppLifecycleState.paused) {
      _backgroundTime = DateTime.now();
      _timer?.cancel(); // Stop actual timer to save resources
    } else if (state == AppLifecycleState.resumed) {
      if (_backgroundTime != null) {
        final elapsed = DateTime.now().difference(_backgroundTime!).inSeconds;
        _remainingSeconds -= elapsed;
        if (_remainingSeconds <= 0) {
          _remainingSeconds = 0;
          _complete();
        } else {
          // Restart timer loop
          _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
             if (_remainingSeconds > 0) {
              _remainingSeconds--;
              notifyListeners();
            } else {
              _complete();
            }
          });
        }
        _backgroundTime = null;
        notifyListeners();
      }
    }
  }
}
