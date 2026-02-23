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
  @override String get tasksHelpContent => 'จัดการงานอย่างมีประสิทธิภาพเพื่อเพิ่มผลผลิต:\n\n1. สร้างงาน\nแตะปุ่ม (+) เพื่อเพิ่มงานใหม่\n\n2. ประมาณการ\nประมาณการว่าคุณต้องการ Pomodoro กี่รอบ (ระยะเวลาปรับได้ในการตั้งค่า)\n\n3. เริ่มโฟกัส\nแตะปุ่มเล่น (▶) บนงานเพื่อเริ่มจับเวลา\n\n4. แก้ไขและลบ\nปัดการ์ดงานไปทางซ้ายเพื่อดูตัวเลือกการแก้ไขและลบ\n\n5. ติดตามความคืบหน้า\nความคืบหน้าจะถูกบันทึกในสถิติเมื่อตัวจับเวลาสิ้นสุดลง เซสชันที่ไม่มีงานจะถูกบันทึกเป็น "โฟกัสทั่วไป"';

  @override String get tasksHelpStep1Title => 'สร้างงาน';
  @override String get tasksHelpStep1Content => 'แตะปุ่ม (+) เพื่อเพิ่มงานใหม่';
  
  @override String get tasksHelpStep2Title => 'ประมาณการ';
  @override String get tasksHelpStep2Content => 'ประมาณการว่าคุณต้องการ Pomodoro กี่รอบสำหรับงาน (ระยะเวลาปรับได้ในการตั้งค่า)';
  
  @override String get tasksHelpStep3Title => 'เริ่มโฟกัส';
  @override String get tasksHelpStep3Content => 'แตะปุ่มเล่น (▶) บนงานเพื่อเริ่มจับเวลาโฟกัส';
  
  @override String get tasksHelpStep4Title => 'แก้ไขและลบ';
  @override String get tasksHelpStep4Content => 'ปัดการ์ดงานไปทางซ้ายเพื่อแสดงตัวเลือกการแก้ไขและลบ';
  
  @override String get tasksHelpStep5Title => 'ติดตามความคืบหน้า';
  @override String get tasksHelpStep5Content => 'ความคืบหน้าจะถูกบันทึกในสถิติเมื่อตัวจับเวลาสิ้นสุดลง เซสชันที่ไม่มีงานจะถูกบันทึกเป็น "โฟกัสทั่วไป"';
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

  @override String get shareAdUnlockContent => 'คุณต้องดูโฆษณาสั้น ๆ เพื่อปลดล็อกคุณสมบัตินี้';
  @override String get shareAdUnlockButton => 'ดูโฆษณา';
  
  @override String get shareSummary => 'สรุป';
  @override String get shareFocused => 'มีสมาธิ';
  @override String get shareSessions => 'เซสชัน';
  @override String get shareStreak => 'แบ่งปันสถิติต่อเนื่องของคุณและรักษาความรับผิดชอบ 🚀';

  @override String get languageEnglish => 'อังกฤษ';
  @override String get languageTurkish => 'ตุรกี';

  @override String get focusShort => 'โฟกัส';
  @override String get shortBreakShort => 'พักสั้น';
  @override String get longBreakShort => 'พักยาว';

  @override String get addNote => 'เพิ่มโน้ต';
  // Help & Warnings
  @override String get helpTitle => 'App Guide';
  @override String get helpContent => 
    "**How does the app work?**\n\n"
    "**Pomodoro**: Focus for 25 minutes, then take a short break. After 4 sessions, take a long break.\n\n"
    "**Timer**: Tap start to focus. Pause if needed.\n\n"
    "**Settings**: Customize your focus durations and sounds.\n\n"
    "**Tasks**: Track your work by adding tasks.\n\n"
    "**Stats**: View your progress over time.";
  @override String get timerRunningWarning => 'กรุณาหยุดตัวจับเวลาก่อนเปลี่ยนโหมด';
  // Help Slideshow
  @override String get helpUnknown => 'ไม่ทราบ';
  @override String get helpSlide1Title => 'เป็นนายเวลาของคุณ';
  @override String get helpSlide1Desc => 'การบริหารเวลาคือศิลปะ รักษาสมาธิของคุณให้คมดั่งเลเซอร์ ป้องกันความเหนื่อยล้า และเพิ่มประสิทธิภาพสูงสุดด้วยเทคนิคโปโมโดโร';
  
  @override String get helpSlide2Title => 'เลือกเป้าหมายของคุณ';
  @override String get helpSlide2Desc => 'ความสำเร็จยิ่งใหญ่เริ่มต้นจากก้าวเล็กๆ เลือกงานที่สำคัญที่สุดของวันนี้และเตรียมพร้อมที่จะมุ่งเน้นไปที่มัน';
  
  @override String get helpSlide3Title => 'สมาธิเต็มที่';
  @override String get helpSlide3Desc => 'ปิดเสียงโลกภายนอกเป็นเวลา 25 นาที มีแค่คุณและเป้าหมายของคุณ เข้าสู่โหมดทำงานเชิงลึกและจับกระแสให้ได้';
  
  @override String get helpSlide4Title => 'ฟื้นฟูจิตใจ';
  @override String get helpSlide4Desc => 'การพักผ่อนไม่ใช่การเสียเวลา แต่เป็นการฟื้นฟูเชิงกลยุทธ์ เตรียมสมองสำหรับเซสชั่นถัดไปด้วยการพักสั้นๆ 5 นาที';
  
  @override String get helpSlide5Title => 'วงจรแห่งชัยชนะ';
  @override String get helpSlide5Desc => 'ทุกรอบที่เสร็จสมบูรณ์คือก้าวยักษ์สู่เป้าหมายของคุณ ฉลองความสำเร็จ พักผ่อนอย่างเต็มที่ และเตรียมพร้อมให้แข็งแกร่งขึ้นสำหรับชัยชนะครั้งต่อไป';
  
  @override String get skip => 'ข้าม';
  @override String get start => 'เริ่ม';
  @override String get next => 'ถัดไป';

  // Rate App & Contact Us
  @override String get rateApp => 'ให้คะแนนแอป';
  @override String get contactUs => 'ติดต่อเรา';
  @override String get rateAppTitle => 'ชอบแอปนี้ใช่ไหม?';
  @override String get rateAppMessage => 'การให้คะแนนช่วยให้เราเติบโต ให้คะแนน Pomodoro Master บน Play Store!';
  @override String get rateNow => 'ให้คะแนนตอนนี้';
  @override String get rateLater => 'ภายหลัง';
  @override String get rateAlreadyDone => 'ให้คะแนนแล้ว ✓';
}
