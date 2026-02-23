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
  @override String get tasksHelpContent => 'Управляйте задачами эффективно для повышения продуктивности:\n\n1. Создать Задачу\nНажмите кнопку (+) чтобы добавить новую задачу.\n\n2. Оценка\nОцените, сколько Pomodoro вам нужно. (Длительность настраивается в Настройках).\n\n3. Начать Фокусировку\nНажмите кнопку Воспроизведения (▶) на задаче, чтобы запустить таймер.\n\n4. Редактировать и Удалить\nПроведите карточку задачи ВЛЕВО, чтобы увидеть опции редактирования и удаления.\n\n5. Отслеживать Прогресс\nПрогресс сохраняется в Статистике, когда таймер заканчивается. Сессии без задачи записываются как "Общий фокус".';

  @override String get tasksHelpStep1Title => 'Создать Задачу';
  @override String get tasksHelpStep1Content => 'Нажмите кнопку (+) чтобы добавить новую задачу.';
  
  @override String get tasksHelpStep2Title => 'Оценка';
  @override String get tasksHelpStep2Content => 'Оцените, сколько Pomodoro вам нужно для задачи. (Длительность настраивается в Настройках).';
  
  @override String get tasksHelpStep3Title => 'Начать Фокусировку';
  @override String get tasksHelpStep3Content => 'Нажмите кнопку Воспроизведения (▶) на задаче, чтобы запустить таймер фокусировки.';
  
  @override String get tasksHelpStep4Title => 'Редактировать и Удалить';
  @override String get tasksHelpStep4Content => 'Проведите карточку задачи ВЛЕВО, чтобы открыть опции редактирования и удаления.';
  
  @override String get tasksHelpStep5Title => 'Отслеживать Прогресс';
  @override String get tasksHelpStep5Content => 'Прогресс сохраняется в Статистике, когда таймер заканчивается. Сессии без задачи записываются как "Общий фокус".';

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

  @override String get shareAdUnlockContent => 'Вы должны посмотреть короткую рекламу, чтобы разблокировать эту функцию.';
  @override String get shareAdUnlockButton => 'Смотреть рекламу';
  
  @override String get shareSummary => 'Сводка';
  @override String get shareFocused => 'в фокусе';
  @override String get shareSessions => 'сессий';
  @override String get shareStreak => 'Поделитесь своим сериями и держите себя в тонусе 🚀';

  @override String get languageEnglish => 'Английский';
  @override String get languageTurkish => 'Турецкий';

  @override String get focusShort => 'Фокус';
  @override String get shortBreakShort => 'Короткий';
  @override String get longBreakShort => 'Длинный';

  @override String get addNote => 'Добавить заметку';
  // Help & Warnings
  @override String get helpTitle => 'App Guide';
  @override String get helpContent => 
    "**How does the app work?**\n\n"
    "**Pomodoro**: Focus for 25 minutes, then take a short break. After 4 sessions, take a long break.\n\n"
    "**Timer**: Tap start to focus. Pause if needed.\n\n"
    "**Settings**: Customize your focus durations and sounds.\n\n"
    "**Tasks**: Track your work by adding tasks.\n\n"
    "**Stats**: View your progress over time.";
  @override String get timerRunningWarning => 'Пожалуйста, остановите таймер перед сменой режима.';
  // Help Slideshow
  @override String get helpUnknown => 'Неизвестно';
  @override String get helpSlide1Title => 'Управляй Своим Временем';
  @override String get helpSlide1Desc => 'Управление временем — это искусство. Держи фокус острым как лазер, предотвращай выгорание и максимизируй продуктивность с техникой Помодоро.';
  
  @override String get helpSlide2Title => 'Выбери Свою Цель';
  @override String get helpSlide2Desc => 'Великие достижения начинаются с маленьких шагов. Выбери самую важную задачу на сегодня и подготовься сосредоточиться на ней.';
  
  @override String get helpSlide3Title => 'Полная Концентрация';
  @override String get helpSlide3Desc => 'Заглуши внешний мир на 25 минут. Только ты и твоя цель. Войди в режим глубокой работы и поймай поток.';
  
  @override String get helpSlide4Title => 'Обнови Разум';
  @override String get helpSlide4Desc => 'Перерыв — это не потеря времени; это стратегическое обновление. Подготовь мозг к следующей сессии коротким 5-минутным перерывом.';
  
  @override String get helpSlide5Title => 'Цикл Победы';
  @override String get helpSlide5Desc => 'Каждый завершённый цикл — это гигантский шаг к твоей цели. Отпразднуй успех, хорошо отдохни и подготовься ещё сильнее к следующей победе.';
  
  @override String get skip => 'Пропустить';
  @override String get start => 'Начать';
  @override String get next => 'Далее';

  // Rate App & Contact Us
  @override String get rateApp => 'Оценить приложение';
  @override String get contactUs => 'Связаться с нами';
  @override String get rateAppTitle => 'Нравится приложение?';
  @override String get rateAppMessage => 'Ваш отзыв помогает нам расти. Оцените Pomodoro Master в Play Store!';
  @override String get rateNow => 'Оценить';
  @override String get rateLater => 'Позже';
  @override String get rateAlreadyDone => 'Уже оценено ✓';
}
