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
  @override String get tasksHelpContent => '1. 생성 (+)\n2. 예측\n3. 시작 (▶)\n4. 수정 (왼쪽 스와이프)';

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

  @override String get languageEnglish => '영어';
  @override String get languageTurkish => '터키어';

  @override String get focusShort => '집중';
  @override String get shortBreakShort => '휴식';
  @override String get longBreakShort => '긴휴식';

  @override String get addNote => '메모 추가';
}
