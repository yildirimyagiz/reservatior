import 'package:flutter/material.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class SubtitlePreviewWidget extends StatefulWidget {
  final bool isRecording;
  final String currentText;
  final String language;
  final Function(String) onLanguageChange;

  const SubtitlePreviewWidget({
    super.key,
    required this.isRecording,
    required this.currentText,
    required this.language,
    required this.onLanguageChange,
  });

  @override
  State<SubtitlePreviewWidget> createState() => _SubtitlePreviewWidgetState();
}

class _SubtitlePreviewWidgetState extends State<SubtitlePreviewWidget>
    with SingleTickerProviderStateMixin {
  bool _isHydrated = false;
  bool _showLanguageMenu = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _isHydrated = true;

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  List<Language> get languages => [
    Language(code: 'en', name: 'English', flag: '🇺🇸'),
    Language(code: 'es', name: 'Spanish', flag: '🇪🇸'),
    Language(code: 'fr', name: 'French', flag: '🇫🇷'),
    Language(code: 'de', name: 'German', flag: '🇩🇪'),
    Language(code: 'zh', name: 'Chinese', flag: '🇨🇳'),
    Language(code: 'ar', name: 'Arabic', flag: '🇸🇦'),
  ];

  Language get currentLanguage =>
      languages.firstWhere((lang) => lang.code == widget.language) ??
      languages.first;

  @override
  Widget build(BuildContext context) {
    if (!_isHydrated) {
      return _buildShimmerLoading();
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [AppColors.darkCard.withOpacity(0.9), Colors.transparent],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildSubtitleDisplay(),
            const SizedBox(height: 16),
            _buildSubtitleInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity * 0.75,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity * 0.5,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Icon(
                  widget.isRecording ? Icons.mic : Icons.speaker,
                  size: 20,
                  color: widget.isRecording
                      ? Colors.red.withOpacity(_pulseAnimation.value)
                      : AppColors.textSecondaryDark,
                );
              },
            ),
            const SizedBox(width: 8),
            Text(
              widget.isRecording ? 'mobile.leftovers.listening'.tr() : 'mobile.leftovers.subtitles_ready'.tr(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: widget.isRecording
                    ? Colors.red
                    : AppColors.textSecondaryDark,
              ),
            ),
          ],
        ),
        _buildLanguageSelector(),
      ],
    );
  }

  Widget _buildLanguageSelector() {
    return PopupMenuButton<Language>(
      onSelected: (language) {
        widget.onLanguageChange(language.code);
        setState(() {
          _showLanguageMenu = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(currentLanguage.flag, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              currentLanguage.code.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 14,
              color: AppColors.textSecondaryDark,
            ),
          ],
        ),
      ),
      itemBuilder: (context) => languages
          .map(
            (language) => PopupMenuItem<Language>(
              value: language,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Text(language.flag, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        language.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimaryDark,
                        ),
                      ),
                    ),
                    if (language.code == widget.language)
                      Icon(Icons.check, size: 16, color: AppColors.gold),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildSubtitleDisplay() {
    return Container(
      height: 80,
      alignment: Alignment.center,
      child: widget.currentText.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.darkCard.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                widget.currentText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimaryDark,
                  height: 1.4,
                ),
              ),
            )
          : Text(
              widget.isRecording
                  ? 'mobile.leftovers.start_speaking_to_see_live_subtitles'.tr()
                  : 'mobile.leftovers.subtitles_will_appear_here_during_record'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondaryDark,
                fontStyle: FontStyle.italic,
              ),
            ),
    );
  }

  Widget _buildSubtitleInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildInfoItem(Icons.translate, 'mobile.leftovers.auto_translate'.tr()),
        const SizedBox(width: 16),
        _buildInfoItem(Icons.auto_awesome, 'mobile.leftovers.ai_powered'.tr()),
        const SizedBox(width: 16),
        _buildInfoItem(Icons.access_time, 'mobile.leftovers.real_time'.tr()),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondaryDark),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: AppColors.textSecondaryDark),
        ),
      ],
    );
  }
}

class Language {
  final String code;
  final String name;
  final String flag;

  Language({required this.code, required this.name, required this.flag});
}
