import 'language.dart';

class GreekLanguage implements Language {
  @override String get code => 'el';
  @override String get name => 'Ελληνικά';

  @override String get settings => 'Ρυθμίσεις';
  @override String get appearance => 'Εμφάνιση';
  @override String get darkMode => 'Σκοτεινή Λειτουργία';
  @override String get theme => 'Θέμα';
  @override String get language => 'Γλώσσα';
  @override String get focusSounds => 'Ήχοι Εστίασης';
  @override String get tasks => 'Εργασίες';
  @override String get stats => 'Στατιστικά';
  @override String get focus => 'Εστίαση';
  @override String get shortBreak => 'Μικρό Διάλειμμα';
  @override String get longBreak => 'Μεγάλο Διάλειμμα';
  @override String get version => 'Έκδοση';

  @override String get weeklyActivity => 'Εβδομαδιαία Δραστηριότητα';
  @override String get focusTime => 'Χρόνος Εστίασης';
  @override String get dailyGoal => 'Ημερήσιος Στόχος';
  @override String get remaining => 'Απομένουν';
  @override String get completed => 'Ολοκληρώθηκε';
  @override String get setGoal => 'Ορισμός Στόχου';
  @override String get hours => 'Ώρες';
  
  @override String get timerSettings => 'Ρυθμίσεις Χρονομέτρου';
  @override String get pomodoroDuration => 'Διάρκεια Pomodoro';
  @override String get shortBreakDuration => 'Διάρκεια Μικρού Διαλείμματος';
  @override String get longBreakDuration => 'Διάρκεια Μεγάλου Διαλείμματος';
  @override String get minutes => 'Λεπτά';
  @override String get timeIsUp => 'Ο χρόνος τελείωσε!';
  @override String get sessionCompleted => 'Συνεδρία Ολοκληρώθηκε';
  @override String get breakOver => 'Τέλος Διαλείμματος';

  @override String get themeClassic => 'Κλασικό';
  @override String get themeSakura => 'Σακούρα';
  @override String get themeOcean => 'Ωκεανός';
  @override String get themeForest => 'Δάσος';
  @override String get themeSilver => 'Ασήμι';

  @override String get cancel => 'Ακύρωση';
  @override String get save => 'Αποθήκευση';
  @override String get close => 'Κλείσιμο';
  @override String get delete => 'Διαγραφή';
  @override String get saveNote => 'Αποθ. Σημείωσης';
  @override String get editNote => 'Επεξ. Σημείωσης';

  @override String get today => 'Σήμερα';
  @override String get empty => 'Άδειο';
  @override String get newTask => 'Νέα Εργασία';
  @override String get taskHint => 'Σε τι δουλεύεις;';
  @override String get estPomodoros => 'Εκτ. Pomodoros:';
  @override String get createTask => 'Δημιουργία';
  @override String get updateTask => 'Ενημέρωση';
  @override String get noTasks => 'Καμία εργασία. Πρόσθεσε μία!';
  @override String get pomodoroCount => 'pomodoros';
  @override String get inProgress => 'Σε Εξέλιξη';
  @override String get focusedTime => 'Χρόνος Εστίασης';
  @override String get tasksWorkedOn => 'Δραστηριότητες:';
  @override String get completedTasksLabel => 'Ολοκληρωμένες';
  @override String get noTasksRecorded => 'Καμία εργασία καταγεγραμμένη.';
  @override String get dailyNote => 'Σημείωση Ημέρας:';
  @override String get noteHint => 'Πώς πήγε η εστίαση σήμερα;';
  @override String get generalFocus => 'Γενική Εστίαση';
  @override String get goalMet => 'Στόχος Επετεύχθη';
  @override String get goalMissed => 'Κάτω από Στόχο';
  @override String get tasksHelpTitle => 'Διαχείριση Εργασιών';
  @override String get tasksHelpContent => 'Διαχειριστείτε τις εργασίες αποτελεσματικά για να αυξήσετε την παραγωγικότητα:\n\n1. Δημιουργία Εργασίας\nΠατήστε το κουμπί (+) για να προσθέσετε μια νέα εργασία.\n\n2. Εκτίμηση\nΕκτιμήστε πόσα Pomodoro χρειάζεστε. (Η διάρκεια μπορεί να προσαρμοστεί στις Ρυθμίσεις).\n\n3. Έναρξη Εστίασης\nΠατήστε το κουμπί Αναπαραγωγής (▶) σε μια εργασία για να ξεκινήσει το χρονόμετρο.\n\n4. Επεξεργασία & Διαγραφή\nΣύρετε την κάρτα εργασίας προς τα ΑΡΙΣΤΕΡΑ για επιλογές επεξεργασίας και διαγραφής.\n\n5. Παρακολούθηση Προόδου\nΗ πρόοδος καταγράφεται στα Στατιστικά όταν τελειώσει το χρονόμετρο. Συνεδρίες χωρίς εργασία καταγράφονται ως "Γενική Εστίαση".';

  @override String get tasksHelpStep1Title => 'Δημιουργία Εργασίας';
  @override String get tasksHelpStep1Content => 'Πατήστε το κουμπί (+) για να προσθέσετε μια νέα εργασία.';
  
  @override String get tasksHelpStep2Title => 'Εκτίμηση';
  @override String get tasksHelpStep2Content => 'Εκτιμήστε πόσα Pomodoro χρειάζεστε για την εργασία. (Η διάρκεια μπορεί να προσαρμοστεί στις Ρυθμίσεις).';
  
  @override String get tasksHelpStep3Title => 'Έναρξη Εστίασης';
  @override String get tasksHelpStep3Content => 'Πατήστε το κουμπί Αναπαραγωγής (▶) σε μια εργασία για να ξεκινήσει το χρονόμετρο εστίασης.';
  
  @override String get tasksHelpStep4Title => 'Επεξεργασία & Διαγραφή';
  @override String get tasksHelpStep4Content => 'Σύρετε την κάρτα εργασίας προς τα ΑΡΙΣΤΕΡΑ για να εμφανίσετε επιλογές επεξεργασίας και διαγραφής.';
  
  @override String get tasksHelpStep5Title => 'Παρακολούθηση Προόδου';
  @override String get tasksHelpStep5Content => 'Η πρόοδος καταγράφεται στα Στατιστικά όταν τελειώσει το χρονόμετρο. Συνεδρίες χωρίς εργασία καταγράφονται ως "Γενική Εστίαση".';
  @override String get navFocus => 'Εστίαση';
  @override String get navTasks => 'Εργασίες';
  @override String get navStats => 'Στατιστικά';
  @override String get navSettings => 'Ρυθμίσεις';

  @override String get monthJan => 'Ιανουάριος';
  @override String get monthFeb => 'Φεβρουάριος';
  @override String get monthMar => 'Μάρτιος';
  @override String get monthApr => 'Απρίλιος';
  @override String get monthMay => 'Μάιος';
  @override String get monthJun => 'Ιούνιος';
  @override String get monthJul => 'Ιούλιος';
  @override String get monthAug => 'Αύγουστος';
  @override String get monthSep => 'Σεπτέμβριος';
  @override String get monthOct => 'Οκτώβριος';
  @override String get monthNov => 'Νοέμβριος';
  @override String get monthDec => 'Δεκέμβριος';
  
  @override String get share => 'Κοινοποίηση';
  @override String get shareStatsTitle => 'Τα Στατιστικά μου';
  @override String get shareMessage => 'Δείτε την πρόοδό μου!';
  @override String get statsDaily => 'Ημερήσια';
  @override String get statsMonthly => 'Μηνιαία';
  @override String get stats6Months => '6 Μήνες';
  @override String get statsYearly => 'Ετήσια';
  @override String get average => 'Μέσος Όρος';
  @override String get sessions => 'Συνεδρίες';
  @override String get heatmapLegend => 'Λιγότερο • Περισσότερο';

  @override String get soundType => 'Ήχοι';
  @override String get soundTypeBell => 'Καμπάνα';
  @override String get soundTypeNotification => 'Ειδοποίηση';

  @override String get shareFooterQuote => 'Εστίαση με Pomodoro Master';
  @override String get shareGoalCompleted => 'Στόχος Επετεύχθη';
  @override String get shareTopFocus => 'Κορυφαία Εστίαση';
  @override String get shareLegendStart => 'Αρχή';
  @override String get shareLegendGoal => 'Στόχος';
  @override String get shareWeeklyFocus => 'ΕΒΔΟΜΑΔΙΑΙΑ ΕΣΤΙΑΣΗ';
  @override String get shareYearlyJourney => 'ΤΑΞΙΔΙ';

  @override String get quoteMotivation1 => "Η εστίαση είναι το κλειδί της επιτυχίας.";
  @override String get quoteMotivation2 => "Ένα pomodoro τη φορά.";
  @override String get quoteMotivation3 => "Μικρά βήματα, μεγάλα αποτελέσματα.";
  @override String get quoteMotivation4 => "Συνέχισε μπροστά!";
  @override String get quoteMotivation5 => "Το μέλλον σου δημιουργείται σήμερα.";
  @override String get quoteMotivation6 => "Μείνε συνεπής, μείνε εστιασμένος.";
  @override String get quoteMotivation7 => "Η βαθιά εργασία μετράει.";

  @override String get shareRange => 'Εύρος';
  @override String get shareRangeDaily => 'Ημερήσιο';
  @override String get shareRangeWeekly => 'Εβδομαδιαίο';
  @override String get shareRangeMonthly => 'Μηνιαίο';
  @override String get shareRangeYearly => 'Ετήσιο';
  @override String get shareButton => 'Κοινοποίηση';
  @override String get monthlyOverview => 'ΜΗΝΙΑΙΑ ΕΠΙΣΚΟΠΗΣΗ';

  @override String get shareAdUnlockContent => 'Πρέπει να παρακολουθήσετε μια σύντομη διαφήμιση για να ξεκλειδώσετε αυτήν τη λειτουργία.';
  @override String get shareAdUnlockButton => 'Δες Διαφήμιση';
  
  @override String get shareSummary => 'Σύνοψη';
  @override String get shareFocused => 'εστιασμένος';
  @override String get shareSessions => 'συνεδρίες';
  @override String get shareStreak => 'Μοιραστείτε το σερί σας και μείνετε συνεπείς 🚀';

  @override String get languageEnglish => 'Αγγλικά';
  @override String get languageTurkish => 'Τουρκικά';

  @override String get focusShort => 'Εστίαση';
  @override String get shortBreakShort => 'Μικρό';
  @override String get longBreakShort => 'Μεγάλο';

  @override String get addNote => 'Προσθήκη σημείωσης';
}
