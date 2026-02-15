import 'language.dart';

class ArabicLanguage implements Language {
  @override String get code => 'ar';
  @override String get name => 'العربية';

  @override String get settings => 'الإعدادات';
  @override String get appearance => 'المظهر';
  @override String get darkMode => 'الوضع الداكن';
  @override String get theme => 'السمة';
  @override String get language => 'اللغة';
  @override String get focusSounds => 'أصوات التركيز';
  @override String get tasks => 'المهام';
  @override String get stats => 'الإحصائيات';
  @override String get focus => 'التركيز';
  @override String get shortBreak => 'استراحة قصيرة';
  @override String get longBreak => 'استراحة طويلة';
  @override String get version => 'الإصدار';

  @override String get weeklyActivity => 'النشاط الأسبوعي';
  @override String get focusTime => 'وقت التركيز';
  @override String get dailyGoal => 'الهدف اليومي';
  @override String get remaining => 'المتبقي';
  @override String get completed => 'مكتمل';
  @override String get setGoal => 'تحديد الهدف';
  @override String get hours => 'ساعات';
  
  @override String get timerSettings => 'إعدادات المؤقت';
  @override String get pomodoroDuration => 'مدة بومودورو';
  @override String get shortBreakDuration => 'مدة الاستراحة القصيرة';
  @override String get longBreakDuration => 'مدة الاستراحة الطويلة';
  @override String get minutes => 'دقيقة';
  @override String get timeIsUp => 'انتهى الوقت!';
  @override String get sessionCompleted => 'اكتملت الجلسة';
  @override String get breakOver => 'انتهت الاستراحة';

  @override String get themeClassic => 'كلاسيكي';
  @override String get themeSakura => 'ساكورا';
  @override String get themeOcean => 'محيط';
  @override String get themeForest => 'غابة';
  @override String get themeSilver => 'فضي';

  @override String get cancel => 'إلغاء';
  @override String get save => 'حفظ';
  @override String get close => 'إغلاق';
  @override String get delete => 'حذف';
  @override String get saveNote => 'حفظ الملاحظة';
  @override String get editNote => 'تعديل الملاحظة';

  @override String get today => 'اليوم';
  @override String get empty => 'فارغ';
  @override String get newTask => 'مهمة جديدة';
  @override String get taskHint => 'على ماذا تعمل؟';
  @override String get estPomodoros => 'تقدير بومودورو:';
  @override String get createTask => 'إنشاء مهمة';
  @override String get updateTask => 'تحديث';
  @override String get noTasks => 'لا مهام. أضف واحدة!';
  @override String get pomodoroCount => 'بومودورو';
  @override String get inProgress => 'قيد التنفيذ';
  @override String get focusedTime => 'وقت التركيز';
  @override String get tasksWorkedOn => 'الأنشطة:';
  @override String get completedTasksLabel => 'المهام المكتملة';
  @override String get noTasksRecorded => 'لا سجلات.';
  @override String get dailyNote => 'ملاحظة اليوم:';
  @override String get noteHint => 'كيف كان تركيزك اليوم؟';
  @override String get generalFocus => 'تركيز عام';
  @override String get goalMet => 'تم تحقيق الهدف';
  @override String get goalMissed => 'لم يتحقق الهدف';
  @override String get tasksHelpTitle => 'إدارة المهام';
  @override String get tasksHelpContent => '1. إنشاء (+)\n2. تقدير\n3. بدء (▶)\n4. تعديل (سحب لليسار)';

  @override String get navFocus => 'تركيز';
  @override String get navTasks => 'مهام';
  @override String get navStats => 'إحصائيات';
  @override String get navSettings => 'إعدادات';

  @override String get monthJan => 'يناير';
  @override String get monthFeb => 'فبراير';
  @override String get monthMar => 'مارس';
  @override String get monthApr => 'أبريل';
  @override String get monthMay => 'مايو';
  @override String get monthJun => 'يونيو';
  @override String get monthJul => 'يوليو';
  @override String get monthAug => 'أغسطس';
  @override String get monthSep => 'سبتمبر';
  @override String get monthOct => 'أكتوبر';
  @override String get monthNov => 'نوفمبر';
  @override String get monthDec => 'ديسمبر';
  
  @override String get share => 'مشاركة';
  @override String get shareStatsTitle => 'إحصائياتي';
  @override String get shareMessage => 'تحقق من تقدمي!';
  @override String get statsDaily => 'يومي';
  @override String get statsMonthly => 'شهري';
  @override String get stats6Months => '6 أشهر';
  @override String get statsYearly => 'سنوي';
  @override String get average => 'المعدل';
  @override String get sessions => 'جلسات';
  @override String get heatmapLegend => 'أقل • أكثر';

  @override String get soundType => 'أصوات';
  @override String get soundTypeBell => 'جرس';
  @override String get soundTypeNotification => 'إشعار';

  @override String get shareFooterQuote => 'التركيز مع Pomodoro Master';
  @override String get shareGoalCompleted => 'تحقق الهدف';
  @override String get shareTopFocus => 'أعلى تركيز';
  @override String get shareLegendStart => 'بدء';
  @override String get shareLegendGoal => 'هدف';
  @override String get shareWeeklyFocus => 'تركيز أسبوعي';
  @override String get shareYearlyJourney => 'الرحلة';

  @override String get quoteMotivation1 => "التركيز هو مفتاح النجاح.";
  @override String get quoteMotivation2 => "خطوة بخطوة.";
  @override String get quoteMotivation3 => "نتائج كبيرة.";
  @override String get quoteMotivation4 => "استمر في التقدم!";
  @override String get quoteMotivation5 => "مستقبلك يصنع اليوم.";
  @override String get quoteMotivation6 => "كن مثابراً.";
  @override String get quoteMotivation7 => "العمل العميق مهم.";

  @override String get shareRange => 'النطاق';
  @override String get shareRangeDaily => 'يومي';
  @override String get shareRangeWeekly => 'أسبوعي';
  @override String get shareRangeMonthly => 'شهري';
  @override String get shareRangeYearly => 'سنوي';
  @override String get shareButton => 'مشاركة';
  @override String get monthlyOverview => 'نظرة عامة شهرية';

  @override String get languageEnglish => 'الإنجليزية';
  @override String get languageTurkish => 'التركية';

  @override String get focusShort => 'تركيز';
  @override String get shortBreakShort => 'قصير';
  @override String get longBreakShort => 'طويل';

  @override String get addNote => 'إضافة ملاحظة';
}
