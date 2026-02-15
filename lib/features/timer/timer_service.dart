import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/services/notification_service.dart';
import '../../core/localization/languages/language.dart';

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
  
  // Sound preference (needs to be synced)
  String _soundType = "bell";
  
  // Localization references
  Language? _currentLanguage;

  int _remainingSeconds = 1500; 
  int _initialSeconds = 1500;

  // Active Task Tracking
  String? _activeTaskId;
  String? _activeTaskTitle;
  
  // Target time for robust background handling
  DateTime? _targetEndTime;

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
  void updateSettings(int pomodoro, int short, int long, String soundType, Language language) {
    bool changed = false;
    if (_pomodoroMinutes != pomodoro) { _pomodoroMinutes = pomodoro; changed = true; }
    if (_shortBreakMinutes != short) { _shortBreakMinutes = short; changed = true; }
    if (_longBreakMinutes != long) { _longBreakMinutes = long; changed = true; }
    
    _currentLanguage = language;
    if (_soundType != soundType) { _soundType = soundType; }

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
    _updateDurationForMode(mode); 
    _remainingSeconds = _initialSeconds;
    notifyListeners();
  }

  void start() {
    if (_status == TimerStatus.running) return;
    
    // Ensure we start with correct duration
    if (_initialSeconds <= 0) {
       _updateDurationForMode(_mode);
    }
    
    // Calculate target end time based on current remaining seconds
    _targetEndTime = DateTime.now().add(Duration(seconds: _remainingSeconds));

    _status = TimerStatus.running;
    
    NotificationService().cancelNotification(1); 
    notifyListeners();

    // Standard 1-second tick
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _tick();
    });
  }

  void _tick() {
    if (_targetEndTime == null) return;
    
    final now = DateTime.now();
    final remaining = _targetEndTime!.difference(now).inSeconds;

    if (remaining > 0) {
      _remainingSeconds = remaining;
      notifyListeners();
      
      // Update Notification every second
      final title = _mode == TimerMode.pomodoro 
          ? "${_currentLanguage?.focus ?? 'Focus'} - ${_currentLanguage?.inProgress ?? 'In Progress'}"
          : (_currentLanguage?.shortBreak ?? 'Break');
          
      NotificationService().showOngoingNotification(
         progress: _initialSeconds - _remainingSeconds, 
         maxProgress: _initialSeconds, 
         title: title, 
         body: timeString
      );

    } else {
      _remainingSeconds = 0;
      _complete();
    }
  }

  void pause() {
    if (_status != TimerStatus.running) return;
    _timer?.cancel();
    _status = TimerStatus.paused;
    _targetEndTime = null; // Clear target text since we are paused
    NotificationService().cancelNotification(0); 
    notifyListeners();
  }

  void stop() {
    _timer?.cancel();
    _status = TimerStatus.initial;
    _targetEndTime = null;
    _updateDurationForMode(_mode); 
    _remainingSeconds = _initialSeconds;
    NotificationService().cancelNotification(0); 
    notifyListeners();
  }

  void _complete() {
    _timer?.cancel();
    _status = TimerStatus.completed;
    _targetEndTime = null;
    
    // Trigger alarm
    NotificationService().showAlarmNow(
      useAppBell: _soundType == 'bell',
      title: _currentLanguage?.timeIsUp ?? 'Time is up!',
      body: _mode == TimerMode.pomodoro 
          ? (_currentLanguage?.sessionCompleted ?? 'Session Completed') 
          : (_currentLanguage?.breakOver ?? 'Break Over'),
    );
    
    NotificationService().cancelNotification(0); 

    if (_mode == TimerMode.pomodoro) {
      onPomodoroComplete?.call(_activeTaskId);
      setMode(TimerMode.shortBreak);
    }

    notifyListeners();
  }

  // Background Lifecycle Handling
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_status != TimerStatus.running) return;

    // We do NOT cancel the timer on pause anymore. 
    // We let it run to support background updates.
    
    if (state == AppLifecycleState.resumed) {
      // When resuming, we verify the time just in case the timer was killed/throttled.
      if (_targetEndTime != null) {
         final now = DateTime.now();
         final remaining = _targetEndTime!.difference(now).inSeconds;
         if (remaining <= 0) {
           _remainingSeconds = 0;
           _complete();
         } else {
           _remainingSeconds = remaining;
           notifyListeners();
           
           // Ensure timer is actually running (if OS killed it)
           if (_timer == null || !_timer!.isActive) {
             _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
               _tick();
             });
           }
         }
      }
    }
  }
}
