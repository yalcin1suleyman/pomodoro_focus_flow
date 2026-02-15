import 'language.dart';

class UkrainianLanguage implements Language {
  @override String get code => 'uk';
  @override String get name => 'Українська';

  @override String get settings => 'Налаштування';
  @override String get appearance => 'Вигляд';
  @override String get darkMode => 'Темний режим';
  @override String get theme => 'Тема';
  @override String get language => 'Мова';
  @override String get focusSounds => 'Звуки фокусу';
  @override String get tasks => 'Завдання';
  @override String get stats => 'Статистика';
  @override String get focus => 'Фокус';
  @override String get shortBreak => 'Коротка перерва';
  @override String get longBreak => 'Довга перерва';
  @override String get version => 'Версія';

  @override String get weeklyActivity => 'Тижнева активність';
  @override String get focusTime => 'Час фокусу';
  @override String get dailyGoal => 'Денна ціль';
  @override String get remaining => 'Залишилось';
  @override String get completed => 'Завершено';
  @override String get setGoal => 'Встановити ціль';
  @override String get hours => 'Год';
  
  @override String get timerSettings => 'Налаштування таймера';
  @override String get pomodoroDuration => 'Тривалість Pomodoro';
  @override String get shortBreakDuration => 'Коротка перерва';
  @override String get longBreakDuration => 'Довга перерва';
  @override String get minutes => 'Хвилини';
  @override String get timeIsUp => 'Час вийшов!';
  @override String get sessionCompleted => 'Сесія завершена';
  @override String get breakOver => 'Перерва закінчилась';

  @override String get themeClassic => 'Класичний';
  @override String get themeSakura => 'Сакура';
  @override String get themeOcean => 'Океан';
  @override String get themeForest => 'Ліс';
  @override String get themeSilver => 'Срібло';

  @override String get cancel => 'Скасувати';
  @override String get save => 'Зберегти';
  @override String get close => 'Закрити';
  @override String get delete => 'Видалити';
  @override String get saveNote => 'Зберегти нотатку';
  @override String get editNote => 'Редагувати нотатку';

  @override String get today => 'Сьогодні';
  @override String get empty => 'Порожньо';
  @override String get newTask => 'Нове завдання';
  @override String get taskHint => 'Над чим працюєте?';
  @override String get estPomodoros => 'Оцінка Pomodoro:';
  @override String get createTask => 'Створити';
  @override String get updateTask => 'Оновити';
  @override String get noTasks => 'Немає завдань. Додайте одне!';
  @override String get pomodoroCount => 'pomodoro';
  @override String get inProgress => 'В процесі';
  @override String get focusedTime => 'Час фокусу';
  @override String get tasksWorkedOn => 'Діяльність:';
  @override String get completedTasksLabel => 'Завершені завдання';
  @override String get noTasksRecorded => 'Немає записів.';
  @override String get dailyNote => 'Нотатка дня:';
  @override String get noteHint => 'Як пройшов фокус?';
  @override String get generalFocus => 'Загальний фокус';
  @override String get goalMet => 'Ціль досягнуто';
  @override String get goalMissed => 'Менше цілі';
  @override String get tasksHelpTitle => 'Керування завданнями';
  @override String get tasksHelpContent => '1. Створити (+)\n2. Оцінити\n3. Почати (▶)\n4. Редагувати (Свайп вліво)';

  @override String get navFocus => 'Фокус';
  @override String get navTasks => 'Завдання';
  @override String get navStats => 'Статистика';
  @override String get navSettings => 'Налаш.';

  @override String get monthJan => 'Січень';
  @override String get monthFeb => 'Лютий';
  @override String get monthMar => 'Березень';
  @override String get monthApr => 'Квітень';
  @override String get monthMay => 'Травень';
  @override String get monthJun => 'Червень';
  @override String get monthJul => 'Липень';
  @override String get monthAug => 'Серпень';
  @override String get monthSep => 'Вересень';
  @override String get monthOct => 'Жовтень';
  @override String get monthNov => 'Листопад';
  @override String get monthDec => 'Грудень';
  
  @override String get share => 'Поділитися';
  @override String get shareStatsTitle => 'Моя статистика';
  @override String get shareMessage => 'Перегляньте мій прогрес!';
  @override String get statsDaily => 'Щоденна';
  @override String get statsMonthly => 'Щомісячна';
  @override String get stats6Months => '6 Місяців';
  @override String get statsYearly => 'Річна';
  @override String get average => 'Середнє';
  @override String get sessions => 'Сесії';
  @override String get heatmapLegend => 'Менше • Більше';

  @override String get soundType => 'Звуки';
  @override String get soundTypeBell => 'Дзвінок';
  @override String get soundTypeNotification => 'Сповіщення';

  @override String get shareFooterQuote => 'Фокус з Pomodoro Master';
  @override String get shareGoalCompleted => 'Ціль досягнуто';
  @override String get shareTopFocus => 'Топ Фокус';
  @override String get shareLegendStart => 'Старт';
  @override String get shareLegendGoal => 'Ціль';
  @override String get shareWeeklyFocus => 'ТИЖНЕВИЙ ФОКУС';
  @override String get shareYearlyJourney => 'ПОДОРОЖ';

  @override String get quoteMotivation1 => "Фокус - ключ до успіху.";
  @override String get quoteMotivation2 => "Один pomodoro за раз.";
  @override String get quoteMotivation3 => "Маленькі кроки, великі результати.";
  @override String get quoteMotivation4 => "Продовжуй рухатися!";
  @override String get quoteMotivation5 => "Твоє майбутнє створюється сьогодні.";
  @override String get quoteMotivation6 => "Будь послідовним.";
  @override String get quoteMotivation7 => "Глибока робота важлива.";

  @override String get shareRange => 'Діапазон';
  @override String get shareRangeDaily => 'День';
  @override String get shareRangeWeekly => 'Тиждень';
  @override String get shareRangeMonthly => 'Місяць';
  @override String get shareRangeYearly => 'Рік';
  @override String get shareButton => 'Поділитися';
  @override String get monthlyOverview => 'МІСЯЧНИЙ ОГЛЯД';

  @override String get languageEnglish => 'Англійська';
  @override String get languageTurkish => 'Турецька';

  @override String get focusShort => 'Фокус';
  @override String get shortBreakShort => 'Коротка';
  @override String get longBreakShort => 'Довга';

  @override String get addNote => 'Додати нотатку';
}
