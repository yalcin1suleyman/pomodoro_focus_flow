import 'language.dart';

class PortugueseLanguage implements Language {
  @override String get code => 'pt';
  @override String get name => 'Português';

  @override String get settings => 'Configurações';
  @override String get appearance => 'Aparência';
  @override String get darkMode => 'Modo Escuro';
  @override String get theme => 'Tema';
  @override String get language => 'Idioma';
  @override String get focusSounds => 'Sons de Foco';
  @override String get tasks => 'Tarefas';
  @override String get stats => 'Estatísticas';
  @override String get focus => 'Foco';
  @override String get shortBreak => 'Pausa Curta';
  @override String get longBreak => 'Pausa Longa';
  @override String get version => 'Versão';

  @override String get weeklyActivity => 'Atividade Semanal';
  @override String get focusTime => 'Tempo de Foco';
  @override String get dailyGoal => 'Meta Diária';
  @override String get remaining => 'Restante';
  @override String get completed => 'Concluído';
  @override String get setGoal => 'Definir Meta';
  @override String get hours => 'Horas';
  
  @override String get timerSettings => 'Config. do Temporizador';
  @override String get pomodoroDuration => 'Duração Pomodoro';
  @override String get shortBreakDuration => 'Duração Pausa Curta';
  @override String get longBreakDuration => 'Duração Pausa Longa';
  @override String get minutes => 'Minutos';
  @override String get timeIsUp => 'O tempo acabou!';
  @override String get sessionCompleted => 'Sessão Concluída';
  @override String get breakOver => 'Pausa Terminada';

  @override String get themeClassic => 'Clássico';
  @override String get themeSakura => 'Sakura';
  @override String get themeOcean => 'Oceano';
  @override String get themeForest => 'Floresta';
  @override String get themeSilver => 'Prata';

  @override String get cancel => 'Cancelar';
  @override String get save => 'Salvar';
  @override String get close => 'Fechar';
  @override String get delete => 'Excluir';
  @override String get saveNote => 'Salvar Nota';
  @override String get editNote => 'Editar Nota';

  @override String get today => 'Hoje';
  @override String get empty => 'Vazio';
  @override String get newTask => 'Nova Tarefa';
  @override String get taskHint => 'No que você está trabalhando?';
  @override String get estPomodoros => 'Est. Pomodoros:';
  @override String get createTask => 'Criar Tarefa';
  @override String get updateTask => 'Atualizar Tarefa';
  @override String get noTasks => 'Nenhuma tarefa. Adicione uma!';
  @override String get pomodoroCount => 'pomodoros';
  @override String get inProgress => 'Em Andamento';
  @override String get focusedTime => 'Tempo Focado';
  @override String get tasksWorkedOn => 'Atividades:';
  @override String get completedTasksLabel => 'Tarefas Concluídas';
  @override String get noTasksRecorded => 'Nenhuma tarefa registrada.';
  @override String get dailyNote => 'Nota Diária:';
  @override String get noteHint => 'Como foi seu foco hoje?';
  @override String get generalFocus => 'Foco Geral';
  @override String get goalMet => 'Meta Atingida';
  @override String get goalMissed => 'Abaixo da Meta';
  @override String get tasksHelpTitle => 'Gestão de Tarefas';
  @override String get tasksHelpContent => 'Gerencie suas tarefas de forma eficaz para aumentar a produtividade:\n\n1. Criar Tarefa\nToque no botão (+) para adicionar uma nova tarefa.\n\n2. Estimativa\nEstime quantos Pomodoros você precisa. (A duração é ajustável nas Configurações).\n\n3. Começar a Focar\nToque no botão Play (▶) em uma tarefa para iniciar o cronômetro.\n\n4. Editar e Excluir\nDeslize o cartão da tarefa para a ESQUERDA para ver as opções de edição e exclusão.\n\n5. Acompanhar Progresso\nO progresso é registrado nas Estatísticas quando o cronômetro termina. Sessões sem tarefa são registradas como "Foco Geral".';

  @override String get tasksHelpStep1Title => 'Criar Tarefa';
  @override String get tasksHelpStep1Content => 'Toque no botão (+) para adicionar uma nova tarefa.';
  
  @override String get tasksHelpStep2Title => 'Estimativa';
  @override String get tasksHelpStep2Content => 'Estime quantos Pomodoros você precisa para a tarefa. (A duração é ajustável nas Configurações).';
  
  @override String get tasksHelpStep3Title => 'Começar a Focar';
  @override String get tasksHelpStep3Content => 'Toque no botão Play (▶) em uma tarefa para iniciar o cronômetro de foco.';
  
  @override String get tasksHelpStep4Title => 'Editar e Excluir';
  @override String get tasksHelpStep4Content => 'Desliza o cartão da tarefa para a ESQUERDA para revelar as opções de edição e exclusão.';
  
  @override String get tasksHelpStep5Title => 'Acompanhar Progresso';
  @override String get tasksHelpStep5Content => 'O progresso é registrado nas Estatísticas quando o cronômetro termina. Sessões sem tarefa são registradas como "Foco Geral".';

  @override String get navFocus => 'Foco';
  @override String get navTasks => 'Tarefas';
  @override String get navStats => 'Stats';
  @override String get navSettings => 'Config';

  @override String get monthJan => 'Janeiro';
  @override String get monthFeb => 'Fevereiro';
  @override String get monthMar => 'Março';
  @override String get monthApr => 'Abril';
  @override String get monthMay => 'Maio';
  @override String get monthJun => 'Junho';
  @override String get monthJul => 'Julho';
  @override String get monthAug => 'Agosto';
  @override String get monthSep => 'Setembro';
  @override String get monthOct => 'Outubro';
  @override String get monthNov => 'Novembro';
  @override String get monthDec => 'Dezembro';
  
  @override String get share => 'Compartilhar';
  @override String get shareStatsTitle => 'Minhas Estatísticas';
  @override String get shareMessage => 'Veja meu progresso no foco!';
  @override String get statsDaily => 'Diário';
  @override String get statsMonthly => 'Mensal';
  @override String get stats6Months => '6 Meses';
  @override String get statsYearly => 'Anual';
  @override String get average => 'Média Diária';
  @override String get sessions => 'Sessões';
  @override String get heatmapLegend => 'Menos • Mais';

  @override String get soundType => 'Sons';
  @override String get soundTypeBell => 'Sino';
  @override String get soundTypeNotification => 'Notificação';

  @override String get shareFooterQuote => 'Foco com Pomodoro Master';
  @override String get shareGoalCompleted => 'Meta Atingida';
  @override String get shareTopFocus => 'Top Foco';
  @override String get shareLegendStart => 'Início';
  @override String get shareLegendGoal => 'Meta';
  @override String get shareWeeklyFocus => 'FOCO SEMANAL';
  @override String get shareYearlyJourney => 'JORNADA';

  @override String get quoteMotivation1 => "Foco é a chave para o sucesso.";
  @override String get quoteMotivation2 => "Um pomodoro de cada vez.";
  @override String get quoteMotivation3 => "Pequenos passos, grandes resultados.";
  @override String get quoteMotivation4 => "Continue avançando!";
  @override String get quoteMotivation5 => "Seu futuro é criado hoje.";
  @override String get quoteMotivation6 => "Seja consistente, mantenha o foco.";
  @override String get quoteMotivation7 => "Trabalho profundo importa.";

  @override String get shareRange => 'Intervalo';
  @override String get shareRangeDaily => 'Diário';
  @override String get shareRangeWeekly => 'Semanal';
  @override String get shareRangeMonthly => 'Mensal';
  @override String get shareRangeYearly => 'Anual';
  @override String get shareButton => 'Compartilhar';
  @override String get monthlyOverview => 'VISÃO GERAL MENSAL';

  @override String get shareAdUnlockContent => 'Você deve assistir a um anúncio curto para desbloquear este recurso.';
  @override String get shareAdUnlockButton => 'Assistir Anúncio';
  
  @override String get shareSummary => 'Resumo';
  @override String get shareFocused => 'focado';
  @override String get shareSessions => 'sessões';
  @override String get shareStreak => 'Compartilhe sua sequência e mantenha-se responsável 🚀';

  @override String get languageEnglish => 'Inglês';
  @override String get languageTurkish => 'Turco';

  @override String get focusShort => 'Foco';
  @override String get shortBreakShort => 'Curto';
  @override String get longBreakShort => 'Longo';

  @override String get addNote => 'Adicionar nota';
  // Help & Warnings
  @override String get helpTitle => 'App Guide';
  @override String get helpContent => 
    "**How does the app work?**\n\n"
    "**Pomodoro**: Focus for 25 minutes, then take a short break. After 4 sessions, take a long break.\n\n"
    "**Timer**: Tap start to focus. Pause if needed.\n\n"
    "**Settings**: Customize your focus durations and sounds.\n\n"
    "**Tasks**: Track your work by adding tasks.\n\n"
    "**Stats**: View your progress over time.";
  @override String get timerRunningWarning => 'Por favor, pare o temporizador antes de mudar de modo.';
  // Help Slideshow
  @override String get helpUnknown => 'Desconhecido';
  @override String get helpSlide1Title => 'Domine Seu Tempo';
  @override String get helpSlide1Desc => 'Gerenciar o tempo é uma arte. Mantenha seu foco com precisão de laser, previna o esgotamento e maximize sua produtividade com a técnica Pomodoro.';
  
  @override String get helpSlide2Title => 'Escolha Sua Meta';
  @override String get helpSlide2Desc => 'Grandes conquistas começam com pequenos passos. Escolha a tarefa mais importante do dia e prepare-se para se concentrar nela.';
  
  @override String get helpSlide3Title => 'Foco Total';
  @override String get helpSlide3Desc => 'Silencie o mundo exterior por 25 minutos. Só você e seu objetivo. Entre no modo de trabalho profundo e alcance o fluxo.';
  
  @override String get helpSlide4Title => 'Renove Sua Mente';
  @override String get helpSlide4Desc => 'Fazer uma pausa não é perda de tempo; é renovação estratégica. Prepare seu cérebro para a próxima sessão com uma breve pausa de 5 minutos.';
  
  @override String get helpSlide5Title => 'Ciclo de Vitória';
  @override String get helpSlide5Desc => 'Cada ciclo completado é um passo gigante em direção à sua meta. Celebre seu sucesso, descanse profundamente e prepare-se mais forte para a próxima vitória.';
  
  @override String get skip => 'Pular';
  @override String get start => 'Começar';
  @override String get next => 'Próximo';
}
