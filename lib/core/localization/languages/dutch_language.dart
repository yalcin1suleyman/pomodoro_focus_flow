import 'language.dart';

class DutchLanguage implements Language {
  @override String get code => 'nl';
  @override String get name => 'Nederlands';

  @override String get settings => 'Instellingen';
  @override String get appearance => 'Uiterlijk';
  @override String get darkMode => 'Donkere Modus';
  @override String get theme => 'Thema';
  @override String get language => 'Taal';
  @override String get focusSounds => 'Focus Geluiden';
  @override String get tasks => 'Taken';
  @override String get stats => 'Statistieken';
  @override String get focus => 'Focus';
  @override String get shortBreak => 'Korte Pauze';
  @override String get longBreak => 'Lange Pauze';
  @override String get version => 'Versie';

  @override String get weeklyActivity => 'Wekelijkse Activiteit';
  @override String get focusTime => 'Focustijd';
  @override String get dailyGoal => 'Dagelijks Doel';
  @override String get remaining => 'Resterend';
  @override String get completed => 'Voltooid';
  @override String get setGoal => 'Doel Instellen';
  @override String get hours => 'Uur';
  
  @override String get timerSettings => 'Timer Instellingen';
  @override String get pomodoroDuration => 'Pomodoro Duur';
  @override String get shortBreakDuration => 'Korte Pauze Duur';
  @override String get longBreakDuration => 'Lange Pauze Duur';
  @override String get minutes => 'Minuten';
  @override String get timeIsUp => 'Tijd is om!';
  @override String get sessionCompleted => 'Sessie Voltooid';
  @override String get breakOver => 'Pauze Voorbij';

  @override String get themeClassic => 'Klassiek';
  @override String get themeSakura => 'Sakura';
  @override String get themeOcean => 'Oceaan';
  @override String get themeForest => 'Bos';
  @override String get themeSilver => 'Zilver';

  @override String get cancel => 'Annuleren';
  @override String get save => 'Opslaan';
  @override String get close => 'Sluiten';
  @override String get delete => 'Verwijderen';
  @override String get saveNote => 'Notitie Opslaan';
  @override String get editNote => 'Notitie Bewerken';

  @override String get today => 'Vandaag';
  @override String get empty => 'Leeg';
  @override String get newTask => 'Nieuwe Taak';
  @override String get taskHint => 'Waar werk je aan?';
  @override String get estPomodoros => 'Gesch. Pomodoros:';
  @override String get createTask => 'Taak Maken';
  @override String get updateTask => 'Taak Bijwerken';
  @override String get noTasks => 'Geen taken. Voeg er een toe!';
  @override String get pomodoroCount => 'pomodoros';
  @override String get inProgress => 'Bezig';
  @override String get focusedTime => 'Gefocuste Tijd';
  @override String get tasksWorkedOn => 'Activiteiten:';
  @override String get completedTasksLabel => 'Voltooide Taken';
  @override String get noTasksRecorded => 'Geen taken geregistreerd.';
  @override String get dailyNote => 'Dagnotitie:';
  @override String get noteHint => 'Hoe ging het focussen vandaag?';
  @override String get generalFocus => 'Algemene Focus';
  @override String get goalMet => 'Doel Bereikt';
  @override String get goalMissed => 'Onder Doel';
  @override String get tasksHelpTitle => 'Taakbeheer';
  @override String get tasksHelpContent => '1. Maak Taak (+)\n2. Schatten\n3. Starten (▶)\n4. Bewerken (Veeg links)';

  @override String get navFocus => 'Focus';
  @override String get navTasks => 'Taken';
  @override String get navStats => 'Stats';
  @override String get navSettings => 'Instel.';

  @override String get monthJan => 'Januari';
  @override String get monthFeb => 'Februari';
  @override String get monthMar => 'Maart';
  @override String get monthApr => 'April';
  @override String get monthMay => 'Mei';
  @override String get monthJun => 'Juni';
  @override String get monthJul => 'Juli';
  @override String get monthAug => 'Augustus';
  @override String get monthSep => 'September';
  @override String get monthOct => 'Oktober';
  @override String get monthNov => 'November';
  @override String get monthDec => 'December';
  
  @override String get share => 'Delen';
  @override String get shareStatsTitle => 'Mijn Statistieken';
  @override String get shareMessage => 'Bekijk mijn voortgang!';
  @override String get statsDaily => 'Dagelijks';
  @override String get statsMonthly => 'Maandelijks';
  @override String get stats6Months => '6 Maanden';
  @override String get statsYearly => 'Jaarlijks';
  @override String get average => 'Gemiddelde';
  @override String get sessions => 'Sessies';
  @override String get heatmapLegend => 'Minder • Meer';

  @override String get soundType => 'Geluiden';
  @override String get soundTypeBell => 'Bel';
  @override String get soundTypeNotification => 'Melding';

  @override String get shareFooterQuote => 'Focus met Pomodoro Master';
  @override String get shareGoalCompleted => 'Doel Bereikt';
  @override String get shareTopFocus => 'Top Focus';
  @override String get shareLegendStart => 'Start';
  @override String get shareLegendGoal => 'Doel';
  @override String get shareWeeklyFocus => 'WEKELIJKSE FOCUS';
  @override String get shareYearlyJourney => 'REIS';

  @override String get quoteMotivation1 => "Focus is de sleutel tot succes.";
  @override String get quoteMotivation2 => "Eén pomodoro per keer.";
  @override String get quoteMotivation3 => "Kleine stappen, grote resultaten.";
  @override String get quoteMotivation4 => "Blijf doorgaan!";
  @override String get quoteMotivation5 => "Je toekomst wordt vandaag gemaakt.";
  @override String get quoteMotivation6 => "Wees consistent, blijf gefocust.";
  @override String get quoteMotivation7 => "Diep werk telt.";

  @override String get shareRange => 'Bereik';
  @override String get shareRangeDaily => 'Dagelijks';
  @override String get shareRangeWeekly => 'Wekelijks';
  @override String get shareRangeMonthly => 'Maandelijks';
  @override String get shareRangeYearly => 'Jaarlijks';
  @override String get shareButton => 'Delen';
  @override String get monthlyOverview => 'MAANDOVERZICHT';

  @override String get languageEnglish => 'Engels';
  @override String get languageTurkish => 'Turks';

  @override String get focusShort => 'Focus';
  @override String get shortBreakShort => 'Kort';
  @override String get longBreakShort => 'Lang';

  @override String get addNote => 'Notitie toevoegen';
}
