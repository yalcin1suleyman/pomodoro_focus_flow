// lib/core/content/quotes.dart
import '../localization/app_language.dart';

class FocusQuote {
  final String id;
  final String tr; // Türkçe metin (yazarla birlikte)
  final String en; // İngilizce metin (yazarla birlikte)

  const FocusQuote({
    required this.id,
    required this.tr,
    required this.en,
  });

  String text(AppLanguage lang) => lang == AppLanguage.tr ? tr : en;
}

// İstediğin kadar ekleyip çoğaltabilirsin:
const List<FocusQuote> focusQuotes = [
  FocusQuote(
    id: 'cal_newport_focus',
    tr: '"Odak, ustalığın kapısıdır." — Cal Newport',
    en: '"Focus is the gateway to mastery." — Cal Newport',
  ),
  FocusQuote(
    id: 'james_clear_habits',
    tr: '"Küçük alışkanlıklar, büyük sonuçlar doğurur." — James Clear',
    en: '"Tiny habits create remarkable results." — James Clear',
  ),
  FocusQuote(
    id: 'seneca_time',
    tr: '"Zaman, harcadığımız en değerli sermayedir." — Seneca',
    en: '"Time is the most valuable thing we spend." — Seneca',
  ),

  // 🇹🇷 Türk isimler:

  FocusQuote(
    id: 'ataturk_study',
    tr: '"Hayatta en hakiki mürşit ilimdir." — Mustafa Kemal Atatürk',
    en: '"In life, the truest guide is science." — Mustafa Kemal Atatürk',
  ),
  FocusQuote(
    id: 'aziz_sancar',
    tr: '"Başarı, disiplinli çalışmanın yan ürünüdür." — Aziz Sancar',
    en: '"Success is a by-product of disciplined work." — Aziz Sancar',
  ),
  FocusQuote(
    id: 'sabahattin_ali',
    tr: '"Yola çıkmadan varılmaz." — Sabahattin Ali',
    en: '"You cannot arrive without setting out." — Sabahattin Ali',
  ),
  FocusQuote(
    id: 'mevlana_step',
    tr: '"Damlaya damlaya göl olur." — Mevlânâ',
    en: '"Drop by drop, a lake is formed." — Rumi',
  ),
  FocusQuote(
    id: 'cahit_zarifoglu',
    tr: '"İş, vaktinden çoktur; ama insan azdır." — Cahit Zarifoğlu',
    en: '"Work is more than time; but people are few." — Cahit Zarifoğlu',
  ),
];
