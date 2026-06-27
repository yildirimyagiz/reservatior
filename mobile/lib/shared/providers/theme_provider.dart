import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reservatior/core/theme/app_theme.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.dark) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTheme = prefs.getString('theme_mode') ?? 'dark';
      state = savedTheme == 'light' ? ThemeMode.light : ThemeMode.dark;
    } catch (e) {
      // Fallback to dark mode if there's an error
      state = ThemeMode.dark;
    }
  }

  Future<void> toggleTheme() async {
    final newTheme = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    state = newTheme;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('theme_mode', newTheme == ThemeMode.light ? 'light' : 'dark');
    } catch (e) {
      // Continue even if saving fails
      debugPrint('Failed to save theme preference: $e');
    }
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    state = themeMode;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('theme_mode', themeMode == ThemeMode.light ? 'light' : 'dark');
    } catch (e) {
      debugPrint('Failed to save theme preference: $e');
    }
  }

  bool get isDarkMode => state == ThemeMode.dark;
  bool get isLightMode => state == ThemeMode.light;
}

// Helper provider for theme-aware colors
final themeAwareColorsProvider = Provider<ThemeAwareColors>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  return ThemeAwareColors(themeMode);
});

class ThemeAwareColors {
  final ThemeMode _themeMode;
  
  ThemeAwareColors(this._themeMode);

  bool get isDark => _themeMode == ThemeMode.dark;
  bool get isLight => _themeMode == ThemeMode.light;

  // Background colors
  Color get background => isDark ? AppColors.darkBg : AppColors.lightBg;
  Color get surface => isDark ? AppColors.darkSurface : AppColors.lightSurface;
  Color get card => isDark ? AppColors.darkCard : AppColors.lightCard;
  Color get border => isDark ? AppColors.darkBorder : AppColors.lightBorder;

  // Text colors
  Color get textPrimary => isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
  Color get textSecondary => isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
  Color get textMuted => isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

  // Primary colors
  Color get primary => AppColors.primary;
  Color get primaryLight => AppColors.primaryLight;
  Color get primaryDark => AppColors.primaryDark;

  // Aliases for compatibility
  Color get gold => primary;
  Color get goldLight => primaryLight;
  Color get goldDark => primaryDark;

  // Status colors
  Color get success => AppColors.success;
  Color get error => AppColors.error;
  Color get warning => AppColors.warning;
  Color get info => AppColors.info;
}
