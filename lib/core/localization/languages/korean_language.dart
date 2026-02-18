import 'language.dart';

class KoreanLanguage implements Language {
  @override String get code => 'ko';
  @override String get name => '한국어';

  @override String get settings => '설정';
  @override String get appearance => '화면';
  @override String get darkMode => '다크 모드';
  @override String get theme => '테마';
  @override String get language => '언어';
  @override String get focusSounds => '집중 사운드';
  @override String get tasks => '할 일';
  @override String get stats => '통계';
  @override String get focus => '집중';
  @override String get shortBreak => '짧은 휴식';
  @override String get longBreak => '긴 휴식';
  @override String get version => '버전';

  @override String get weeklyActivity => '주간 활동';
  @override String get focusTime => '집중 시간';
  @override String get dailyGoal => '일일 목표';
  @override String get remaining => '남음';
  @override String get completed => '완료됨';
  @override String get setGoal => '목표 설정';
  @override String get hours => '시간';
  
  @override String get timerSettings => '타이머 설정';
  @override String get pomodoroDuration => '뽀모도로 시간';
  @override String get shortBreakDuration => '짧은 휴식 시간';
  @override String get longBreakDuration => '긴 휴식 시간';
  @override String get minutes => '분';
  @override String get timeIsUp => '시간이 되었습니다!';
  @override String get sessionCompleted => '세션 완료';
  @override String get breakOver => '휴식 종료';

  @override String get themeClassic => '클래식';
  @override String get themeSakura => '벚꽃';
  @override String get themeOcean => '바다';
  @override String get themeForest => '숲';
  @override String get themeSilver => '실버';

  @override String get cancel => '취소';
  @override String get save => '저장';
  @override String get close => '닫기';
  @override String get delete => '삭제';
  @override String get saveNote => '메모 저장';
  @override String get editNote => '메모 수정';

  @override String get today => '오늘';
  @override String get empty => '비어있음';
  @override String get newTask => '새 할 일';
  @override String get taskHint => '무엇을 하시나요?';
  @override String get estPomodoros => '예상 뽀모도로:';
  @override String get createTask => '생성';
  @override String get updateTask => '수정';
  @override String get noTasks => '할 일이 없습니다. 추가해보세요!';
  @override String get pomodoroCount => '뽀모도로';
  @override String get inProgress => '진행 중';
  @override String get focusedTime => '집중된 시간';
  @override String get tasksWorkedOn => '활동:';
  @override String get completedTasksLabel => '완료된 할 일';
  @override String get noTasksRecorded => '기록 없음.';
  @override String get dailyNote => '오늘의 메모:';
  @override String get noteHint => '오늘 집중은 어땠나요?';
  @override String get generalFocus => '일반 집중';
  @override String get goalMet => '목표 달성';
  @override String get goalMissed => '목표 미달';
  @override String get tasksHelpTitle => '할 일 관리';
  @override String get tasksHelpContent => '생산성을 높이기 위해 작업을 효과적으로 관리하세요:\n\n1. 작업 생성\n(+) 버튼을 탭하여 새 작업을 추가하세요.\n\n2. 견적 설정\n필요한 뽀모도로 수를 예상하세요. (시간은 설정에서 조정 가능).\n\n3. 집중 시작\n작업의 재생(▶) 버튼을 탭하여 타이머를 시작하세요.\n\n4. 편집 및 삭제\n편집 및 삭제 옵션을 보려면 작업 카드를 왼쪽으로 스와이프하세요.\n\n5. 진행 상황 추적\n타이머가 종료되면 진행 상황이 통계에 기록됩니다. 작업 없는 세션은 "일반 집중"으로 기록됩니다.';

  @override String get tasksHelpStep1Title => '작업 생성';
  @override String get tasksHelpStep1Content => '(+) 버튼을 탭하여 새 작업을 추가하세요.';
  
  @override String get tasksHelpStep2Title => '견적 설정';
  @override String get tasksHelpStep2Content => '작업에 필요한 뽀모도로 수를 예상하세요. (시간은 설정에서 조정 가능).';
  
  @override String get tasksHelpStep3Title => '집중 시작';
  @override String get tasksHelpStep3Content => '작업의 재생(▶) 버튼을 탭하여 집중 타이머를 시작하세요.';
  
  @override String get tasksHelpStep4Title => '편집 및 삭제';
  @override String get tasksHelpStep4Content => '작업 카드를 왼쪽으로 스와이프하여 편집 및 삭제 옵션을 확인하세요.';
  
  @override String get tasksHelpStep5Title => '진행 상황 추적';
  @override String get tasksHelpStep5Content => '타이머가 종료되면 진행 상황이 통계에 기록됩니다. 작업 없는 세션은 "일반 집중"으로 기록됩니다.';
  @override String get navFocus => '집중';
  @override String get navTasks => '할 일';
  @override String get navStats => '통계';
  @override String get navSettings => '설정';

  @override String get monthJan => '1월';
  @override String get monthFeb => '2월';
  @override String get monthMar => '3월';
  @override String get monthApr => '4월';
  @override String get monthMay => '5월';
  @override String get monthJun => '6월';
  @override String get monthJul => '7월';
  @override String get monthAug => '8월';
  @override String get monthSep => '9월';
  @override String get monthOct => '10월';
  @override String get monthNov => '11월';
  @override String get monthDec => '12월';
  
  @override String get share => '공유';
  @override String get shareStatsTitle => '나의 통계';
  @override String get shareMessage => '내 진행 상황을 확인하세요!';
  @override String get statsDaily => '일별';
  @override String get statsMonthly => '월별';
  @override String get stats6Months => '6개월';
  @override String get statsYearly => '연별';
  @override String get average => '평균';
  @override String get sessions => '세션';
  @override String get heatmapLegend => '적음 • 많음';

  @override String get soundType => '소리';
  @override String get soundTypeBell => '종소리';
  @override String get soundTypeNotification => '알림음';

  @override String get shareFooterQuote => 'Pomodoro Master와 함께 집중';
  @override String get shareGoalCompleted => '목표 달성';
  @override String get shareTopFocus => '최고 집중';
  @override String get shareLegendStart => '시작';
  @override String get shareLegendGoal => '목표';
  @override String get shareWeeklyFocus => '주간 집중';
  @override String get shareYearlyJourney => '여정';

  @override String get quoteMotivation1 => "집중은 성공의 열쇠입니다.";
  @override String get quoteMotivation2 => "한 번에 하나씩.";
  @override String get quoteMotivation3 => "작은 발걸음이 큰 결과로.";
  @override String get quoteMotivation4 => "계속 나아가세요!";
  @override String get quoteMotivation5 => "미래는 오늘 만들어집니다.";
  @override String get quoteMotivation6 => "꾸준함이 답입니다.";
  @override String get quoteMotivation7 => "깊은 몰입이 중요합니다.";

  @override String get shareRange => '기간';
  @override String get shareRangeDaily => '일간';
  @override String get shareRangeWeekly => '주간';
  @override String get shareRangeMonthly => '월간';
  @override String get shareRangeYearly => '연간';
  @override String get shareButton => '공유';
  @override String get monthlyOverview => '월간 개요';

  @override String get shareAdUnlockContent => '이 기능을 잠금 해제하려면 짧은 광고를 시청해야 합니다.';
  @override String get shareAdUnlockButton => '광고 시청';
  
  @override String get shareSummary => '요약';
  @override String get shareFocused => '집중';
  @override String get shareSessions => '세션';
  @override String get shareStreak => '연속 기록을 공유하고 책임감을 유지하세요 🚀';

  @override String get languageEnglish => '영어';
  @override String get languageTurkish => '터키어';

  @override String get focusShort => '집중';
  @override String get shortBreakShort => '휴식';
  @override String get longBreakShort => '긴휴식';

  @override String get addNote => '메모 추가';
  // Help & Warnings
  @override String get helpTitle => 'App Guide';
  @override String get helpContent => 
    "**How does the app work?**\n\n"
    "**Pomodoro**: Focus for 25 minutes, then take a short break. After 4 sessions, take a long break.\n\n"
    "**Timer**: Tap start to focus. Pause if needed.\n\n"
    "**Settings**: Customize your focus durations and sounds.\n\n"
    "**Tasks**: Track your work by adding tasks.\n\n"
    "**Stats**: View your progress over time.";
  @override String get timerRunningWarning => '모드를 전환하기 전에 타이머를 중지하세요.';
  // Help Slideshow
  @override String get helpUnknown => '알 수 없음';
  @override String get helpSlide1Title => '시간을 지배하라';
  @override String get helpSlide1Desc => '시간 관리는 예술입니다. 포모도로 기법으로 레이저처럼 날카로운 집중력을 유지하고, 번아웃을 예방하며, 생산성을 극대화하세요.';
  
  @override String get helpSlide2Title => '목표를 선택하라';
  @override String get helpSlide2Desc => '위대한 성취는 작은 발걸음에서 시작됩니다. 오늘 가장 중요한 작업을 선택하고 집중할 준비를 하세요.';
  
  @override String get helpSlide3Title => '완전한 집중';
  @override String get helpSlide3Desc => '25분 동안 외부 세계를 차단하세요. 오직 당신과 목표만 있습니다. 딥 워크 모드에 진입하고 플로우를 잡으세요.';
  
  @override String get helpSlide4Title => '마음을 새롭게';
  @override String get helpSlide4Desc => '휴식은 시간 낭비가 아닙니다; 전략적 재충전입니다. 5분의 짧은 휴식으로 다음 세션을 위해 뇌를 준비하세요.';
  
  @override String get helpSlide5Title => '승리의 사이클';
  @override String get helpSlide5Desc => '완료된 모든 사이클은 목표를 향한 거대한 발걸음입니다. 성공을 축하하고, 깊이 쉬고, 다음 승리를 위해 더 강하게 준비하세요.';
  
  @override String get skip => '건너뛰기';
  @override String get start => '시작';
  @override String get next => '다음';
}
