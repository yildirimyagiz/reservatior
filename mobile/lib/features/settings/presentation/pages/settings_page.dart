import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

// Provide local states for switches
final yieldAlertsProvider = StateProvider<bool>((ref) => true);
final marketSqueezeAlertsProvider = StateProvider<bool>((ref) => false);
final aiPriceRecalibrationProvider = StateProvider<bool>((ref) => true);
final biometricLoginProvider = StateProvider<bool>((ref) => true);
final twoFactorProvider = StateProvider<bool>((ref) => false);
final currencyProvider = StateProvider<String>((ref) => 'TRY');

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;

    final yieldAlerts = ref.watch(yieldAlertsProvider);
    final marketSqueeze = ref.watch(marketSqueezeAlertsProvider);
    final aiRecalibration = ref.watch(aiPriceRecalibrationProvider);
    final biometric = ref.watch(biometricLoginProvider);
    final twoFactor = ref.watch(twoFactorProvider);
    final currency = ref.watch(currencyProvider);

    String currentLanguageText = _getLanguageName(context.locale.languageCode);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colors.textPrimary),
        title: Text(
          'mobile.settings.title'.tr(),
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontStyle: FontStyle.italic,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        children: [
          // ── INTELLIGENT ALERTS ──────────────────────────────
          _buildSectionTitle('mobile.settings.intelligentAlerts'.tr(), colors),
          _buildSettingsGroup(colors, [
            _buildSwitchTile(
              'mobile.settings.yieldAlerts'.tr(),
              yieldAlerts,
              Icons.trending_up,
              Colors.green,
              colors,
              (v) => ref.read(yieldAlertsProvider.notifier).state = v,
            ),
            _buildSwitchTile(
              'mobile.settings.marketSqueezeAlerts'.tr(),
              marketSqueeze,
              Icons.radar,
              Colors.orange,
              colors,
              (v) => ref.read(marketSqueezeAlertsProvider.notifier).state = v,
            ),
            _buildSwitchTile(
              'mobile.settings.aiPriceRecalibration'.tr(),
              aiRecalibration,
              Icons.auto_awesome,
              Colors.purple,
              colors,
              (v) => ref.read(aiPriceRecalibrationProvider.notifier).state = v,
            ),
          ]),

          const SizedBox(height: 32),

          // ── GLOBAL PREFERENCES ──────────────────────────────
          _buildSectionTitle('mobile.settings.globalPreferences'.tr(), colors),
          _buildSettingsGroup(colors, [
            _buildActionTile(
              'mobile.settings.language'.tr(),
              currentLanguageText,
              Icons.language,
              Colors.blue,
              colors,
              () => _showLanguageSelection(context, colors),
            ),
            _buildActionTile(
              'mobile.settings.currency'.tr(),
              currency,
              Icons.payments_outlined,
              Colors.green,
              colors,
              () => _showCurrencySelection(context, ref, colors),
            ),
            _buildSwitchTile(
              'mobile.settings.themeMode'.tr(),
              isDark,
              isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
              isDark ? Colors.indigoAccent : Colors.orangeAccent,
              colors,
              (_) => ref.read(themeModeProvider.notifier).toggleTheme(),
            ),
          ]),

          const SizedBox(height: 32),

          // ── PRIVACY & SECURITY ──────────────────────────────
          _buildSectionTitle('mobile.settings.security'.tr(), colors),
          _buildSettingsGroup(colors, [
            _buildSwitchTile(
              'mobile.settings.biometricLogin'.tr(),
              biometric,
              Icons.face,
              Colors.blue,
              colors,
              (v) => ref.read(biometricLoginProvider.notifier).state = v,
            ),
            _buildSwitchTile(
              'mobile.settings.twoFactorAuth'.tr(),
              twoFactor,
              Icons.security,
              Colors.green,
              colors,
              (v) => _showTwoFactorSetup(context, ref, colors, v),
            ),
            _buildActionTile(
              'mobile.settings.privacyPolicy'.tr(),
              '',
              Icons.policy_outlined,
              colors.textSecondary,
              colors,
              () => context.push('/privacy'),
            ),
          ]),

          const SizedBox(height: 48),

          // ── DELETE ACCOUNT ──────────────────────────────────
          _buildSettingsGroup(colors, [
            ListTile(
              title: Text(
                'mobile.settings.deleteProfile'.tr(),
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                'mobile.settings.deleteDesc'.tr(),
                style: TextStyle(color: colors.textSecondary.withValues(alpha: 0.5), fontSize: 11),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.redAccent,
                size: 20,
              ),
              onTap: () {},
            ),
          ]),
        ],
      ),
    );
  }

  String _getLanguageName(String code) {
    const Map<String, String> names = {
      'ar': 'العربية (Arabic)',
      'da': 'Dansk (Danish)',
      'de': 'Deutsch (German)',
      'en': 'English',
      'es': 'Español (Spanish)',
      'fi': 'Suomi (Finnish)',
      'fr': 'Français (French)',
      'gr': 'Ελληνικά (Greek)',
      'hi': 'हिन्दी (Hindi)',
      'it': 'Italiano (Italian)',
      'ja': '日本語 (Japanese)',
      'ko': '한국어 (Korean)',
      'nl': 'Nederlands (Dutch)',
      'no': 'Norsk (Norwegian)',
      'pl': 'Polski (Polish)',
      'pt': 'Português (Portuguese)',
      'ru': 'Русский (Russian)',
      'se': 'Svenska (Swedish)',
      'tr': 'Türkçe (Turkish)',
      'zh': '中文 (Chinese)',
    };
    return names[code] ?? code;
  }

  void _showLanguageSelection(BuildContext context, ThemeAwareColors colors) {
    final currentCode = context.locale.languageCode;
    final locales = [
      'ar', 'da', 'de', 'en', 'es', 'fi', 'fr', 'gr', 'hi', 'it', 
      'ja', 'ko', 'nl', 'no', 'pl', 'pt', 'ru', 'se', 'tr', 'zh'
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (_, scrollController) => SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Text(
                      'mobile.settings.language'.tr(),
                      style: GoogleFonts.outfit(
                        color: colors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.close, color: colors.textSecondary),
                      onPressed: () => Navigator.pop(ctx),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: locales.length,
                  separatorBuilder: (_, __) => Divider(color: colors.border, height: 1),
                  itemBuilder: (ctx, i) {
                    final code = locales[i];
                    return ListTile(
                      title: Text(
                        _getLanguageName(code),
                        style: TextStyle(
                          color: colors.textPrimary, 
                          fontWeight: currentCode == code ? FontWeight.bold : FontWeight.normal
                        ),
                      ),
                      trailing: currentCode == code ? const Icon(Icons.check, color: AppColors.primary) : null,
                      onTap: () {
                        context.setLocale(Locale(code));
                        Navigator.pop(ctx);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCurrencySelection(BuildContext context, WidgetRef ref, ThemeAwareColors colors) {
    final currencies = ['TRY', 'USD', 'EUR', 'GBP', 'AED', 'SAR', 'QAR', 'JPY', 'CAD', 'AUD', 'CHF', 'CNY', 'INR', 'SGD', 'NZD'];
    final currentCurrency = ref.read(currencyProvider);

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'mobile.settings.currency'.tr(),
                style: GoogleFonts.outfit(
                  color: colors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...currencies.map((currency) => Column(
                children: [
                  ListTile(
                    title: Text(currency, style: TextStyle(
                      color: colors.textPrimary, 
                      fontWeight: currentCurrency == currency ? FontWeight.bold : FontWeight.normal
                    )),
                    trailing: currentCurrency == currency ? const Icon(Icons.check, color: AppColors.primary) : null,
                    onTap: () {
                      ref.read(currencyProvider.notifier).state = currency;
                      Navigator.pop(ctx);
                    },
                  ),
                  Divider(color: colors.border, height: 1),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _showTwoFactorSetup(BuildContext context, WidgetRef ref, ThemeAwareColors colors, bool newValue) {
    if (newValue == false) {
      ref.read(twoFactorProvider.notifier).state = false;
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'mobile.settings.twoFactorAuth'.tr(),
          style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold),
        ),
        content: Text(
          "We will send a 6-digit code to your registered device. Do you want to enable 2FA?",
          style: TextStyle(color: colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: TextStyle(color: colors.textSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              ref.read(twoFactorProvider.notifier).state = true;
              Navigator.pop(ctx);
            },
            child: const Text("Enable", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeAwareColors colors) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.outfit(
          color: colors.textSecondary.withValues(alpha: 0.5),
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(ThemeAwareColors colors, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile(
    String title,
    bool value,
    IconData icon,
    Color color,
    ThemeAwareColors colors,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: colors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: color,
        activeTrackColor: color.withValues(alpha: 0.2),
        inactiveThumbColor: colors.textSecondary.withValues(alpha: 0.3),
        inactiveTrackColor: colors.textSecondary.withValues(alpha: 0.05),
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String value,
    IconData icon,
    Color color,
    ThemeAwareColors colors,
    VoidCallback onTap,
  ) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: colors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value.isNotEmpty)
            Text(
              value,
              style: TextStyle(color: colors.textSecondary.withValues(alpha: 0.6), fontSize: 12),
            ),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, color: colors.textSecondary.withValues(alpha: 0.3), size: 16),
        ],
      ),
    );
  }
}
