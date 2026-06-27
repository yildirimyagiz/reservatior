import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class RecordingSettingsWidget extends StatefulWidget {
  final String videoQuality;
  final bool autoFocus;
  final bool showBlurring;
  final bool consentGiven;
  final Function(String) onVideoQualityChange;
  final Function(bool) onAutoFocusChange;
  final Function(bool) onBlurringChange;
  final Function(bool) onConsentChange;

  const RecordingSettingsWidget({
    super.key,
    required this.videoQuality,
    required this.autoFocus,
    required this.showBlurring,
    required this.consentGiven,
    required this.onVideoQualityChange,
    required this.onAutoFocusChange,
    required this.onBlurringChange,
    required this.onConsentChange,
  });

  @override
  State<RecordingSettingsWidget> createState() =>
      _RecordingSettingsWidgetState();
}

class _RecordingSettingsWidgetState extends State<RecordingSettingsWidget>
    with SingleTickerProviderStateMixin {
  bool _isHydrated = false;
  bool _showSettings = false;
  bool _showConsentModal = false;
  late AnimationController _settingsController;
  late Animation<double> _settingsAnimation;

  @override
  void initState() {
    super.initState();
    _isHydrated = true;
    _showConsentModal = !widget.consentGiven;

    _settingsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _settingsAnimation = CurvedAnimation(
      parent: _settingsController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _settingsController.dispose();
    super.dispose();
  }

  List<QualityOption> get qualityOptions => [
    QualityOption(
      value: 'high',
      label: 'mobile.auto.high_1080p'.tr(),
      description: 'mobile.leftovers.best_quality_larger_file_size'.tr(),
    ),
    QualityOption(
      value: 'medium',
      label: 'mobile.auto.medium_720p'.tr(),
      description: 'mobile.leftovers.balanced_quality_and_size'.tr(),
    ),
    QualityOption(
      value: 'low',
      label: 'mobile.auto.low_480p'.tr(),
      description: 'mobile.leftovers.smaller_file_size_faster_upload'.tr(),
    ),
  ];

  void toggleSettings() {
    setState(() {
      _showSettings = !_showSettings;
    });
    if (_showSettings) {
      _settingsController.forward();
    } else {
      _settingsController.reverse();
    }
  }

  void handleConsentAccept() {
    widget.onConsentChange(true);
    setState(() {
      _showConsentModal = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isHydrated) {
      return _buildShimmerLoading();
    }

    return Column(
      children: [
        _buildSettingsToggle(),
        if (_showSettings) _buildSettingsPanel(),
        if (_showConsentModal) _buildConsentModal(),
      ],
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsToggle() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: toggleSettings,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.settings, size: 24, color: AppColors.textPrimaryDark),
              SizedBox(width: 12),
              Expanded(
                child: Text('mobile.auto.recording_settings'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ),
              Icon(
                _showSettings
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 20,
                color: AppColors.textSecondaryDark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsPanel() {
    return SizeTransition(
      sizeFactor: _settingsAnimation,
      child: FadeTransition(
        opacity: _settingsAnimation,
        child: Container(
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildVideoQualitySection(),
                const SizedBox(height: 16),
                _buildAutoFocusSection(),
                const SizedBox(height: 16),
                _buildBlurringSection(),
                const SizedBox(height: 16),
                _buildConsentStatusSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoQualitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.video_quality'.tr(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryDark,
          ),
        ),
        const SizedBox(height: 12),
        ...qualityOptions.map(
          (option) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildQualityOption(option),
          ),
        ),
      ],
    );
  }

  Widget _buildQualityOption(QualityOption option) {
    final isSelected = widget.videoQuality == option.value;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onVideoQualityChange(option.value),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? AppColors.gold
                  : AppColors.darkBorder.withOpacity(0.3),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
            color: isSelected
                ? AppColors.gold.withOpacity(0.1)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.gold
                        : AppColors.textSecondaryDark,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          shape: BoxShape.circle,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      option.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAutoFocusSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.camera_alt, size: 20, color: AppColors.textPrimaryDark),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('mobile.auto.auto_focus'.tr(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                SizedBox(height: 2),
                Text('mobile.auto.automatically_adjust_focus_during_recording'.tr(),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ],
            ),
          ),
          _buildToggleSwitch(widget.autoFocus, widget.onAutoFocusChange),
        ],
      ),
    );
  }

  Widget _buildBlurringSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.visibility_off,
            size: 20,
            color: AppColors.textPrimaryDark,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('mobile.auto.auto_blur_faces_plates'.tr(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                SizedBox(height: 2),
                Text('mobile.auto.automatically_blur_faces_and_license_plates'.tr(),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ],
            ),
          ),
          _buildToggleSwitch(widget.showBlurring, widget.onBlurringChange),
        ],
      ),
    );
  }

  Widget _buildToggleSwitch(bool value, Function(bool) onChanged) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 48,
          height: 24,
          decoration: BoxDecoration(
            color: value
                ? AppColors.gold
                : AppColors.darkBorder.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConsentStatusSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 20, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('mobile.auto.recording_consent_given'.tr(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 2),
                Text('mobile.auto.you_have_permission_to_record_this_property'.tr(),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsentModal() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildConsentHeader(),
            _buildConsentContent(),
            _buildConsentActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildConsentHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.darkBorder.withOpacity(0.3)),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.security, size: 28, color: AppColors.gold),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text('mobile.auto.recording_consent_required'.tr(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsentContent() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('mobile.auto.before_you_begin_recording_please_confirm_that_you_have'.tr(),
            style: TextStyle(fontSize: 16, color: AppColors.textPrimaryDark),
          ),
          const SizedBox(height: 16),
          _buildConsentItem(
            Icons.check_circle,
            'mobile.leftovers.permission_from_the_property_owner_to_re'.tr(),
          ),
          const SizedBox(height: 12),
          _buildConsentItem(
            Icons.check_circle,
            'mobile.leftovers.informed_any_occupants_or_visitors_that'.tr(),
          ),
          const SizedBox(height: 12),
          _buildConsentItem(
            Icons.check_circle,
            'mobile.leftovers.reviewed_and_agree_to_our_privacy_and_co'.tr(),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.withOpacity(0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning, size: 20, color: Colors.orange),
                SizedBox(width: 12),
                Expanded(
                  child: Text('mobile.auto.recording_without_proper_consent_may_violate_privacy_laws_and_platform_policies'.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsentItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.gold),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: AppColors.textPrimaryDark),
          ),
        ),
      ],
    );
  }

  Widget _buildConsentActions() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.darkBorder.withOpacity(0.3)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.darkBorder.withOpacity(0.3),
                    ),
                  ),
                  child: Text('mobile.auto.cancel'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: handleConsentAccept,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('mobile.auto.i_confirm_agree'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkBg,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QualityOption {
  final String value;
  final String label;
  final String description;

  QualityOption({
    required this.value,
    required this.label,
    required this.description,
  });
}
