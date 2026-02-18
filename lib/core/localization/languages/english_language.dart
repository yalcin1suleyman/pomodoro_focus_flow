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

  @override String get themeClassic => 'Classic Blue';
  @override String get themeSakura => 'Sakura';
  @override String get themeOcean => 'Ocean';
  @override String get themeForest => 'Forest';
  @override String get themeSilver => 'Silver';

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
  @override String get tasksHelpTitle => 'Task Management System';
  @override String get tasksHelpContent => 'Manage tasks effectively to boost productivity:\n\n1. Create Task\nTap the (+) button to add a new task.\n\n2. Set Estimation\nEstimate how many Pomodoros you need. (Duration is adjustable in Settings.)\n\n3. Start Focusing\nTap the Play (▶) button on a task to start the focus timer.\n\n4. Edit & Delete\nSwipe the task card to the LEFT to reveal editing and deleting options.\n\n5. Track Progress\nProgress is logged in Statistics when timer ends. Sessions started without a task are logged as "General Focus".';

  @override String get tasksHelpStep1Title => 'Create Task';
  @override String get tasksHelpStep1Content => 'Tap the (+) button to add a new task.';
  
  @override String get tasksHelpStep2Title => 'Set Estimation';
  @override String get tasksHelpStep2Content => 'Estimate how many Pomodoros you need for the task. (Duration is adjustable in Settings.)';
  
  @override String get tasksHelpStep3Title => 'Start Focusing';
  @override String get tasksHelpStep3Content => 'Tap the Play (▶) button on a task to start the focus timer.';
  
  @override String get tasksHelpStep4Title => 'Edit & Delete';
  @override String get tasksHelpStep4Content => 'Swipe the task card to the LEFT to reveal edit and delete options.';
  
  @override String get tasksHelpStep5Title => 'Track Progress';
  @override String get tasksHelpStep5Content => 'Progress is logged in Statistics when timer ends. Sessions started without a task are logged as "General Focus".';

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

  @override String get soundType => 'Notification Sounds';
  @override String get soundTypeBell => 'Bell';
  @override String get soundTypeNotification => 'System Notification';

  // Share Screen
  @override String get shareFooterQuote => 'Focus with Pomodoro Master';
  @override String get shareGoalCompleted => 'Goal Completed';
  @override String get shareTopFocus => 'Top Focus';
  @override String get shareLegendStart => 'Start';
  @override String get shareLegendGoal => 'Goal';
  @override String get shareWeeklyFocus => 'WEEKLY FOCUS';
  @override String get shareYearlyJourney => 'JOURNEY';

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

  @override String get shareAdUnlockContent => 'You must watch a short ad to unlock this feature.';
  @override String get shareAdUnlockButton => 'Watch Ad';
  
  @override String get shareSummary => 'Summary';
  @override String get shareFocused => 'focused';
  @override String get shareSessions => 'sessions';
  @override String get shareStreak => 'Share your streak and keep yourself accountable 🚀';

  // Language Names
  @override String get languageEnglish => 'English';
  @override String get languageTurkish => 'Türkçe';

  // Timer Mode Labels (shortened)
  @override String get focusShort => 'Focus';
  @override String get shortBreakShort => 'Short';
  @override String get longBreakShort => 'Long';

  // Misc
  @override String get addNote => 'Add a note';
  
  // Help & Warnings
  @override String get helpTitle => 'App Guide';
  @override String get helpContent => 
    "**How does the app work?**\n\n"
    "**Pomodoro**: Focus for 25 minutes, then take a short break. After 4 sessions, take a long break.\n\n"
    "**Timer**: Tap start to focus. Pause if needed.\n\n"
    "**Settings**: Customize your focus durations and sounds.\n\n"
    "**Tasks**: Track your work by adding tasks.\n\n"
    "**Stats**: View your progress over time.";
  @override String get timerRunningWarning => 'Please stop the timer before switching modes.';

  // Help Slideshow
  @override String get helpUnknown => 'Unknown';
  @override String get helpSlide1Title => 'Master Your Time';
  @override String get helpSlide1Desc => 'Time management is an art. Keep your focus laser-sharp, prevent burnout, and maximize productivity with the Pomodoro technique.';
  
  @override String get helpSlide2Title => 'Choose Your Goal';
  @override String get helpSlide2Desc => 'Great achievements start with small steps. Pick the most important task for today and prepare to focus on it.';
  
  @override String get helpSlide3Title => 'Total Focus';
  @override String get helpSlide3Desc => "Silence the outside world for 25 minutes. It's just you and your goal. Enter deep work mode and catch the flow.";
  
  @override String get helpSlide4Title => 'Refresh Your Mind';
  @override String get helpSlide4Desc => "Taking a break isn't a waste of time; it's strategic renewal. Prepare your brain for the next session with a short 5-minute break.";
  
  @override String get helpSlide5Title => 'Cycle of Victory';
  @override String get helpSlide5Desc => 'Every completed cycle is a giant step towards your goal. Celebrate your success, rest deeply, and prepare stronger for the next victory.';
  
  @override String get skip => 'Skip';
  @override String get start => 'Start';
  @override String get next => 'Next';
}
