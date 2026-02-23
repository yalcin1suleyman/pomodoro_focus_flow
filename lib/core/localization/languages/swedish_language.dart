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
  @override String get tasksHelpContent => 'Hantera uppgifter effektivt för att öka produktiviteten:\n\n1. Skapa Uppgift\nTryck på knappen (+) för att lägga till en ny uppgift.\n\n2. Uppskattning\nUppskatta hur många Pomodoros du behöver. (Längden kan justeras i Inställningar).\n\n3. Börja Fokusera\nTryck på Spela-knappen (▶) på en uppgift för att starta timern.\n\n4. Redigera & Ta Bort\nSvep uppgiftskortet till VÄNSTER för att se alternativ för redigering och borttagning.\n\n5. Följ Framsteg\nFramsteg loggas i Statistik när timern är klar. Sessioner utan uppgift loggas som "Allmänt Fokus".';

  @override String get tasksHelpStep1Title => 'Skapa Uppgift';
  @override String get tasksHelpStep1Content => 'Tryck på knappen (+) för att lägga till en ny uppgift.';
  
  @override String get tasksHelpStep2Title => 'Uppskattning';
  @override String get tasksHelpStep2Content => 'Uppskatta hur många Pomodoros du behöver för uppgiften. (Längden kan justeras i Inställningar).';
  
  @override String get tasksHelpStep3Title => 'Börja Fokusera';
  @override String get tasksHelpStep3Content => 'Tryck på Spela-knappen (▶) på en uppgift för att starta fokustimern.';
  
  @override String get tasksHelpStep4Title => 'Redigera & Ta Bort';
  @override String get tasksHelpStep4Content => 'Svep uppgiftskortet till VÄNSTER för att visa alternativ för redigering och borttagning.';
  
  @override String get tasksHelpStep5Title => 'Följ Framsteg';
  @override String get tasksHelpStep5Content => 'Framsteg loggas i Statistik när timern är klar. Sessioner utan uppgift loggas som "Allmänt Fokus".';
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

  @override String get shareAdUnlockContent => 'Du måste titta på en kort annons för att låsa upp den här funktionen.';
  @override String get shareAdUnlockButton => 'Titta på Annons';
  
  @override String get shareSummary => 'Sammanfattning';
  @override String get shareFocused => 'fokuserad';
  @override String get shareSessions => 'sessioner';
  @override String get shareStreak => 'Dela din streak och håll dig ansvarig 🚀';

  @override String get languageEnglish => 'Engelska';
  @override String get languageTurkish => 'Turkiska';

  @override String get focusShort => 'Fokus';
  @override String get shortBreakShort => 'Kort';
  @override String get longBreakShort => 'Lång';

  @override String get addNote => 'Lägg till anteckning';
  // Help & Warnings
  @override String get helpTitle => 'App Guide';
  @override String get helpContent => 
    "**How does the app work?**\n\n"
    "**Pomodoro**: Focus for 25 minutes, then take a short break. After 4 sessions, take a long break.\n\n"
    "**Timer**: Tap start to focus. Pause if needed.\n\n"
    "**Settings**: Customize your focus durations and sounds.\n\n"
    "**Tasks**: Track your work by adding tasks.\n\n"
    "**Stats**: View your progress over time.";
  @override String get timerRunningWarning => 'Stoppa timern innan du byter läge.';
  // Help Slideshow
  @override String get helpUnknown => 'Okänd';
  @override String get helpSlide1Title => 'Bemästra Din Tid';
  @override String get helpSlide1Desc => 'Tidshantering är en konst. Håll ditt fokus vasst som en laser, förhindra utbrändhet och maximera din produktivitet med Pomodoro-tekniken.';
  
  @override String get helpSlide2Title => 'Välj Ditt Mål';
  @override String get helpSlide2Desc => 'Stora prestationer börjar med små steg. Välj dagens viktigaste uppgift och förbered dig på att fokusera på den.';
  
  @override String get helpSlide3Title => 'Totalt Fokus';
  @override String get helpSlide3Desc => 'Tysta omvärlden i 25 minuter. Bara du och ditt mål. Gå in i djupt arbetsläge och fånga flödet.';
  
  @override String get helpSlide4Title => 'Förnya Ditt Sinne';
  @override String get helpSlide4Desc => 'Att ta en paus är inte slöseri med tid; det är strategisk förnyelse. Förbered din hjärna för nästa session med en kort 5-minuters paus.';
  
  @override String get helpSlide5Title => 'Segerscykel';
  @override String get helpSlide5Desc => 'Varje avslutad cykel är ett jättesteg mot ditt mål. Fira din framgång, vila djupt och förbered dig starkare för nästa seger.';
  
  @override String get skip => 'Hoppa över';
  @override String get start => 'Starta';
  @override String get next => 'Nästa';

  // Rate App & Contact Us
  @override String get rateApp => 'Betygsätt appen';
  @override String get contactUs => 'Kontakta oss';
  @override String get rateAppTitle => 'Gillar du appen?';
  @override String get rateAppMessage => 'Din recension hjälper oss att växa. Betygsätt Pomodoro Master på Play Store!';
  @override String get rateNow => 'Betygsätt nu';
  @override String get rateLater => 'Senare';
  @override String get rateAlreadyDone => 'Redan betygsatt ✓';
}
