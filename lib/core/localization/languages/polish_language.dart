import 'language.dart';

class PolishLanguage implements Language {
  @override String get code => 'pl';
  @override String get name => 'Polski';

  @override String get settings => 'Ustawienia';
  @override String get appearance => 'Wygląd';
  @override String get darkMode => 'Tryb Ciemny';
  @override String get theme => 'Motyw';
  @override String get language => 'Język';
  @override String get focusSounds => 'Dźwięki Skupienia';
  @override String get tasks => 'Zadania';
  @override String get stats => 'Statystyki';
  @override String get focus => 'Skupienie';
  @override String get shortBreak => 'Krótka Przerwa';
  @override String get longBreak => 'Długa Przerwa';
  @override String get version => 'Wersja';

  @override String get weeklyActivity => 'Aktywność Tygodniowa';
  @override String get focusTime => 'Czas Skupienia';
  @override String get dailyGoal => 'Cel Dzienny';
  @override String get remaining => 'Pozostało';
  @override String get completed => 'Ukończono';
  @override String get setGoal => 'Ustaw Cel';
  @override String get hours => 'Godz.';
  
  @override String get timerSettings => 'Ustawienia Timera';
  @override String get pomodoroDuration => 'Czas Pomodoro';
  @override String get shortBreakDuration => 'Czas Krótkiej Przerwy';
  @override String get longBreakDuration => 'Czas Długiej Przerwy';
  @override String get minutes => 'Minuty';
  @override String get timeIsUp => 'Czas minął!';
  @override String get sessionCompleted => 'Sesja Zakończona';
  @override String get breakOver => 'Koniec Przerwy';

  @override String get themeClassic => 'Klasyczny';
  @override String get themeSakura => 'Wiśnia';
  @override String get themeOcean => 'Ocean';
  @override String get themeForest => 'Las';
  @override String get themeSilver => 'Srebrny';

  @override String get cancel => 'Anuluj';
  @override String get save => 'Zapisz';
  @override String get close => 'Zamknij';
  @override String get delete => 'Usuń';
  @override String get saveNote => 'Zapisz Notatkę';
  @override String get editNote => 'Edytuj Notatkę';

  @override String get today => 'Dzisiaj';
  @override String get empty => 'Pusto';
  @override String get newTask => 'Nowe Zadanie';
  @override String get taskHint => 'Nad czym pracujesz?';
  @override String get estPomodoros => 'Szac. Pomodoro:';
  @override String get createTask => 'Utwórz Zadanie';
  @override String get updateTask => 'Aktualizuj';
  @override String get noTasks => 'Brak zadań. Dodaj nowe!';
  @override String get pomodoroCount => 'pomodoro';
  @override String get inProgress => 'W Trakcie';
  @override String get focusedTime => 'Czas Skupienia';
  @override String get tasksWorkedOn => 'Aktywności:';
  @override String get completedTasksLabel => 'Ukończone Zadania';
  @override String get noTasksRecorded => 'Brak zapisanych zadań.';
  @override String get dailyNote => 'Notatka Dnia:';
  @override String get noteHint => 'Jak poszło skupienie?';
  @override String get generalFocus => 'Ogólne Skupienie';
  @override String get goalMet => 'Cel Osiągnięty';
  @override String get goalMissed => 'Poniżej Celu';
  @override String get tasksHelpTitle => 'Zarządzanie Zadaniami';
  @override String get tasksHelpContent => '1. Utwórz Zadanie (+)\n2. Oszacuj\n3. Start (▶)\n4. Edytuj (Przesuń w lewo)';

  @override String get navFocus => 'Skupienie';
  @override String get navTasks => 'Zadania';
  @override String get navStats => 'Statystyki';
  @override String get navSettings => 'Ustawienia';

  @override String get monthJan => 'Styczeń';
  @override String get monthFeb => 'Luty';
  @override String get monthMar => 'Marzec';
  @override String get monthApr => 'Kwiecień';
  @override String get monthMay => 'Maj';
  @override String get monthJun => 'Czerwiec';
  @override String get monthJul => 'Lipiec';
  @override String get monthAug => 'Sierpień';
  @override String get monthSep => 'Wrzesień';
  @override String get monthOct => 'Październik';
  @override String get monthNov => 'Listopad';
  @override String get monthDec => 'Grudzień';
  
  @override String get share => 'Udostępnij';
  @override String get shareStatsTitle => 'Moje Statystyki';
  @override String get shareMessage => 'Sprawdź mój postęp!';
  @override String get statsDaily => 'Dzienne';
  @override String get statsMonthly => 'Miesięczne';
  @override String get stats6Months => '6 Miesięcy';
  @override String get statsYearly => 'Roczne';
  @override String get average => 'Średnia';
  @override String get sessions => 'Sesje';
  @override String get heatmapLegend => 'Mniej • Więcej';

  @override String get soundType => 'Dźwięki';
  @override String get soundTypeBell => 'Dzwonek';
  @override String get soundTypeNotification => 'Powiadomienie';

  @override String get shareFooterQuote => 'Skupienie z Pomodoro Master';
  @override String get shareGoalCompleted => 'Cel Osiągnięty';
  @override String get shareTopFocus => 'Top Skupienie';
  @override String get shareLegendStart => 'Start';
  @override String get shareLegendGoal => 'Cel';
  @override String get shareWeeklyFocus => 'FOCUS TYGODNIA';
  @override String get shareYearlyJourney => 'PODRÓŻ';

  @override String get quoteMotivation1 => "Skupienie to klucz do sukcesu.";
  @override String get quoteMotivation2 => "Jedno pomodoro naraz.";
  @override String get quoteMotivation3 => "Małe kroki, wielkie wyniki.";
  @override String get quoteMotivation4 => "Przyj do przodu!";
  @override String get quoteMotivation5 => "Twój przyszłość tworzy się dziś.";
  @override String get quoteMotivation6 => "Bądź konsekwentny.";
  @override String get quoteMotivation7 => "Głęboka praca ma znaczenie.";

  @override String get shareRange => 'Zakres';
  @override String get shareRangeDaily => 'Dzienny';
  @override String get shareRangeWeekly => 'Tygodniowy';
  @override String get shareRangeMonthly => 'Miesięczny';
  @override String get shareRangeYearly => 'Roczny';
  @override String get shareButton => 'Udostępnij';
  @override String get monthlyOverview => 'PRZEGLĄD MIESIĘCZNY';

  @override String get languageEnglish => 'Angielski';
  @override String get languageTurkish => 'Turecki';

  @override String get focusShort => 'Skupienie';
  @override String get shortBreakShort => 'Krótka';
  @override String get longBreakShort => 'Długa';

  @override String get addNote => 'Dodaj notatkę';
}
