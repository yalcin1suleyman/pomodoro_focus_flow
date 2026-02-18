import 'package:flutter/material.dart';

enum AppThemeType { silver, ocean, forest, classic, sakura }

class AppColors {
  // Classic (Harmonious Blue) - Was Default
  static const Color primaryLight = Color(0xFF2196F3); // Material Blue
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color accent = Color(0xFF64B5F6); // Soft Blue Accent 
  
  // Sakura
  static const Color sakuraPrimary = Color(0xFFFFB7B2);
  static const Color sakuraAccent = Color(0xFFFF69B4); 
  static const Color sakuraBg = Color(0xFFFFF0F5); 

  // Ocean
  static const Color oceanPrimary = Color(0xFF48CAE4);
  static const Color oceanAccent = Color(0xFF0077B6);
  static const Color oceanBg = Color(0xFFCAF0F8);

  // Forest
  static const Color forestPrimary = Color(0xFF2D6A4F);
  static const Color forestAccent = Color(0xFF95D5B2);
  static const Color forestBg = Color(0xFFD8F3DC);

  // Silver (Was Luxury)
  static const Color silverPrimary = Color(0xFFE0E0E0); 
  static const Color silverAccent = Color(0xFFBDBDBD); // Darker Silver for visibility
  static const Color silverBg = Color(0xFF121212); 
  static const Color silverSurface = Color(0xFF1E1E1E);

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
    Color onSurface = Colors.black87;
    Color textPrimary = AppColors.textLight;

    // Determine Theme Colors
    switch (type) {
      case AppThemeType.sakura:
        primary = AppColors.sakuraPrimary;
        secondary = AppColors.sakuraAccent;
        background = isDark ? const Color(0xFF2C2C2C) : AppColors.sakuraBg;
        surface = isDark ? const Color(0xFF3E3E3E) : Colors.white;
        brightness = isDark ? Brightness.dark : Brightness.light;
        break;
      case AppThemeType.ocean:
        primary = AppColors.oceanPrimary;
        secondary = AppColors.oceanAccent;
        background = isDark ? const Color(0xFF001219) : AppColors.oceanBg;
        surface = isDark ? const Color(0xFF001F29) : Colors.white;
        brightness = isDark ? Brightness.dark : Brightness.light;
        break;
      case AppThemeType.forest:
        primary = AppColors.forestPrimary;
        secondary = AppColors.forestAccent;
        background = isDark ? const Color(0xFF081C15) : AppColors.forestBg;
        surface = isDark ? const Color(0xFF1B4332) : Colors.white;
        brightness = isDark ? Brightness.dark : Brightness.light;
        break;
      case AppThemeType.silver: // Was Luxury
        primary = AppColors.silverPrimary;
        secondary = AppColors.silverAccent;
        background = AppColors.silverBg;
        surface = AppColors.silverSurface;
        brightness = Brightness.dark;
        break;
      case AppThemeType.classic: // Was Default

        // Classic Harmonious Blue - RESTORED
        primary = isDark ? AppColors.primaryDark : AppColors.primaryLight;
        secondary = AppColors.accent;
        background = isDark ? const Color(0xFF1A1A2E) : const Color(0xFFF0F2F5);
        surface = isDark ? const Color(0xFF16213E) : Colors.white;
        brightness = isDark ? Brightness.dark : Brightness.light;
        break;
    }

    // Ensure text contrast based on brightness
    if (brightness == Brightness.dark) {
      onSurface = Colors.white;
      textPrimary = Colors.white;
    } else {
      onSurface = Colors.black87;
      textPrimary = AppColors.textLight;
    }

    // Construct ColorScheme
    ColorScheme colorScheme;
    if (brightness == Brightness.dark) {
       colorScheme = ColorScheme.dark(
         primary: primary,
         onPrimary: brightness == Brightness.dark ? Colors.black : Colors.white,
         secondary: secondary,
         onSecondary: Colors.black, // Ensure text on secondary (often bright/accent) is black
         surface: surface,
         onSurface: onSurface,
         surfaceContainerHighest: surface.withValues(alpha: 0.5), // For GlassBox contrast
       );
    } else {
       colorScheme = ColorScheme.light(
         primary: primary,
         onPrimary: Colors.white,
         secondary: secondary,
         onSecondary: Colors.white,
         surface: surface,
         onSurface: onSurface,
       );
    }

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      cardColor: surface,
      fontFamily: 'Manrope',
      textTheme: (brightness == Brightness.dark ? ThemeData.dark().textTheme : ThemeData.light().textTheme).apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
        fontFamily: 'Manrope',
      ),
      colorScheme: colorScheme,
      iconTheme: IconThemeData(
        color: onSurface,
      ),
    );
  }
}
