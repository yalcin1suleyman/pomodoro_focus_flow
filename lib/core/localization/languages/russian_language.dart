import 'language.dart';

class RussianLanguage implements Language {
  @override String get code => 'ru';
  @override String get name => 'Русский';

  @override String get settings => 'Настройки';
  @override String get appearance => 'Внешний вид';
  @override String get darkMode => 'Темная тема';
  @override String get theme => 'Тема';
  @override String get language => 'Язык';
  @override String get focusSounds => 'Звуки фокуса';
  @override String get tasks => 'Задачи';
  @override String get stats => 'Статистика';
  @override String get focus => 'Фокус';
  @override String get shortBreak => 'Короткий перерыв';
  @override String get longBreak => 'Длинный перерыв';
  @override String get version => 'Версия';

  @override String get weeklyActivity => 'Недельная активность';
  @override String get focusTime => 'Время фокуса';
  @override String get dailyGoal => 'Дневная цель';
  @override String get remaining => 'Осталось';
  @override String get completed => 'Завершено';
  @override String get setGoal => 'Задать цель';
  @override String get hours => 'Часов';
  
  @override String get timerSettings => 'Настройки таймера';
  @override String get pomodoroDuration => 'Длительность Pomodoro';
  @override String get shortBreakDuration => 'Короткий перерыв';
  @override String get longBreakDuration => 'Длинный перерыв';
  @override String get minutes => 'Минуты';
  @override String get timeIsUp => 'Время вышло!';
  @override String get sessionCompleted => 'Сессия завершена';
  @override String get breakOver => 'Перерыв окончен';

  @override String get themeClassic => 'Классический';
  @override String get themeSakura => 'Сакура';
  @override String get themeOcean => 'Океан';
  @override String get themeForest => 'Лес';
  @override String get themeSilver => 'Серебро';

  @override String get cancel => 'Отмена';
  @override String get save => 'Сохранить';
  @override String get close => 'Закрыть';
  @override String get delete => 'Удалить';
  @override String get saveNote => 'Сохранить заметку';
  @override String get editNote => 'Редактировать';

  @override String get today => 'Сегодня';
  @override String get empty => 'Пусто';
  @override String get newTask => 'Новая задача';
  @override String get taskHint => 'Над чем работаете?';
  @override String get estPomodoros => 'Оценка Pomodoro:';
  @override String get createTask => 'Создать';
  @override String get updateTask => 'Обновить';
  @override String get noTasks => 'Нет задач. Добавьте одну!';
  @override String get pomodoroCount => 'pomodoro';
  @override String get inProgress => 'В процессе';
  @override String get focusedTime => 'Время фокуса';
  @override String get tasksWorkedOn => 'Активность:';
  @override String get completedTasksLabel => 'Завершенные задачи';
  @override String get noTasksRecorded => 'Нет записей.';
  @override String get dailyNote => 'Заметка дня:';
  @override String get noteHint => 'Как прошел фокус?';
  @override String get generalFocus => 'Общий фокус';
  @override String get goalMet => 'Цель достигнута';
  @override String get goalMissed => 'Ниже цели';
  @override String get tasksHelpTitle => 'Управление задачами';
  @override String get tasksHelpContent => '1. Создать (+)\n2. Оценить\n3. Начать (▶)\n4. Редактировать (Свайп влево)';

  @override String get navFocus => 'Фокус';
  @override String get navTasks => 'Задачи';
  @override String get navStats => 'Статистика';
  @override String get navSettings => 'Настр.';

  @override String get monthJan => 'Январь';
  @override String get monthFeb => 'Февраль';
  @override String get monthMar => 'Март';
  @override String get monthApr => 'Апрель';
  @override String get monthMay => 'Май';
  @override String get monthJun => 'Июнь';
  @override String get monthJul => 'Июль';
  @override String get monthAug => 'Август';
  @override String get monthSep => 'Сентябрь';
  @override String get monthOct => 'Октябрь';
  @override String get monthNov => 'Ноябрь';
  @override String get monthDec => 'Декабрь';
  
  @override String get share => 'Поделиться';
  @override String get shareStatsTitle => 'Моя статистика';
  @override String get shareMessage => 'Посмотри мой прогресс!';
  @override String get statsDaily => 'Ежедневная';
  @override String get statsMonthly => 'Ежемесячная';
  @override String get stats6Months => '6 Месяцев';
  @override String get statsYearly => 'Годовая';
  @override String get average => 'Среднее';
  @override String get sessions => 'Сессии';
  @override String get heatmapLegend => 'Меньше • Больше';

  @override String get soundType => 'Звуки';
  @override String get soundTypeBell => 'Колокольчик';
  @override String get soundTypeNotification => 'Уведомление';

  @override String get shareFooterQuote => 'Фокус с Pomodoro Master';
  @override String get shareGoalCompleted => 'Цель достигнута';
  @override String get shareTopFocus => 'Топ Фокус';
  @override String get shareLegendStart => 'Старт';
  @override String get shareLegendGoal => 'Цель';
  @override String get shareWeeklyFocus => 'НЕДЕЛЬНЫЙ ФОКУС';
  @override String get shareYearlyJourney => 'ПУТЕШЕСТВИЕ';

  @override String get quoteMotivation1 => "Фокус - ключ к успеху.";
  @override String get quoteMotivation2 => "Один pomodoro за раз.";
  @override String get quoteMotivation3 => "Маленькие шаги, большие результаты.";
  @override String get quoteMotivation4 => "Продолжай двигаться!";
  @override String get quoteMotivation5 => "Твое будущее создается сегодня.";
  @override String get quoteMotivation6 => "Будь последовательным.";
  @override String get quoteMotivation7 => "Глубокая работа важна.";

  @override String get shareRange => 'Диапазон';
  @override String get shareRangeDaily => 'День';
  @override String get shareRangeWeekly => 'Неделя';
  @override String get shareRangeMonthly => 'Месяц';
  @override String get shareRangeYearly => 'Год';
  @override String get shareButton => 'Поделиться';
  @override String get monthlyOverview => 'МЕСЯЧНЫЙ ОБЗОР';

  @override String get languageEnglish => 'Английский';
  @override String get languageTurkish => 'Турецкий';

  @override String get focusShort => 'Фокус';
  @override String get shortBreakShort => 'Короткий';
  @override String get longBreakShort => 'Длинный';

  @override String get addNote => 'Добавить заметку';
}
