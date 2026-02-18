import 'language.dart';

class TurkishLanguage implements Language {
  @override String get code => 'tr';
  @override String get name => 'Türkçe';

  @override String get settings => 'Ayarlar';
  @override String get appearance => 'Görünüm';
  @override String get darkMode => 'Karanlık Mod';
  @override String get theme => 'Tema';
  @override String get language => 'Dil';
  @override String get focusSounds => 'Odak Sesleri';
  @override String get tasks => 'Görevler';
  @override String get stats => 'İstatistikler';
  @override String get focus => 'Odaklan';
  @override String get shortBreak => 'Kısa Mola';
  @override String get longBreak => 'Uzun Mola';
  @override String get version => 'Sürüm';

  @override String get weeklyActivity => 'Haftalık Aktivite';
  @override String get focusTime => 'Odak Süresi';
  @override String get dailyGoal => 'Günlük Hedef';
  @override String get remaining => 'Kalan';
  @override String get completed => 'Tamamlanan';
  @override String get setGoal => 'Günlük Hedef Belirle';
  @override String get hours => 'Saat';
  
  @override String get timerSettings => 'Zamanlayıcı Ayarları';
  @override String get pomodoroDuration => 'Pomodoro Süresi';
  @override String get shortBreakDuration => 'Kısa Mola Süresi';
  @override String get longBreakDuration => 'Uzun Mola Süresi';
  @override String get minutes => 'Dakika';
  @override String get timeIsUp => 'Süre Doldu!';
  @override String get sessionCompleted => 'Oturum Tamamlandı';
  @override String get breakOver => 'Mola Bitti';

  @override String get themeClassic => 'Klasik'; 
  @override String get themeSakura => 'Sakura';
  @override String get themeOcean => 'Okyanus';
  @override String get themeForest => 'Orman';
  @override String get themeSilver => 'Gümüş';

  @override String get cancel => 'İptal';
  @override String get save => 'Kaydet';
  @override String get close => 'Kapat';
  @override String get delete => 'Sil';
  @override String get saveNote => 'Kaydet';
  @override String get editNote => 'Düzenle';

  @override String get today => 'Bugün';
  @override String get empty => 'Boş';
  @override String get newTask => 'Yeni Görev';
  @override String get taskHint => 'Ne üzerinde çalışıyorsun?';
  @override String get estPomodoros => 'Tahmini Pomodoro:';
  @override String get createTask => 'Görev Oluştur';
  @override String get updateTask => 'Görevi Güncelle';
  @override String get noTasks => 'Henüz görev yok. Bir tane ekle!';
  @override String get pomodoroCount => 'pomodoro';
  @override String get inProgress => 'Devam Ediyor';
  @override String get focusedTime => 'Odak Süresi';
  @override String get tasksWorkedOn => 'Etkinlikler:';
  @override String get completedTasksLabel => 'Tamamlanan Görevler';
  @override String get noTasksRecorded => 'Kayıtlı görev yok.';
  @override String get dailyNote => 'Günlük Not:';
  @override String get noteHint => 'Bugünkü odaklanman nasıldı?';
  @override String get generalFocus => 'Genel Odak';
  @override String get goalMet => 'Hedef Tamamlandı';
  @override String get goalMissed => 'Hedef Altında';
  @override String get tasksHelpTitle => 'Görev Yönetim Sistemi';
  @override String get tasksHelpContent => 'Görevleri yöneterek üretkenliğinizi artırın:\n\n1. Görev Oluştur\nYeni bir görev eklemek için (+) düğmesine dokunun.\n\n2. Tahmin Belirle\nGörevi tamamlamak için kaç Pomodoro\'ya ihtiyacınız olduğunu tahmin edin. (Pomodoro süresi Ayarlar\'dan değiştirilebilir.)\n\n3. Odaklanmaya Başla\nOdaklanma sayacını başlatmak için görevdeki Oynat (▶) düğmesine dokunun.\n\n4. Düzenle & Sil\nDüzenleme ve silme seçeneklerini görmek için görev kartını SOLA kaydırın.\n\n5. İlerlemeyi Takip Et\nSayaç bittiğinde ilerleme otomatik olarak İstatistikler kısmına kaydedilir. Görev seçmeden başlatılan sayaçlar "Genel Odak" olarak kaydedilir.';

  @override String get tasksHelpStep1Title => 'Görev Oluştur';
  @override String get tasksHelpStep1Content => 'Yeni bir görev eklemek için (+) düğmesine dokunun.';
  
  @override String get tasksHelpStep2Title => 'Tahmin Belirle';
  @override String get tasksHelpStep2Content => 'Görevi tamamlamak için kaç Pomodoro\'ya ihtiyacınız olduğunu tahmin edin. (Pomodoro süresi Ayarlar\'dan değiştirilebilir.)';
  
  @override String get tasksHelpStep3Title => 'Odaklanmaya Başla';
  @override String get tasksHelpStep3Content => 'Odaklanma sayacını başlatmak için görevdeki Oynat (▶) düğmesine dokunun.';
  
  @override String get tasksHelpStep4Title => 'Düzenle & Sil';
  @override String get tasksHelpStep4Content => 'Düzenleme ve silme seçeneklerini görmek için görev kartını SOLA kaydırın.';
  
  @override String get tasksHelpStep5Title => 'İlerlemeyi Takip Et';
  @override String get tasksHelpStep5Content => 'Sayaç bittiğinde ilerleme otomatik olarak İstatistikler kısmına kaydedilir. Görev seçmeden başlatılan sayaçlar "Genel Odak" olarak kaydedilir.';

  @override String get navFocus => 'Odak';
  @override String get navTasks => 'Görevler';
  @override String get navStats => 'İstatistik';
  @override String get navSettings => 'Ayarlar';

  @override String get monthJan => 'Ocak';
  @override String get monthFeb => 'Şubat';
  @override String get monthMar => 'Mart';
  @override String get monthApr => 'Nisan';
  @override String get monthMay => 'Mayıs';
  @override String get monthJun => 'Haziran';
  @override String get monthJul => 'Temmuz';
  @override String get monthAug => 'Ağustos';
  @override String get monthSep => 'Eylül';
  @override String get monthOct => 'Ekim';
  @override String get monthNov => 'Kasım';
  @override String get monthDec => 'Aralık';

  @override String get share => 'Paylaş';
  @override String get shareStatsTitle => 'Odak İstatistiklerim';
  @override String get shareMessage => 'Odak ilerlememe göz at!';
  @override String get statsDaily => 'Günlük İstatistik';
  @override String get statsMonthly => 'Aylık İstatistik';
  @override String get stats6Months => '6 Aylık İstatistik';
  @override String get statsYearly => 'Yıllık İstatistik';
  @override String get average => 'Günlük Ortalama';
  @override String get sessions => 'Oturum';
  @override String get heatmapLegend => 'Az  •  Çok';

  @override String get soundType => 'Bildirim Sesleri';
  @override String get soundTypeBell => 'Zil';
  @override String get soundTypeNotification => 'Sistem Bildirimi';

  // Share Screen
  @override String get shareFooterQuote => 'Pomodoro Master ile Odaklan';
  @override String get shareGoalCompleted => 'Hedef Tamamlandı';
  @override String get shareTopFocus => 'En Çok Odaklanılan';
  @override String get shareLegendStart => 'Başlangıç';
  @override String get shareLegendGoal => 'Hedef';
  @override String get shareWeeklyFocus => 'HAFTALIK ODAK';
  @override String get shareYearlyJourney => 'YOLCULUK';

  // Motivational Quotes
  @override String get quoteMotivation1 => "Odaklanmak başarının anahtarıdır.";
  @override String get quoteMotivation2 => "Her seferinde bir pomodoro.";
  @override String get quoteMotivation3 => "Küçük adımlar, büyük sonuçlar.";
  @override String get quoteMotivation4 => "İlerlemeye devam et!";
  @override String get quoteMotivation5 => "Geleceğin, bugün yaptıklarınla şekillenir.";
  @override String get quoteMotivation6 => "İstikrarlı ol, odaklan.";
  @override String get quoteMotivation7 => "Derin çalışma önemlidir.";

  // Share Dialog
  @override String get shareRange => 'Aralık';
  @override String get shareRangeDaily => 'Günlük';
  @override String get shareRangeWeekly => 'Haftalık';
  @override String get shareRangeMonthly => 'Aylık';
  @override String get shareRangeYearly => 'Yıllık';
  @override String get shareButton => 'Paylaş';
  @override String get monthlyOverview => 'AYLIK GENEL BAKIŞ';

  @override String get shareAdUnlockContent => 'Bu özelliği kullanmak için reklam izlemelisiniz.';
  @override String get shareAdUnlockButton => 'Reklam İzle';
  
  @override String get shareSummary => 'Özeti';
  @override String get shareFocused => 'odaklanma';
  @override String get shareSessions => 'oturum';
  @override String get shareStreak => 'Serini paylaş ve kendini motive et 🚀';

  // Language Names
  @override String get languageEnglish => 'English';
  @override String get languageTurkish => 'Türkçe';

  // Timer Mode Labels (shortened)
  @override String get focusShort => 'Odak';
  @override String get shortBreakShort => 'Kısa';
  @override String get longBreakShort => 'Uzun';

  // Misc
  @override String get addNote => 'Bir not ekle';

  // Help & Warnings
  @override String get helpTitle => 'Uygulama Rehberi';
  @override String get helpContent => 
    "**Uygulama Nasıl Çalışır?**\n\n"
    "**Pomodoro**: 25 dakika odaklanın, ardından kısa bir mola verin. 4 oturumdan sonra uzun bir mola verin.\n\n"
    "**Zamanlayıcı**: Odaklanmak için başlat'a dokunun. Gerekirse duraklatın.\n\n"
    "**Ayarlar**: Odaklanma sürelerinizi ve seslerinizi özelleştirin.\n\n"
    "**Görevler**: Görev ekleyerek çalışmalarınızı takip edin.\n\n"
    "**İstatistikler**: Zaman içindeki ilerlemenizi görüntüleyin.";
  @override String get timerRunningWarning => 'Lütfen durdurmadan geçiş yapmayın.';

  // Help Slideshow
  @override String get helpUnknown => 'Bilinmeyen';
  @override String get helpSlide1Title => 'Zamanın Efendisi Olun';
  @override String get helpSlide1Desc => 'Zamanı yönetmek bir sanattır. Pomodoro tekniği ile dikkatinizi lazer keskinliğinde tutun, tükenmişliği önleyin ve üretkenliğinizi zirveye taşıyın.';
  
  @override String get helpSlide2Title => 'Hedefini Seç';
  @override String get helpSlide2Desc => 'Büyük başarılar küçük adımlarla başlar. Bugün tamamlaman gereken en önemli görevi seç ve ona odaklanmaya hazırlan.';
  
  @override String get helpSlide3Title => 'Tam Odaklanma';
  @override String get helpSlide3Desc => '25 dakika boyunca dış dünyayı sessize al. Sadece sen ve hedefin varsınız. Derin çalışma moduna geç ve akışı yakala.';
  
  @override String get helpSlide4Title => 'Zihnini Tazele';
  @override String get helpSlide4Desc => 'Mola vermek zaman kaybı değil, stratejik bir yenilenmedir. 5 dakikalık kısa bir mola ile beynini bir sonraki seansa hazırla.';
  
  @override String get helpSlide5Title => 'Zafer Döngüsü';
  @override String get helpSlide5Desc => 'Her tamamlanan döngü, hedefine atılan dev bir adımdır. Başarını kutla, derinlemesine dinlen ve bir sonraki zafere daha güçlü hazırlan.';
  
  @override String get skip => 'Atla';
  @override String get start => 'Başla';
  @override String get next => 'İleri';
}
