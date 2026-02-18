import 'dart:io';

void main() async {
  const dir = 'lib/core/localization/languages';

  final Map<String, Map<String, String>> translations = {
    'spanish_language.dart': {
      'timerRunningWarning': 'Por favor, detén el temporizador antes de cambiar de modo.',
      'helpUnknown': 'Desconocido',
      'helpSlide1Title': 'Domina Tu Tiempo',
      'helpSlide1Desc': 'Gestionar el tiempo es un arte. Mantén tu enfoque con precisión láser, previene el agotamiento y maximiza tu productividad con la técnica Pomodoro.',
      'helpSlide2Title': 'Elige Tu Meta',
      'helpSlide2Desc': 'Los grandes logros comienzan con pequeños pasos. Elige la tarea más importante del día y prepárate para enfocarte en ella.',
      'helpSlide3Title': 'Enfoque Total',
      'helpSlide3Desc': 'Silencia el mundo exterior durante 25 minutos. Solo tú y tu objetivo. Entra en modo de trabajo profundo y alcanza el flujo.',
      'helpSlide4Title': 'Renueva Tu Mente',
      'helpSlide4Desc': 'Tomar un descanso no es perder el tiempo; es una renovación estratégica. Prepara tu cerebro para la siguiente sesión con un breve descanso de 5 minutos.',
      'helpSlide5Title': 'Ciclo de Victoria',
      'helpSlide5Desc': 'Cada ciclo completado es un paso gigante hacia tu meta. Celebra tu éxito, descansa profundamente y prepárate más fuerte para la próxima victoria.',
      'skip': 'Omitir',
      'start': 'Comenzar',
      'next': 'Siguiente',
    },
    'portuguese_language.dart': {
      'timerRunningWarning': 'Por favor, pare o temporizador antes de mudar de modo.',
      'helpUnknown': 'Desconhecido',
      'helpSlide1Title': 'Domine Seu Tempo',
      'helpSlide1Desc': 'Gerenciar o tempo é uma arte. Mantenha seu foco com precisão de laser, previna o esgotamento e maximize sua produtividade com a técnica Pomodoro.',
      'helpSlide2Title': 'Escolha Sua Meta',
      'helpSlide2Desc': 'Grandes conquistas começam com pequenos passos. Escolha a tarefa mais importante do dia e prepare-se para se concentrar nela.',
      'helpSlide3Title': 'Foco Total',
      'helpSlide3Desc': 'Silencie o mundo exterior por 25 minutos. Só você e seu objetivo. Entre no modo de trabalho profundo e alcance o fluxo.',
      'helpSlide4Title': 'Renove Sua Mente',
      'helpSlide4Desc': 'Fazer uma pausa não é perda de tempo; é renovação estratégica. Prepare seu cérebro para a próxima sessão com uma breve pausa de 5 minutos.',
      'helpSlide5Title': 'Ciclo de Vitória',
      'helpSlide5Desc': 'Cada ciclo completado é um passo gigante em direção à sua meta. Celebre seu sucesso, descanse profundamente e prepare-se mais forte para a próxima vitória.',
      'skip': 'Pular',
      'start': 'Começar',
      'next': 'Próximo',
    },
    'german_language.dart': {
      'timerRunningWarning': 'Bitte stoppe den Timer, bevor du den Modus wechselst.',
      'helpUnknown': 'Unbekannt',
      'helpSlide1Title': 'Meistere Deine Zeit',
      'helpSlide1Desc': 'Zeitmanagement ist eine Kunst. Halte deinen Fokus messerscharf, verhindere Burnout und maximiere deine Produktivität mit der Pomodoro-Technik.',
      'helpSlide2Title': 'Wähle Dein Ziel',
      'helpSlide2Desc': 'Große Erfolge beginnen mit kleinen Schritten. Wähle die wichtigste Aufgabe des Tages und bereite dich darauf vor, dich darauf zu konzentrieren.',
      'helpSlide3Title': 'Volle Konzentration',
      'helpSlide3Desc': 'Schalte die Außenwelt für 25 Minuten stumm. Nur du und dein Ziel. Tritt in den Deep-Work-Modus ein und erlebe den Flow.',
      'helpSlide4Title': 'Erneuere Deinen Geist',
      'helpSlide4Desc': 'Eine Pause zu machen ist keine Zeitverschwendung; es ist strategische Erneuerung. Bereite dein Gehirn mit einer kurzen 5-Minuten-Pause auf die nächste Sitzung vor.',
      'helpSlide5Title': 'Siegeszyklus',
      'helpSlide5Desc': 'Jeder abgeschlossene Zyklus ist ein riesiger Schritt in Richtung deines Ziels. Feiere deinen Erfolg, ruh dich tief aus und bereite dich stärker auf den nächsten Sieg vor.',
      'skip': 'Überspringen',
      'start': 'Starten',
      'next': 'Weiter',
    },
    'french_language.dart': {
      'timerRunningWarning': 'Veuillez arrêter le minuteur avant de changer de mode.',
      'helpUnknown': 'Inconnu',
      'helpSlide1Title': 'Maîtrisez Votre Temps',
      'helpSlide1Desc': "Gestionar el tiempo es un arte. Mantén tu enfoque con precisión láser, previene el agotamiento y maximiza tu productividad con la técnica Pomodoro.",
      'helpSlide2Title': 'Choisissez Votre Objectif',
      'helpSlide2Desc': "Les grandes réalisations commencent par de petits pas. Choisissez la tâche la plus importante de la journée et préparez-vous à vous y concentrer.",
      'helpSlide3Title': 'Concentration Totale',
      'helpSlide3Desc': "Réduisez le monde extérieur au silence pendant 25 minutes. Juste vous et votre objectif. Entrez en mode travail profond et atteignez le flux.",
      'helpSlide4Title': 'Renouvelez Votre Esprit',
      'helpSlide4Desc': "Faire une pause n'est pas une perte de temps ; c'est un renouveau stratégique. Préparez votre cerveau pour la prochaine session avec une courte pause de 5 minutes.",
      'helpSlide5Title': 'Cycle de Victoire',
      'helpSlide5Desc': "Chaque cycle complété est un pas de géant vers votre objectif. Célébrez votre succès, reposez-vous profondément et préparez-vous plus fort pour la prochaine victoire.",
      'skip': 'Passer',
      'start': 'Commencer',
      'next': 'Suivant',
    },
    'italian_language.dart': {
      'timerRunningWarning': 'Per favore, ferma il timer prima di cambiare modalità.',
      'helpUnknown': 'Sconosciuto',
      'helpSlide1Title': 'Padroneggia il Tuo Tempo',
      'helpSlide1Desc': "Gestire il tempo è un'arte. Mantieni la tua concentrazione affilata come un laser, previeni il burnout e massimizza la produttività con la tecnica Pomodoro.",
      'helpSlide2Title': 'Scegli il Tuo Obiettivo',
      'helpSlide2Desc': 'I grandi successi iniziano con piccoli passi. Scegli il compito più importante della giornata e preparati a concentrarti su di esso.',
      'helpSlide3Title': 'Concentrazione Totale',
      'helpSlide3Desc': 'Silenzia il mondo esterno per 25 minuti. Solo tu e il tuo obiettivo. Entra in modalità lavoro profondo e raggiungi il flusso.',
      'helpSlide4Title': 'Rinnova la Tua Mente',
      'helpSlide4Desc': 'Fare una pausa non è perdere tempo; è un rinnovamento strategico. Prepara il tuo cervello per la prossima sessione con una breve pausa di 5 minuti.',
      'helpSlide5Title': 'Ciclo di Vittoria',
      'helpSlide5Desc': 'Ogni ciclo completato è un passo da gigante verso il tuo obiettivo. Celebra il tuo successo, riposati profondamente e preparati più forte per la prossima vittoria.',
      'skip': 'Salta',
      'start': 'Inizia',
      'next': 'Avanti',
    },
    'russian_language.dart': {
      'timerRunningWarning': 'Пожалуйста, остановите таймер перед сменой режима.',
      'helpUnknown': 'Неизвестно',
      'helpSlide1Title': 'Управляй Своим Временем',
      'helpSlide1Desc': 'Управление временем — это искусство. Держи фокус острым как лазер, предотвращай выгорание и максимизируй продуктивность с техникой Помодоро.',
      'helpSlide2Title': 'Выбери Свою Цель',
      'helpSlide2Desc': 'Великие достижения начинаются с маленьких шагов. Выбери самую важную задачу на сегодня и подготовься сосредоточиться на ней.',
      'helpSlide3Title': 'Полная Концентрация',
      'helpSlide3Desc': 'Заглуши внешний мир на 25 минут. Только ты и твоя цель. Войди в режим глубокой работы и поймай поток.',
      'helpSlide4Title': 'Обнови Разум',
      'helpSlide4Desc': 'Перерыв — это не потеря времени; это стратегическое обновление. Подготовь мозг к следующей сессии коротким 5-минутным перерывом.',
      'helpSlide5Title': 'Цикл Победы',
      'helpSlide5Desc': 'Каждый завершённый цикл — это гигантский шаг к твоей цели. Отпразднуй успех, хорошо отдохни и подготовься ещё сильнее к следующей победе.',
      'skip': 'Пропустить',
      'start': 'Начать',
      'next': 'Далее',
    },
    'japanese_language.dart': {
      'timerRunningWarning': 'モードを切り替える前にタイマーを停止してください。',
      'helpUnknown': '不明',
      'helpSlide1Title': '時間をマスターする',
      'helpSlide1Desc': '時間管理は芸術です。ポモドーロテクニックで集中力をレーザーのように鋭く保ち、燃え尽きを防ぎ、生産性を最大化しましょう。',
      'helpSlide2Title': '目標を選ぶ',
      'helpSlide2Desc': '偉大な成果は小さな一歩から始まります。今日最も重要なタスクを選び、それに集中する準備をしましょう。',
      'helpSlide3Title': '完全集中',
      'helpSlide3Desc': '25分間、外の世界を遮断しましょう。あなたと目標だけです。ディープワークモードに入り、フローを掴みましょう。',
      'helpSlide4Title': '心をリフレッシュ',
      'helpSlide4Desc': '休憩は時間の無駄ではなく、戦略的な刷新です。5分間の短い休憩で次のセッションに向けて脳を準備しましょう。',
      'helpSlide5Title': '勝利のサイクル',
      'helpSlide5Desc': '完了したサイクルは目標への大きな一歩です。成功を祝い、深く休んで、次の勝利に向けてより強く準備しましょう。',
      'skip': 'スキップ',
      'start': '開始',
      'next': '次へ',
    },
    'korean_language.dart': {
      'timerRunningWarning': '모드를 전환하기 전에 타이머를 중지하세요.',
      'helpUnknown': '알 수 없음',
      'helpSlide1Title': '시간을 지배하라',
      'helpSlide1Desc': '시간 관리는 예술입니다. 포모도로 기법으로 레이저처럼 날카로운 집중력을 유지하고, 번아웃을 예방하며, 생산성을 극대화하세요.',
      'helpSlide2Title': '목표를 선택하라',
      'helpSlide2Desc': '위대한 성취는 작은 발걸음에서 시작됩니다. 오늘 가장 중요한 작업을 선택하고 집중할 준비를 하세요.',
      'helpSlide3Title': '완전한 집중',
      'helpSlide3Desc': '25분 동안 외부 세계를 차단하세요. 오직 당신과 목표만 있습니다. 딥 워크 모드에 진입하고 플로우를 잡으세요.',
      'helpSlide4Title': '마음을 새롭게',
      'helpSlide4Desc': '휴식은 시간 낭비가 아닙니다; 전략적 재충전입니다. 5분의 짧은 휴식으로 다음 세션을 위해 뇌를 준비하세요.',
      'helpSlide5Title': '승리의 사이클',
      'helpSlide5Desc': '완료된 모든 사이클은 목표를 향한 거대한 발걸음입니다. 성공을 축하하고, 깊이 쉬고, 다음 승리를 위해 더 강하게 준비하세요.',
      'skip': '건너뛰기',
      'start': '시작',
      'next': '다음',
    },
    'chinese_language.dart': {
      'timerRunningWarning': '请在切换模式前停止计时器。',
      'helpUnknown': '未知',
      'helpSlide1Title': '掌控你的时间',
      'helpSlide1Desc': '时间管理是一门艺术。用番茄工作法保持激光般的专注，预防倦怠，最大化你的生产力。',
      'helpSlide2Title': '选择你的目标',
      'helpSlide2Desc': '伟大的成就从小步骤开始。选择今天最重要的任务，准备好专注于它。',
      'helpSlide3Title': '全神贯注',
      'helpSlide3Desc': '让外部世界沉默25分钟。只有你和你的目标。进入深度工作模式，抓住心流。',
      'helpSlide4Title': '焕新思维',
      'helpSlide4Desc': '休息不是浪费时间，而是战略性的更新。用5分钟的短暂休息为下一个工作阶段准备好你的大脑。',
      'helpSlide5Title': '胜利循环',
      'helpSlide5Desc': '每一个完成的循环都是向目标迈出的巨大一步。庆祝你的成功，深度休息，为下一次胜利做好更强的准备。',
      'skip': '跳过',
      'start': '开始',
      'next': '下一步',
    },
    'hindi_language.dart': {
      'timerRunningWarning': 'कृपया मोड बदलने से पहले टाइमर रोकें।',
      'helpUnknown': 'अज्ञात',
      'helpSlide1Title': 'अपने समय पर नियंत्रण पाएं',
      'helpSlide1Desc': 'समय प्रबंधन एक कला है। पोमोडोरो तकनीक से अपना ध्यान लेज़र की तरह तेज़ रखें, बर्नआउट से बचें और उत्पादकता को अधिकतम करें।',
      'helpSlide2Title': 'अपना लक्ष्य चुनें',
      'helpSlide2Desc': 'महान उपलब्धियां छोटे कदमों से शुरू होती हैं। आज का सबसे महत्वपूर्ण काम चुनें और उस पर ध्यान केंद्रित करने के लिए तैयार हों।',
      'helpSlide3Title': 'पूर्ण एकाग्रता',
      'helpSlide3Desc': '25 मिनट के लिए बाहरी दुनिया को शांत करें। सिर्फ आप और आपका लक्ष्य। गहरे काम के मोड में प्रवेश करें और प्रवाह को पकड़ें।',
      'helpSlide4Title': 'मन को तरोताज़ा करें',
      'helpSlide4Desc': 'ब्रेक लेना समय की बर्बादी नहीं है; यह रणनीतिक नवीनीकरण है। 5 मिनट के छोटे ब्रेक से अगले सत्र के लिए अपने दिमाग को तैयार करें।',
      'helpSlide5Title': 'जीत का चक्र',
      'helpSlide5Desc': 'हर पूरा किया गया चक्र आपके लक्ष्य की ओर एक विशाल कदम है। अपनी सफलता का जश्न मनाएं, गहरा आराम करें और अगली जीत के लिए और मजबूत तैयारी करें।',
      'skip': 'छोड़ें',
      'start': 'शुरू करें',
      'next': 'अगला',
    },
    'arabic_language.dart': {
      'timerRunningWarning': 'يرجى إيقاف المؤقت قبل تغيير الوضع.',
      'helpUnknown': 'غير معروف',
      'helpSlide1Title': 'أتقن وقتك',
      'helpSlide1Desc': 'إدارة الوقت فن. حافظ على تركيزك حاداً كالليزر، وامنع الإرهاق، وعظّم إنتاجيتك مع تقنية بومودورو.',
      'helpSlide2Title': 'اختر هدفك',
      'helpSlide2Desc': 'تبدأ الإنجازات العظيمة بخطوات صغيرة. اختر أهم مهمة اليوم وكن مستعداً للتركيز عليها.',
      'helpSlide3Title': 'تركيز كامل',
      'helpSlide3Desc': 'أسكت العالم الخارجي لمدة 25 دقيقة. أنت وهدفك فقط. ادخل وضع العمل العميق والتقط التدفق.',
      'helpSlide4Title': 'جدد عقلك',
      'helpSlide4Desc': 'أخذ استراحة ليس إضاعة للوقت؛ إنه تجديد استراتيجي. أعد تهيئة دماغك للجلسة التالية باستراحة قصيرة مدتها 5 دقائق.',
      'helpSlide5Title': 'دورة النصر',
      'helpSlide5Desc': 'كل دورة مكتملة هي خطوة عملاقة نحو هدفك. احتفل بنجاحك، واسترح بعمق، واستعد بقوة أكبر للنصر القادم.',
      'skip': 'تخطي',
      'start': 'ابدأ',
      'next': 'التالي',
    },
    'indonesian_language.dart': {
      'timerRunningWarning': 'Harap hentikan timer sebelum beralih mode.',
      'helpUnknown': 'Tidak Diketahui',
      'helpSlide1Title': 'Kuasai Waktumu',
      'helpSlide1Desc': 'Manajemen waktu adalah seni. Jaga fokusmu setajam laser, cegah kelelahan, dan maksimalkan produktivitasmu dengan teknik Pomodoro.',
      'helpSlide2Title': 'Pilih Tujuanmu',
      'helpSlide2Desc': 'Pencapaian besar dimulai dari langkah kecil. Pilih tugas terpenting hari ini dan bersiaplah untuk fokus padanya.',
      'helpSlide3Title': 'Fokus Total',
      'helpSlide3Desc': 'Diamkan dunia luar selama 25 menit. Hanya kamu dan tujuanmu. Masuki mode kerja mendalam dan raih aliran.',
      'helpSlide4Title': 'Segarkan Pikiranmu',
      'helpSlide4Desc': 'Beristirahat bukan pemborosan waktu; itu pembaruan strategis. Siapkan otakmu untuk sesi berikutnya dengan istirahat singkat 5 menit.',
      'helpSlide5Title': 'Siklus Kemenangan',
      'helpSlide5Desc': 'Setiap siklus yang diselesaikan adalah langkah raksasa menuju tujuanmu. Rayakan kesuksesanmu, istirahat dengan nyenyak, dan bersiaplah lebih kuat untuk kemenangan berikutnya.',
      'skip': 'Lewati',
      'start': 'Mulai',
      'next': 'Berikutnya',
    },
    'vietnamese_language.dart': {
      'timerRunningWarning': 'Vui lòng dừng bộ đếm thời gian trước khi chuyển chế độ.',
      'helpUnknown': 'Không rõ',
      'helpSlide1Title': 'Làm Chủ Thời Gian',
      'helpSlide1Desc': 'Quản lý thời gian là một nghệ thuật. Giữ sự tập trung sắc bén như laser, ngăn ngừa kiệt sức và tối đa hóa năng suất với kỹ thuật Pomodoro.',
      'helpSlide2Title': 'Chọn Mục Tiêu',
      'helpSlide2Desc': 'Những thành tựu vĩ đại bắt đầu từ những bước nhỏ. Chọn nhiệm vụ quan trọng nhất hôm nay và chuẩn bị tập trung vào nó.',
      'helpSlide3Title': 'Tập Trung Hoàn Toàn',
      'helpSlide3Desc': 'Tắt tiếng thế giới bên ngoài trong 25 phút. Chỉ có bạn và mục tiêu. Bước vào chế độ làm việc sâu và nắm bắt dòng chảy.',
      'helpSlide4Title': 'Làm Mới Tâm Trí',
      'helpSlide4Desc': 'Nghỉ ngơi không phải lãng phí thời gian; đó là sự đổi mới chiến lược. Chuẩn bị não bộ cho phiên tiếp theo với khoảng nghỉ ngắn 5 phút.',
      'helpSlide5Title': 'Vòng Chiến Thắng',
      'helpSlide5Desc': 'Mỗi chu kỳ hoàn thành là một bước khổng lồ hướng tới mục tiêu. Hãy ăn mừng thành công, nghỉ ngơi sâu và chuẩn bị mạnh mẽ hơn cho chiến thắng tiếp theo.',
      'skip': 'Bỏ qua',
      'start': 'Bắt đầu',
      'next': 'Tiếp theo',
    },
    'bengali_language.dart': {
      'timerRunningWarning': 'মোড পরিবর্তন করার আগে টাইমার বন্ধ করুন।',
      'helpUnknown': 'অজানা',
      'helpSlide1Title': 'আপনার সময়ের নিয়ন্ত্রণ নিন',
      'helpSlide1Desc': 'সময় ব্যবস্থাপনা একটি শিল্প। পোমোডোরো কৌশলে আপনার মনোযোগ লেজারের মতো তীক্ষ্ণ রাখুন, বার্নআউট প্রতিরোধ করুন এবং উৎপাদনশীলতা সর্বাধিক করুন।',
      'helpSlide2Title': 'আপনার লক্ষ্য বেছে নিন',
      'helpSlide2Desc': 'মহান অর্জন ছোট পদক্ষেপ থেকে শুরু হয়। আজকের সবচেয়ে গুরুত্বপূর্ণ কাজটি বেছে নিন এবং সেটিতে মনোযোগ দিতে প্রস্তুত হন।',
      'helpSlide3Title': 'সম্পূর্ণ মনোযোগ',
      'helpSlide3Desc': '25 মিনিটের জন্য বাইরের জগতকে নীরব করুন। শুধু আপনি এবং আপনার লক্ষ্য। গভীর কাজের মোডে প্রবেশ করুন এবং প্রবাহ ধরুন।',
      'helpSlide4Title': 'মন সতেজ করুন',
      'helpSlide4Desc': 'বিরতি নেওয়া সময়ের অপচয় নয়; এটি কৌশলগত পুনর্নবীকরণ। 5 মিনিটের ছোট বিরতিতে পরবর্তী সেশনের জন্য আপনার মস্তিষ্ককে প্রস্তুত করুন।',
      'helpSlide5Title': 'বিজয়ের চক্র',
      'helpSlide5Desc': 'প্রতিটি সম্পন্ন চক্র আপনার লক্ষ্যের দিকে একটি বিশাল পদক্ষেপ। আপনার সাফল্য উদযাপন করুন, গভীরভাবে বিশ্রাম নিন এবং পরবর্তী বিজয়ের জন্য আরও শক্তিশালী হয়ে প্রস্তুত হন।',
      'skip': 'এড়িয়ে যান',
      'start': 'শুরু করুন',
      'next': 'পরবর্তী',
    },
    'urdu_language.dart': {
      'timerRunningWarning': 'براہ کرم موڈ تبدیل کرنے سے پہلے ٹائمر روکیں۔',
      'helpUnknown': 'نامعلوم',
      'helpSlide1Title': 'اپنے وقت پر قابو پائیں',
      'helpSlide1Desc': 'وقت کا انتظام ایک فن ہے۔ پوموڈورو تکنیک سے اپنی توجہ لیزر کی طرح تیز رکھیں، جلن سے بچیں اور پیداواریت کو زیادہ سے زیادہ کریں۔',
      'helpSlide2Title': 'اپنا ہدف منتخب کریں',
      'helpSlide2Desc': 'عظیم کامیابیاں چھوٹے قدموں سے شروع ہوتی ہیں۔ آج کا سب سے اہم کام منتخب کریں اور اس پر توجہ دینے کے لیے تیار ہوں۔',
      'helpSlide3Title': 'مکمل توجہ',
      'helpSlide3Desc': '25 منٹ کے لیے بیرونی دنیا کو خاموش کریں۔ صرف آپ اور آپ کا ہدف۔ گہرے کام کے موڈ میں داخل ہوں اور بہاؤ کو پکڑیں۔',
      'helpSlide4Title': 'ذہن کو تازہ کریں',
      'helpSlide4Desc': 'وقفہ لینا وقت کا ضیاع نہیں؛ یہ حکمت عملی کی تجدید ہے۔ 5 منٹ کے مختصر وقفے سے اگلے سیشن کے لیے اپنے دماغ کو تیار کریں۔',
      'helpSlide5Title': 'فتح کا چکر',
      'helpSlide5Desc': 'ہر مکمل چکر آپ کے ہدف کی طرف ایک بڑا قدم ہے۔ اپنی کامیابی کا جشن منائیں، گہرا آرام کریں اور اگلی فتح کے لیے اور مضبوط تیاری کریں۔',
      'skip': 'چھوڑیں',
      'start': 'شروع کریں',
      'next': 'اگلا',
    },
    'polish_language.dart': {
      'timerRunningWarning': 'Proszę zatrzymać timer przed zmianą trybu.',
      'helpUnknown': 'Nieznany',
      'helpSlide1Title': 'Opanuj Swój Czas',
      'helpSlide1Desc': 'Zarządzanie czasem to sztuka. Utrzymuj skupienie ostre jak laser, zapobiegaj wypaleniu i maksymalizuj produktywność dzięki technice Pomodoro.',
      'helpSlide2Title': 'Wybierz Swój Cel',
      'helpSlide2Desc': 'Wielkie osiągnięcia zaczynają się od małych kroków. Wybierz najważniejsze zadanie na dziś i przygotuj się na skupienie się na nim.',
      'helpSlide3Title': 'Pełna Koncentracja',
      'helpSlide3Desc': 'Wycisz zewnętrzny świat na 25 minut. Tylko ty i twój cel. Wejdź w tryb głębokiej pracy i złap przepływ.',
      'helpSlide4Title': 'Odśwież Umysł',
      'helpSlide4Desc': 'Przerwa to nie strata czasu; to strategiczne odnowienie. Przygotuj mózg do następnej sesji krótką 5-minutową przerwą.',
      'helpSlide5Title': 'Cykl Zwycięstwa',
      'helpSlide5Desc': 'Każdy ukończony cykl to gigantyczny krok w kierunku twojego celu. Świętuj sukces, głęboko odpoczywaj i przygotuj się silniej na kolejne zwycięstwo.',
      'skip': 'Pomiń',
      'start': 'Zacznij',
      'next': 'Dalej',
    },
    'thai_language.dart': {
      'timerRunningWarning': 'กรุณาหยุดตัวจับเวลาก่อนเปลี่ยนโหมด',
      'helpUnknown': 'ไม่ทราบ',
      'helpSlide1Title': 'เป็นนายเวลาของคุณ',
      'helpSlide1Desc': 'การบริหารเวลาคือศิลปะ รักษาสมาธิของคุณให้คมดั่งเลเซอร์ ป้องกันความเหนื่อยล้า และเพิ่มประสิทธิภาพสูงสุดด้วยเทคนิคโปโมโดโร',
      'helpSlide2Title': 'เลือกเป้าหมายของคุณ',
      'helpSlide2Desc': 'ความสำเร็จยิ่งใหญ่เริ่มต้นจากก้าวเล็กๆ เลือกงานที่สำคัญที่สุดของวันนี้และเตรียมพร้อมที่จะมุ่งเน้นไปที่มัน',
      'helpSlide3Title': 'สมาธิเต็มที่',
      'helpSlide3Desc': 'ปิดเสียงโลกภายนอกเป็นเวลา 25 นาที มีแค่คุณและเป้าหมายของคุณ เข้าสู่โหมดทำงานเชิงลึกและจับกระแสให้ได้',
      'helpSlide4Title': 'ฟื้นฟูจิตใจ',
      'helpSlide4Desc': 'การพักผ่อนไม่ใช่การเสียเวลา แต่เป็นการฟื้นฟูเชิงกลยุทธ์ เตรียมสมองสำหรับเซสชั่นถัดไปด้วยการพักสั้นๆ 5 นาที',
      'helpSlide5Title': 'วงจรแห่งชัยชนะ',
      'helpSlide5Desc': 'ทุกรอบที่เสร็จสมบูรณ์คือก้าวยักษ์สู่เป้าหมายของคุณ ฉลองความสำเร็จ พักผ่อนอย่างเต็มที่ และเตรียมพร้อมให้แข็งแกร่งขึ้นสำหรับชัยชนะครั้งต่อไป',
      'skip': 'ข้าม',
      'start': 'เริ่ม',
      'next': 'ถัดไป',
    },
    'dutch_language.dart': {
      'timerRunningWarning': 'Stop de timer voordat je van modus wisselt.',
      'helpUnknown': 'Onbekend',
      'helpSlide1Title': 'Beheers Je Tijd',
      'helpSlide1Desc': 'Tijdmanagement is een kunst. Houd je focus scherp als een laser, voorkom burn-out en maximaliseer je productiviteit met de Pomodoro-techniek.',
      'helpSlide2Title': 'Kies Je Doel',
      'helpSlide2Desc': 'Grote prestaties beginnen met kleine stappen. Kies de belangrijkste taak van vandaag en bereid je voor om je daarop te concentreren.',
      'helpSlide3Title': 'Volledige Focus',
      'helpSlide3Desc': 'Zet de buitenwereld 25 minuten op stil. Alleen jij en je doel. Ga in de diepe werkmodus en vang de flow.',
      'helpSlide4Title': 'Vernieuw Je Geest',
      'helpSlide4Desc': 'Een pauze nemen is geen tijdverspilling; het is strategische vernieuwing. Bereid je hersenen voor op de volgende sessie met een korte pauze van 5 minuten.',
      'helpSlide5Title': 'Cyclus van Overwinning',
      'helpSlide5Desc': 'Elke voltooide cyclus is een reuzensprong richting je doel. Vier je succes, rust diep uit en bereid je sterker voor op de volgende overwinning.',
      'skip': 'Overslaan',
      'start': 'Starten',
      'next': 'Volgende',
    },
    'ukrainian_language.dart': {
      'timerRunningWarning': 'Будь ласка, зупиніть таймер перед зміною режиму.',
      'helpUnknown': 'Невідомо',
      'helpSlide1Title': 'Керуй Своїм Часом',
      'helpSlide1Desc': 'Управління часом — це мистецтво. Тримай фокус гострим як лазер, запобігай вигоранню та максимізуй продуктивність за допомогою техніки Помодоро.',
      'helpSlide2Title': 'Обери Свою Мету',
      'helpSlide2Desc': 'Великі досягнення починаються з маленьких кроків. Обери найважливіше завдання на сьогодні та підготуйся зосередитися на ньому.',
      'helpSlide3Title': 'Повна Концентрація',
      'helpSlide3Desc': 'Заглуши зовнішній світ на 25 хвилин. Тільки ти і твоя мета. Увійди в режим глибокої роботи та впіймай потік.',
      'helpSlide4Title': 'Онови Розум',
      'helpSlide4Desc': 'Перерва — це не втрата часу; це стратегічне оновлення. Підготуй мозок до наступної сесії коротким 5-хвилинним відпочинком.',
      'helpSlide5Title': 'Цикл Перемоги',
      'helpSlide5Desc': 'Кожен завершений цикл — це гігантський крок до твоєї мети. Відсвяткуй успіх, добре відпочинь і підготуйся ще сильнішим до наступної перемоги.',
      'skip': 'Пропустити',
      'start': 'Почати',
      'next': 'Далі',
    },
    'greek_language.dart': {
      'timerRunningWarning': 'Παρακαλώ σταματήστε το χρονόμετρο πριν αλλάξετε λειτουργία.',
      'helpUnknown': 'Άγνωστο',
      'helpSlide1Title': 'Κατακτήστε τον Χρόνο σας',
      'helpSlide1Desc': 'Η διαχείριση χρόνου είναι τέχνη. Διατηρήστε την εστίασή σας οξεία σαν λέιζερ, αποτρέψτε την εξουθένωση και μεγιστοποιήστε την παραγωγικότητά σας με την τεχνική Pomodoro.',
      'helpSlide2Title': 'Επιλέξτε τον Στόχο σας',
      'helpSlide2Desc': 'Τα μεγάλα επιτεύγματα ξεκινούν με μικρά βήματα. Επιλέξτε την πιο σημαντική εργασία της ημέρας και ετοιμαστείτε να εστιάσετε σε αυτήν.',
      'helpSlide3Title': 'Πλήρης Συγκέντρωση',
      'helpSlide3Desc': 'Σιγάστε τον εξωτερικό κόσμο για 25 λεπτά. Μόνο εσείς και ο στόχος σας. Μπείτε σε λειτουργία βαθιάς εργασίας και πιάστε τη ροή.',
      'helpSlide4Title': 'Ανανεώστε το Μυαλό σας',
      'helpSlide4Desc': 'Το διάλειμμα δεν είναι χάσιμο χρόνου· είναι στρατηγική ανανέωση. Προετοιμάστε τον εγκέφαλό σας για την επόμενη συνεδρία με ένα σύντομο διάλειμμα 5 λεπτών.',
      'helpSlide5Title': 'Κύκλος Νίκης',
      'helpSlide5Desc': 'Κάθε ολοκληρωμένος κύκλος είναι ένα γιγαντιαίο βήμα προς τον στόχο σας. Γιορτάστε την επιτυχία σας, ξεκουραστείτε βαθιά και ετοιμαστείτε πιο δυνατοί για την επόμενη νίκη.',
      'skip': 'Παράλειψη',
      'start': 'Έναρξη',
      'next': 'Επόμενο',
    },
    'swedish_language.dart': {
      'timerRunningWarning': 'Stoppa timern innan du byter läge.',
      'helpUnknown': 'Okänd',
      'helpSlide1Title': 'Bemästra Din Tid',
      'helpSlide1Desc': 'Tidshantering är en konst. Håll ditt fokus vasst som en laser, förhindra utbrändhet och maximera din produktivitet med Pomodoro-tekniken.',
      'helpSlide2Title': 'Välj Ditt Mål',
      'helpSlide2Desc': 'Stora prestationer börjar med små steg. Välj dagens viktigaste uppgift och förbered dig på att fokusera på den.',
      'helpSlide3Title': 'Totalt Fokus',
      'helpSlide3Desc': 'Tysta omvärlden i 25 minuter. Bara du och ditt mål. Gå in i djupt arbetsläge och fånga flödet.',
      'helpSlide4Title': 'Förnya Ditt Sinne',
      'helpSlide4Desc': 'Att ta en paus är inte slöseri med tid; det är strategisk förnyelse. Förbered din hjärna för nästa session med en kort 5-minuters paus.',
      'helpSlide5Title': 'Segerscykel',
      'helpSlide5Desc': 'Varje avslutad cykel är ett jättesteg mot ditt mål. Fira din framgång, vila djupt och förbered dig starkare för nästa seger.',
      'skip': 'Hoppa över',
      'start': 'Starta',
      'next': 'Nästa',
    },
  };

  for (final entry in translations.entries) {
    final filename = entry.key;
    final t = entry.value;
    final filepath = '$dir/$filename';
    final file = File(filepath);

    if (!await file.exists()) {
      print('File not found: $filepath');
      continue;
    }

    var content = await file.readAsString();

    // Replace timerRunningWarning
    final oldWarning = "  @override String get timerRunningWarning => 'Please stop the timer before switching modes.';";
    final newWarning = "  @override String get timerRunningWarning => '${t['timerRunningWarning']!.replaceAll("'", "\\'")}';";
    content = content.replaceAll(oldWarning, newWarning);

    // Replace the entire help slideshow block
    // Find the start of the help slideshow section
    final startMarker = '  // Help Slideshow';
    final endMarker = "  @override String get next => 'Next';";
    
    final startIdx = content.indexOf(startMarker);
    final endIdx = content.indexOf(endMarker);
    
    if (startIdx != -1 && endIdx != -1) {
      final newBlock = """  // Help Slideshow
  @override String get helpUnknown => '${t['helpUnknown']}';
  @override String get helpSlide1Title => '${t['helpSlide1Title']!.replaceAll("'", "\\'")}';
  @override String get helpSlide1Desc => '${t['helpSlide1Desc']!.replaceAll("'", "\\'")}';
  
  @override String get helpSlide2Title => '${t['helpSlide2Title']!.replaceAll("'", "\\'")}';
  @override String get helpSlide2Desc => '${t['helpSlide2Desc']!.replaceAll("'", "\\'")}';
  
  @override String get helpSlide3Title => '${t['helpSlide3Title']!.replaceAll("'", "\\'")}';
  @override String get helpSlide3Desc => '${t['helpSlide3Desc']!.replaceAll("'", "\\'")}';
  
  @override String get helpSlide4Title => '${t['helpSlide4Title']!.replaceAll("'", "\\'")}';
  @override String get helpSlide4Desc => '${t['helpSlide4Desc']!.replaceAll("'", "\\'")}';
  
  @override String get helpSlide5Title => '${t['helpSlide5Title']!.replaceAll("'", "\\'")}';
  @override String get helpSlide5Desc => '${t['helpSlide5Desc']!.replaceAll("'", "\\'")}';
  
  @override String get skip => '${t['skip']}';
  @override String get start => '${t['start']}';
  @override String get next => '${t['next']}';""";
      
      content = content.substring(0, startIdx) + newBlock + content.substring(endIdx + endMarker.length);
    } else {
      print('Could not find help slideshow block in $filename (startIdx=$startIdx, endIdx=$endIdx)');
    }

    await file.writeAsString(content);
    print('Updated $filename');
  }
  print('Done!');
}
