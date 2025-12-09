// lib/core/localization/app_language.dart

enum AppLanguage { tr, en }

String tt(AppLanguage lang, String tr, String en) =>
    lang == AppLanguage.tr ? tr : en;
