import 'language.dart';

class ThaiLanguage implements Language {
  @override String get code => 'th';
  @override String get name => 'ไทย';

  @override String get settings => 'การตั้งค่า';
  @override String get appearance => 'รูปลักษณ์';
  @override String get darkMode => 'โหมดมืด';
  @override String get theme => 'ธีม';
  @override String get language => 'ภาษา';
  @override String get focusSounds => 'เสียงโฟกัส';
  @override String get tasks => 'งาน';
  @override String get stats => 'สถิติ';
  @override String get focus => 'โฟกัส';
  @override String get shortBreak => 'พักสั้น';
  @override String get longBreak => 'พักยาว';
  @override String get version => 'เวอร์ชัน';

  @override String get weeklyActivity => 'กิจกรรมรายสัปดาห์';
  @override String get focusTime => 'เวลาโฟกัส';
  @override String get dailyGoal => 'เป้าหมายรายวัน';
  @override String get remaining => 'เหลืออีก';
  @override String get completed => 'เสร็จสิ้น';
  @override String get setGoal => 'ตั้งเป้าหมาย';
  @override String get hours => 'ชั่วโมง';
  
  @override String get timerSettings => 'ตั้งค่าตัวจับเวลา';
  @override String get pomodoroDuration => 'ระยะเวลา Pomodoro';
  @override String get shortBreakDuration => 'ระยะเวลาพักสั้น';
  @override String get longBreakDuration => 'ระยะเวลาพักยาว';
  @override String get minutes => 'นาที';
  @override String get timeIsUp => 'หมดเวลา!';
  @override String get sessionCompleted => 'เซสชันเสร็จสิ้น';
  @override String get breakOver => 'หมดเวลาพัก';

  @override String get themeClassic => 'คลาสสิก';
  @override String get themeSakura => 'ซากุระ';
  @override String get themeOcean => 'มหาสมุทร';
  @override String get themeForest => 'ป่า';
  @override String get themeSilver => 'เงิน';

  @override String get cancel => 'ยกเลิก';
  @override String get save => 'บันทึก';
  @override String get close => 'ปิด';
  @override String get delete => 'ลบ';
  @override String get saveNote => 'บันทึกโน้ต';
  @override String get editNote => 'แก้ไขโน้ต';

  @override String get today => 'วันนี้';
  @override String get empty => 'ว่างเปล่า';
  @override String get newTask => 'งานใหม่';
  @override String get taskHint => 'กำลังทำอะไรอยู่?';
  @override String get estPomodoros => 'ประมาณ Pomodori:';
  @override String get createTask => 'สร้าง';
  @override String get updateTask => 'อัปเดต';
  @override String get noTasks => 'ไม่มีงาน เพิ่มเลย!';
  @override String get pomodoroCount => 'pomodoro';
  @override String get inProgress => 'กำลังดำเนินการ';
  @override String get focusedTime => 'เวลาที่โฟกัส';
  @override String get tasksWorkedOn => 'กิจกรรม:';
  @override String get completedTasksLabel => 'งานที่เสร็จแล้ว';
  @override String get noTasksRecorded => 'ไม่มีบันทึก';
  @override String get dailyNote => 'โน้ตประจำวัน:';
  @override String get noteHint => 'วันนี้เป็นอย่างไรบ้าง?';
  @override String get generalFocus => 'โฟกัสทั่วไป';
  @override String get goalMet => 'บรรลุเป้าหมาย';
  @override String get goalMissed => 'ต่ำกว่าเป้าหมาย';
  @override String get tasksHelpTitle => 'การจัดการงาน';
  @override String get tasksHelpContent => '1. สร้าง (+)\n2. ประมาณการ\n3. เริ่ม (▶)\n4. แก้ไข (ปัดซ้าย)';

  @override String get navFocus => 'โฟกัส';
  @override String get navTasks => 'งาน';
  @override String get navStats => 'สถิติ';
  @override String get navSettings => 'ตั้งค่า';

  @override String get monthJan => 'มกราคม';
  @override String get monthFeb => 'กุมภาพันธ์';
  @override String get monthMar => 'มีนาคม';
  @override String get monthApr => 'เมษายน';
  @override String get monthMay => 'พฤษภาคม';
  @override String get monthJun => 'มิถุนายน';
  @override String get monthJul => 'กรกฎาคม';
  @override String get monthAug => 'สิงหาคม';
  @override String get monthSep => 'กันยายน';
  @override String get monthOct => 'ตุลาคม';
  @override String get monthNov => 'พฤศจิกายน';
  @override String get monthDec => 'ธันวาคม';
  
  @override String get share => 'แชร์';
  @override String get shareStatsTitle => 'สถิติของฉัน';
  @override String get shareMessage => 'ดูความคืบหน้าของฉัน!';
  @override String get statsDaily => 'รายวัน';
  @override String get statsMonthly => 'รายเดือน';
  @override String get stats6Months => '6 เดือน';
  @override String get statsYearly => 'รายปี';
  @override String get average => 'เฉลี่ย';
  @override String get sessions => 'เซสชัน';
  @override String get heatmapLegend => 'น้อย • มาก';

  @override String get soundType => 'เสียง';
  @override String get soundTypeBell => 'กระดิ่ง';
  @override String get soundTypeNotification => 'แจ้งเตือน';

  @override String get shareFooterQuote => 'โฟกัสกับ Pomodoro Master';
  @override String get shareGoalCompleted => 'บรรลุเป้าหมาย';
  @override String get shareTopFocus => 'โฟกัสสูงสุด';
  @override String get shareLegendStart => 'เริ่ม';
  @override String get shareLegendGoal => 'เป้าหมาย';
  @override String get shareWeeklyFocus => 'โฟกัสประจำสัปดาห์';
  @override String get shareYearlyJourney => 'การเดินทาง';

  @override String get quoteMotivation1 => "โฟกัสคือกุญแจสู่ความสำเร็จ";
  @override String get quoteMotivation2 => "ทีละหนึ่ง Pomodoro";
  @override String get quoteMotivation3 => "ก้าวเล็กๆ ผลลัพธ์ที่ยิ่งใหญ่";
  @override String get quoteMotivation4 => "ก้าวต่อไป!";
  @override String get quoteMotivation5 => "อนาคตสร้างขึ้นในวันนี้";
  @override String get quoteMotivation6 => "สม่ำเสมอ";
  @override String get quoteMotivation7 => "งานลึกซึ้งสำคัญ";

  @override String get shareRange => 'ช่วง';
  @override String get shareRangeDaily => 'รายวัน';
  @override String get shareRangeWeekly => 'รายสัปดาห์';
  @override String get shareRangeMonthly => 'รายเดือน';
  @override String get shareRangeYearly => 'รายปี';
  @override String get shareButton => 'แชร์';
  @override String get monthlyOverview => 'ภาพรวมรายเดือน';

  @override String get languageEnglish => 'อังกฤษ';
  @override String get languageTurkish => 'ตุรกี';

  @override String get focusShort => 'โฟกัส';
  @override String get shortBreakShort => 'พักสั้น';
  @override String get longBreakShort => 'พักยาว';

  @override String get addNote => 'เพิ่มโน้ต';
}
