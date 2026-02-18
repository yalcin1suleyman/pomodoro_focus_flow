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
  @override String get tasksHelpContent => 'Kelola tugas secara efektif untuk meningkatkan produktivitas:\n\n1. Buat Tugas\nKetuk tombol (+) untuk menambahkan tugas baru.\n\n2. Estimasi\nPerkirakan berapa banyak Pomodoro yang Anda butuhkan. (Durasi dapat disesuaikan di Pengaturan).\n\n3. Mulai Fokus\nKetuk tombol Putar (▶) pada tugas untuk memulai pengatur waktu.\n\n4. Edit & Hapus\nGeser kartu tugas ke KIRI untuk melihat opsi edit dan hapus.\n\n5. Lacak Kemajuan\nKemajuan dicatat dalam Statistik saat pengatur waktu selesai. Sesi tanpa tugas dicatat sebagai "Fokus Umum".';

  @override String get tasksHelpStep1Title => 'Buat Tugas';
  @override String get tasksHelpStep1Content => 'Ketuk tombol (+) untuk menambahkan tugas baru.';
  
  @override String get tasksHelpStep2Title => 'Estimasi';
  @override String get tasksHelpStep2Content => 'Perkirakan berapa banyak Pomodoro yang Anda butuhkan untuk tugas tersebut. (Durasi dapat disesuaikan di Pengaturan).';
  
  @override String get tasksHelpStep3Title => 'Mulai Fokus';
  @override String get tasksHelpStep3Content => 'Ketuk tombol Putar (▶) pada tugas untuk memulai pengatur waktu fokus.';
  
  @override String get tasksHelpStep4Title => 'Edit & Hapus';
  @override String get tasksHelpStep4Content => 'Geser kartu tugas ke KIRI untuk menampilkan opsi edit dan hapus.';
  
  @override String get tasksHelpStep5Title => 'Lacak Kemajuan';
  @override String get tasksHelpStep5Content => 'Kemajuan dicatat dalam Statistik saat pengatur waktu selesai. Sesi tanpa tugas dicatat sebagai "Fokus Umum".';

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

  @override String get shareAdUnlockContent => 'Anda harus menonton iklan singkat untuk membuka fitur ini.';
  @override String get shareAdUnlockButton => 'Tonton Iklan';
  
  @override String get shareSummary => 'Ringkasan';
  @override String get shareFocused => 'fokus';
  @override String get shareSessions => 'sesi';
  @override String get shareStreak => 'Bagikan rekor Anda dan tetap bertanggung jawab 🚀';

  @override String get languageEnglish => 'Inggris';
  @override String get languageTurkish => 'Turki';

  @override String get focusShort => 'Fokus';
  @override String get shortBreakShort => 'Pendek';
  @override String get longBreakShort => 'Panjang';

  @override String get addNote => 'Tambah catatan';
  // Help & Warnings
  @override String get helpTitle => 'App Guide';
  @override String get helpContent => 
    "**How does the app work?**\n\n"
    "**Pomodoro**: Focus for 25 minutes, then take a short break. After 4 sessions, take a long break.\n\n"
    "**Timer**: Tap start to focus. Pause if needed.\n\n"
    "**Settings**: Customize your focus durations and sounds.\n\n"
    "**Tasks**: Track your work by adding tasks.\n\n"
    "**Stats**: View your progress over time.";
  @override String get timerRunningWarning => 'Harap hentikan timer sebelum beralih mode.';
  // Help Slideshow
  @override String get helpUnknown => 'Tidak Diketahui';
  @override String get helpSlide1Title => 'Kuasai Waktumu';
  @override String get helpSlide1Desc => 'Manajemen waktu adalah seni. Jaga fokusmu setajam laser, cegah kelelahan, dan maksimalkan produktivitasmu dengan teknik Pomodoro.';
  
  @override String get helpSlide2Title => 'Pilih Tujuanmu';
  @override String get helpSlide2Desc => 'Pencapaian besar dimulai dari langkah kecil. Pilih tugas terpenting hari ini dan bersiaplah untuk fokus padanya.';
  
  @override String get helpSlide3Title => 'Fokus Total';
  @override String get helpSlide3Desc => 'Diamkan dunia luar selama 25 menit. Hanya kamu dan tujuanmu. Masuki mode kerja mendalam dan raih aliran.';
  
  @override String get helpSlide4Title => 'Segarkan Pikiranmu';
  @override String get helpSlide4Desc => 'Beristirahat bukan pemborosan waktu; itu pembaruan strategis. Siapkan otakmu untuk sesi berikutnya dengan istirahat singkat 5 menit.';
  
  @override String get helpSlide5Title => 'Siklus Kemenangan';
  @override String get helpSlide5Desc => 'Setiap siklus yang diselesaikan adalah langkah raksasa menuju tujuanmu. Rayakan kesuksesanmu, istirahat dengan nyenyak, dan bersiaplah lebih kuat untuk kemenangan berikutnya.';
  
  @override String get skip => 'Lewati';
  @override String get start => 'Mulai';
  @override String get next => 'Berikutnya';
}
