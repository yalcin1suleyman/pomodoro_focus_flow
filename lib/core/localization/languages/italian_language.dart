import 'language.dart';

class ItalianLanguage implements Language {
  @override String get code => 'it';
  @override String get name => 'Italiano';

  @override String get settings => 'Impostazioni';
  @override String get appearance => 'Aspetto';
  @override String get darkMode => 'Modo Scuro';
  @override String get theme => 'Tema';
  @override String get language => 'Lingua';
  @override String get focusSounds => 'Suoni Focus';
  @override String get tasks => 'Attività';
  @override String get stats => 'Statistiche';
  @override String get focus => 'Focus';
  @override String get shortBreak => 'Pisc. Pausa';
  @override String get longBreak => 'Lunga Pausa';
  @override String get version => 'Versione';

  @override String get weeklyActivity => 'Attività Settimanale';
  @override String get focusTime => 'Tempo Focus';
  @override String get dailyGoal => 'Obiettivo Giorn.';
  @override String get remaining => 'Rimanente';
  @override String get completed => 'Completato';
  @override String get setGoal => 'Imp. Obiettivo';
  @override String get hours => 'Ore';
  
  @override String get timerSettings => 'Impostazioni Timer';
  @override String get pomodoroDuration => 'Durata Pomodoro';
  @override String get shortBreakDuration => 'Durata Pausa Breve';
  @override String get longBreakDuration => 'Durata Pausa Lunga';
  @override String get minutes => 'Minuti';
  @override String get timeIsUp => 'Tempo scaduto!';
  @override String get sessionCompleted => 'Sessione Completata';
  @override String get breakOver => 'Pausa Finita';

  @override String get themeClassic => 'Classico';
  @override String get themeSakura => 'Sakura';
  @override String get themeOcean => 'Oceano';
  @override String get themeForest => 'Foresta';
  @override String get themeSilver => 'Argento';

  @override String get cancel => 'Annulla';
  @override String get save => 'Salva';
  @override String get close => 'Chiudi';
  @override String get delete => 'Elimina';
  @override String get saveNote => 'Salva Nota';
  @override String get editNote => 'Modifica Nota';

  @override String get today => 'Oggi';
  @override String get empty => 'Vuoto';
  @override String get newTask => 'Nuova Attività';
  @override String get taskHint => 'A cosa stai lavorando?';
  @override String get estPomodoros => 'Stima Pomodori:';
  @override String get createTask => 'Crea Attività';
  @override String get updateTask => 'Aggiorna';
  @override String get noTasks => 'Nessuna attività.';
  @override String get pomodoroCount => 'pomodori';
  @override String get inProgress => 'In Corso';
  @override String get focusedTime => 'Tempo Focalizzato';
  @override String get tasksWorkedOn => 'Attività:';
  @override String get completedTasksLabel => 'Completate';
  @override String get noTasksRecorded => 'Nessuna attività registrata.';
  @override String get dailyNote => 'Nota Giornaliera:';
  @override String get noteHint => 'Com\'è andato il focus oggi?';
  @override String get generalFocus => 'Focus Generale';
  @override String get goalMet => 'Obiettivo Raggiunto';
  @override String get goalMissed => 'Sotto Obiettivo';
  @override String get tasksHelpTitle => 'Gestione Attività';
  @override String get tasksHelpContent => '1. Crea (+)\n2. Stima\n3. Avvia (▶)\n4. Modifica (Swipe a sx)';

  @override String get navFocus => 'Focus';
  @override String get navTasks => 'Attività';
  @override String get navStats => 'Stats';
  @override String get navSettings => 'Impost.';

  @override String get monthJan => 'Gennaio';
  @override String get monthFeb => 'Febbraio';
  @override String get monthMar => 'Marzo';
  @override String get monthApr => 'Aprile';
  @override String get monthMay => 'Maggio';
  @override String get monthJun => 'Giugno';
  @override String get monthJul => 'Luglio';
  @override String get monthAug => 'Agosto';
  @override String get monthSep => 'Settembre';
  @override String get monthOct => 'Ottobre';
  @override String get monthNov => 'Novembre';
  @override String get monthDec => 'Dicembre';
  
  @override String get share => 'Condividi';
  @override String get shareStatsTitle => 'Le mie Statistiche';
  @override String get shareMessage => 'Guarda i miei progressi!';
  @override String get statsDaily => 'Giornaliero';
  @override String get statsMonthly => 'Mensile';
  @override String get stats6Months => '6 Mesi';
  @override String get statsYearly => 'Annuale';
  @override String get average => 'Media';
  @override String get sessions => 'Sessioni';
  @override String get heatmapLegend => 'Meno • Più';

  @override String get soundType => 'Suoni';
  @override String get soundTypeBell => 'Campana';
  @override String get soundTypeNotification => 'Notifica';

  @override String get shareFooterQuote => 'Focus con Pomodoro Master';
  @override String get shareGoalCompleted => 'Fatto';
  @override String get shareTopFocus => 'Top Focus';
  @override String get shareLegendStart => 'Inizio';
  @override String get shareLegendGoal => 'Goal';
  @override String get shareWeeklyFocus => 'FOCUS SETTIMANALE';
  @override String get shareYearlyJourney => 'VIAGGIO';

  @override String get quoteMotivation1 => "Il focus è la chiave del successo.";
  @override String get quoteMotivation2 => "Un pomodoro alla volta.";
  @override String get quoteMotivation3 => "Piccoli passi, grandi risultati.";
  @override String get quoteMotivation4 => "Continua a spingere!";
  @override String get quoteMotivation5 => "Il tuo futuro si crea oggi.";
  @override String get quoteMotivation6 => "Sii costante, resta concentrato.";
  @override String get quoteMotivation7 => "Il lavoro profondo conta.";

  @override String get shareRange => 'Intervallo';
  @override String get shareRangeDaily => 'Giornaliero';
  @override String get shareRangeWeekly => 'Settimanale';
  @override String get shareRangeMonthly => 'Mensile';
  @override String get shareRangeYearly => 'Annuale';
  @override String get shareButton => 'Condividi';
  @override String get monthlyOverview => 'PANORAMICA MENSILE';

  @override String get languageEnglish => 'Inglese';
  @override String get languageTurkish => 'Turco';

  @override String get focusShort => 'Focus';
  @override String get shortBreakShort => 'Breve';
  @override String get longBreakShort => 'Lunga';

  @override String get addNote => 'Aggiungi nota';
}
