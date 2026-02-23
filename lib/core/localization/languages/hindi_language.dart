import 'language.dart';

class HindiLanguage implements Language {
  @override String get code => 'hi';
  @override String get name => 'हिन्दी';

  @override String get settings => 'सेटिंग्स';
  @override String get appearance => 'दिखावट';
  @override String get darkMode => 'डार्क मोड';
  @override String get theme => 'थीम';
  @override String get language => 'भाषा';
  @override String get focusSounds => 'फोकस ध्वनियाँ';
  @override String get tasks => 'कार्य';
  @override String get stats => 'सांख्यिकी';
  @override String get focus => 'फोकस';
  @override String get shortBreak => 'छोटा ब्रेक';
  @override String get longBreak => 'लंबा ब्रेक';
  @override String get version => 'संस्करण';

  @override String get weeklyActivity => 'साप्ताहिक गतिविधि';
  @override String get focusTime => 'फोकस समय';
  @override String get dailyGoal => 'दैनिक लक्ष्य';
  @override String get remaining => 'शेष';
  @override String get completed => 'पूरा हुआ';
  @override String get setGoal => 'लक्ष्य निर्धारित करें';
  @override String get hours => 'घंटे';
  
  @override String get timerSettings => 'टाइमर सेटिंग्स';
  @override String get pomodoroDuration => 'पोमोडोरो अवधि';
  @override String get shortBreakDuration => 'छोटा ब्रेक अवधि';
  @override String get longBreakDuration => 'लंबा ब्रेक अवधि';
  @override String get minutes => 'मिनट';
  @override String get timeIsUp => 'समय समाप्त!';
  @override String get sessionCompleted => 'सत्र पूरा हुआ';
  @override String get breakOver => 'ब्रेक समाप्त';

  @override String get themeClassic => 'क्लासिक';
  @override String get themeSakura => 'साकुरा';
  @override String get themeOcean => 'महासागर';
  @override String get themeForest => 'वन';
  @override String get themeSilver => 'चांदी';

  @override String get cancel => 'रद्द करें';
  @override String get save => 'सहेजें';
  @override String get close => 'बंद करें';
  @override String get delete => 'हटाएं';
  @override String get saveNote => 'नोट सहेजें';
  @override String get editNote => 'नोट संपादित करें';

  @override String get today => 'आज';
  @override String get empty => 'खाली';
  @override String get newTask => 'नया कार्य';
  @override String get taskHint => 'आप किस पर काम कर रहे हैं?';
  @override String get estPomodoros => 'अनुमानित पोमोडोरो:';
  @override String get createTask => 'कार्य बनाएं';
  @override String get updateTask => 'अपडेट करें';
  @override String get noTasks => 'कोई कार्य नहीं। एक जोड़ें!';
  @override String get pomodoroCount => 'पोमोडोरो';
  @override String get inProgress => 'प्रगति पर';
  @override String get focusedTime => 'फोकस्ड समय';
  @override String get tasksWorkedOn => 'गतिविधियाँ:';
  @override String get completedTasksLabel => 'पूरे किए गए कार्य';
  @override String get noTasksRecorded => 'कोई कार्य रिकॉर्ड नहीं।';
  @override String get dailyNote => 'दैनिक नोट:';
  @override String get noteHint => 'आज का फोकस कैसा था?';
  @override String get generalFocus => 'सामान्य फोकस';
  @override String get goalMet => 'लक्ष्य पूरा हुआ';
  @override String get goalMissed => 'लक्ष्य से कम';
  @override String get tasksHelpTitle => 'कार्य प्रबंधन';
  @override String get tasksHelpContent => 'उत्पादकता बढ़ाने के लिए कार्यों को प्रभावी ढंग से प्रबंधित करें:\n\n1. कार्य बनाएं\nनया कार्य जोड़ने के लिए (+) बटन पर टैप करें।\n\n2. अनुमान\nअनुमान लगाएं कि आपको कितने पोमोडोरो की आवश्यकता है। (अवधि सेटिंग्स में समायोज्य है)।\n\n3. ध्यान केंद्रित करना शुरू करें\nटाइमर शुरू करने के लिए कार्य पर प्ले (▶) बटन पर टैप करें।\n\n4. संपादित करें और हटाएं\nसंपादन और हटाने के विकल्पों को देखने के लिए टास्क कार्ड को बाईं ओर स्वाइप करें।\n\n5. प्रगति ट्रैक करें\nटाइमर समाप्त होने पर प्रगति आंकड़ों में लॉग की जाती है। कार्य के बिना सत्र "सामान्य फोकस" के रूप में लॉग किए जाते हैं।';

  @override String get tasksHelpStep1Title => 'कार्य बनाएं';
  @override String get tasksHelpStep1Content => 'नया कार्य जोड़ने के लिए (+) बटन पर टैप करें।';
  
  @override String get tasksHelpStep2Title => 'अनुमान';
  @override String get tasksHelpStep2Content => 'अनुमान लगाएं कि कार्य के लिए आपको कितने पोमोडोरो की आवश्यकता है। (अवधि सेटिंग्स में समायोज्य है)।';
  
  @override String get tasksHelpStep3Title => 'ध्यान केंद्रित करना शुरू करें';
  @override String get tasksHelpStep3Content => 'फोकस टाइमर शुरू करने के लिए कार्य पर प्ले (▶) बटन पर टैप करें।';
  
  @override String get tasksHelpStep4Title => 'संपादित करें और हटाएं';
  @override String get tasksHelpStep4Content => 'संपादन और हटाने के विकल्पों को प्रकट करने के लिए टास्क कार्ड को बाईं ओर स्वाइप करें।';
  
  @override String get tasksHelpStep5Title => 'प्रगति ट्रैक करें';
  @override String get tasksHelpStep5Content => 'टाइमर समाप्त होने पर प्रगति आंकड़ों में लॉग की जाती है। कार्य के बिना सत्र "सामान्य फोकस" के रूप में लॉग किए जाते हैं।';
  @override String get navFocus => 'फोकस';
  @override String get navTasks => 'कार्य';
  @override String get navStats => 'सांख्यिकी';
  @override String get navSettings => 'सेटिंग्स';

  @override String get monthJan => 'जनवरी';
  @override String get monthFeb => 'फरवरी';
  @override String get monthMar => 'मार्च';
  @override String get monthApr => 'अप्रैल';
  @override String get monthMay => 'मई';
  @override String get monthJun => 'जून';
  @override String get monthJul => 'जुलाई';
  @override String get monthAug => 'अगस्त';
  @override String get monthSep => 'सितंबर';
  @override String get monthOct => 'अक्टूबर';
  @override String get monthNov => 'नवंबर';
  @override String get monthDec => 'दिसंबर';
  
  @override String get share => 'साझा करें';
  @override String get shareStatsTitle => 'मेरे आँकड़े';
  @override String get shareMessage => 'मेरी प्रगति देखें!';
  @override String get statsDaily => 'दैनिक';
  @override String get statsMonthly => 'मासिक';
  @override String get stats6Months => '6 महीने';
  @override String get statsYearly => 'वार्षिक';
  @override String get average => 'औसत';
  @override String get sessions => 'सत्र';
  @override String get heatmapLegend => 'कम • अधिक';

  @override String get soundType => 'ध्वनियाँ';
  @override String get soundTypeBell => 'घंटी';
  @override String get soundTypeNotification => 'अधिसूचना';

  @override String get shareFooterQuote => 'Pomodoro Master के साथ फोकस करें';
  @override String get shareGoalCompleted => 'लक्ष्य पूरा हुआ';
  @override String get shareTopFocus => 'शीर्ष फोकस';
  @override String get shareLegendStart => 'शुरू';
  @override String get shareLegendGoal => 'लक्ष्य';
  @override String get shareWeeklyFocus => 'साप्ताहिक फोकस';
  @override String get shareYearlyJourney => 'यात्रा';

  @override String get quoteMotivation1 => "फोकस सफलता की कुंजी है।";
  @override String get quoteMotivation2 => "एक बार में एक पोमोडोरो।";
  @override String get quoteMotivation3 => "छोटे कदम, बड़े परिणाम।";
  @override String get quoteMotivation4 => "आगे बढ़ते रहो!";
  @override String get quoteMotivation5 => "आपका भविष्य आज बनता है।";
  @override String get quoteMotivation6 => "निरंतर रहें।";
  @override String get quoteMotivation7 => "गहरा काम मायने रखता है।";

  @override String get shareRange => 'रेंज';
  @override String get shareRangeDaily => 'दैनिक';
  @override String get shareRangeWeekly => 'साप्ताहिक';
  @override String get shareRangeMonthly => 'मासिक';
  @override String get shareRangeYearly => 'वार्षिक';
  @override String get shareButton => 'साझा करें';
  @override String get monthlyOverview => 'मासिक अवलोकन';

  @override String get shareAdUnlockContent => 'इस सुविधा को अनलॉक करने के लिए आपको एक छोटा विज्ञापन देखना होगा।';
  @override String get shareAdUnlockButton => 'विज्ञापन देखें';
  
  @override String get shareSummary => 'सारांश';
  @override String get shareFocused => 'फोकस्ड';
  @override String get shareSessions => 'सत्र';
  @override String get shareStreak => 'अपनी स्ट्रीक साझा करें और खुद को जवाबदेह रखें 🚀';

  @override String get languageEnglish => 'अंग्रेज़ी';
  @override String get languageTurkish => 'तुर्की';

  @override String get focusShort => 'फोकस';
  @override String get shortBreakShort => 'छोटा';
  @override String get longBreakShort => 'लंबा';

  @override String get addNote => 'नोट जोड़ें';
  // Help & Warnings
  @override String get helpTitle => 'App Guide';
  @override String get helpContent => 
    "**How does the app work?**\n\n"
    "**Pomodoro**: Focus for 25 minutes, then take a short break. After 4 sessions, take a long break.\n\n"
    "**Timer**: Tap start to focus. Pause if needed.\n\n"
    "**Settings**: Customize your focus durations and sounds.\n\n"
    "**Tasks**: Track your work by adding tasks.\n\n"
    "**Stats**: View your progress over time.";
  @override String get timerRunningWarning => 'कृपया मोड बदलने से पहले टाइमर रोकें।';
  // Help Slideshow
  @override String get helpUnknown => 'अज्ञात';
  @override String get helpSlide1Title => 'अपने समय पर नियंत्रण पाएं';
  @override String get helpSlide1Desc => 'समय प्रबंधन एक कला है। पोमोडोरो तकनीक से अपना ध्यान लेज़र की तरह तेज़ रखें, बर्नआउट से बचें और उत्पादकता को अधिकतम करें।';
  
  @override String get helpSlide2Title => 'अपना लक्ष्य चुनें';
  @override String get helpSlide2Desc => 'महान उपलब्धियां छोटे कदमों से शुरू होती हैं। आज का सबसे महत्वपूर्ण काम चुनें और उस पर ध्यान केंद्रित करने के लिए तैयार हों।';
  
  @override String get helpSlide3Title => 'पूर्ण एकाग्रता';
  @override String get helpSlide3Desc => '25 मिनट के लिए बाहरी दुनिया को शांत करें। सिर्फ आप और आपका लक्ष्य। गहरे काम के मोड में प्रवेश करें और प्रवाह को पकड़ें।';
  
  @override String get helpSlide4Title => 'मन को तरोताज़ा करें';
  @override String get helpSlide4Desc => 'ब्रेक लेना समय की बर्बादी नहीं है; यह रणनीतिक नवीनीकरण है। 5 मिनट के छोटे ब्रेक से अगले सत्र के लिए अपने दिमाग को तैयार करें।';
  
  @override String get helpSlide5Title => 'जीत का चक्र';
  @override String get helpSlide5Desc => 'हर पूरा किया गया चक्र आपके लक्ष्य की ओर एक विशाल कदम है। अपनी सफलता का जश्न मनाएं, गहरा आराम करें और अगली जीत के लिए और मजबूत तैयारी करें।';
  
  @override String get skip => 'छोड़ें';
  @override String get start => 'शुरू करें';
  @override String get next => 'अगला';

  // Rate App & Contact Us
  @override String get rateApp => 'एप को रेट करें';
  @override String get contactUs => 'हमसे संपर्क करें';
  @override String get rateAppTitle => 'क्या एप पसंद आ रही है?';
  @override String get rateAppMessage => 'आपकी समीक्षा हमें आगे बढ़ने में मदद करती है। Play Store पर Pomodoro Master को रेट करें!';
  @override String get rateNow => 'अभी रेट करें';
  @override String get rateLater => 'बाद में';
  @override String get rateAlreadyDone => 'पहले से रेट किया ✓';
}
