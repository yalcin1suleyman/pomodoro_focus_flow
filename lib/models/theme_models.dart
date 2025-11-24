import 'package:flutter/material.dart';

/// Uygulamanın desteklediği tema tipleri
enum FocusThemeType {
  cosmic,
  sakura,
  ocean,
  forest,
}

/// Tek bir temanın renk seti
class FocusTheme {
  final String name;
  final FocusThemeType type;

  final Color bgTop;
  final Color bgBottom;
  final Color card;
  final Color innerCard;
  final Color accent;
  final Color warning;

  const FocusTheme({
    required this.name,
    required this.type,
    required this.bgTop,
    required this.bgBottom,
    required this.card,
    required this.innerCard,
    required this.accent,
    required this.warning,
  });
}

/// React projesindeki THEMES (cosmic / sakura / ocean / forest) karşılığı
class FocusThemes {
  /// 🚀 Cosmic
  static const cosmic = FocusTheme(
    name: "Cosmic",
    type: FocusThemeType.cosmic,
    bgTop: Color(0xFF050816),
    bgBottom: Color(0xFF020617),
    card: Color(0xFF0B1120),
    innerCard: Color(0xFF020617),
    accent: Color(0xFF6366F1), // indigo
    warning: Color(0xFFFBBF24),
  );

  /// 🌸 Sakura
  static const sakura = FocusTheme(
    name: "Sakura",
    type: FocusThemeType.sakura,
    bgTop: Color(0xFF4C0519),      // rose / pink tonları
    bgBottom: Color(0xFF831843),
    card: Color(0xFF3F0D1E),
    innerCard: Color(0xFF4C0519),
    accent: Color(0xFFF472B6),     // pembe
    warning: Color(0xFFF97316),
  );

  /// 🌊 Ocean
  static const ocean = FocusTheme(
    name: "Ocean",
    type: FocusThemeType.ocean,
    bgTop: Color(0xFF022C3A),      // cyan / mavi tonları
    bgBottom: Color(0xFF0F172A),
    card: Color(0xFF020617),
    innerCard: Color(0xFF022C3A),
    accent: Color(0xFF22D3EE),     // cyan
    warning: Color(0xFFFBBF24),
  );

  /// 🌲 Forest
  static const forest = FocusTheme(
    name: "Forest",
    type: FocusThemeType.forest,
    bgTop: Color(0xFF022C22),      // emerald / yeşil tonları
    bgBottom: Color(0xFF012417),
    card: Color(0xFF064E3B),
    innerCard: Color(0xFF022C22),
    accent: Color(0xFF10B981),     // yeşil
    warning: Color(0xFFF59E0B),
  );

  /// Tema listesini tek yerde tutalım
  static List<FocusTheme> all = [
    cosmic,
    sakura,
    ocean,
    forest,
  ];
}
