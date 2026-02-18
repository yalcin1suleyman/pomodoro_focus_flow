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
  @override String get tasksHelpContent => 'أدر مهامك بفعالية لزيادة الإنتاجية:\n\n1. إنشاء مهمة\nاضغط على الزر (+) لإضافة مهمة جديدة.\n\n2. التقدير\nقدر عدد جلسات بومودورو التي تحتاجها. (يمكن تعديل المدة في الإعدادات).\n\n3. ابدأ التركيز\nاضغط على زر التشغيل (▶) في المهمة لبدء موقت التركيز.\n\n4. تحرير وحذف\nاسحب بطاقة المهمة إلى اليسار للكشف عن خيارات التحرير والحذف.\n\n5. تتبع التقدم\nيتم تسجيل التقدم في الإحصائيات عند انتهاء الموقت. الجلسات التي تبدأ بدون مهمة تسجل كـ "تركيز عام".';

  @override String get tasksHelpStep1Title => 'إنشاء مهمة';
  @override String get tasksHelpStep1Content => 'اضغط على الزر (+) لإضافة مهمة جديدة.';
  
  @override String get tasksHelpStep2Title => 'التقدير';
  @override String get tasksHelpStep2Content => 'قدر عدد جلسات بومودورو التي تحتاجها للمهمة. (يمكن تعديل المدة في الإعدادات).';
  
  @override String get tasksHelpStep3Title => 'ابدأ التركيز';
  @override String get tasksHelpStep3Content => 'اضغط على زر التشغيل (▶) في المهمة لبدء موقت التركيز.';
  
  @override String get tasksHelpStep4Title => 'تحرير وحذف';
  @override String get tasksHelpStep4Content => 'اسحب بطاقة المهمة إلى اليسار للكشف عن خيارات التحرير والحذف.';
  
  @override String get tasksHelpStep5Title => 'تتبع التقدم';
  @override String get tasksHelpStep5Content => 'يتم تسجيل التقدم في الإحصائيات عند انتهاء الموقت. الجلسات التي تبدأ بدون مهمة تسجل كـ "تركيز عام".';
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

  @override String get shareAdUnlockContent => 'يجب عليك مشاهدة إعلان قصير لفتح هذه الميزة.';
  @override String get shareAdUnlockButton => 'مشاهدة الإعلان';
  
  @override String get shareSummary => 'ملخص';
  @override String get shareFocused => 'تركيز';
  @override String get shareSessions => 'جلسات';
  @override String get shareStreak => 'شارك خطك وحافظ على مسؤوليتك 🚀';

  @override String get languageEnglish => 'الإنجليزية';
  @override String get languageTurkish => 'التركية';

  @override String get focusShort => 'تركيز';
  @override String get shortBreakShort => 'قصير';
  @override String get longBreakShort => 'طويل';

  @override String get addNote => 'إضافة ملاحظة';
  // Help & Warnings
  @override String get helpTitle => 'App Guide';
  @override String get helpContent => 
    "**How does the app work?**\n\n"
    "**Pomodoro**: Focus for 25 minutes, then take a short break. After 4 sessions, take a long break.\n\n"
    "**Timer**: Tap start to focus. Pause if needed.\n\n"
    "**Settings**: Customize your focus durations and sounds.\n\n"
    "**Tasks**: Track your work by adding tasks.\n\n"
    "**Stats**: View your progress over time.";
  @override String get timerRunningWarning => 'يرجى إيقاف المؤقت قبل تغيير الوضع.';
  // Help Slideshow
  @override String get helpUnknown => 'غير معروف';
  @override String get helpSlide1Title => 'أتقن وقتك';
  @override String get helpSlide1Desc => 'إدارة الوقت فن. حافظ على تركيزك حاداً كالليزر، وامنع الإرهاق، وعظّم إنتاجيتك مع تقنية بومودورو.';
  
  @override String get helpSlide2Title => 'اختر هدفك';
  @override String get helpSlide2Desc => 'تبدأ الإنجازات العظيمة بخطوات صغيرة. اختر أهم مهمة اليوم وكن مستعداً للتركيز عليها.';
  
  @override String get helpSlide3Title => 'تركيز كامل';
  @override String get helpSlide3Desc => 'أسكت العالم الخارجي لمدة 25 دقيقة. أنت وهدفك فقط. ادخل وضع العمل العميق والتقط التدفق.';
  
  @override String get helpSlide4Title => 'جدد عقلك';
  @override String get helpSlide4Desc => 'أخذ استراحة ليس إضاعة للوقت؛ إنه تجديد استراتيجي. أعد تهيئة دماغك للجلسة التالية باستراحة قصيرة مدتها 5 دقائق.';
  
  @override String get helpSlide5Title => 'دورة النصر';
  @override String get helpSlide5Desc => 'كل دورة مكتملة هي خطوة عملاقة نحو هدفك. احتفل بنجاحك، واسترح بعمق، واستعد بقوة أكبر للنصر القادم.';
  
  @override String get skip => 'تخطي';
  @override String get start => 'ابدأ';
  @override String get next => 'التالي';
}
