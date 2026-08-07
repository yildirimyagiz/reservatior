import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();
  
  // Brand Colors (Client Blue - High-Fidelity Sync)
  static const primary         = Color(0xFF2563EB); // Blue 600 (HSL 221, 83%, 53%)
  static const primaryLight    = Color(0xFF60A5FA); // Blue 400
  static const primaryDark     = Color(0xFF1D4ED8); // Blue 700
  
  // Neural Obsidian Palette (Matched to index.css :root)
  static const darkBg          = Color(0xFF0A0B0D); // Deep Obsidian
  static const darkSurface     = Color(0xFF14151A); // Secondary Obsidian
  static const darkCard        = Color(0xFF1E2026); // Card Obsidian
  static const darkBorder      = Color(0xFF262933); // Border Edge
  static const darkMuted       = Color(0xFF334155); // Slate 700-like
  
  // Light Palette (Matched to index.css .light)
  static const lightBg         = Color(0xFFFFFFFF); // --background
  static const lightSurface    = Color(0xFFF8FAFC); // Slightly off-white
  static const lightCard       = Color(0xFFF1F5F9); // --secondary
  static const lightBorder     = Color(0xFFE2E8F0); // --border
  
  // Functional Colors
  static const success         = Color(0xFF10B981); // Emerald 500
  static const error           = Color(0xFFEF4444); // Red 500
  static const warning         = Color(0xFFF59E0B); // Amber 500
  static const info            = Color(0xFF3B82F6); // Blue 500
  
  // Text Colors
  static const textPrimaryDark    = Color(0xFFF8FAFC); // --foreground
  static const textSecondaryDark  = Color(0xFFA1A1AA); // --muted-foreground
  static const textPrimaryLight   = Color(0xFF0F172A); // --foreground (light)
  static const textSecondaryLight = Color(0xFF64748B); // Slate 500

  // Backward Compatibility Aliases
  static const gold      = primary;
  static const goldLight = primaryLight;
  static const goldDark  = primaryDark;
  static const aiAccent  = primary;
  static const cardBg    = darkCard;
  static const border    = darkBorder;
}

class AppRadius {
  AppRadius._();
  static const double xs   = 6;
  static const double sm   = 8;
  static const double md   = 12;
  static const double lg   = 16;
  static const double xl   = 24;
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

  static ThemeData dark() => _createTheme(Brightness.dark);
  static ThemeData light() => _createTheme(Brightness.light);

  static ThemeData _createTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    
    final Color bgColor = isDark ? AppColors.darkBg : AppColors.lightBg;
    final Color surfaceColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final Color cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final Color borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final Color textPrimary = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: bgColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: isDark ? AppColors.primaryLight : AppColors.primaryDark,
        surface: surfaceColor,
        onSurface: textPrimary,
        error: AppColors.error,
        surfaceContainer: cardColor,
      ),
      canvasColor: bgColor,
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: BorderSide(color: borderColor, width: 1),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.5,
        ),
        iconTheme: IconThemeData(color: textPrimary, size: 22),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          textStyle: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          textStyle: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        labelStyle: GoogleFonts.outfit(color: textSecondary, fontSize: 14),
        floatingLabelStyle: GoogleFonts.outfit(color: AppColors.primary, fontWeight: FontWeight.w500),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: bgColor,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      dividerTheme: DividerThemeData(color: borderColor, thickness: 1),
      textTheme: _textTheme(textPrimary, textSecondary),
    );
  }

  static TextTheme _textTheme(Color primary, Color secondary) => TextTheme(
    displayLarge:  GoogleFonts.outfit(fontSize: 42, fontWeight: FontWeight.w700, color: primary, letterSpacing: -1),
    displayMedium: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.w700, color: primary, letterSpacing: -0.5),
    displaySmall:  GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.w600, color: primary),
    headlineLarge:  GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w700, color: primary),
    headlineMedium: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w600, color: primary),
    headlineSmall:  GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600, color: primary),
    titleLarge:  GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600, color: primary),
    titleMedium: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w500, color: primary),
    bodyLarge:  GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: primary, height: 1.5),
    bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: primary, height: 1.5),
    bodySmall:  GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: secondary),
    labelLarge: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: primary),
    labelSmall: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: secondary),
  );
  
  // Getters for backward compatibility
  Color get primaryColor => AppColors.primary;
}

