enum AppLanguage { tr, en }

/// Dil çevirisi yardımcı fonksiyon
String tt(AppLanguage lang, String tr, String en) =>
    lang == AppLanguage.tr ? tr : en;
