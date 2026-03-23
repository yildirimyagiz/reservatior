import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();
  static const gold        = Color(0xFFC9A84C);
  static const goldLight   = Color(0xFFE8C97A);
  static const goldDark    = Color(0xFF9A7A2E);
  static const darkBg      = Color(0xFF0C0D10);
  static const darkSurface = Color(0xFF14161B);
  static const cardDark    = Color(0xFF1C1F27);
  static const darkCard    = Color(0xFF1C1F27);
  static const darkBorder  = Color(0xFF2A2D38);
  static const darkMuted   = Color(0xFF3A3D4A);
  static const lightBg      = Color(0xFFF8F7F4);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard    = Color(0xFFF2F0EB);
  static const lightBorder  = Color(0xFFE4E0D8);
  static const success = Color(0xFF3ECF8E);
  static const error   = Color(0xFFFF4757);
  static const warning = Color(0xFFFFA502);
  static const info    = Color(0xFF1E90FF);
  static const primary = Color(0xFF3B82F6);
  static const secondary = Color(0xFF10B981);
  static const textPrimaryLight   = Color(0xFF1A1A2E);
  static const textSecondaryLight = Color(0xFF6B6B7A);
  static const textPrimaryDark    = Color(0xFFF0EDE8);
  static const textSecondaryDark  = Color(0xFF8A8D99);
  static const textPrimary = Color(0xFF1A1A2E);
  static const errorRed           = Color(0xFFDC2626);
  static const surfaceDark       = Color(0xFF1E1E1E);
  static const borderDark        = Color(0xFF424242);
}

class AppRadius {
  AppRadius._();
  static const double xs   = 6;
  static const double sm   = 10;
  static const double md   = 16;
  static const double lg   = 24;
  static const double xl   = 32;
  static const double full = 100;
}

class AppSpacing {
  AppSpacing._();
  static const double xs  = 4;
  static const double sm  = 8;
  static const double md  = 16;
  static const double lg  = 24;
  static const double xl  = 32;
  static const double xxl = 48;
}

class AppTheme {
  AppTheme._();

  // Color shortcuts for easy access
  static const background = AppColors.darkBg;
  static const glassSurface = AppColors.darkSurface;
  static const glassBorder = AppColors.darkBorder;
  static const primary = AppColors.gold;
  static const aiAccent = AppColors.info;
  static const error = AppColors.error;
  static const errorMuted = AppColors.darkMuted;
  static const warning = AppColors.warning;
  static const success = AppColors.success;
  static const successMuted = AppColors.darkMuted;
  static const surfaceVariant = AppColors.darkCard;
  static const textPrimary = AppColors.textPrimaryDark;
  static const textSecondary = AppColors.textSecondaryDark;
  static const textMuted = AppColors.darkMuted;

  static ThemeData dark() => ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColors.darkBg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.gold,
      secondary: AppColors.goldLight,
      surface: AppColors.darkSurface,
      error: AppColors.error,
      onPrimary: AppColors.darkBg,
      onSurface: AppColors.textPrimaryDark,
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkCard, elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: const BorderSide(color: AppColors.darkBorder),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBg,
      surfaceTintColor: Colors.transparent, elevation: 0,
      titleTextStyle: GoogleFonts.cormorantGaramond(
        fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimaryDark,
      ),
      iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gold, foregroundColor: AppColors.darkBg, elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
        textStyle: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.8),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.gold, elevation: 0,
        side: const BorderSide(color: AppColors.gold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
        textStyle: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.8),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: AppColors.darkCard,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      labelStyle: GoogleFonts.dmSans(color: AppColors.textSecondaryDark, fontSize: 14),
      hintStyle: GoogleFonts.dmSans(color: AppColors.darkMuted, fontSize: 14),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: AppColors.gold,
      unselectedItemColor: AppColors.darkMuted,
      type: BottomNavigationBarType.fixed, elevation: 0,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.darkCard,
      selectedColor: Color(0x33C9A84C),
      side: const BorderSide(color: AppColors.darkBorder),
      labelStyle: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textPrimaryDark),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.full)),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.darkBorder, thickness: 1),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkCard,
      contentTextStyle: GoogleFonts.dmSans(color: AppColors.textPrimaryDark),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        side: const BorderSide(color: AppColors.darkBorder),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    textTheme: _textTheme(AppColors.textPrimaryDark),
  );

  static ThemeData light() => ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColors.lightBg,
    colorScheme: const ColorScheme.light(
      primary: AppColors.goldDark, secondary: AppColors.gold,
      surface: AppColors.lightSurface, error: AppColors.error,
      onPrimary: Colors.white, onSurface: AppColors.textPrimaryLight,
    ),
    textTheme: _textTheme(AppColors.textPrimaryLight),
  );

  static TextTheme _textTheme(Color c) => TextTheme(
    displayLarge:  GoogleFonts.cormorantGaramond(fontSize: 48, fontWeight: FontWeight.w700, color: c),
    displayMedium: GoogleFonts.cormorantGaramond(fontSize: 36, fontWeight: FontWeight.w700, color: c),
    displaySmall:  GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w600, color: c),
    headlineLarge:  GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w700, color: c),
    headlineMedium: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w600, color: c),
    headlineSmall:  GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w600, color: c),
    titleLarge:  GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600, color: c),
    titleMedium: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w500, color: c),
    bodyLarge:  GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w400, color: c),
    bodyMedium: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w400, color: c),
    bodySmall:  GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w400, color: c),
    labelLarge: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.5, color: c),
    labelSmall: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.0, color: c),
  );
}

// Theme Mode Provider
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.dark) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('theme_mode') ?? 'dark';
    state = savedTheme == 'light' ? ThemeMode.light : ThemeMode.dark;
  }

  Future<void> toggleTheme() async {
    final newTheme = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    state = newTheme;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', newTheme == ThemeMode.light ? 'light' : 'dark');
  }
}
