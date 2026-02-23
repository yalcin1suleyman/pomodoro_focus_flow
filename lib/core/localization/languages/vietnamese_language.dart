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
  @override String get tasksHelpContent => 'Quản lý công việc hiệu quả để tăng năng suất:\n\n1. Tạo công việc\nNhấn nút (+) để thêm công việc mới.\n\n2. Ước tính\nƯớc tính bạn cần bao nhiêu Pomodoro. (Thời lượng có thể điều chỉnh trong Cài đặt).\n\n3. Bắt đầu tập trung\nNhấn nút Phát (▶) trên công việc để bắt đầu hẹn giờ.\n\n4. Chỉnh sửa & Xóa\nVuốt thẻ công việc sang TRÁI để xem các tùy chọn chỉnh sửa và xóa.\n\n5. Theo dõi tiến độ\nTiến độ được ghi lại trong Thống kê khi hẹn giờ kết thúc. Các phiên không có công việc được ghi lại là "Tập trung chung".';

  @override String get tasksHelpStep1Title => 'Tạo công việc';
  @override String get tasksHelpStep1Content => 'Nhấn nút (+) để thêm công việc mới.';
  
  @override String get tasksHelpStep2Title => 'Ước tính';
  @override String get tasksHelpStep2Content => 'Ước tính bạn cần bao nhiêu Pomodoro cho công việc. (Thời lượng có thể điều chỉnh trong Cài đặt).';
  
  @override String get tasksHelpStep3Title => 'Bắt đầu tập trung';
  @override String get tasksHelpStep3Content => 'Nhấn nút Phát (▶) trên công việc để bắt đầu hẹn giờ tập trung.';
  
  @override String get tasksHelpStep4Title => 'Chỉnh sửa & Xóa';
  @override String get tasksHelpStep4Content => 'Vuốt thẻ công việc sang TRÁI để hiển thị các tùy chọn chỉnh sửa và xóa.';
  
  @override String get tasksHelpStep5Title => 'Theo dõi tiến độ';
  @override String get tasksHelpStep5Content => 'Tiến độ được ghi lại trong Thống kê khi hẹn giờ kết thúc. Các phiên không có công việc được ghi lại là "Tập trung chung".';

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

  @override String get shareAdUnlockContent => 'Bạn phải xem một quảng cáo ngắn để mở khóa tính năng này.';
  @override String get shareAdUnlockButton => 'Xem Quảng cáo';
  
  @override String get shareSummary => 'Tóm tắt';
  @override String get shareFocused => 'tập trung';
  @override String get shareSessions => 'phiên';
  @override String get shareStreak => 'Chia sẻ chuỗi của bạn và giữ trách nhiệm 🚀';

  @override String get languageEnglish => 'Tiếng Anh';
  @override String get languageTurkish => 'Tiếng Thổ Nhĩ Kỳ';

  @override String get focusShort => 'Tập trung';
  @override String get shortBreakShort => 'Ngắn';
  @override String get longBreakShort => 'Dài';

  @override String get addNote => 'Thêm ghi chú';
  // Help & Warnings
  @override String get helpTitle => 'App Guide';
  @override String get helpContent => 
    "**How does the app work?**\n\n"
    "**Pomodoro**: Focus for 25 minutes, then take a short break. After 4 sessions, take a long break.\n\n"
    "**Timer**: Tap start to focus. Pause if needed.\n\n"
    "**Settings**: Customize your focus durations and sounds.\n\n"
    "**Tasks**: Track your work by adding tasks.\n\n"
    "**Stats**: View your progress over time.";
  @override String get timerRunningWarning => 'Vui lòng dừng bộ đếm thời gian trước khi chuyển chế độ.';
  // Help Slideshow
  @override String get helpUnknown => 'Không rõ';
  @override String get helpSlide1Title => 'Làm Chủ Thời Gian';
  @override String get helpSlide1Desc => 'Quản lý thời gian là một nghệ thuật. Giữ sự tập trung sắc bén như laser, ngăn ngừa kiệt sức và tối đa hóa năng suất với kỹ thuật Pomodoro.';
  
  @override String get helpSlide2Title => 'Chọn Mục Tiêu';
  @override String get helpSlide2Desc => 'Những thành tựu vĩ đại bắt đầu từ những bước nhỏ. Chọn nhiệm vụ quan trọng nhất hôm nay và chuẩn bị tập trung vào nó.';
  
  @override String get helpSlide3Title => 'Tập Trung Hoàn Toàn';
  @override String get helpSlide3Desc => 'Tắt tiếng thế giới bên ngoài trong 25 phút. Chỉ có bạn và mục tiêu. Bước vào chế độ làm việc sâu và nắm bắt dòng chảy.';
  
  @override String get helpSlide4Title => 'Làm Mới Tâm Trí';
  @override String get helpSlide4Desc => 'Nghỉ ngơi không phải lãng phí thời gian; đó là sự đổi mới chiến lược. Chuẩn bị não bộ cho phiên tiếp theo với khoảng nghỉ ngắn 5 phút.';
  
  @override String get helpSlide5Title => 'Vòng Chiến Thắng';
  @override String get helpSlide5Desc => 'Mỗi chu kỳ hoàn thành là một bước khổng lồ hướng tới mục tiêu. Hãy ăn mừng thành công, nghỉ ngơi sâu và chuẩn bị mạnh mẽ hơn cho chiến thắng tiếp theo.';
  
  @override String get skip => 'Bỏ qua';
  @override String get start => 'Bắt đầu';
  @override String get next => 'Tiếp theo';

  // Rate App & Contact Us
  @override String get rateApp => 'Đánh giá Ứng dụng';
  @override String get contactUs => 'Liên hệ chúng tôi';
  @override String get rateAppTitle => 'Bạn thích ứng dụng?';
  @override String get rateAppMessage => 'Đánh giá của bạn giúp chúng tôi phát triển. Hãy đánh giá Pomodoro Master trên Play Store!';
  @override String get rateNow => 'Đánh giá ngay';
  @override String get rateLater => 'Sau';
  @override String get rateAlreadyDone => 'Đã đánh giá ✓';
}
