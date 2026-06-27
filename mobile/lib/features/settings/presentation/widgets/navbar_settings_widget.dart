import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class NavbarSettingsWidget extends ConsumerStatefulWidget {
  const NavbarSettingsWidget({super.key});

  @override
  ConsumerState<NavbarSettingsWidget> createState() => _NavbarSettingsWidgetState();
}

class _NavbarSettingsWidgetState extends ConsumerState<NavbarSettingsWidget> {
  String _navbarStyle = 'Standard';
  bool _badgeAnimations = true;
  bool _showLabels = false;
  bool _hapticFeedback = true;

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('mobile.auto.navigation_bar'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 16),

          // Navbar Style Options
          _buildSettingOption(
            title: 'mobile.auto.navbar_style'.tr(),
            subtitle: 'mobile.auto.choose_your_preferred_navigation_style'.tr(),
            options: ['Standard', 'Modern', 'Minimal'],
            colors: colors,
          ),

          SizedBox(height: 16),

          // Badge Animation
          _buildSwitchOption(
            title: 'mobile.auto.badge_animations'.tr(),
            subtitle: 'mobile.auto.animate_notification_badges_when_count_changes'.tr(),
            colors: colors,
            value: _badgeAnimations,
            onChanged: (value) {
              setState(() => _badgeAnimations = value);
            },
          ),

          SizedBox(height: 16),

          // Icon Labels
          _buildSwitchOption(
            title: 'mobile.auto.show_labels'.tr(),
            subtitle: 'mobile.auto.display_text_labels_below_navigation_icons'.tr(),
            colors: colors,
            value: _showLabels,
            onChanged: (value) {
              setState(() => _showLabels = value);
            },
          ),

          SizedBox(height: 16),

          // Haptic Feedback
          _buildSwitchOption(
            title: 'mobile.auto.haptic_feedback'.tr(),
            subtitle: 'mobile.auto.vibrate_when_tapping_navigation_items'.tr(),
            colors: colors,
            value: _hapticFeedback,
            onChanged: (value) {
              setState(() => _hapticFeedback = value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingOption({
    required String title,
    required String subtitle,
    required List<String> options,
    required ThemeAwareColors colors,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: GoogleFonts.outfit(fontSize: 12, color: colors.textSecondary),
        ),
        const SizedBox(height: 12),

        // Option Pills
        Row(
          children: options.map((option) {
            final isSelected = option == _navbarStyle;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  setState(() => _navbarStyle = option);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? colors.gold : colors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? colors.gold : colors.border,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    option,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected
                          ? colors.background
                          : colors.textSecondary,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSwitchOption({
    required String title,
    required String subtitle,
    required ThemeAwareColors colors,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: colors.gold,
          trackColor: MaterialStateProperty.all(colors.border),
          thumbColor: MaterialStateProperty.all(Colors.white),
        ),
      ],
    );
  }
}

class NavbarPreviewWidget extends ConsumerWidget {
  const NavbarPreviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('mobile.auto.preview'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          // Mini Navbar Preview
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPreviewIcon(Icons.home, true, colors),
                _buildPreviewIcon(Icons.play_circle, false, colors),
                _buildPreviewIcon(Icons.search, false, colors),
                _buildPreviewNotificationIcon(3, colors),
                _buildPreviewIcon(Icons.person, false, colors),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewIcon(
    IconData icon,
    bool isActive,
    ThemeAwareColors colors,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isActive ? colors.gold.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: isActive ? colors.gold : colors.textSecondary,
        size: 20,
      ),
    );
  }

  Widget _buildPreviewNotificationIcon(int count, ThemeAwareColors colors) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.notifications_outlined,
            color: colors.textSecondary,
            size: 20,
          ),
        ),
        Positioned(
          right: 4,
          top: 4,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: colors.error,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: colors.surface, width: 1),
            ),
            child: Center(
              child: Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
