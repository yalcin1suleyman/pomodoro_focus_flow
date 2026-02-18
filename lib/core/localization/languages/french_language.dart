import 'language.dart';

class FrenchLanguage implements Language {
  @override String get code => 'fr';
  @override String get name => 'Français';

  @override String get settings => 'Paramètres';
  @override String get appearance => 'Apparence';
  @override String get darkMode => 'Mode Sombre';
  @override String get theme => 'Thème';
  @override String get language => 'Langue';
  @override String get focusSounds => 'Sons de Concentration';
  @override String get tasks => 'Tâches';
  @override String get stats => 'Statistiques';
  @override String get focus => 'Concentration';
  @override String get shortBreak => 'Pause Courte';
  @override String get longBreak => 'Pause Longue';
  @override String get version => 'Version';

  @override String get weeklyActivity => 'Activité Hebdo';
  @override String get focusTime => 'Temps de Focus';
  @override String get dailyGoal => 'Objectif Quotidien';
  @override String get remaining => 'Restant';
  @override String get completed => 'Terminé';
  @override String get setGoal => 'Définir Objectif';
  @override String get hours => 'Heures';
  
  @override String get timerSettings => 'Réglages Minuteur';
  @override String get pomodoroDuration => 'Durée Pomodoro';
  @override String get shortBreakDuration => 'Durée Pause Courte';
  @override String get longBreakDuration => 'Durée Pause Longue';
  @override String get minutes => 'Minutes';
  @override String get timeIsUp => 'Le temps est écoulé !';
  @override String get sessionCompleted => 'Session Terminée';
  @override String get breakOver => 'Pause Terminée';

  @override String get themeClassic => 'Classique';
  @override String get themeSakura => 'Sakura';
  @override String get themeOcean => 'Océan';
  @override String get themeForest => 'Forêt';
  @override String get themeSilver => 'Argent';

  @override String get cancel => 'Annuler';
  @override String get save => 'Sauvegarder';
  @override String get close => 'Fermer';
  @override String get delete => 'Supprimer';
  @override String get saveNote => 'Sauver Note';
  @override String get editNote => 'Éditer Note';

  @override String get today => 'Aujourd\'hui';
  @override String get empty => 'Vide';
  @override String get newTask => 'Nouvelle Tâche';
  @override String get taskHint => 'Sur quoi travaillez-vous ?';
  @override String get estPomodoros => 'Est. Pomodoros :';
  @override String get createTask => 'Créer Tâche';
  @override String get updateTask => 'Mettre à jour';
  @override String get noTasks => 'Aucune tâche. Ajoutez-en une !';
  @override String get pomodoroCount => 'pomodoros';
  @override String get inProgress => 'En Cours';
  @override String get focusedTime => 'Temps Concentré';
  @override String get tasksWorkedOn => 'Activités :';
  @override String get completedTasksLabel => 'Tâches Terminées';
  @override String get noTasksRecorded => 'Aucune tâche enregistrée.';
  @override String get dailyNote => 'Note du Jour :';
  @override String get noteHint => 'Comment s\'est passé votre focus ?';
  @override String get generalFocus => 'Focus Général';
  @override String get goalMet => 'Objectif Atteint';
  @override String get goalMissed => 'Sous l\'objectif';
  @override String get tasksHelpTitle => 'Gestion des Tâches';
  @override String get tasksHelpContent => 'Gérez efficacement vos tâches pour booster votre productivité :\n\n1. Créer une Tâche\nAppuyez sur le bouton (+) pour ajouter une nouvelle tâche.\n\n2. Estimation\nEstimez le nombre de Pomodoros nécessaires. (Durée modifiable dans les paramètres).\n\n3. Commencer à se Concentrer\nAppuyez sur le bouton Lecture (▶) sur une tâche pour démarrer le minuteur.\n\n4. Modifier et Supprimer\nFaites glisser la carte de la tâche vers la GAUCHE pour voir les options.\n\n5. Suivre les Progrès\nLes progrès sont enregistrés dans les Statistiques à la fin du minuteur. Les sessions sans tâche sont notées comme "Focus Général".';

  @override String get tasksHelpStep1Title => 'Créer une Tâche';
  @override String get tasksHelpStep1Content => 'Appuyez sur le bouton (+) pour ajouter une nouvelle tâche.';
  
  @override String get tasksHelpStep2Title => 'Estimation';
  @override String get tasksHelpStep2Content => 'Estimez le nombre de Pomodoros nécessaires pour la tâche. (Durée modifiable dans les paramètres).';
  
  @override String get tasksHelpStep3Title => 'Commencer à se Concentrer';
  @override String get tasksHelpStep3Content => 'Appuyez sur le bouton Lecture (▶) sur une tâche pour démarrer le minuteur de concentration.';
  
  @override String get tasksHelpStep4Title => 'Modifier et Supprimer';
  @override String get tasksHelpStep4Content => 'Faites glisser la carte de la tâche vers la GAUCHE pour révéler les options de modification et de suppression.';
  
  @override String get tasksHelpStep5Title => 'Suivre les Progrès';
  @override String get tasksHelpStep5Content => 'Les progrès sont enregistrés dans les Statistiques à la fin du minuteur. Les sessions sans tâche sont notées comme "Focus Général".';
  @override String get navFocus => 'Focus';
  @override String get navTasks => 'Tâches';
  @override String get navStats => 'Stats';
  @override String get navSettings => 'Réglages';

  @override String get monthJan => 'Janvier';
  @override String get monthFeb => 'Février';
  @override String get monthMar => 'Mars';
  @override String get monthApr => 'Avril';
  @override String get monthMay => 'Mai';
  @override String get monthJun => 'Juin';
  @override String get monthJul => 'Juillet';
  @override String get monthAug => 'Août';
  @override String get monthSep => 'Septembre';
  @override String get monthOct => 'Octobre';
  @override String get monthNov => 'Novembre';
  @override String get monthDec => 'Décembre';
  
  @override String get share => 'Partager';
  @override String get shareStatsTitle => 'Mes Stats Focus';
  @override String get shareMessage => 'Regardez mes progrès !';
  @override String get statsDaily => 'Stats Quotidiennes';
  @override String get statsMonthly => 'Stats Mensuelles';
  @override String get stats6Months => 'Stats 6 Mois';
  @override String get statsYearly => 'Stats Annuelles';
  @override String get average => 'Moyenne Journalière';
  @override String get sessions => 'Sessions';
  @override String get heatmapLegend => 'Moins • Plus';

  @override String get soundType => 'Sons';
  @override String get soundTypeBell => 'Cloche';
  @override String get soundTypeNotification => 'Notification';

  @override String get shareFooterQuote => 'Focus avec Pomodoro Master';
  @override String get shareGoalCompleted => 'Objectif Atteint';
  @override String get shareTopFocus => 'Top Focus';
  @override String get shareLegendStart => 'Début';
  @override String get shareLegendGoal => 'But';
  @override String get shareWeeklyFocus => 'FOCUS HEBDO';
  @override String get shareYearlyJourney => 'PARCOURS';

  @override String get quoteMotivation1 => "La concentration est la clé du succès.";
  @override String get quoteMotivation2 => "Un pomodoro à la fois.";
  @override String get quoteMotivation3 => "Petits pas, grands résultats.";
  @override String get quoteMotivation4 => "Continuez d'avancer !";
  @override String get quoteMotivation5 => "Votre futur se crée aujourd'hui.";
  @override String get quoteMotivation6 => "Soyez constant, restez focus.";
  @override String get quoteMotivation7 => "Le travail profond compte.";

  @override String get shareRange => 'Période';
  @override String get shareRangeDaily => 'Jour';
  @override String get shareRangeWeekly => 'Semaine';
  @override String get shareRangeMonthly => 'Mois';
  @override String get shareRangeYearly => 'Année';
  @override String get shareButton => 'Partager';
  @override String get monthlyOverview => 'APERÇU MENSUEL';

  @override String get shareAdUnlockContent => 'Vous devez regarder une courte publicité pour débloquer cette fonctionnalité.';
  @override String get shareAdUnlockButton => 'Regarder la Pub';
  
  @override String get shareSummary => 'Résumé';
  @override String get shareFocused => 'concentré';
  @override String get shareSessions => 'sessions';
  @override String get shareStreak => 'Partagez votre série et restez motivé 🚀';

  @override String get languageEnglish => 'Anglais';
  @override String get languageTurkish => 'Turc';

  @override String get focusShort => 'Focus';
  @override String get shortBreakShort => 'Court';
  @override String get longBreakShort => 'Long';

  @override String get addNote => 'Ajouter note';
}
