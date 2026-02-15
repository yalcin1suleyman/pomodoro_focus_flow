import 'language.dart';

class ChineseLanguage implements Language {
  @override String get code => 'zh';
  @override String get name => '中文';

  @override String get settings => '设置';
  @override String get appearance => '外观';
  @override String get darkMode => '深色模式';
  @override String get theme => '主题';
  @override String get language => '语言';
  @override String get focusSounds => '专注音效';
  @override String get tasks => '任务';
  @override String get stats => '统计';
  @override String get focus => '专注';
  @override String get shortBreak => '短休息';
  @override String get longBreak => '长休息';
  @override String get version => '版本';

  @override String get weeklyActivity => '每周活动';
  @override String get focusTime => '专注时间';
  @override String get dailyGoal => '每日目标';
  @override String get remaining => '剩余';
  @override String get completed => '已完成';
  @override String get setGoal => '设定目标';
  @override String get hours => '小时';
  
  @override String get timerSettings => '计时器设置';
  @override String get pomodoroDuration => '番茄时长';
  @override String get shortBreakDuration => '短休息时长';
  @override String get longBreakDuration => '长休息时长';
  @override String get minutes => '分钟';
  @override String get timeIsUp => '时间到！';
  @override String get sessionCompleted => '会话完成';
  @override String get breakOver => '休息结束';

  @override String get themeClassic => '经典';
  @override String get themeSakura => '樱花';
  @override String get themeOcean => '海洋';
  @override String get themeForest => '森林';
  @override String get themeSilver => '银色';

  @override String get cancel => '取消';
  @override String get save => '保存';
  @override String get close => '关闭';
  @override String get delete => '删除';
  @override String get saveNote => '保存笔记';
  @override String get editNote => '编辑笔记';

  @override String get today => '今天';
  @override String get empty => '空';
  @override String get newTask => '新任务';
  @override String get taskHint => '在做什么？';
  @override String get estPomodoros => '预估番茄钟:';
  @override String get createTask => '创建任务';
  @override String get updateTask => '更新';
  @override String get noTasks => '没有任务。添加一个吧！';
  @override String get pomodoroCount => '番茄钟';
  @override String get inProgress => '进行中';
  @override String get focusedTime => '专注时长';
  @override String get tasksWorkedOn => '活动:';
  @override String get completedTasksLabel => '已完成任务';
  @override String get noTasksRecorded => '无记录';
  @override String get dailyNote => '每日笔记:';
  @override String get noteHint => '今天的专注效果如何？';
  @override String get generalFocus => '一般专注';
  @override String get goalMet => '目标达成';
  @override String get goalMissed => '未达标';
  @override String get tasksHelpTitle => '任务管理';
  @override String get tasksHelpContent => '高效管理任务：\n\n1. 创建任务\n点击 (+) 按钮添加新任务。\n\n2. 估算\n估算您需要多少个番茄钟（25分钟）。\n\n3. 开始专注\n点击任务上的播放 (▶) 按钮开始计时。\n\n4. 编辑和删除\n向左滑动任务卡片以查看选项。\n\n5. 追踪进度\n计时结束时，进度会自动记录。';

  @override String get tasksHelpStep1Title => '创建任务';
  @override String get tasksHelpStep1Content => '点击 (+) 按钮添加新任务。';
  
  @override String get tasksHelpStep2Title => '估算';
  @override String get tasksHelpStep2Content => '估算完成任务需要多少个番茄钟（25分钟）。';
  
  @override String get tasksHelpStep3Title => '开始专注';
  @override String get tasksHelpStep3Content => '点击任务上的播放 (▶) 按钮开始专注计时。';
  
  @override String get tasksHelpStep4Title => '编辑和删除';
  @override String get tasksHelpStep4Content => '向左滑动任务卡片以显示编辑和删除选项。';

  @override String get tasksHelpStep5Title => '追踪进度';
  @override String get tasksHelpStep5Content => '计时器结束时，进度会记录在统计数据中。没有任务的会话将记录为“一般专注”。';

  @override String get navFocus => '专注';
  @override String get navTasks => '任务';
  @override String get navStats => '统计';
  @override String get navSettings => '设置';

  @override String get monthJan => '1月';
  @override String get monthFeb => '2月';
  @override String get monthMar => '3月';
  @override String get monthApr => '4月';
  @override String get monthMay => '5月';
  @override String get monthJun => '6月';
  @override String get monthJul => '7月';
  @override String get monthAug => '8月';
  @override String get monthSep => '9月';
  @override String get monthOct => '10月';
  @override String get monthNov => '11月';
  @override String get monthDec => '12月';
  
  @override String get share => '分享';
  @override String get shareStatsTitle => '我的统计';
  @override String get shareMessage => '看看我的进度！';
  @override String get statsDaily => '日统计';
  @override String get statsMonthly => '月统计';
  @override String get stats6Months => '6个月';
  @override String get statsYearly => '年统计';
  @override String get average => '平均';
  @override String get sessions => '次';
  @override String get heatmapLegend => '少 • 多';

  @override String get soundType => '声音';
  @override String get soundTypeBell => '铃声';
  @override String get soundTypeNotification => '通知音';

  @override String get shareFooterQuote => '使用 Pomodoro Master 专注';
  @override String get shareGoalCompleted => '目标达成';
  @override String get shareTopFocus => '最佳专注';
  @override String get shareLegendStart => '开始';
  @override String get shareLegendGoal => '目标';
  @override String get shareWeeklyFocus => '每周专注';
  @override String get shareYearlyJourney => '旅程';

  @override String get quoteMotivation1 => "专注是成功的关键。";
  @override String get quoteMotivation2 => "一次一个番茄钟。";
  @override String get quoteMotivation3 => "积少成多。";
  @override String get quoteMotivation4 => "继续前进！";
  @override String get quoteMotivation5 => "未来始于当下。";
  @override String get quoteMotivation6 => "保持一致，保持专注。";
  @override String get quoteMotivation7 => "深度工作很重要。";

  @override String get shareRange => '范围';
  @override String get shareRangeDaily => '日';
  @override String get shareRangeWeekly => '周';
  @override String get shareRangeMonthly => '月';
  @override String get shareRangeYearly => '年';
  @override String get shareButton => '分享';
  @override String get monthlyOverview => '月度概览';

  @override String get shareAdUnlockContent => 'You must watch a short ad to unlock this feature.';
  @override String get shareAdUnlockButton => 'Watch Ad';
  
  @override String get shareSummary => 'Summary';
  @override String get shareFocused => 'focused';
  @override String get shareSessions => 'sessions';
  @override String get shareStreak => 'Share your streak and keep yourself accountable 🚀';

  @override String get languageEnglish => '英语';
  @override String get languageTurkish => '土耳其语';

  @override String get focusShort => '专注';
  @override String get shortBreakShort => '休息';
  @override String get longBreakShort => '长休';

  @override String get addNote => '添加笔记';
}
