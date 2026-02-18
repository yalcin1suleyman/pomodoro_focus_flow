import 'language.dart';

class SpanishLanguage implements Language {
  @override String get code => 'es';
  @override String get name => 'Español';

  @override String get settings => 'Ajustes';
  @override String get appearance => 'Apariencia';
  @override String get darkMode => 'Modo Oscuro';
  @override String get theme => 'Tema';
  @override String get language => 'Idioma';
  @override String get focusSounds => 'Sonidos de Enfoque';
  @override String get tasks => 'Tareas';
  @override String get stats => 'Estadísticas';
  @override String get focus => 'Enfoque';
  @override String get shortBreak => 'Descanso Corto';
  @override String get longBreak => 'Descanso Largo';
  @override String get version => 'Versión';

  @override String get weeklyActivity => 'Actividad Semanal';
  @override String get focusTime => 'Tiempo de Enfoque';
  @override String get dailyGoal => 'Meta Diaria';
  @override String get remaining => 'Restante';
  @override String get completed => 'Completado';
  @override String get setGoal => 'Establecer Meta';
  @override String get hours => 'Horas';
  
  @override String get timerSettings => 'Ajustes del Temporizador';
  @override String get pomodoroDuration => 'Duración Pomodoro';
  @override String get shortBreakDuration => 'Duración Descanso Corto';
  @override String get longBreakDuration => 'Duración Descanso Largo';
  @override String get minutes => 'Minutos';
  @override String get timeIsUp => '¡Se acabó el tiempo!';
  @override String get sessionCompleted => 'Sesión Completada';
  @override String get breakOver => 'Fin del Descanso';

  @override String get themeClassic => 'Clásico';
  @override String get themeSakura => 'Sakura';
  @override String get themeOcean => 'Océano';
  @override String get themeForest => 'Bosque';
  @override String get themeSilver => 'Plata';

  @override String get cancel => 'Cancelar';
  @override String get save => 'Guardar';
  @override String get close => 'Cerrar';
  @override String get delete => 'Eliminar';
  @override String get saveNote => 'Guardar Nota';
  @override String get editNote => 'Editar Nota';

  @override String get today => 'Hoy';
  @override String get empty => 'Vacío';
  @override String get newTask => 'Nueva Tarea';
  @override String get taskHint => '¿En qué estás trabajando?';
  @override String get estPomodoros => 'Est. Pomodoros:';
  @override String get createTask => 'Crear Tarea';
  @override String get updateTask => 'Actualizar Tarea';
  @override String get noTasks => 'No hay tareas. ¡Añade una!';
  @override String get pomodoroCount => 'pomodoros';
  @override String get inProgress => 'En Progreso';
  @override String get focusedTime => 'Tiempo Enfocado';
  @override String get tasksWorkedOn => 'Actividades:';
  @override String get completedTasksLabel => 'Tareas Completadas';
  @override String get noTasksRecorded => 'No hay tareas registradas.';
  @override String get dailyNote => 'Nota Diaria:';
  @override String get noteHint => '¿Cómo fue tu enfoque hoy?';
  @override String get generalFocus => 'Enfoque General';
  @override String get goalMet => 'Meta Alcanzada';
  @override String get goalMissed => 'Por debajo de la meta';
  @override String get tasksHelpTitle => 'Gestión de Tareas';
  @override String get tasksHelpContent => 'Administra tus tareas eficazmente para aumentar la productividad:\n\n1. Crear Tarea\nToca el botón (+) para añadir una nueva tarea.\n\n2. Estimación\nEstima cuántos Pomodoros necesitas. (La duración es ajustable en Ajustes).\n\n3. Empezar a Enfocarse\nToca el botón Play (▶) en una tarea para iniciar el temporizador.\n\n4. Editar y Eliminar\nDesliza la tarjeta de la tarea a la IZQUIERDA para ver opciones de edición y eliminación.\n\n5. Seguir Progreso\nEl progreso se registra en Estadísticas cuando termina el temporizador. Las sesiones sin tarea se registran como "Enfoque General".';

  @override String get tasksHelpStep1Title => 'Crear Tarea';
  @override String get tasksHelpStep1Content => 'Toca el botón (+) para añadir una nueva tarea.';
  
  @override String get tasksHelpStep2Title => 'Estimación';
  @override String get tasksHelpStep2Content => 'Estima cuántos Pomodoros necesitas para la tarea. (La duración es ajustable en Ajustes).';
  
  @override String get tasksHelpStep3Title => 'Empezar a Enfocarse';
  @override String get tasksHelpStep3Content => 'Toca el botón Play (▶) en una tarea para iniciar el temporizador de enfoque.';
  
  @override String get tasksHelpStep4Title => 'Editar y Eliminar';
  @override String get tasksHelpStep4Content => 'Desliza la tarjeta de la tarea a la IZQUIERDA para ver las opciones de editar y eliminar.';
  
  @override String get tasksHelpStep5Title => 'Seguir Progreso';
  @override String get tasksHelpStep5Content => 'El progreso se registra en Estadísticas cuando termina el temporizador. Las sesiones sin tarea se registran como "Enfoque General".';

  @override String get navFocus => 'Enfoque';
  @override String get navTasks => 'Tareas';
  @override String get navStats => 'Estadísticas';
  @override String get navSettings => 'Ajustes';

  @override String get monthJan => 'Enero';
  @override String get monthFeb => 'Febrero';
  @override String get monthMar => 'Marzo';
  @override String get monthApr => 'Abril';
  @override String get monthMay => 'Mayo';
  @override String get monthJun => 'Junio';
  @override String get monthJul => 'Julio';
  @override String get monthAug => 'Agosto';
  @override String get monthSep => 'Septiembre';
  @override String get monthOct => 'Octubre';
  @override String get monthNov => 'Noviembre';
  @override String get monthDec => 'Diciembre';
  
  @override String get share => 'Compartir';
  @override String get shareStatsTitle => 'Mis Estadísticas';
  @override String get shareMessage => '¡Mira mi progreso!';
  @override String get statsDaily => 'Estad. Diarias';
  @override String get statsMonthly => 'Estad. Mensuales';
  @override String get stats6Months => 'Estad. 6 Meses';
  @override String get statsYearly => 'Estad. Anuales';
  @override String get average => 'Promedio Diario';
  @override String get sessions => 'Sesiones';
  @override String get heatmapLegend => 'Menos • Más';

  @override String get soundType => 'Sonidos';
  @override String get soundTypeBell => 'Campana';
  @override String get soundTypeNotification => 'Notificación';

  @override String get shareFooterQuote => 'Enfócate con Pomodoro Master';
  @override String get shareGoalCompleted => 'Meta Completada';
  @override String get shareTopFocus => 'Mejor Enfoque';
  @override String get shareLegendStart => 'Inicio';
  @override String get shareLegendGoal => 'Meta';
  @override String get shareWeeklyFocus => 'ENFOQUE SEMANAL';
  @override String get shareYearlyJourney => 'VIAJE';

  @override String get quoteMotivation1 => "El enfoque es la clave del éxito.";
  @override String get quoteMotivation2 => "Un pomodoro a la vez.";
  @override String get quoteMotivation3 => "Pequeños pasos, grandes resultados.";
  @override String get quoteMotivation4 => "¡Sigue adelante!";
  @override String get quoteMotivation5 => "Tu futuro se crea hoy.";
  @override String get quoteMotivation6 => "Sé constante, mantente enfocado.";
  @override String get quoteMotivation7 => "El trabajo profundo importa.";

  @override String get shareRange => 'Rango';
  @override String get shareRangeDaily => 'Diario';
  @override String get shareRangeWeekly => 'Semanal';
  @override String get shareRangeMonthly => 'Mensual';
  @override String get shareRangeYearly => 'Anual';
  @override String get shareButton => 'Compartir';
  @override String get monthlyOverview => 'RESUMEN MENSUAL';

  @override String get shareAdUnlockContent => 'Debes ver un anuncio corto para desbloquear esta función.';
  @override String get shareAdUnlockButton => 'Ver Anuncio';
  
  @override String get shareSummary => 'Resumen';
  @override String get shareFocused => 'enfocado';
  @override String get shareSessions => 'sesiones';
  @override String get shareStreak => 'Comparte tu racha y mantente responsable 🚀';

  @override String get languageEnglish => 'Inglés';
  @override String get languageTurkish => 'Turco';

  @override String get focusShort => 'Enfoque';
  @override String get shortBreakShort => 'Corto';
  @override String get longBreakShort => 'Largo';

  @override String get addNote => 'Añadir nota';
  // Help & Warnings
  @override String get helpTitle => 'App Guide';
  @override String get helpContent => 
    "**How does the app work?**\n\n"
    "**Pomodoro**: Focus for 25 minutes, then take a short break. After 4 sessions, take a long break.\n\n"
    "**Timer**: Tap start to focus. Pause if needed.\n\n"
    "**Settings**: Customize your focus durations and sounds.\n\n"
    "**Tasks**: Track your work by adding tasks.\n\n"
    "**Stats**: View your progress over time.";
  @override String get timerRunningWarning => 'Por favor, detén el temporizador antes de cambiar de modo.';
  // Help Slideshow
  @override String get helpUnknown => 'Desconocido';
  @override String get helpSlide1Title => 'Domina Tu Tiempo';
  @override String get helpSlide1Desc => 'Gestionar el tiempo es un arte. Mantén tu enfoque con precisión láser, previene el agotamiento y maximiza tu productividad con la técnica Pomodoro.';
  
  @override String get helpSlide2Title => 'Elige Tu Meta';
  @override String get helpSlide2Desc => 'Los grandes logros comienzan con pequeños pasos. Elige la tarea más importante del día y prepárate para enfocarte en ella.';
  
  @override String get helpSlide3Title => 'Enfoque Total';
  @override String get helpSlide3Desc => 'Silencia el mundo exterior durante 25 minutos. Solo tú y tu objetivo. Entra en modo de trabajo profundo y alcanza el flujo.';
  
  @override String get helpSlide4Title => 'Renueva Tu Mente';
  @override String get helpSlide4Desc => 'Tomar un descanso no es perder el tiempo; es una renovación estratégica. Prepara tu cerebro para la siguiente sesión con un breve descanso de 5 minutos.';
  
  @override String get helpSlide5Title => 'Ciclo de Victoria';
  @override String get helpSlide5Desc => 'Cada ciclo completado es un paso gigante hacia tu meta. Celebra tu éxito, descansa profundamente y prepárate más fuerte para la próxima victoria.';
  
  @override String get skip => 'Omitir';
  @override String get start => 'Comenzar';
  @override String get next => 'Siguiente';
}
