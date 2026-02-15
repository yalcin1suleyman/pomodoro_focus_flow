import 'language.dart';

class UrduLanguage implements Language {
  @override String get code => 'ur';
  @override String get name => 'اردو';

  @override String get settings => 'ترتیبات';
  @override String get appearance => 'ظاہری شکل';
  @override String get darkMode => 'ڈارک موڈ';
  @override String get theme => 'تھیم';
  @override String get language => 'زبان';
  @override String get focusSounds => 'فوکس آوازیں';
  @override String get tasks => 'کام';
  @override String get stats => 'اعداد و شمار';
  @override String get focus => 'فوکس';
  @override String get shortBreak => 'مختصر وقفہ';
  @override String get longBreak => 'لمبا وقفہ';
  @override String get version => 'ورژن';

  @override String get weeklyActivity => 'ہفتہ وار سرگرمی';
  @override String get focusTime => 'فوکس کا وقت';
  @override String get dailyGoal => 'روزانہ کا مقصد';
  @override String get remaining => 'باقی';
  @override String get completed => 'مکمل';
  @override String get setGoal => 'مقصد مقرر کریں';
  @override String get hours => 'گھنٹے';
  
  @override String get timerSettings => 'ٹائمر کی ترتیبات';
  @override String get pomodoroDuration => 'پومودورو کا دورانیہ';
  @override String get shortBreakDuration => 'مختصر وقفے کا دورانیہ';
  @override String get longBreakDuration => 'لمبے وقفے کا دورانیہ';
  @override String get minutes => 'منٹ';
  @override String get timeIsUp => 'وقت ختم!';
  @override String get sessionCompleted => 'سیشن مکمل';
  @override String get breakOver => 'وقفہ ختم';

  @override String get themeClassic => 'کلاسک';
  @override String get themeSakura => 'ساکورا';
  @override String get themeOcean => 'سمندر';
  @override String get themeForest => 'جنگل';
  @override String get themeSilver => 'چاندی';

  @override String get cancel => 'منسوخ';
  @override String get save => 'محفوظ کریں';
  @override String get close => 'بند کریں';
  @override String get delete => 'حذف کریں';
  @override String get saveNote => 'نوٹ محفوظ کریں';
  @override String get editNote => 'نوٹ میں ترمیم کریں';

  @override String get today => 'آج';
  @override String get empty => 'خالی';
  @override String get newTask => 'نیا کام';
  @override String get taskHint => 'آپ کس پر کام کر رہے ہیں؟';
  @override String get estPomodoros => 'تخمینہ پومودورو:';
  @override String get createTask => 'کام بنائیں';
  @override String get updateTask => 'اپ ڈیٹ';
  @override String get noTasks => 'کوئی کام نہیں۔ ایک شامل کریں!';
  @override String get pomodoroCount => 'پومودورو';
  @override String get inProgress => 'پیش رفت';
  @override String get focusedTime => 'مرکوز وقت';
  @override String get tasksWorkedOn => 'سرگرمیاں:';
  @override String get completedTasksLabel => 'مکمل شدہ کام';
  @override String get noTasksRecorded => 'کوئی ریکارڈ نہیں۔';
  @override String get dailyNote => 'روزانہ کا نوٹ:';
  @override String get noteHint => 'آج کا فوکس کیسا تھا؟';
  @override String get generalFocus => 'عام فوکس';
  @override String get goalMet => 'مقصد حاصل';
  @override String get goalMissed => 'مقصد سے نیچے';
  @override String get tasksHelpTitle => 'ٹاسک مینجمنٹ';
  @override String get tasksHelpContent => 'پیداواری صلاحیت بڑھانے کے لیے کاموں کا مؤثر طریقے سے انتظام کریں:\n\n1. کام بنائیں\nنیا کام شامل کرنے کے لیے (+) بٹن دبائیں۔\n\n2. تخمینہ\nاندازہ لگائیں کہ آپ کو کتنے پومودورو کی ضرورت ہے۔ (دورانیہ ترتیبات میں قابل ایڈجسٹ ہے)۔\n\n3. توجہ مرکوز کرنا شروع کریں\nٹائمر شروع کرنے کے لیے کام پر پلے (▶) بٹن دبائیں۔\n\n4. ترمیم اور حذف کریں\nترمیم اور حذف کرنے کے اختیارات دیکھنے کے لیے ٹاسک کارڈ کو بائیں طرف سوائپ کریں۔\n\n5. پیشرفت کو ٹریک کریں\nٹائمر ختم ہونے پر پیشرفت کے اعدادوشمار میں لاگ ان ہوجاتا ہے۔ بغیر کام کے سیشنز کو "عام فوکس" کے طور پر لاگ کیا جاتا ہے۔';

  @override String get tasksHelpStep1Title => 'کام بنائیں';
  @override String get tasksHelpStep1Content => 'نیا کام شامل کرنے کے لیے (+) بٹن دبائیں۔';
  
  @override String get tasksHelpStep2Title => 'تخمینہ';
  @override String get tasksHelpStep2Content => 'اندازہ لگائیں کہ کام کے لیے آپ کو کتنے پومودورو کی ضرورت ہے۔ (دورانیہ ترتیبات میں قابل ایڈجسٹ ہے)۔';
  
  @override String get tasksHelpStep3Title => 'توجہ مرکوز کرنا شروع کریں';
  @override String get tasksHelpStep3Content => 'فोकस ٹائمر شروع کرنے کے لیے کام پر پلے (▶) بٹن دبائیں۔';
  
  @override String get tasksHelpStep4Title => 'ترمیم اور حذف کریں';
  @override String get tasksHelpStep4Content => 'ترمیم اور حذف کرنے کے اختیارات ظاہر کرنے کے لیے ٹاسک کارڈ کو بائیں طرف سوائپ کریں۔';
  
  @override String get tasksHelpStep5Title => 'پیشرفت کو ٹریک کریں';
  @override String get tasksHelpStep5Content => 'ٹائمر ختم ہونے پر پیشرفت کے اعدادوشمار میں لاگ ان ہوجاتا ہے۔ بغیر کام کے سیشنز کو "عام فوکس" کے طور پر لاگ کیا جاتا ہے۔';
  @override String get navFocus => 'فوکس';
  @override String get navTasks => 'کام';
  @override String get navStats => 'اعداد و شمار';
  @override String get navSettings => 'ترتیبات';

  @override String get monthJan => 'جنوری';
  @override String get monthFeb => 'فروری';
  @override String get monthMar => 'مارچ';
  @override String get monthApr => 'اپریل';
  @override String get monthMay => 'مئی';
  @override String get monthJun => 'جون';
  @override String get monthJul => 'جولائی';
  @override String get monthAug => 'اگست';
  @override String get monthSep => 'ستمبر';
  @override String get monthOct => 'اکتوبر';
  @override String get monthNov => 'نومبر';
  @override String get monthDec => 'دسمبر';
  
  @override String get share => 'شیئر کریں';
  @override String get shareStatsTitle => 'میرے اعداد و شمار';
  @override String get shareMessage => 'میری پیشرفت دیکھیں!';
  @override String get statsDaily => 'روزانہ';
  @override String get statsMonthly => 'ماہانہ';
  @override String get stats6Months => '6 ماہ';
  @override String get statsYearly => 'سالانہ';
  @override String get average => 'اوسط';
  @override String get sessions => 'سیشن';
  @override String get heatmapLegend => 'کم • زیادہ';

  @override String get soundType => 'آوازیں';
  @override String get soundTypeBell => 'گھنٹی';
  @override String get soundTypeNotification => 'نوٹیفکیشن';

  @override String get shareFooterQuote => 'Pomodoro Master کے ساتھ فوکس کریں';
  @override String get shareGoalCompleted => 'مقصد حاصل';
  @override String get shareTopFocus => 'ٹاپ فوکس';
  @override String get shareLegendStart => 'شروع';
  @override String get shareLegendGoal => 'مقصد';
  @override String get shareWeeklyFocus => 'ہفتہ وار فوکس';
  @override String get shareYearlyJourney => 'سفر';

  @override String get quoteMotivation1 => "فوکس کامیابی کی کلید ہے۔";
  @override String get quoteMotivation2 => "ایک وقت میں ایک پومودورو۔";
  @override String get quoteMotivation3 => "چھوٹے قدم، بڑے نتائج۔";
  @override String get quoteMotivation4 => "آگے بڑھتے رہو!";
  @override String get quoteMotivation5 => "آپ کا مستقبل آج بنتا ہے۔";
  @override String get quoteMotivation6 => "مستقل مزاج رہیں۔";
  @override String get quoteMotivation7 => "گہرا کام اہم ہے۔";

  @override String get shareRange => 'رینج';
  @override String get shareRangeDaily => 'روزانہ';
  @override String get shareRangeWeekly => 'ہفتہ وار';
  @override String get shareRangeMonthly => 'ماہانہ';
  @override String get shareRangeYearly => 'سالانہ';
  @override String get shareButton => 'شیئر کریں';
  @override String get monthlyOverview => 'ماہانہ جائزہ';

  @override String get shareAdUnlockContent => 'You must watch a short ad to unlock this feature.';
  @override String get shareAdUnlockButton => 'Watch Ad';
  
  @override String get shareSummary => 'Summary';
  @override String get shareFocused => 'focused';
  @override String get shareSessions => 'sessions';
  @override String get shareStreak => 'Share your streak and keep yourself accountable 🚀';

  @override String get languageEnglish => 'انگریزی';
  @override String get languageTurkish => 'ترکی';

  @override String get focusShort => 'فوکس';
  @override String get shortBreakShort => 'مختصر';
  @override String get longBreakShort => 'لمبا';

  @override String get addNote => 'نوٹ شامل کریں';
}
