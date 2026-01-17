import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppThemeType { defaultTheme, sakura, ocean, forest, space, superBlack, cleanWhite, luxury, sunset, nightLight }

class AppColors {
  // Default (Classic Harmonious Blue)
  static const Color primaryLight = Color(0xFF2196F3); // Material Blue
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color accent = Color(0xFF64B5F6); // Soft Blue Accent (Harmonious) 
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

  // Luxury (Silver)
  static const Color luxuryPrimary = Color(0xFFE0E0E0); // Silver / Platinum
  static const Color luxuryAccent = Color(0xFFFFFFFF); // White Accent
  static const Color luxuryBg = Color(0xFF000000);

  // Super Black (High Contrast)
  static const Color blackPrimary = Color(0xFFFFFFFF); // White for high contrast on black
  static const Color blackAccent = Color(0xFFE0E0E0);  
  static const Color blackBg = Color(0xFF000000); // Pure Black

  // Clean White (High Contrast - White Buttons)
  static const Color whitePrimary = Color(0xFFFFFFFF); // White for buttons
  static const Color whiteAccent = Color(0xFF000000); // Black accent
  static const Color whiteBg = Color(0xFFFFFFFF); // Pure White 

  // Sunset (Refined - Relaxing)
  static const Color sunsetPrimary = Color(0xFFFF7043); // Sunkissed Coral (Softer than Deep Orange)
  static const Color sunsetAccent = Color(0xFFFFCA28); // Soft Amber
  static const Color sunsetBg = Color(0xFFFFF8E1); // Very Light Cream

  // Night Light (Refined - Deep Night)
  static const Color nightPrimary = Color(0xFFFFF176); // Moonlight Yellow
  static const Color nightAccent = Color(0xFF536DFE); // Indigo Accent
  static const Color nightBg = Color(0xFF02020A); // Pitch Dark Night 

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

    if (type == AppThemeType.space || type == AppThemeType.superBlack || type == AppThemeType.luxury || type == AppThemeType.nightLight) { 
      // Space, Super Black, Luxury, NightLight are dark
      brightness = Brightness.dark;
    } else if (type == AppThemeType.cleanWhite) {
      // Clean White is always light
      brightness = Brightness.light;
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
      case AppThemeType.superBlack:
        primary = AppColors.blackPrimary;
        secondary = AppColors.blackAccent;
        background = AppColors.blackBg;
        surface = const Color(0xFF080808); // Almost pure black surface
        break;
      case AppThemeType.cleanWhite:
        primary = AppColors.whitePrimary;
        secondary = AppColors.whiteAccent;
        background = AppColors.whiteBg;
        surface = const Color(0xFFF7F9FA); // Very subtle cool grey for depth
        break;
      case AppThemeType.luxury:
        primary = AppColors.luxuryPrimary;
        secondary = AppColors.luxuryAccent;
        background = AppColors.luxuryBg;
        surface = const Color(0xFF1A1A1A); // Luxury dark surface
        break;
      case AppThemeType.sunset:
        primary = AppColors.sunsetPrimary;
        secondary = AppColors.sunsetAccent;
        background = isDark ? const Color(0xFF3E2723) : AppColors.sunsetBg; // Dark brown if dark mode
        surface = isDark ? Colors.black45 : Colors.white;
        break;
      case AppThemeType.nightLight:
        primary = AppColors.nightPrimary;
        secondary = AppColors.nightAccent;
        background = AppColors.nightBg;
        surface = const Color(0xFF151525); // Dark Surface
        break;
      case AppThemeType.defaultTheme:
      default:
        primary = isDark ? AppColors.primaryDark : AppColors.primaryLight;
        secondary = AppColors.accent;
        background = isDark ? const Color(0xFF1A1A2E) : const Color(0xFFF0F2F5);
        surface = isDark ? const Color(0xFF16213E) : Colors.white;
        break;
    }

    // Construct ColorScheme manually for strict themes
    ColorScheme colorScheme;
    if (type == AppThemeType.superBlack) {
      colorScheme = const ColorScheme.dark(
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.white,
        onSecondary: Colors.black,
        surface: Color(0xFF121212), // Or Colors.black if strictly flat
        onSurface: Colors.white,
      );
    } else if (type == AppThemeType.cleanWhite) {
      // Manual White Scheme: Buttons are White, Text Black
      colorScheme = const ColorScheme.light(
        primary: Colors.white, 
        onPrimary: Colors.black, // Black text on White button
        secondary: Colors.black,
        onSecondary: Colors.white,
        surface: Color(0xFFF5F5F5),
        onSurface: Colors.black,
      );
    } else if (type == AppThemeType.luxury) {
       // Manual Silver Scheme to avoid blue tints from seeds
       colorScheme = const ColorScheme.dark(
        primary: Color(0xFFE0E0E0), // Silver Buttons
        onPrimary: Colors.black, // Black Text on Silver
        secondary: Color(0xFFFFFFFF), // White Accents
        onSecondary: Colors.black,
        surface: Color(0xFF1E1E1E), // Dark Steel Surface
        onSurface: Color(0xFFE0E0E0), // Silver Text
      );
    } else if (type == AppThemeType.nightLight) {
       // Manual Night Light Scheme - Harmonious
       colorScheme = const ColorScheme.dark(
        primary: Color(0xFFFFE082), // Warm Amber (Softer)
        onPrimary: Colors.black,
        secondary: Color(0xFF3F51B5), // Indigo
        onSecondary: Colors.white, // Deep Midnight
        surface: Color(0xFF14142B), // Harmonious Dark Blue Surface
        onSurface: Color(0xFFE0E0E0), 
      );
    } else {
      colorScheme = ColorScheme.fromSeed(
        seedColor: primary,
        brightness: brightness,
        secondary: secondary,
        background: background,
        surface: surface,
      );
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
      colorScheme: colorScheme,
      iconTheme: IconThemeData(
        color: brightness == Brightness.dark ? Colors.white : Colors.black87,
      ),
    );
  }
}
