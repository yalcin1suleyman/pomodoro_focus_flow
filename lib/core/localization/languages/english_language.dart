import 'language.dart';

class EnglishLanguage implements Language {
  @override String get code => 'en';
  @override String get name => 'English';

  @override String get settings => 'Settings';
  @override String get appearance => 'Appearance';
  @override String get darkMode => 'Dark Mode';
  @override String get theme => 'Theme';
  @override String get language => 'Language';
  @override String get focusSounds => 'Focus Sounds';
  @override String get tasks => 'Tasks';
  @override String get stats => 'Statistics';
  @override String get focus => 'Focus';
  @override String get shortBreak => 'Short Break';
  @override String get longBreak => 'Long Break';
  @override String get version => 'Version';

  @override String get weeklyActivity => 'Weekly Activity';
  @override String get focusTime => 'Focus Time';
  @override String get dailyGoal => 'Daily Goal';
  @override String get remaining => 'Remaining';
  @override String get completed => 'Completed';
  @override String get setGoal => 'Set Daily Goal';
  @override String get hours => 'Hours';
  
  @override String get timerSettings => 'Timer Settings';
  @override String get pomodoroDuration => 'Pomodoro Duration';
  @override String get shortBreakDuration => 'Short Break Duration';
  @override String get longBreakDuration => 'Long Break Duration';
  @override String get minutes => 'Minutes';
  @override String get timeIsUp => 'Time is up!';
  @override String get sessionCompleted => 'Session Completed';
  @override String get breakOver => 'Break Over';

  @override String get themeDefault => 'Default';
  @override String get themeSakura => 'Sakura';
  @override String get themeOcean => 'Ocean';
  @override String get themeForest => 'Forest';
  @override String get themeLuxury => 'Silver Luxury';

  @override String get cancel => 'Cancel';
  @override String get save => 'Save';
  @override String get close => 'Close';
  @override String get delete => 'Delete';
  @override String get saveNote => 'Save Note';
  @override String get editNote => 'Edit Note';

  @override String get today => 'Today';
  @override String get empty => 'Empty';
  @override String get newTask => 'New Task';
  @override String get taskHint => 'What are you working on?';
  @override String get estPomodoros => 'Est. Pomodoros:';
  @override String get createTask => 'Create Task';
  @override String get updateTask => 'Update Task';
  @override String get noTasks => 'No tasks yet. Start by adding one!';
  @override String get pomodoroCount => 'pomodoros';
  @override String get inProgress => 'In Progress';
  @override String get focusedTime => 'Focused Time';
  @override String get tasksWorkedOn => 'Activities:';
  @override String get completedTasksLabel => 'Completed Tasks';
  @override String get noTasksRecorded => 'No tasks recorded.';
  @override String get dailyNote => 'Daily Note:';
  @override String get noteHint => 'How was your focus today?';
  @override String get generalFocus => 'General Focus';
  @override String get goalMet => 'Goal Met';
  @override String get goalMissed => 'Below Goal';
  @override String get tasksHelpTitle => 'How to Use Tasks';
  @override String get tasksHelpContent => '1. Click the + button to add a new task.\n2. Estimate how many Pomodoros it will take.\n3. Click the Play button on a task to start focusing on it.\n4. Swipe LEFT on a task to reveal Edit and Delete options.\n5. When the timer finishes, your progress will be logged!';

  @override String get navFocus => 'Focus';
  @override String get navTasks => 'Tasks';
  @override String get navStats => 'Stats';
  @override String get navSettings => 'Settings';

  @override String get monthJan => 'January';
  @override String get monthFeb => 'February';
  @override String get monthMar => 'March';
  @override String get monthApr => 'April';
  @override String get monthMay => 'May';
  @override String get monthJun => 'June';
  @override String get monthJul => 'July';
  @override String get monthAug => 'August';
  @override String get monthSep => 'September';
  @override String get monthOct => 'October';
  @override String get monthNov => 'November';
  @override String get monthDec => 'December';
  
  @override String get share => 'Share';
  @override String get shareStatsTitle => 'My Focus Stats';
  @override String get shareMessage => 'Check out my focus progress!';
  @override String get statsDaily => 'Daily Stats';
  @override String get statsMonthly => 'Monthly Stats';
  @override String get stats6Months => '6 Months Stats';
  @override String get statsYearly => 'Yearly Stats';
  @override String get average => 'Daily Average';
  @override String get sessions => 'Sessions';
  @override String get heatmapLegend => 'Less  •  More';

  @override String get soundType => 'Alarm Tone';
  @override String get soundTypeBell => 'Guitar (Standard)';
  @override String get soundTypeNotification => 'System Notification';

  // Motivational Quotes
  @override String get quoteMotivation1 => "Focus is the key to success.";
  @override String get quoteMotivation2 => "One pomodoro at a time.";
  @override String get quoteMotivation3 => "Small steps, big results.";
  @override String get quoteMotivation4 => "Keep pushing forward!";
  @override String get quoteMotivation5 => "Your future is created by what you do today.";
  @override String get quoteMotivation6 => "Stay consistent, stay focused.";
  @override String get quoteMotivation7 => "Deep work matters.";

  // Share Dialog
  @override String get shareRange => 'Range';
  @override String get shareRangeDaily => 'Daily';
  @override String get shareRangeWeekly => 'Weekly';
  @override String get shareRangeMonthly => 'Monthly';
  @override String get shareRangeYearly => 'Yearly';
  @override String get shareButton => 'Share';
  @override String get monthlyOverview => 'MONTHLY OVERVIEW';

  // Language Names
  @override String get languageEnglish => 'English';
  @override String get languageTurkish => 'Türkçe';

  // Timer Mode Labels (shortened)
  @override String get focusShort => 'Focus';
  @override String get shortBreakShort => 'Short';
  @override String get longBreakShort => 'Long';

  // Misc
  @override String get addNote => 'Add a note';
}
