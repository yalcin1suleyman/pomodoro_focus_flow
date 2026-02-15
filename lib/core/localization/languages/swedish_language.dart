import 'language.dart';

class SwedishLanguage implements Language {
  @override String get code => 'sv';
  @override String get name => 'Svenska';

  @override String get settings => 'Inställningar';
  @override String get appearance => 'Utseende';
  @override String get darkMode => 'Mörkt Läge';
  @override String get theme => 'Tema';
  @override String get language => 'Språk';
  @override String get focusSounds => 'Fokusljud';
  @override String get tasks => 'Uppgifter';
  @override String get stats => 'Statistik';
  @override String get focus => 'Fokus';
  @override String get shortBreak => 'Kort Rast';
  @override String get longBreak => 'Lång Rast';
  @override String get version => 'Version';

  @override String get weeklyActivity => 'Veckoaktivitet';
  @override String get focusTime => 'Fokustid';
  @override String get dailyGoal => 'Dagligt Mål';
  @override String get remaining => 'Kvar';
  @override String get completed => 'Klar';
  @override String get setGoal => 'Sätt Mål';
  @override String get hours => 'Timmar';
  
  @override String get timerSettings => 'Timerinställningar';
  @override String get pomodoroDuration => 'Pomodoro Längd';
  @override String get shortBreakDuration => 'Kort Rast Längd';
  @override String get longBreakDuration => 'Lång Rast Längd';
  @override String get minutes => 'Minuter';
  @override String get timeIsUp => 'Tiden är ute!';
  @override String get sessionCompleted => 'Session Avslutad';
  @override String get breakOver => 'Rasten Slut';

  @override String get themeClassic => 'Klassisk';
  @override String get themeSakura => 'Sakura';
  @override String get themeOcean => 'Hav';
  @override String get themeForest => 'Skog';
  @override String get themeSilver => 'Silver';

  @override String get cancel => 'Avbryt';
  @override String get save => 'Spara';
  @override String get close => 'Stäng';
  @override String get delete => 'Ta bort';
  @override String get saveNote => 'Spara Anteckning';
  @override String get editNote => 'Redigera Anteckning';

  @override String get today => 'Idag';
  @override String get empty => 'Tom';
  @override String get newTask => 'Ny Uppgift';
  @override String get taskHint => 'Vad jobbar du på?';
  @override String get estPomodoros => 'Est. Pomodoros:';
  @override String get createTask => 'Skapa Uppgift';
  @override String get updateTask => 'Uppdatera';
  @override String get noTasks => 'Inga uppgifter. Lägg till en!';
  @override String get pomodoroCount => 'pomodoros';
  @override String get inProgress => 'Pågår';
  @override String get focusedTime => 'Fokuserad Tid';
  @override String get tasksWorkedOn => 'Aktiviteter:';
  @override String get completedTasksLabel => 'Avslutade Uppgifter';
  @override String get noTasksRecorded => 'Inga uppgifter sparade.';
  @override String get dailyNote => 'Dagens Anteckning:';
  @override String get noteHint => 'Hur gick fokuset idag?';
  @override String get generalFocus => 'Allmänt Fokus';
  @override String get goalMet => 'Mål Uppnått';
  @override String get goalMissed => 'Under Målet';
  @override String get tasksHelpTitle => 'Uppgiftshantering';
  @override String get tasksHelpContent => '1. Skapa Uppgift (+)\n2. Uppskatta\n3. Starta (▶)\n4. Redigera (Svep vänster)';

  @override String get navFocus => 'Fokus';
  @override String get navTasks => 'Uppgifter';
  @override String get navStats => 'Stats';
  @override String get navSettings => 'Inställn.';

  @override String get monthJan => 'Januari';
  @override String get monthFeb => 'Februari';
  @override String get monthMar => 'Mars';
  @override String get monthApr => 'April';
  @override String get monthMay => 'Maj';
  @override String get monthJun => 'Juni';
  @override String get monthJul => 'Juli';
  @override String get monthAug => 'Augusti';
  @override String get monthSep => 'September';
  @override String get monthOct => 'Oktober';
  @override String get monthNov => 'November';
  @override String get monthDec => 'December';
  
  @override String get share => 'Dela';
  @override String get shareStatsTitle => 'Mina Statistik';
  @override String get shareMessage => 'Kolla mina framsteg!';
  @override String get statsDaily => 'Dagliga';
  @override String get statsMonthly => 'Månatliga';
  @override String get stats6Months => '6 Månader';
  @override String get statsYearly => 'Årliga';
  @override String get average => 'Snitt';
  @override String get sessions => 'Sessioner';
  @override String get heatmapLegend => 'Mindre • Mer';

  @override String get soundType => 'Ljud';
  @override String get soundTypeBell => 'Klocka';
  @override String get soundTypeNotification => 'Notis';

  @override String get shareFooterQuote => 'Fokus med Pomodoro Master';
  @override String get shareGoalCompleted => 'Mål Uppnått';
  @override String get shareTopFocus => 'Topp Fokus';
  @override String get shareLegendStart => 'Start';
  @override String get shareLegendGoal => 'Mål';
  @override String get shareWeeklyFocus => 'VECKOFOKUS';
  @override String get shareYearlyJourney => 'RESA';

  @override String get quoteMotivation1 => "Fokus är nyckeln till framgång.";
  @override String get quoteMotivation2 => "En pomodoro i taget.";
  @override String get quoteMotivation3 => "Små steg, stora resultat.";
  @override String get quoteMotivation4 => "Fortsätt framåt!";
  @override String get quoteMotivation5 => "Din framtid skapas idag.";
  @override String get quoteMotivation6 => "Var konsekvent, håll fokus.";
  @override String get quoteMotivation7 => "Djupt arbete räknas.";

  @override String get shareRange => 'Intervall';
  @override String get shareRangeDaily => 'Dag';
  @override String get shareRangeWeekly => 'Vecka';
  @override String get shareRangeMonthly => 'Månad';
  @override String get shareRangeYearly => 'År';
  @override String get shareButton => 'Dela';
  @override String get monthlyOverview => 'MÅNADSÖVERSIKT';

  @override String get languageEnglish => 'Engelska';
  @override String get languageTurkish => 'Turkiska';

  @override String get focusShort => 'Fokus';
  @override String get shortBreakShort => 'Kort';
  @override String get longBreakShort => 'Lång';

  @override String get addNote => 'Lägg till anteckning';
}
