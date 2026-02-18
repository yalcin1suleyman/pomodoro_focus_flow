import 'language.dart';

class GermanLanguage implements Language {
  @override String get code => 'de';
  @override String get name => 'Deutsch';

  @override String get settings => 'Einstellungen';
  @override String get appearance => 'Aussehen';
  @override String get darkMode => 'Dunkelmodus';
  @override String get theme => 'Design';
  @override String get language => 'Sprache';
  @override String get focusSounds => 'Fokus-Töne';
  @override String get tasks => 'Aufgaben';
  @override String get stats => 'Statistiken';
  @override String get focus => 'Fokus';
  @override String get shortBreak => 'Kurze Pause';
  @override String get longBreak => 'Lange Pause';
  @override String get version => 'Version';

  @override String get weeklyActivity => 'Wochenaktivität';
  @override String get focusTime => 'Fokuszeit';
  @override String get dailyGoal => 'Tagesziel';
  @override String get remaining => 'Verbleibend';
  @override String get completed => 'Erledigt';
  @override String get setGoal => 'Ziel setzen';
  @override String get hours => 'Stunden';
  
  @override String get timerSettings => 'Timer-Einstellungen';
  @override String get pomodoroDuration => 'Pomodoro-Dauer';
  @override String get shortBreakDuration => 'Kurze Pause Dauer';
  @override String get longBreakDuration => 'Lange Pause Dauer';
  @override String get minutes => 'Minuten';
  @override String get timeIsUp => 'Die Zeit ist um!';
  @override String get sessionCompleted => 'Sitzung beendet';
  @override String get breakOver => 'Pause vorbei';

  @override String get themeClassic => 'Klassisch';
  @override String get themeSakura => 'Sakura';
  @override String get themeOcean => 'Ozean';
  @override String get themeForest => 'Wald';
  @override String get themeSilver => 'Silber';

  @override String get cancel => 'Abbrechen';
  @override String get save => 'Speichern';
  @override String get close => 'Schließen';
  @override String get delete => 'Löschen';
  @override String get saveNote => 'Notiz speichern';
  @override String get editNote => 'Notiz bearbeiten';

  @override String get today => 'Heute';
  @override String get empty => 'Leer';
  @override String get newTask => 'Neue Aufgabe';
  @override String get taskHint => 'Woran arbeitest du?';
  @override String get estPomodoros => 'Gesch. Pomodoros:';
  @override String get createTask => 'Aufgabe erstellen';
  @override String get updateTask => 'Aufgabe aktualisieren';
  @override String get noTasks => 'Keine Aufgaben.';
  @override String get pomodoroCount => 'Pomodoros';
  @override String get inProgress => 'In Bearbeitung';
  @override String get focusedTime => 'Fokuszeit';
  @override String get tasksWorkedOn => 'Aktivitäten:';
  @override String get completedTasksLabel => 'Erledigte Aufgaben';
  @override String get noTasksRecorded => 'Keine Aufgaben aufgezeichnet.';
  @override String get dailyNote => 'Tagesnotiz:';
  @override String get noteHint => 'Wie war dein Fokus heute?';
  @override String get generalFocus => 'Allgemeiner Fokus';
  @override String get goalMet => 'Ziel erreicht';
  @override String get goalMissed => 'Ziel verfehlt';
  @override String get tasksHelpTitle => 'Aufgabenverwaltung';
  @override String get tasksHelpContent => 'Verwalten Sie Aufgaben effektiv, um die Produktivität zu steigern:\n\n1. Aufgabe Erstellen\nTippen Sie auf die Taste (+), um eine neue Aufgabe hinzuzufügen.\n\n2. Schätzung\nSchätzen Sie, wie viele Pomodoros Sie benötigen. (Dauer ist in den Einstellungen anpassbar).\n\n3. Fokus Starten\nTippen Sie auf die Play-Taste (▶) bei einer Aufgabe, um den Fokus-Timer zu starten.\n\n4. Bearbeiten & Löschen\nWischen Sie die Aufgabenkarte nach LINKS, um Optionen zum Bearbeiten und Löschen anzuzeigen.\n\n5. Fortschritt Verfolgen\nDer Fortschritt wird in den Statistiken protokolliert, wenn der Timer endet. Sitzungen ohne Aufgabe werden als "Allgemeiner Fokus" protokolliert.';

  @override String get tasksHelpStep1Title => 'Aufgabe Erstellen';
  @override String get tasksHelpStep1Content => 'Tippen Sie auf die Taste (+), um eine neue Aufgabe hinzuzufügen.';
  
  @override String get tasksHelpStep2Title => 'Schätzung';
  @override String get tasksHelpStep2Content => 'Schätzen Sie, wie viele Pomodoros Sie für die Aufgabe benötigen. (Dauer ist in den Einstellungen anpassbar).';
  
  @override String get tasksHelpStep3Title => 'Fokus Starten';
  @override String get tasksHelpStep3Content => 'Tippen Sie auf die Play-Taste (▶) bei einer Aufgabe, um den Fokus-Timer zu starten.';
  
  @override String get tasksHelpStep4Title => 'Bearbeiten & Löschen';
  @override String get tasksHelpStep4Content => 'Wischen Sie die Aufgabenkarte nach LINKS, um Optionen zum Bearbeiten und Löschen anzuzeigen.';
  
  @override String get tasksHelpStep5Title => 'Fortschritt Verfolgen';
  @override String get tasksHelpStep5Content => 'Der Fortschritt wird in den Statistiken protokolliert, wenn der Timer endet. Sitzungen ohne Aufgabe werden als "Allgemeiner Fokus" protokolliert.';


  @override String get navFocus => 'Fokus';
  @override String get navTasks => 'Aufgaben';
  @override String get navStats => 'Stats';
  @override String get navSettings => 'Einst.';

  @override String get monthJan => 'Januar';
  @override String get monthFeb => 'Februar';
  @override String get monthMar => 'März';
  @override String get monthApr => 'April';
  @override String get monthMay => 'Mai';
  @override String get monthJun => 'Juni';
  @override String get monthJul => 'Juli';
  @override String get monthAug => 'August';
  @override String get monthSep => 'September';
  @override String get monthOct => 'Oktober';
  @override String get monthNov => 'November';
  @override String get monthDec => 'Dezember';
  
  @override String get share => 'Teilen';
  @override String get shareStatsTitle => 'Meine Statistiken';
  @override String get shareMessage => 'Sieh dir meinen Fortschritt an!';
  @override String get statsDaily => 'Täglich';
  @override String get statsMonthly => 'Monatlich';
  @override String get stats6Months => '6 Monate';
  @override String get statsYearly => 'Jährlich';
  @override String get average => 'Durchschnitt';
  @override String get sessions => 'Sitzungen';
  @override String get heatmapLegend => 'Weniger • Mehr';

  @override String get soundType => 'Töne';
  @override String get soundTypeBell => 'Glocke';
  @override String get soundTypeNotification => 'Benachrichtigung';

  @override String get shareFooterQuote => 'Fokus mit Pomodoro Master';
  @override String get shareGoalCompleted => 'Ziel erreicht';
  @override String get shareTopFocus => 'Top Fokus';
  @override String get shareLegendStart => 'Start';
  @override String get shareLegendGoal => 'Ziel';
  @override String get shareWeeklyFocus => 'WOCHENFOKUS';
  @override String get shareYearlyJourney => 'REISE';

  @override String get quoteMotivation1 => "Fokus ist der Schlüssel zum Erfolg.";
  @override String get quoteMotivation2 => "Ein Pomodoro nach dem anderen.";
  @override String get quoteMotivation3 => "Kleine Schritte, große Ergebnisse.";
  @override String get quoteMotivation4 => "Mach weiter!";
  @override String get quoteMotivation5 => "Deine Zukunft entsteht heute.";
  @override String get quoteMotivation6 => "Bleib dran, bleib fokussiert.";
  @override String get quoteMotivation7 => "Tiefe Arbeit zählt.";

  @override String get shareRange => 'Zeitraum';
  @override String get shareRangeDaily => 'Täglich';
  @override String get shareRangeWeekly => 'Wöchentlich';
  @override String get shareRangeMonthly => 'Monatlich';
  @override String get shareRangeYearly => 'Jährlich';
  @override String get shareButton => 'Teilen';
  @override String get monthlyOverview => 'MONATSÜBERSICHT';

  @override String get shareAdUnlockContent => 'Sie müssen eine kurze Werbung ansehen, um diese Funktion freizuschalten.';
  @override String get shareAdUnlockButton => 'Werbung ansehen';
  
  @override String get shareSummary => 'Zusammenfassung';
  @override String get shareFocused => 'fokussiert';
  @override String get shareSessions => 'Sitzungen';
  @override String get shareStreak => 'Teile deinen Streak und bleib am Ball 🚀';

  @override String get languageEnglish => 'Englisch';
  @override String get languageTurkish => 'Türkisch';

  @override String get focusShort => 'Fokus';
  @override String get shortBreakShort => 'Kurz';
  @override String get longBreakShort => 'Lang';

  @override String get addNote => 'Notiz hinzufügen';
  // Help & Warnings
  @override String get helpTitle => 'App Guide';
  @override String get helpContent => 
    "**How does the app work?**\n\n"
    "**Pomodoro**: Focus for 25 minutes, then take a short break. After 4 sessions, take a long break.\n\n"
    "**Timer**: Tap start to focus. Pause if needed.\n\n"
    "**Settings**: Customize your focus durations and sounds.\n\n"
    "**Tasks**: Track your work by adding tasks.\n\n"
    "**Stats**: View your progress over time.";
  @override String get timerRunningWarning => 'Bitte stoppe den Timer, bevor du den Modus wechselst.';
  // Help Slideshow
  @override String get helpUnknown => 'Unbekannt';
  @override String get helpSlide1Title => 'Meistere Deine Zeit';
  @override String get helpSlide1Desc => 'Zeitmanagement ist eine Kunst. Halte deinen Fokus messerscharf, verhindere Burnout und maximiere deine Produktivität mit der Pomodoro-Technik.';
  
  @override String get helpSlide2Title => 'Wähle Dein Ziel';
  @override String get helpSlide2Desc => 'Große Erfolge beginnen mit kleinen Schritten. Wähle die wichtigste Aufgabe des Tages und bereite dich darauf vor, dich darauf zu konzentrieren.';
  
  @override String get helpSlide3Title => 'Volle Konzentration';
  @override String get helpSlide3Desc => 'Schalte die Außenwelt für 25 Minuten stumm. Nur du und dein Ziel. Tritt in den Deep-Work-Modus ein und erlebe den Flow.';
  
  @override String get helpSlide4Title => 'Erneuere Deinen Geist';
  @override String get helpSlide4Desc => 'Eine Pause zu machen ist keine Zeitverschwendung; es ist strategische Erneuerung. Bereite dein Gehirn mit einer kurzen 5-Minuten-Pause auf die nächste Sitzung vor.';
  
  @override String get helpSlide5Title => 'Siegeszyklus';
  @override String get helpSlide5Desc => 'Jeder abgeschlossene Zyklus ist ein riesiger Schritt in Richtung deines Ziels. Feiere deinen Erfolg, ruh dich tief aus und bereite dich stärker auf den nächsten Sieg vor.';
  
  @override String get skip => 'Überspringen';
  @override String get start => 'Starten';
  @override String get next => 'Weiter';
}
