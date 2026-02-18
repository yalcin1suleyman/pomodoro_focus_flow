import 'language.dart';

class JapaneseLanguage implements Language {
  @override String get code => 'ja';
  @override String get name => '日本語';

  @override String get settings => '設定';
  @override String get appearance => '外観';
  @override String get darkMode => 'ダークモード';
  @override String get theme => 'テーマ';
  @override String get language => '言語';
  @override String get focusSounds => '集中サウンド';
  @override String get tasks => 'タスク';
  @override String get stats => '統計';
  @override String get focus => '集中';
  @override String get shortBreak => '短い休憩';
  @override String get longBreak => '長い休憩';
  @override String get version => 'バージョン';

  @override String get weeklyActivity => '週間アクティビティ';
  @override String get focusTime => '集中時間';
  @override String get dailyGoal => '一日の目標';
  @override String get remaining => '残り';
  @override String get completed => '完了';
  @override String get setGoal => '目標設定';
  @override String get hours => '時間';
  
  @override String get timerSettings => 'タイマー設定';
  @override String get pomodoroDuration => 'ポモドーロ時間';
  @override String get shortBreakDuration => '短い休憩時間';
  @override String get longBreakDuration => '長い休憩時間';
  @override String get minutes => '分';
  @override String get timeIsUp => '時間です！';
  @override String get sessionCompleted => 'セッション完了';
  @override String get breakOver => '休憩終了';

  @override String get themeClassic => 'クラシック';
  @override String get themeSakura => '桜';
  @override String get themeOcean => '海';
  @override String get themeForest => '森';
  @override String get themeSilver => 'シルバー';

  @override String get cancel => 'キャンセル';
  @override String get save => '保存';
  @override String get close => '閉じる';
  @override String get delete => '削除';
  @override String get saveNote => 'メモを保存';
  @override String get editNote => 'メモを編集';

  @override String get today => '今日';
  @override String get empty => '空';
  @override String get newTask => '新しいタスク';
  @override String get taskHint => '何に取り組みますか？';
  @override String get estPomodoros => '予想ポモドーロ:';
  @override String get createTask => 'タスク作成';
  @override String get updateTask => '更新';
  @override String get noTasks => 'タスクがありません。追加しましょう！';
  @override String get pomodoroCount => 'ポモドーロ';
  @override String get inProgress => '進行中';
  @override String get focusedTime => '集中した時間';
  @override String get tasksWorkedOn => '活動内容:';
  @override String get completedTasksLabel => '完了したタスク';
  @override String get noTasksRecorded => '記録なし';
  @override String get dailyNote => '今日のメモ:';
  @override String get noteHint => '今日の集中はどうでしたか？';
  @override String get generalFocus => '一般的な集中';
  @override String get goalMet => '目標達成';
  @override String get goalMissed => '目標未達';
  @override String get tasksHelpTitle => 'タスク管理';
  @override String get tasksHelpContent => 'タスクを効果的に管理して生産性を向上させましょう：\n\n1. タスク作成\n(+) ボタンをタップして新しいタスクを追加します。\n\n2. 見積もり\n必要なポモドーロ数を見積もります。（期間は設定で調整可能）。\n\n3. 集中開始\nタスクの再生（▶）ボタンをタップしてタイマーを開始します。\n\n4. 編集と削除\nタスクカードを左にスワイプして編集および削除のオプションを表示します。\n\n5. 進捗追跡\nタイマーが終了すると、進捗が統計に記録されます。タスクなしのセッションは「一般的な集中」として記録されます。';

  @override String get tasksHelpStep1Title => 'タスク作成';
  @override String get tasksHelpStep1Content => '(+) ボタンをタップして新しいタスクを追加します。';
  
  @override String get tasksHelpStep2Title => '見積もり';
  @override String get tasksHelpStep2Content => 'タスクに必要なポモドーロ数を見積もります。（期間は設定で調整可能）。';
  
  @override String get tasksHelpStep3Title => '集中開始';
  @override String get tasksHelpStep3Content => 'タスクの再生（▶）ボタンをタップして集中タイマーを開始します。';
  
  @override String get tasksHelpStep4Title => '編集と削除';
  @override String get tasksHelpStep4Content => 'タスクカードを左にスワイプして、編集および削除のオプションを表示します。';
  
  @override String get tasksHelpStep5Title => '進捗追跡';
  @override String get tasksHelpStep5Content => 'タイマーが終了すると、進捗が統計に記録されます。タスクなしのセッションは「一般的な集中」として記録されます。';

  @override String get navFocus => '集中';
  @override String get navTasks => 'タスク';
  @override String get navStats => '統計';
  @override String get navSettings => '設定';

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
  
  @override String get share => '共有';
  @override String get shareStatsTitle => '私の統計';
  @override String get shareMessage => '進捗を見てください！';
  @override String get statsDaily => '日別';
  @override String get statsMonthly => '月別';
  @override String get stats6Months => '6ヶ月';
  @override String get statsYearly => '年別';
  @override String get average => '平均';
  @override String get sessions => 'セッション';
  @override String get heatmapLegend => '少 • 多';

  @override String get soundType => 'サウンド';
  @override String get soundTypeBell => 'ベル';
  @override String get soundTypeNotification => '通知音';

  @override String get shareFooterQuote => 'Pomodoro Masterで集中';
  @override String get shareGoalCompleted => '目標達成';
  @override String get shareTopFocus => 'トップフォーカス';
  @override String get shareLegendStart => '開始';
  @override String get shareLegendGoal => '目標';
  @override String get shareWeeklyFocus => '週間フォーカス';
  @override String get shareYearlyJourney => 'ジャーニー';

  @override String get quoteMotivation1 => "集中は成功への鍵。";
  @override String get quoteMotivation2 => "一つずつ着実に。";
  @override String get quoteMotivation3 => "小さな一歩が大きな成果に。";
  @override String get quoteMotivation4 => "前進し続けよう！";
  @override String get quoteMotivation5 => "未来は今日作られる。";
  @override String get quoteMotivation6 => "継続は力なり。";
  @override String get quoteMotivation7 => "深い集中が重要。";

  @override String get shareRange => '期間';
  @override String get shareRangeDaily => '日';
  @override String get shareRangeWeekly => '週';
  @override String get shareRangeMonthly => '月';
  @override String get shareRangeYearly => '年';
  @override String get shareButton => '共有';
  @override String get monthlyOverview => '月間概要';

  @override String get shareAdUnlockContent => 'この機能のロックを解除するには、短い広告を視聴する必要があります。';
  @override String get shareAdUnlockButton => '広告を見る';
  
  @override String get shareSummary => '概要';
  @override String get shareFocused => '集中';
  @override String get shareSessions => 'セッション';
  @override String get shareStreak => 'ストリークを共有して、責任を持ち続けましょう 🚀';

  @override String get languageEnglish => '英語';
  @override String get languageTurkish => 'トルコ語';

  @override String get focusShort => '集中';
  @override String get shortBreakShort => '休憩';
  @override String get longBreakShort => '長休';

  @override String get addNote => 'メモを追加';
  // Help & Warnings
  @override String get helpTitle => 'App Guide';
  @override String get helpContent => 
    "**How does the app work?**\n\n"
    "**Pomodoro**: Focus for 25 minutes, then take a short break. After 4 sessions, take a long break.\n\n"
    "**Timer**: Tap start to focus. Pause if needed.\n\n"
    "**Settings**: Customize your focus durations and sounds.\n\n"
    "**Tasks**: Track your work by adding tasks.\n\n"
    "**Stats**: View your progress over time.";
  @override String get timerRunningWarning => 'モードを切り替える前にタイマーを停止してください。';
  // Help Slideshow
  @override String get helpUnknown => '不明';
  @override String get helpSlide1Title => '時間をマスターする';
  @override String get helpSlide1Desc => '時間管理は芸術です。ポモドーロテクニックで集中力をレーザーのように鋭く保ち、燃え尽きを防ぎ、生産性を最大化しましょう。';
  
  @override String get helpSlide2Title => '目標を選ぶ';
  @override String get helpSlide2Desc => '偉大な成果は小さな一歩から始まります。今日最も重要なタスクを選び、それに集中する準備をしましょう。';
  
  @override String get helpSlide3Title => '完全集中';
  @override String get helpSlide3Desc => '25分間、外の世界を遮断しましょう。あなたと目標だけです。ディープワークモードに入り、フローを掴みましょう。';
  
  @override String get helpSlide4Title => '心をリフレッシュ';
  @override String get helpSlide4Desc => '休憩は時間の無駄ではなく、戦略的な刷新です。5分間の短い休憩で次のセッションに向けて脳を準備しましょう。';
  
  @override String get helpSlide5Title => '勝利のサイクル';
  @override String get helpSlide5Desc => '完了したサイクルは目標への大きな一歩です。成功を祝い、深く休んで、次の勝利に向けてより強く準備しましょう。';
  
  @override String get skip => 'スキップ';
  @override String get start => '開始';
  @override String get next => '次へ';
}
