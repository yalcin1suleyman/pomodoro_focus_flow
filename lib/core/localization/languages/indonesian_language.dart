import 'language.dart';

class IndonesianLanguage implements Language {
  @override String get code => 'id';
  @override String get name => 'Bahasa Indonesia';

  @override String get settings => 'Pengaturan';
  @override String get appearance => 'Tampilan';
  @override String get darkMode => 'Mode Gelap';
  @override String get theme => 'Tema';
  @override String get language => 'Bahasa';
  @override String get focusSounds => 'Suara Fokus';
  @override String get tasks => 'Tugas';
  @override String get stats => 'Statistik';
  @override String get focus => 'Fokus';
  @override String get shortBreak => 'Istirahat Pendek';
  @override String get longBreak => 'Istirahat Panjang';
  @override String get version => 'Versi';

  @override String get weeklyActivity => 'Aktivitas Mingguan';
  @override String get focusTime => 'Waktu Fokus';
  @override String get dailyGoal => 'Target Harian';
  @override String get remaining => 'Tersisa';
  @override String get completed => 'Selesai';
  @override String get setGoal => 'Atur Target';
  @override String get hours => 'Jam';
  
  @override String get timerSettings => 'Pengaturan Timer';
  @override String get pomodoroDuration => 'Durasi Pomodoro';
  @override String get shortBreakDuration => 'Durasi Istirahat Pendek';
  @override String get longBreakDuration => 'Durasi Istirahat Panjang';
  @override String get minutes => 'Menit';
  @override String get timeIsUp => 'Waktu habis!';
  @override String get sessionCompleted => 'Sesi Selesai';
  @override String get breakOver => 'Istirahat Selesai';

  @override String get themeClassic => 'Klasik';
  @override String get themeSakura => 'Sakura';
  @override String get themeOcean => 'Laut';
  @override String get themeForest => 'Hutan';
  @override String get themeSilver => 'Perak';

  @override String get cancel => 'Batal';
  @override String get save => 'Simpan';
  @override String get close => 'Tutup';
  @override String get delete => 'Hapus';
  @override String get saveNote => 'Simpan Catatan';
  @override String get editNote => 'Edit Catatan';

  @override String get today => 'Hari Ini';
  @override String get empty => 'Kosong';
  @override String get newTask => 'Tugas Baru';
  @override String get taskHint => 'Apa yang sedang dikerjakan?';
  @override String get estPomodoros => 'Est. Pomodoro:';
  @override String get createTask => 'Buat Tugas';
  @override String get updateTask => 'Perbarui';
  @override String get noTasks => 'Tidak ada tugas. Tambahkan satu!';
  @override String get pomodoroCount => 'pomodoro';
  @override String get inProgress => 'Sedang Berjalan';
  @override String get focusedTime => 'Waktu Fokus';
  @override String get tasksWorkedOn => 'Aktivitas:';
  @override String get completedTasksLabel => 'Tugas Selesai';
  @override String get noTasksRecorded => 'Tidak ada catatan.';
  @override String get dailyNote => 'Catatan Harian:';
  @override String get noteHint => 'Bagaimana fokus hari ini?';
  @override String get generalFocus => 'Fokus Umum';
  @override String get goalMet => 'Target Tercapai';
  @override String get goalMissed => 'Di Bawah Target';
  @override String get tasksHelpTitle => 'Manajemen Tugas';
  @override String get tasksHelpContent => '1. Buat (+)\n2. Perkirakan\n3. Mulai (▶)\n4. Edit (Geser kiri)';

  @override String get navFocus => 'Fokus';
  @override String get navTasks => 'Tugas';
  @override String get navStats => 'Statistik';
  @override String get navSettings => 'Pengaturan';

  @override String get monthJan => 'Januari';
  @override String get monthFeb => 'Februari';
  @override String get monthMar => 'Maret';
  @override String get monthApr => 'April';
  @override String get monthMay => 'Mei';
  @override String get monthJun => 'Juni';
  @override String get monthJul => 'Juli';
  @override String get monthAug => 'Agustus';
  @override String get monthSep => 'September';
  @override String get monthOct => 'Oktober';
  @override String get monthNov => 'November';
  @override String get monthDec => 'Desember';
  
  @override String get share => 'Bagikan';
  @override String get shareStatsTitle => 'Statistik Saya';
  @override String get shareMessage => 'Lihat kemajuan saya!';
  @override String get statsDaily => 'Harian';
  @override String get statsMonthly => 'Bulanan';
  @override String get stats6Months => '6 Bulan';
  @override String get statsYearly => 'Tahunan';
  @override String get average => 'Rata-rata';
  @override String get sessions => 'Sesi';
  @override String get heatmapLegend => 'Kurang • Lebih';

  @override String get soundType => 'Suara';
  @override String get soundTypeBell => 'Lonceng';
  @override String get soundTypeNotification => 'Notifikasi';

  @override String get shareFooterQuote => 'Fokus dengan Pomodoro Master';
  @override String get shareGoalCompleted => 'Target Tercapai';
  @override String get shareTopFocus => 'Fokus Teratas';
  @override String get shareLegendStart => 'Mulai';
  @override String get shareLegendGoal => 'Target';
  @override String get shareWeeklyFocus => 'FOKUS MINGGUAN';
  @override String get shareYearlyJourney => 'PERJALANAN';

  @override String get quoteMotivation1 => "Fokus adalah kunci kesuksesan.";
  @override String get quoteMotivation2 => "Satu pomodoro setiap kalinya.";
  @override String get quoteMotivation3 => "Langkah kecil, hasil besar.";
  @override String get quoteMotivation4 => "Terus melangkah!";
  @override String get quoteMotivation5 => "Masa depanmu dibuat hari ini.";
  @override String get quoteMotivation6 => "Konsistenlah.";
  @override String get quoteMotivation7 => "Kerja mendalam itu penting.";

  @override String get shareRange => 'Rentang';
  @override String get shareRangeDaily => 'Harian';
  @override String get shareRangeWeekly => 'Mingguan';
  @override String get shareRangeMonthly => 'Bulanan';
  @override String get shareRangeYearly => 'Tahunan';
  @override String get shareButton => 'Bagikan';
  @override String get monthlyOverview => 'IKHTISAR BULANAN';

  @override String get languageEnglish => 'Inggris';
  @override String get languageTurkish => 'Turki';

  @override String get focusShort => 'Fokus';
  @override String get shortBreakShort => 'Pendek';
  @override String get longBreakShort => 'Panjang';

  @override String get addNote => 'Tambah catatan';
}
