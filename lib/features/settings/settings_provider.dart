import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/app_theme.dart';
import '../../core/localization/languages/language.dart';
import '../../core/localization/languages/english_language.dart';
import '../../core/localization/languages/turkish_language.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  AppThemeType _currentTheme = AppThemeType.defaultTheme;
  String _language = 'en'; // 'tr' or 'en'
  Language _currentLanguage = EnglishLanguage(); // Default
  
  String _soundType = "bell"; // 'bell' or 'notification'
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
  Language get currentLanguageObj => _currentLanguage; // Expose object if needed
  
  String get soundType => _soundType;
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
    
    // Set Language Object
    if (_language == 'tr') {
      _currentLanguage = TurkishLanguage();
    } else {
      _currentLanguage = EnglishLanguage();
    }

    final themeIndex = prefs.getInt('themeIndex') ?? 0;
    if (themeIndex >= 0 && themeIndex < AppThemeType.values.length) {
      _currentTheme = AppThemeType.values[themeIndex];
    }
    
    _soundType = prefs.getString('soundType') ?? "bell";
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
    // Force dark mode for Luxury (if desired), else restore user pref or default logic
    if (theme == AppThemeType.luxury) {
      _isDarkMode = true;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeIndex', theme.index);
  }

  Future<void> setLanguage(String lang) async {
    _language = lang;
    if (_language == 'tr') {
      _currentLanguage = TurkishLanguage();
    } else {
      _currentLanguage = EnglishLanguage();
    }
    
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang);
  }

  Future<void> setSoundType(String type) async { // 'bell' or 'notification'
    _soundType = type;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('soundType', type);
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
    // Dynamic dispatch using reflection (mirrors) is heavy in Flutter.
    // Since we defined getters in the interface, we need a way to access them dynamically OR 
    // we just use the getter directly if we know the key at compile time.
    // However, existing code uses strings like translate('settings').
    // We need a map-like access or switch case. 
    // To solve this efficiently without changing every call site:
    // We will Implement a helper in Language class or here.
    
    // BETTER APPROACH: 
    // Let's make the Language class support a `operator []` or `get(String key)` 
    // But since I already wrote the class with getters, let me add a big switch here 
    // OR just use a map in the Language definition. 
    
    // Wait, the "cleanest" way for the future is to change usage to `s.language.settings`
    // But that requires changing ALL files.
    // For now, let's map the string key to the getter.
    
    switch (key) {
      case 'settings': return _currentLanguage.settings;
      case 'appearance': return _currentLanguage.appearance;
      case 'darkMode': return _currentLanguage.darkMode;
      case 'theme': return _currentLanguage.theme;
      case 'language': return _currentLanguage.language;
      case 'focusSounds': return _currentLanguage.focusSounds;
      case 'tasks': return _currentLanguage.tasks;
      case 'stats': return _currentLanguage.stats;
      case 'focus': return _currentLanguage.focus;
      case 'shortBreak': return _currentLanguage.shortBreak;
      case 'longBreak': return _currentLanguage.longBreak;
      case 'version': return _currentLanguage.version;
      case 'weeklyActivity': return _currentLanguage.weeklyActivity;
      case 'focusTime': return _currentLanguage.focusTime;
      case 'dailyGoal': return _currentLanguage.dailyGoal;
      case 'remaining': return _currentLanguage.remaining;
      case 'completed': return _currentLanguage.completed;
      case 'setGoal': return _currentLanguage.setGoal;
      case 'hours': return _currentLanguage.hours;
      case 'timerSettings': return _currentLanguage.timerSettings;
      case 'pomodoroDuration': return _currentLanguage.pomodoroDuration;
      case 'shortBreakDuration': return _currentLanguage.shortBreakDuration;
      case 'longBreakDuration': return _currentLanguage.longBreakDuration;
      case 'minutes': return _currentLanguage.minutes;
      case 'themeDefault': return _currentLanguage.themeDefault;
      case 'themeSakura': return _currentLanguage.themeSakura;
      case 'themeOcean': return _currentLanguage.themeOcean;
      case 'themeForest': return _currentLanguage.themeForest;
      case 'themeLuxury': return _currentLanguage.themeLuxury;
      case 'cancel': return _currentLanguage.cancel;
      case 'save': return _currentLanguage.save;
      case 'close': return _currentLanguage.close;
      case 'delete': return _currentLanguage.delete;
      case 'saveNote': return _currentLanguage.saveNote;
      case 'editNote': return _currentLanguage.editNote;
      case 'today': return _currentLanguage.today;
      case 'empty': return _currentLanguage.empty;
      case 'newTask': return _currentLanguage.newTask;
      case 'taskHint': return _currentLanguage.taskHint;
      case 'estPomodoros': return _currentLanguage.estPomodoros;
      case 'createTask': return _currentLanguage.createTask;
      case 'updateTask': return _currentLanguage.updateTask;
      case 'noTasks': return _currentLanguage.noTasks;
      case 'pomodoroCount': return _currentLanguage.pomodoroCount;
      case 'inProgress': return _currentLanguage.inProgress;
      case 'focusedTime': return _currentLanguage.focusedTime;
      case 'tasksWorkedOn': return _currentLanguage.tasksWorkedOn;
      case 'completedTasksLabel': return _currentLanguage.completedTasksLabel;
      case 'noTasksRecorded': return _currentLanguage.noTasksRecorded;
      case 'dailyNote': return _currentLanguage.dailyNote;
      case 'noteHint': return _currentLanguage.noteHint;
      case 'goalMet': return _currentLanguage.goalMet;
      case 'goalMissed': return _currentLanguage.goalMissed;
      case 'navFocus': return _currentLanguage.navFocus;
      case 'navTasks': return _currentLanguage.navTasks;
      case 'navStats': return _currentLanguage.navStats;
      case 'navSettings': return _currentLanguage.navSettings;
      case 'monthJan': return _currentLanguage.monthJan;
      case 'monthFeb': return _currentLanguage.monthFeb;
      case 'monthMar': return _currentLanguage.monthMar;
      case 'monthApr': return _currentLanguage.monthApr;
      case 'monthMay': return _currentLanguage.monthMay;
      case 'monthJun': return _currentLanguage.monthJun;
      case 'monthJul': return _currentLanguage.monthJul;
      case 'monthAug': return _currentLanguage.monthAug;
      case 'monthSep': return _currentLanguage.monthSep;
      case 'monthOct': return _currentLanguage.monthOct;
      case 'monthNov': return _currentLanguage.monthNov;
      case 'monthDec': return _currentLanguage.monthDec;
      case 'generalFocus': return _currentLanguage.generalFocus;
      case 'share': return _currentLanguage.share;
      case 'shareStatsTitle': return _currentLanguage.shareStatsTitle;
      case 'shareMessage': return _currentLanguage.shareMessage;
      case 'statsDaily': return _currentLanguage.statsDaily;
      case 'statsMonthly': return _currentLanguage.statsMonthly;
      case 'stats6Months': return _currentLanguage.stats6Months;
      case 'statsYearly': return _currentLanguage.statsYearly;
      case 'average': return _currentLanguage.average;
      case 'sessions': return _currentLanguage.sessions;
      case 'heatmapLegend': return _currentLanguage.heatmapLegend;
      case 'soundType': return _currentLanguage.soundType;
      case 'soundTypeBell': return _currentLanguage.soundTypeBell;
      case 'soundTypeNotification': return _currentLanguage.soundTypeNotification;
      case 'tasksHelpTitle': return _currentLanguage.tasksHelpTitle;
      case 'tasksHelpContent': return _currentLanguage.tasksHelpContent;
      // Motivational Quotes
      case 'quoteMotivation1': return _currentLanguage.quoteMotivation1;
      case 'quoteMotivation2': return _currentLanguage.quoteMotivation2;
      case 'quoteMotivation3': return _currentLanguage.quoteMotivation3;
      case 'quoteMotivation4': return _currentLanguage.quoteMotivation4;
      case 'quoteMotivation5': return _currentLanguage.quoteMotivation5;
      case 'quoteMotivation6': return _currentLanguage.quoteMotivation6;
      case 'quoteMotivation7': return _currentLanguage.quoteMotivation7;
      // Share Dialog
      case 'shareRange': return _currentLanguage.shareRange;
      case 'shareRangeDaily': return _currentLanguage.shareRangeDaily;
      case 'shareRangeWeekly': return _currentLanguage.shareRangeWeekly;
      case 'shareRangeMonthly': return _currentLanguage.shareRangeMonthly;
      case 'shareRangeYearly': return _currentLanguage.shareRangeYearly;
      case 'shareButton': return _currentLanguage.shareButton;
      case 'monthlyOverview': return _currentLanguage.monthlyOverview;
      // Language Names
      case 'languageEnglish': return _currentLanguage.languageEnglish;
      case 'languageTurkish': return _currentLanguage.languageTurkish;
      // Timer Mode Labels (shortened)
      case 'focusShort': return _currentLanguage.focusShort;
      case 'shortBreakShort': return _currentLanguage.shortBreakShort;
      case 'longBreakShort': return _currentLanguage.longBreakShort;
      // Misc
      case 'addNote': return _currentLanguage.addNote;
      default: return key;
    }
  }
}
