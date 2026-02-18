import 'language.dart';

class BengaliLanguage implements Language {
  @override String get code => 'bn';
  @override String get name => 'বাংলা';

  @override String get settings => 'সেটিংস';
  @override String get appearance => 'চেহারা';
  @override String get darkMode => 'ডার্ক মোড';
  @override String get theme => 'থিম';
  @override String get language => 'ভাষা';
  @override String get focusSounds => 'ফোকাস সাউন্ড';
  @override String get tasks => 'কাজ';
  @override String get stats => 'পরিসংখ্যান';
  @override String get focus => 'ফোকাস';
  @override String get shortBreak => 'ছোট বিরতি';
  @override String get longBreak => 'লম্বা বিরতি';
  @override String get version => 'সংস্করণ';

  @override String get weeklyActivity => 'সাপ্তাহিক কার্যকলাপ';
  @override String get focusTime => 'ফোকাস সময়';
  @override String get dailyGoal => 'দৈনিক লক্ষ্য';
  @override String get remaining => 'বাকি';
  @override String get completed => 'সম্পন্ন';
  @override String get setGoal => 'লক্ষ্য নির্ধারণ';
  @override String get hours => 'ঘণ্টা';
  
  @override String get timerSettings => 'টাইমার সেটিংস';
  @override String get pomodoroDuration => 'পোমোডোরো সময়কাল';
  @override String get shortBreakDuration => 'ছোট বিরতি সময়কাল';
  @override String get longBreakDuration => 'লম্বা বিরতি সময়কাল';
  @override String get minutes => 'মিনিট';
  @override String get timeIsUp => 'সময় শেষ!';
  @override String get sessionCompleted => 'সেশন সমাপ্ত';
  @override String get breakOver => 'বিরতি শেষ';

  @override String get themeClassic => 'ক্লাসিক';
  @override String get themeSakura => 'সাকুরা';
  @override String get themeOcean => 'মহাসাগর';
  @override String get themeForest => 'বন';
  @override String get themeSilver => 'সিলভার';

  @override String get cancel => 'বাতিল';
  @override String get save => 'সংরক্ষণ';
  @override String get close => 'বন্ধ';
  @override String get delete => 'মুছুন';
  @override String get saveNote => 'নোট সংরক্ষণ';
  @override String get editNote => 'নোট সম্পাদনা';

  @override String get today => 'আজ';
  @override String get empty => 'খালি';
  @override String get newTask => 'নতুন কাজ';
  @override String get taskHint => 'আপনি কি করছেন?';
  @override String get estPomodoros => 'আনুমানিক পোমোডোরো:';
  @override String get createTask => 'তৈরি করুন';
  @override String get updateTask => 'আপডেট';
  @override String get noTasks => 'কোনো কাজ নেই। যোগ করুন!';
  @override String get pomodoroCount => 'পোমোডোরো';
  @override String get inProgress => 'চলছে';
  @override String get focusedTime => 'ফোকাস করা সময়';
  @override String get tasksWorkedOn => 'কার্যকলাপ:';
  @override String get completedTasksLabel => 'সম্পন্ন কাজ';
  @override String get noTasksRecorded => 'কোনো রেকর্ড নেই।';
  @override String get dailyNote => 'দৈনিক নোট:';
  @override String get noteHint => 'আজকের ফোকাস কেমন ছিল?';
  @override String get generalFocus => 'সাধারণ ফোকাস';
  @override String get goalMet => 'লক্ষ্য অর্জিত';
  @override String get goalMissed => 'লক্ষ্যের নিচে';
  @override String get tasksHelpTitle => 'টাস্ক ম্যানেজমেন্ট';
  @override String get tasksHelpContent => 'উৎপাদনশীলতা বাড়াতে কার্যগুলি কার্যকরভাবে পরিচালনা করুন:\n\n1. কার্য তৈরি করুন\nনতুন কার্য যোগ করতে (+) বোতাম টিপুন।\n\n2. অনুমান\nঅনুমান করুন আপনার কতটি পোমোডোরো প্রয়োজন। (সময়কাল সেটিংসে সামঞ্জস্যযোগ্য)।\n\n3. ফোকাস শুরু করুন\nটাইমার শুরু করতে কার্যে প্লে (▶) বোতাম টিপুন।\n\n4. সম্পাদনা এবং মুছুন\nসম্পাদনা এবং মুছে ফেলার বিকল্পগুলি দেখতে কার্য কার্ডটি বামে সোয়াইপ করুন।\n\n5. অগ্রগতি ট্র্যাক করুন\nটাইমার শেষ হলে অগ্রগতি পরিসংখ্যানে লগ করা হয়। কার্য ছাড়া সেশনগুলি "সাধারণ ফোকাস" হিসাবে লগ করা হয়।';

  @override String get tasksHelpStep1Title => 'কার্য তৈরি করুন';
  @override String get tasksHelpStep1Content => 'নতুন কার্য যোগ করতে (+) বোতাম টিপুন।';
  
  @override String get tasksHelpStep2Title => 'অনুমান';
  @override String get tasksHelpStep2Content => 'অনুমান করুন কাজটির জন্য আপনার কতটি পোমোডোরো প্রয়োজন। (সময়কাল সেটিংসে সামঞ্জস্যযোগ্য)।';
  
  @override String get tasksHelpStep3Title => 'ফোকাস শুরু করুন';
  @override String get tasksHelpStep3Content => 'ফোকাস টাইমার শুরু করতে কার্যে প্লে (▶) বোতাম টিপুন।';
  
  @override String get tasksHelpStep4Title => 'সম্পাদনা এবং মুছুন';
  @override String get tasksHelpStep4Content => 'সম্পাদনা এবং মুছে ফেলার বিকল্পগুলি প্রকাশ করতে কার্য কার্ডটি বামে সোয়াইপ করুন।';
  
  @override String get tasksHelpStep5Title => 'অগ্রগতি ট্র্যাক করুন';
  @override String get tasksHelpStep5Content => 'টাইমার শেষ হলে অগ্রগতি পরিসংখ্যানে লগ করা হয়। কার্য ছাড়া সেশনগুলি "সাধারণ ফোকাস" হিসাবে লগ করা হয়।';
  @override String get navFocus => 'ফোকাস';
  @override String get navTasks => 'কাজ';
  @override String get navStats => 'পরিসংখ্যান';
  @override String get navSettings => 'সেটিংস';

  @override String get monthJan => 'জানুয়ারি';
  @override String get monthFeb => 'ফেব্রুয়ারি';
  @override String get monthMar => 'মার্চ';
  @override String get monthApr => 'এপ্রিল';
  @override String get monthMay => 'মে';
  @override String get monthJun => 'জুন';
  @override String get monthJul => 'জুলাই';
  @override String get monthAug => 'আগস্ট';
  @override String get monthSep => 'সেপ্টেম্বর';
  @override String get monthOct => 'অক্টোবর';
  @override String get monthNov => 'নভেম্বর';
  @override String get monthDec => 'ডিসেম্বর';
  
  @override String get share => 'শেয়ার';
  @override String get shareStatsTitle => 'আমার পরিসংখ্যান';
  @override String get shareMessage => 'আমার অগ্রগতি দেখুন!';
  @override String get statsDaily => 'দৈনিক';
  @override String get statsMonthly => 'মাসিক';
  @override String get stats6Months => '৬ মাস';
  @override String get statsYearly => 'বার্ষিক';
  @override String get average => 'গড়';
  @override String get sessions => 'সেশন';
  @override String get heatmapLegend => 'কম • বেশি';

  @override String get soundType => 'শব্দ';
  @override String get soundTypeBell => 'ঘণ্টা';
  @override String get soundTypeNotification => 'বিজ্ঞপ্তি';

  @override String get shareFooterQuote => 'Pomodoro Master এর সাথে ফোকাস করুন';
  @override String get shareGoalCompleted => 'লক্ষ্য অর্জিত';
  @override String get shareTopFocus => 'শীর্ষ ফোকাস';
  @override String get shareLegendStart => 'শুরু';
  @override String get shareLegendGoal => 'লক্ষ্য';
  @override String get shareWeeklyFocus => 'সাপ্তাহিক ফোকাস';
  @override String get shareYearlyJourney => 'যাত্রা';

  @override String get quoteMotivation1 => "ফোকাস সাফল্যের চাবিকাঠি।";
  @override String get quoteMotivation2 => "একবারে একটি পোমোডোরো।";
  @override String get quoteMotivation3 => "ছোট পদক্ষেপ, বড় ফলাফল।";
  @override String get quoteMotivation4 => "এগিয়ে যান!";
  @override String get quoteMotivation5 => "আপনার ভবিষ্যৎ আজ তৈরি হয়।";
  @override String get quoteMotivation6 => "ধারাবাহিক হোন।";
  @override String get quoteMotivation7 => "গভীর কাজ গুরুত্বপূর্ণ।";

  @override String get shareRange => 'রেঞ্জ';
  @override String get shareRangeDaily => 'দৈনিক';
  @override String get shareRangeWeekly => 'সাপ্তাহিক';
  @override String get shareRangeMonthly => 'মাসিক';
  @override String get shareRangeYearly => 'বার্ষিক';
  @override String get shareButton => 'শেয়ার';
  @override String get monthlyOverview => 'মাসিক ওভারভিউ';

  @override String get shareAdUnlockContent => 'এই বৈশিষ্ট্যটি আনলক করতে আপনাকে একটি ছোট বিজ্ঞাপন দেখতে হবে।';
  @override String get shareAdUnlockButton => 'বিজ্ঞাপন দেখুন';
  
  @override String get shareSummary => 'সারাংশ';
  @override String get shareFocused => 'মনোযোগী';
  @override String get shareSessions => 'সেশন';
  @override String get shareStreak => 'আপনার স্ট্রিক শেয়ার করুন এবং নিজেকে জবাবদিহি করুন 🚀';

  @override String get languageEnglish => 'ইংরেজি';
  @override String get languageTurkish => 'তুর্কি';

  @override String get focusShort => 'ফোকাস';
  @override String get shortBreakShort => 'ছোট';
  @override String get longBreakShort => 'লম্বা';

  @override String get addNote => 'নোট যোগ করুন';
  // Help & Warnings
  @override String get helpTitle => 'App Guide';
  @override String get helpContent => 
    "**How does the app work?**\n\n"
    "**Pomodoro**: Focus for 25 minutes, then take a short break. After 4 sessions, take a long break.\n\n"
    "**Timer**: Tap start to focus. Pause if needed.\n\n"
    "**Settings**: Customize your focus durations and sounds.\n\n"
    "**Tasks**: Track your work by adding tasks.\n\n"
    "**Stats**: View your progress over time.";
  @override String get timerRunningWarning => 'মোড পরিবর্তন করার আগে টাইমার বন্ধ করুন।';
  // Help Slideshow
  @override String get helpUnknown => 'অজানা';
  @override String get helpSlide1Title => 'আপনার সময়ের নিয়ন্ত্রণ নিন';
  @override String get helpSlide1Desc => 'সময় ব্যবস্থাপনা একটি শিল্প। পোমোডোরো কৌশলে আপনার মনোযোগ লেজারের মতো তীক্ষ্ণ রাখুন, বার্নআউট প্রতিরোধ করুন এবং উৎপাদনশীলতা সর্বাধিক করুন।';
  
  @override String get helpSlide2Title => 'আপনার লক্ষ্য বেছে নিন';
  @override String get helpSlide2Desc => 'মহান অর্জন ছোট পদক্ষেপ থেকে শুরু হয়। আজকের সবচেয়ে গুরুত্বপূর্ণ কাজটি বেছে নিন এবং সেটিতে মনোযোগ দিতে প্রস্তুত হন।';
  
  @override String get helpSlide3Title => 'সম্পূর্ণ মনোযোগ';
  @override String get helpSlide3Desc => '25 মিনিটের জন্য বাইরের জগতকে নীরব করুন। শুধু আপনি এবং আপনার লক্ষ্য। গভীর কাজের মোডে প্রবেশ করুন এবং প্রবাহ ধরুন।';
  
  @override String get helpSlide4Title => 'মন সতেজ করুন';
  @override String get helpSlide4Desc => 'বিরতি নেওয়া সময়ের অপচয় নয়; এটি কৌশলগত পুনর্নবীকরণ। 5 মিনিটের ছোট বিরতিতে পরবর্তী সেশনের জন্য আপনার মস্তিষ্ককে প্রস্তুত করুন।';
  
  @override String get helpSlide5Title => 'বিজয়ের চক্র';
  @override String get helpSlide5Desc => 'প্রতিটি সম্পন্ন চক্র আপনার লক্ষ্যের দিকে একটি বিশাল পদক্ষেপ। আপনার সাফল্য উদযাপন করুন, গভীরভাবে বিশ্রাম নিন এবং পরবর্তী বিজয়ের জন্য আরও শক্তিশালী হয়ে প্রস্তুত হন।';
  
  @override String get skip => 'এড়িয়ে যান';
  @override String get start => 'শুরু করুন';
  @override String get next => 'পরবর্তী';
}
