import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─── Supported Languages ───────────────────────────────────────────────────────
class SupportedLanguage {
  final String code;
  final String name;
  final String nativeName;
  final String flag;
  final bool isRTL;

  const SupportedLanguage({
    required this.code, required this.name,
    required this.nativeName, required this.flag,
    this.isRTL = false,
  });
}

const List<SupportedLanguage> kSupportedLanguages = [
  SupportedLanguage(code: 'en', name: 'English',    nativeName: 'English',    flag: '🇺🇸'),
  SupportedLanguage(code: 'tr', name: 'Turkish',    nativeName: 'Türkçe',     flag: '🇹🇷'),
  SupportedLanguage(code: 'ar', name: 'Arabic',     nativeName: 'العربية',    flag: '🇸🇦', isRTL: true),
  SupportedLanguage(code: 'de', name: 'German',     nativeName: 'Deutsch',    flag: '🇩🇪'),
  SupportedLanguage(code: 'fr', name: 'French',     nativeName: 'Français',   flag: '🇫🇷'),
  SupportedLanguage(code: 'es', name: 'Spanish',    nativeName: 'Español',    flag: '🇪🇸'),
  SupportedLanguage(code: 'it', name: 'Italian',    nativeName: 'Italiano',   flag: '🇮🇹'),
  SupportedLanguage(code: 'ru', name: 'Russian',    nativeName: 'Русский',    flag: '🇷🇺'),
  SupportedLanguage(code: 'zh', name: 'Chinese',    nativeName: '中文',        flag: '🇨🇳'),
  SupportedLanguage(code: 'ja', name: 'Japanese',   nativeName: '日本語',      flag: '🇯🇵'),
  SupportedLanguage(code: 'ko', name: 'Korean',     nativeName: '한국어',      flag: '🇰🇷'),
  SupportedLanguage(code: 'pt', name: 'Portuguese', nativeName: 'Português',  flag: '🇧🇷'),
  SupportedLanguage(code: 'nl', name: 'Dutch',      nativeName: 'Nederlands', flag: '🇳🇱'),
  SupportedLanguage(code: 'pl', name: 'Polish',     nativeName: 'Polski',     flag: '🇵🇱'),
  SupportedLanguage(code: 'sv', name: 'Swedish',    nativeName: 'Svenska',    flag: '🇸🇪'),
  SupportedLanguage(code: 'da', name: 'Danish',     nativeName: 'Dansk',      flag: '🇩🇰'),
  SupportedLanguage(code: 'fi', name: 'Finnish',    nativeName: 'Suomi',      flag: '🇫🇮'),
  SupportedLanguage(code: 'no', name: 'Norwegian',  nativeName: 'Norsk',      flag: '🇳🇴'),
  SupportedLanguage(code: 'he', name: 'Hebrew',     nativeName: 'עברית',      flag: '🇮🇱', isRTL: true),
  SupportedLanguage(code: 'hi', name: 'Hindi',      nativeName: 'हिन्दी',     flag: '🇮🇳'),
];

// ─── Locale Provider ────────────────────────────────────────────────────────────
class LocaleNotifier extends Notifier<Locale> {
  
  @override
  Locale build() => const Locale('en');

  Future<void> setLocale(String code) async {
    state = Locale(code);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', code);
  }

  Future<void> loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('locale') ?? 'en';
    state = Locale(saved);
  }

  SupportedLanguage get currentLanguage =>
    kSupportedLanguages.firstWhere((l) => l.code == state.languageCode,
      orElse: () => kSupportedLanguages.first);

  bool get isRTL => currentLanguage.isRTL;
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);
