import 'language.dart';

class VietnameseLanguage implements Language {
  @override String get code => 'vi';
  @override String get name => 'Tiếng Việt';

  @override String get settings => 'Cài đặt';
  @override String get appearance => 'Giao diện';
  @override String get darkMode => 'Chế độ tối';
  @override String get theme => 'Chủ đề';
  @override String get language => 'Ngôn ngữ';
  @override String get focusSounds => 'Âm thanh tập trung';
  @override String get tasks => 'Nhiệm vụ';
  @override String get stats => 'Thống kê';
  @override String get focus => 'Tập trung';
  @override String get shortBreak => 'Nghỉ ngắn';
  @override String get longBreak => 'Nghỉ dài';
  @override String get version => 'Phiên bản';

  @override String get weeklyActivity => 'Hoạt động tuần';
  @override String get focusTime => 'Thời gian tập trung';
  @override String get dailyGoal => 'Mục tiêu hàng ngày';
  @override String get remaining => 'Còn lại';
  @override String get completed => 'Hoàn thành';
  @override String get setGoal => 'Đặt mục tiêu';
  @override String get hours => 'Giờ';
  
  @override String get timerSettings => 'Cài đặt hẹn giờ';
  @override String get pomodoroDuration => 'Thời lượng Pomodoro';
  @override String get shortBreakDuration => 'Thời lượng nghỉ ngắn';
  @override String get longBreakDuration => 'Thời lượng nghỉ dài';
  @override String get minutes => 'Phút';
  @override String get timeIsUp => 'Hết giờ!';
  @override String get sessionCompleted => 'Phiên hoàn thành';
  @override String get breakOver => 'Hết giờ nghỉ';

  @override String get themeClassic => 'Cổ điển';
  @override String get themeSakura => 'Sakura';
  @override String get themeOcean => 'Đại dương';
  @override String get themeForest => 'Rừng';
  @override String get themeSilver => 'Bạc';

  @override String get cancel => 'Hủy';
  @override String get save => 'Lưu';
  @override String get close => 'Đóng';
  @override String get delete => 'Xóa';
  @override String get saveNote => 'Lưu ghi chú';
  @override String get editNote => 'Sửa ghi chú';

  @override String get today => 'Hôm nay';
  @override String get empty => 'Trống';
  @override String get newTask => 'Nhiệm vụ mới';
  @override String get taskHint => 'Bạn đang làm gì?';
  @override String get estPomodoros => 'Dự kiến Pomodoro:';
  @override String get createTask => 'Tạo';
  @override String get updateTask => 'Cập nhật';
  @override String get noTasks => 'Chưa có nhiệm vụ. Thêm ngay!';
  @override String get pomodoroCount => 'pomodoro';
  @override String get inProgress => 'Đang thực hiện';
  @override String get focusedTime => 'Thời gian tập trung';
  @override String get tasksWorkedOn => 'Hoạt động:';
  @override String get completedTasksLabel => 'Đã hoàn thành';
  @override String get noTasksRecorded => 'Không có dữ liệu.';
  @override String get dailyNote => 'Ghi chú ngày:';
  @override String get noteHint => 'Hôm nay tập trung thế nào?';
  @override String get generalFocus => 'Tập trung chung';
  @override String get goalMet => 'Đạt mục tiêu';
  @override String get goalMissed => 'Chưa đạt';
  @override String get tasksHelpTitle => 'Quản lý nhiệm vụ';
  @override String get tasksHelpContent => '1. Tạo (+)\n2. Dự kiến\n3. Bắt đầu (▶)\n4. Sửa (Vuốt trái)';

  @override String get navFocus => 'Tập trung';
  @override String get navTasks => 'Nhiệm vụ';
  @override String get navStats => 'Thống kê';
  @override String get navSettings => 'Cài đặt';

  @override String get monthJan => 'Tháng 1';
  @override String get monthFeb => 'Tháng 2';
  @override String get monthMar => 'Tháng 3';
  @override String get monthApr => 'Tháng 4';
  @override String get monthMay => 'Tháng 5';
  @override String get monthJun => 'Tháng 6';
  @override String get monthJul => 'Tháng 7';
  @override String get monthAug => 'Tháng 8';
  @override String get monthSep => 'Tháng 9';
  @override String get monthOct => 'Tháng 10';
  @override String get monthNov => 'Tháng 11';
  @override String get monthDec => 'Tháng 12';
  
  @override String get share => 'Chia sẻ';
  @override String get shareStatsTitle => 'Thống kê của tôi';
  @override String get shareMessage => 'Xem tiến độ của tôi!';
  @override String get statsDaily => 'Hàng ngày';
  @override String get statsMonthly => 'Hàng tháng';
  @override String get stats6Months => '6 Tháng';
  @override String get statsYearly => 'Hàng năm';
  @override String get average => 'Trung bình';
  @override String get sessions => 'Phiên';
  @override String get heatmapLegend => 'Ít • Nhiều';

  @override String get soundType => 'Âm thanh';
  @override String get soundTypeBell => 'Chuông';
  @override String get soundTypeNotification => 'Thông báo';

  @override String get shareFooterQuote => 'Tập trung với Pomodoro Master';
  @override String get shareGoalCompleted => 'Đạt mục tiêu';
  @override String get shareTopFocus => 'Tập trung cao nhất';
  @override String get shareLegendStart => 'Bắt đầu';
  @override String get shareLegendGoal => 'Mục tiêu';
  @override String get shareWeeklyFocus => 'TẬP TRUNG TUẦN';
  @override String get shareYearlyJourney => 'HÀNH TRÌNH';

  @override String get quoteMotivation1 => "Tập trung là chìa khóa thành công.";
  @override String get quoteMotivation2 => "Từng pomodoro một.";
  @override String get quoteMotivation3 => "Bước nhỏ, kết quả lớn.";
  @override String get quoteMotivation4 => "Tiếp tục tiến lên!";
  @override String get quoteMotivation5 => "Tương lai được tạo ra hôm nay.";
  @override String get quoteMotivation6 => "Kiên trì.";
  @override String get quoteMotivation7 => "Làm việc sâu rất quan trọng.";

  @override String get shareRange => 'Phạm vi';
  @override String get shareRangeDaily => 'Ngày';
  @override String get shareRangeWeekly => 'Tuần';
  @override String get shareRangeMonthly => 'Tháng';
  @override String get shareRangeYearly => 'Năm';
  @override String get shareButton => 'Chia sẻ';
  @override String get monthlyOverview => 'TỔNG QUAN THÁNG';

  @override String get languageEnglish => 'Tiếng Anh';
  @override String get languageTurkish => 'Tiếng Thổ Nhĩ Kỳ';

  @override String get focusShort => 'Tập trung';
  @override String get shortBreakShort => 'Ngắn';
  @override String get longBreakShort => 'Dài';

  @override String get addNote => 'Thêm ghi chú';
}
