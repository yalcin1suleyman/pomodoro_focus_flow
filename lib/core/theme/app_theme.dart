import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppThemeType { defaultTheme, sakura, ocean, forest, space }

class AppColors {
  // Default (Premium Purple)
  static const Color primaryLight = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF5f59f7);
  static const Color accent = Color(0xFF00D2D3); 
  static const Color accentPink = Color(0xFFFF6B6B); // Pomodoro Red/Pink 
  
  // Sakura
  static const Color sakuraPrimary = Color(0xFFFFB7B2);
  static const Color sakuraAccent = Color(0xFFFF69B4); // Hot Pink
  static const Color sakuraBg = Color(0xFFFFF0F5); // Lavender Blush

  // Ocean
  static const Color oceanPrimary = Color(0xFF48CAE4);
  static const Color oceanAccent = Color(0xFF0077B6);
  static const Color oceanBg = Color(0xFFCAF0F8);

  // Forest
  static const Color forestPrimary = Color(0xFF2D6A4F);
  static const Color forestAccent = Color(0xFF95D5B2);
  static const Color forestBg = Color(0xFFD8F3DC);

  // Space
  static const Color spacePrimary = Color(0xFF7209B7);
  static const Color spaceAccent = Color(0xFF4CC9F0);
  static const Color spaceBg = Color(0xFF10002B);

  // Text
  static const Color textLight = Color(0xFF2D3436);
  static const Color textDark = Color(0xFFDFE6E9);
}

class AppTheme {
  static ThemeData getTheme(AppThemeType type, bool isDark) {
    Color primary;
    Color secondary;
    Color background;
    Color surface;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    if (type == AppThemeType.space) { 
      // Space is always darkish
      brightness = Brightness.dark;
    }

    switch (type) {
      case AppThemeType.sakura:
        primary = AppColors.sakuraPrimary;
        secondary = AppColors.sakuraAccent;
        background = isDark ? const Color(0xFF2C2C2C) : AppColors.sakuraBg;
        surface = isDark ? Colors.black45 : Colors.white;
        break;
      case AppThemeType.ocean:
        primary = AppColors.oceanPrimary;
        secondary = AppColors.oceanAccent;
        background = isDark ? const Color(0xFF001219) : AppColors.oceanBg;
        surface = isDark ? Colors.black45 : Colors.white;
        break;
      case AppThemeType.forest:
        primary = AppColors.forestPrimary;
        secondary = AppColors.forestAccent;
        background = isDark ? const Color(0xFF081C15) : AppColors.forestBg;
        surface = isDark ? Colors.black45 : Colors.white;
        break;
      case AppThemeType.space:
        primary = AppColors.spacePrimary;
        secondary = AppColors.spaceAccent;
        background = AppColors.spaceBg;
        surface = const Color(0xFF240046);
        break;
      case AppThemeType.defaultTheme:
      default:
        primary = isDark ? AppColors.primaryDark : AppColors.primaryLight;
        secondary = AppColors.accent;
        background = isDark ? const Color(0xFF1A1A2E) : const Color(0xFFF0F2F5);
        surface = isDark ? const Color(0xFF16213E) : Colors.white;
        break;
    }

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      cardColor: surface,
      textTheme: GoogleFonts.outfitTextTheme(
        brightness == Brightness.dark ? ThemeData.dark().textTheme : ThemeData.light().textTheme
      ).apply(
        bodyColor: brightness == Brightness.dark ? AppColors.textDark : AppColors.textLight,
        displayColor: brightness == Brightness.dark ? AppColors.textDark : AppColors.textLight,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: brightness,
        secondary: secondary,
        background: background,
        surface: surface,
      ),
      iconTheme: IconThemeData(
        color: brightness == Brightness.dark ? Colors.white : Colors.black87,
      ),
    );
  }
}
