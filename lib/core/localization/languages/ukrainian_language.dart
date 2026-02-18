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
  @override String get tasksHelpContent => 'Ефективно керуйте завданнями для підвищення продуктивності:\n\n1. Створити Завдання\nНатисніть кнопку (+) щоб додати нове завдання.\n\n2. Оцінка\nОцініть скільки Pomodoro вам потрібно. (Тривалість можна налаштувати в Налаштуваннях).\n\n3. Почати Фокусуватися\nНатисніть кнопку Відтворення (▶) на завданні, щоб запустити таймер.\n\n4. Редагувати та Видалити\nПроведіть картку завдання ВЛІВО, щоб побачити параметри редагування та видалення.\n\n5. Відстежувати Прогрес\nПрогрес зберігається в Статистиці, коли таймер закінчується. Сесії без завдання записуються як "Загальний фокус".';

  @override String get tasksHelpStep1Title => 'Створити Завдання';
  @override String get tasksHelpStep1Content => 'Натисніть кнопку (+) щоб додати нове завдання.';
  
  @override String get tasksHelpStep2Title => 'Оцінка';
  @override String get tasksHelpStep2Content => 'Оцініть скільки Pomodoro вам потрібно для завдання. (Тривалість можна налаштувати в Налаштуваннях).';
  
  @override String get tasksHelpStep3Title => 'Почати Фокусуватися';
  @override String get tasksHelpStep3Content => 'Натисніть кнопку Відтворення (▶) на завданні, щоб запустити таймер фокусування.';
  
  @override String get tasksHelpStep4Title => 'Редагувати та Видалити';
  @override String get tasksHelpStep4Content => 'Проведіть картку завдання ВЛІВО, щоб відкрити параметри редагування та видалення.';
  
  @override String get tasksHelpStep5Title => 'Відстежувати Прогрес';
  @override String get tasksHelpStep5Content => 'Прогрес зберігається в Статистиці, коли таймер закінчується. Сесії без завдання записуються як "Загальний фокус".';

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

  @override String get shareAdUnlockContent => 'Ви повинні переглянути коротку рекламу, щоб розблокувати цю функцію.';
  @override String get shareAdUnlockButton => 'Дивитись Рекламу';
  
  @override String get shareSummary => 'Зведення';
  @override String get shareFocused => 'у фокусі';
  @override String get shareSessions => 'сесій';
  @override String get shareStreak => 'Поділіться своєю серією та тримайте себе в тонусі 🚀';

  @override String get languageEnglish => 'Англійська';
  @override String get languageTurkish => 'Турецька';

  @override String get focusShort => 'Фокус';
  @override String get shortBreakShort => 'Коротка';
  @override String get longBreakShort => 'Довга';

  @override String get addNote => 'Додати нотатку';
  // Help & Warnings
  @override String get helpTitle => 'App Guide';
  @override String get helpContent => 
    "**How does the app work?**\n\n"
    "**Pomodoro**: Focus for 25 minutes, then take a short break. After 4 sessions, take a long break.\n\n"
    "**Timer**: Tap start to focus. Pause if needed.\n\n"
    "**Settings**: Customize your focus durations and sounds.\n\n"
    "**Tasks**: Track your work by adding tasks.\n\n"
    "**Stats**: View your progress over time.";
  @override String get timerRunningWarning => 'Будь ласка, зупиніть таймер перед зміною режиму.';
  // Help Slideshow
  @override String get helpUnknown => 'Невідомо';
  @override String get helpSlide1Title => 'Керуй Своїм Часом';
  @override String get helpSlide1Desc => 'Управління часом — це мистецтво. Тримай фокус гострим як лазер, запобігай вигоранню та максимізуй продуктивність за допомогою техніки Помодоро.';
  
  @override String get helpSlide2Title => 'Обери Свою Мету';
  @override String get helpSlide2Desc => 'Великі досягнення починаються з маленьких кроків. Обери найважливіше завдання на сьогодні та підготуйся зосередитися на ньому.';
  
  @override String get helpSlide3Title => 'Повна Концентрація';
  @override String get helpSlide3Desc => 'Заглуши зовнішній світ на 25 хвилин. Тільки ти і твоя мета. Увійди в режим глибокої роботи та впіймай потік.';
  
  @override String get helpSlide4Title => 'Онови Розум';
  @override String get helpSlide4Desc => 'Перерва — це не втрата часу; це стратегічне оновлення. Підготуй мозок до наступної сесії коротким 5-хвилинним відпочинком.';
  
  @override String get helpSlide5Title => 'Цикл Перемоги';
  @override String get helpSlide5Desc => 'Кожен завершений цикл — це гігантський крок до твоєї мети. Відсвяткуй успіх, добре відпочинь і підготуйся ще сильнішим до наступної перемоги.';
  
  @override String get skip => 'Пропустити';
  @override String get start => 'Почати';
  @override String get next => 'Далі';
}
