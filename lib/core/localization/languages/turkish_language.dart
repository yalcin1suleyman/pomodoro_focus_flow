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

  @override String get themeDefault => 'Varsayılan';
  @override String get themeSakura => 'Sakura';
  @override String get themeOcean => 'Okyanus';
  @override String get themeForest => 'Orman';
  @override String get themeLuxury => 'Gümüş Lüks';

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
  @override String get tasksHelpTitle => 'Görevler Nasıl Kullanılır?';
  @override String get tasksHelpContent => '1. Yeni bir görev eklemek için + butonuna tıkla.\n2. Kaç Pomodoro süreceğini tahmin et.\n3. Göreve odaklanmak için üzerindeki Oynat (Play) butonuna bas.\n4. Düzenleme ve Silme seçeneklerini görmek için görevi SOLA kaydır.\n5. Süre bittiğinde ilerlemen kaydedilir!';

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

  // Language Names
  @override String get languageEnglish => 'English';
  @override String get languageTurkish => 'Türkçe';

  // Timer Mode Labels (shortened)
  @override String get focusShort => 'Odak';
  @override String get shortBreakShort => 'Kısa';
  @override String get longBreakShort => 'Uzun';

  // Misc
  @override String get addNote => 'Bir not ekle';
}
