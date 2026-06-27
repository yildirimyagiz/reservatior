import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/core/localization/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Language {
  final String code;
  final String name;
  final String flag;
  final String currency;
  final String currencySymbol;

  Language({
    required this.code,
    required this.name,
    required this.flag,
    required this.currency,
    required this.currencySymbol,
  });
}

class LanguageCurrencyDropdownWidget extends ConsumerStatefulWidget {
  const LanguageCurrencyDropdownWidget({super.key});

  @override
  ConsumerState<LanguageCurrencyDropdownWidget> createState() => _LanguageCurrencyDropdownWidgetState();
}

class _LanguageCurrencyDropdownWidgetState extends ConsumerState<LanguageCurrencyDropdownWidget>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isOpen = false;
  
  final List<Language> _languages = [
    Language(
      code: 'en',
      name: 'English',
      flag: '🇺🇸',
      currency: 'USD',
      currencySymbol: '\$',
    ),
    Language(
      code: 'tr',
      name: 'mobile.leftovers.t_rk_e'.tr(),
      flag: '🇹🇷',
      currency: 'TRY',
      currencySymbol: '₺',
    ),
    Language(
      code: 'de',
      name: 'Deutsch',
      flag: '🇩🇪',
      currency: 'EUR',
      currencySymbol: '€',
    ),
    Language(
      code: 'fr',
      name: 'mobile.leftovers.fran_ais'.tr(),
      flag: '🇫🇷',
      currency: 'EUR',
      currencySymbol: '€',
    ),
    Language(
      code: 'es',
      name: 'mobile.leftovers.espa_ol'.tr(),
      flag: '🇪🇸',
      currency: 'EUR',
      currencySymbol: '€',
    ),
    Language(
      code: 'it',
      name: 'Italiano',
      flag: '🇮🇹',
      currency: 'EUR',
      currencySymbol: '€',
    ),
    Language(
      code: 'ar',
      name: 'العربية',
      flag: '🇸🇦',
      currency: 'SAR',
      currencySymbol: '﷼',
    ),
    Language(
      code: 'zh',
      name: '中文',
      flag: '🇨🇳',
      currency: 'CNY',
      currencySymbol: '¥',
    ),
    Language(
      code: 'ja',
      name: '日本語',
      flag: '🇯🇵',
      currency: 'JPY',
      currencySymbol: '¥',
    ),
    Language(
      code: 'ru',
      name: 'Русский',
      flag: '🇷🇺',
      currency: 'RUB',
      currencySymbol: '₽',
    ),
    Language(
      code: 'pt',
      name: 'mobile.leftovers.portugu_s'.tr(),
      flag: '🇧🇷',
      currency: 'BRL',
      currencySymbol: 'R\$',
    ),
    Language(
      code: 'nl',
      name: 'Nederlands',
      flag: '🇳🇱',
      currency: 'EUR',
      currencySymbol: '€',
    ),
    Language(
      code: 'ko',
      name: '한국어',
      flag: '🇰🇷',
      currency: 'KRW',
      currencySymbol: '₩',
    ),
    Language(
      code: 'hi',
      name: 'हिन्दी',
      flag: '🇮🇳',
      currency: 'INR',
      currencySymbol: '₹',
    ),
    Language(
      code: 'se',
      name: 'Svenska',
      flag: '🇸🇪',
      currency: 'SEK',
      currencySymbol: 'kr',
    ),
    Language(
      code: 'no',
      name: 'Norsk',
      flag: '🇳🇴',
      currency: 'NOK',
      currencySymbol: 'kr',
    ),
    Language(
      code: 'da',
      name: 'Dansk',
      flag: '🇩🇰',
      currency: 'DKK',
      currencySymbol: 'kr',
    ),
    Language(
      code: 'fi',
      name: 'Suomi',
      flag: '🇫🇮',
      currency: 'EUR',
      currencySymbol: '€',
    ),
    Language(
      code: 'pl',
      name: 'Polski',
      flag: '🇵🇱',
      currency: 'PLN',
      currencySymbol: 'zł',
    ),
    Language(
      code: 'gr',
      name: 'Ελληνικά',
      flag: '🇬🇷',
      currency: 'EUR',
      currencySymbol: '€',
    ),
  ];

  Language? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
  }

  void _removeOverlay() {
    _animationController.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 320,
        child: CompositedTransformFollower(
          link: _layerLink,
          followerAnchor: Alignment.topRight,
          targetAnchor: Alignment.bottomRight,
          offset: const Offset(0, 8),
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).brightness == Brightness.dark 
                  ? AppColors.darkSurface 
                  : Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.darkBorder
                        : Colors.grey.shade300,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(),
                    const Divider(height: 1),
                    _buildLanguageList(),
                    _buildCurrencySection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkSurface
            : Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.language_rounded,
            color: AppColors.primary,
            size: 20,
          ),
          SizedBox(width: 8),
          Text('mobile.auto.language_currency'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageList() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          final language = _languages[index];
          final isSelected = _selectedLanguage?.code == language.code;
          
          return InkWell(
            onTap: () async {
              setState(() {
                _selectedLanguage = language;
              });
              _removeOverlay();
              setState(() {
                _isOpen = false;
              });
              ref.read(localeProvider.notifier).setLocale(language.code);
              await context.setLocale(Locale(language.code));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.transparent,
              ),
              child: Row(
                children: [
                  Text(
                    language.flag,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          language.name,
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? AppColors.primary
                                : (Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${language.currency} • ${language.currencySymbol}',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppColors.textSecondaryDark
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrencySection() {
    if (_selectedLanguage == null) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkSurface
            : Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.attach_money_rounded,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('mobile.auto.selected_currency'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.textSecondaryDark
                        : Colors.grey.shade600,
                  ),
                ),
                Text(
                  '${_selectedLanguage!.currency} (${_selectedLanguage!.currencySymbol})',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _selectedLanguage!.currencySymbol,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedLanguage == null || _selectedLanguage!.code != context.locale.languageCode) {
      _selectedLanguage = _languages.firstWhere(
        (lang) => lang.code == context.locale.languageCode,
        orElse: () => _languages.first,
      );
    }
    
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _isOpen 
                ? AppColors.primary.withOpacity(0.1) 
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _selectedLanguage?.flag ?? '🇺🇸',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight.withOpacity(0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
