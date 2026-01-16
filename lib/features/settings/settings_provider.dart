import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/app_theme.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  AppThemeType _currentTheme = AppThemeType.defaultTheme;
  String _language = 'en'; // 'tr' or 'en'
  String _selectedSound = "Lofi Beats";
  int _dailyGoalMinutes = 240; // Default 4 hours
  
  // Custom Durations (in minutes)
  int _pomodoroMinutes = 25;
  int _shortBreakMinutes = 5;
  int _longBreakMinutes = 15;

  // Getters
  bool get isDarkMode => _isDarkMode;
  AppThemeType get currentTheme => _currentTheme;
  String get language => _language;
  String get selectedSound => _selectedSound;
  int get dailyGoalMinutes => _dailyGoalMinutes;
  int get pomodoroMinutes => _pomodoroMinutes;
  int get shortBreakMinutes => _shortBreakMinutes;
  int get longBreakMinutes => _longBreakMinutes;

  ThemeData get themeData => AppTheme.getTheme(_currentTheme, _isDarkMode);

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? true;
    _language = prefs.getString('language') ?? 'en';
    
    final themeIndex = prefs.getInt('themeIndex') ?? 0;
    if (themeIndex >= 0 && themeIndex < AppThemeType.values.length) {
      _currentTheme = AppThemeType.values[themeIndex];
    }
    
    _selectedSound = prefs.getString('selectedSound') ?? "Lofi Beats";
    _dailyGoalMinutes = prefs.getInt('dailyGoalMinutes') ?? 240;
    
    _pomodoroMinutes = prefs.getInt('pomodoroMinutes') ?? 25;
    _shortBreakMinutes = prefs.getInt('shortBreakMinutes') ?? 5;
    _longBreakMinutes = prefs.getInt('longBreakMinutes') ?? 15;
    
    notifyListeners();
  }

  Future<void> toggleDarkMode(bool value) async {
    _isDarkMode = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  Future<void> setTheme(AppThemeType theme) async {
    _currentTheme = theme;
    // Force dark mode for space, else restore user pref or default
    if (theme == AppThemeType.space) {
      _isDarkMode = true;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeIndex', theme.index);
  }

  Future<void> setLanguage(String lang) async {
    _language = lang;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang);
  }

  Future<void> setSound(String sound) async {
    _selectedSound = sound;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedSound', sound);
  }

  Future<void> setDailyGoal(int minutes) async {
    _dailyGoalMinutes = minutes;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dailyGoalMinutes', minutes);
  }

  Future<void> setTimerDuration(String type, int minutes) async { // type: 'pomodoro', 'short', 'long'
    final prefs = await SharedPreferences.getInstance();
    switch (type) {
      case 'pomodoro':
        _pomodoroMinutes = minutes;
        await prefs.setInt('pomodoroMinutes', minutes);
        break;
      case 'short':
        _shortBreakMinutes = minutes;
        await prefs.setInt('shortBreakMinutes', minutes);
        break;
      case 'long':
        _longBreakMinutes = minutes;
        await prefs.setInt('longBreakMinutes', minutes);
        break;
    }
    notifyListeners();
  }

  // Localization Helper
  String translate(String key) {
    if (_language == 'tr') {
      return _tr[key] ?? key;
    }
    return _en[key] ?? key;
  }

  static const Map<String, String> _en = {
    'settings': 'Settings',
    'appearance': 'Appearance',
    'darkMode': 'Dark Mode',
    'theme': 'Theme',
    'language': 'Language',
    'focusSounds': 'Focus Sounds',
    'tasks': 'Tasks',
    'stats': 'Statistics',
    'focus': 'Focus',
    'shortBreak': 'Short Break',
    'longBreak': 'Long Break',
    'version': 'Version',
    'weeklyActivity': 'Weekly Activity',
    'focusTime': 'Focus Time',
    'dailyGoal': 'Daily Goal',
    'remaining': 'Remaining',
    'completed': 'Completed',
    'setGoal': 'Set Daily Goal',
    'hours': 'Hours',
    'timerSettings': 'Timer Settings',
    'pomodoroDuration': 'Pomodoro Duration',
    'shortBreakDuration': 'Short Break Duration',
    'longBreakDuration': 'Long Break Duration',
    'minutes': 'Minutes',
    'themeDefault': 'Default',
    'themeSakura': 'Sakura',
    'themeOcean': 'Ocean',
    'themeForest': 'Forest',
    'themeSpace': 'Space',
    // New Keys
    'cancel': 'Cancel',
    'save': 'Save',
    'close': 'Close',
    'saveNote': 'Save Note',
    'editNote': 'Edit Note',
    'today': 'Today',
    'empty': 'Empty',
    'newTask': 'New Task',
    'taskHint': 'What are you working on?',
    'estPomodoros': 'Est. Pomodoros:',
    'createTask': 'Create Task',
    'noTasks': 'No tasks yet. Start by adding one!',
    'pomodoroCount': 'pomodoros',
    'inProgress': 'In Progress',
    'focusedTime': 'Focused Time',
    'tasksWorkedOn': 'Tasks Worked On:',
    'noTasksRecorded': 'No tasks recorded.',
    'dailyNote': 'Daily Note:',
    'noteHint': 'How was your focus today?',
    'navFocus': 'Focus',
    'navTasks': 'Tasks',
    'navStats': 'Stats',
    'navSettings': 'Settings',
    // Months
    'monthJan': 'January', 'monthFeb': 'February', 'monthMar': 'March', 'monthApr': 'April',
    'monthMay': 'May', 'monthJun': 'June', 'monthJul': 'July', 'monthAug': 'August',
    'monthSep': 'September', 'monthOct': 'October', 'monthNov': 'November', 'monthDec': 'December',
    'generalFocus': 'General Focus',
  };

  static const Map<String, String> _tr = {
    'settings': 'Ayarlar',
    'appearance': 'Görünüm',
    'darkMode': 'Karanlık Mod',
    'theme': 'Tema',
    'language': 'Dil',
    'focusSounds': 'Odak Sesleri',
    'tasks': 'Görevler',
    'stats': 'İstatistikler',
    'focus': 'Odaklan',
    'shortBreak': 'Kısa Mola',
    'longBreak': 'Uzun Mola',
    'version': 'Sürüm',
    'weeklyActivity': 'Haftalık Aktivite',
    'focusTime': 'Odak Süresi',
    'dailyGoal': 'Günlük Hedef',
    'remaining': 'Kalan',
    'completed': 'Tamamlanan',
    'setGoal': 'Günlük Hedef Belirle',
    'hours': 'Saat',
    'timerSettings': 'Zamanlayıcı Ayarları',
    'pomodoroDuration': 'Pomodoro Süresi',
    'shortBreakDuration': 'Kısa Mola Süresi',
    'longBreakDuration': 'Uzun Mola Süresi',
    'minutes': 'Dakika',
    'themeDefault': 'Varsayılan',
    'themeSakura': 'Sakura',
    'themeOcean': 'Okyanus',
    'themeForest': 'Orman',
    'themeSpace': 'Uzay',
    // New Keys
    'cancel': 'İptal',
    'save': 'Kaydet',
    'close': 'Kapat',
    'saveNote': 'Kaydet',
    'editNote': 'Düzenle',
    'today': 'Bugün',
    'empty': 'Boş',
    'newTask': 'Yeni Görev',
    'taskHint': 'Ne üzerinde çalışıyorsun?',
    'estPomodoros': 'Tahmini Pomodoro:',
    'createTask': 'Görev Oluştur',
    'noTasks': 'Henüz görev yok. Bir tane ekle!',
    'pomodoroCount': 'pomodoro',
    'inProgress': 'Devam Ediyor',
    'focusedTime': 'Odak Süresi',
    'tasksWorkedOn': 'Çalışılan Görevler:',
    'noTasksRecorded': 'Kayıtlı görev yok.',
    'dailyNote': 'Günlük Not:',
    'noteHint': 'Bugünkü odaklanman nasıldı?',
    'navFocus': 'Odak',
    'navTasks': 'Görevler',
    'navStats': 'İstatistik',
    'navSettings': 'Ayarlar',
    // Months
    'monthJan': 'Ocak', 'monthFeb': 'Şubat', 'monthMar': 'Mart', 'monthApr': 'Nisan',
    'monthMay': 'Mayıs', 'monthJun': 'Haziran', 'monthJul': 'Temmuz', 'monthAug': 'Ağustos',
    'monthSep': 'Eylül', 'monthOct': 'Ekim', 'monthNov': 'Kasım', 'monthDec': 'Aralık',
    'generalFocus': 'Genel Odak',
  };
}
