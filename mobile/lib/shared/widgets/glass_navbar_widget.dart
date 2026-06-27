import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class GlassNavbarWidget extends ConsumerWidget {
  final Widget child;
  final int currentIndex;

  const GlassNavbarWidget({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    
    // Consistent premium navbar height across all tabs to prevent floating button truncation
    final navbarHeight = 60.0;
    
    return Scaffold(
      body: child,
      extendBody: true,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: navbarHeight,
              decoration: BoxDecoration(
                color: colors.surface.withOpacity(0.7),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.home_outlined, Icons.home_rounded, 'mobile.nav.home'.tr(), colors),
                  _buildNavItem(1, Icons.explore_outlined, Icons.explore_rounded, 'mobile.nav.explore'.tr(), colors),
                  _buildStudioButton(context),
                  _buildNavItem(3, Icons.play_circle_outline, Icons.play_circle_rounded, 'mobile.nav.reels'.tr(), colors),
                  _buildNavItem(4, Icons.person_outline_rounded, Icons.person_rounded, 'mobile.nav.profile'.tr(), colors),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStudioButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/video-recording-studio'),
      child: Container(
        margin: EdgeInsets.zero,
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1BFFFF).withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
          ),
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData selectedIcon, String label, ThemeAwareColors colors, {int badgeCount = 0}) {
    final isSelected = currentIndex == index;
    final color = isSelected ? colors.gold : colors.textSecondary;
    
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => _handleNavigation(index, context),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isSelected ? selectedIcon : icon,
                  color: color,
                  size: 24,
                ),
                if (badgeCount > 0)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: colors.error,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        badgeCount > 99 ? '99+' : badgeCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNavigation(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/explore');
        break;
      case 2:
        context.push('/video-recording-studio');
        break;
      case 3:
        context.go('/reels');
        break;
      case 4:
        context.go('/more');
        break;
    }
  }
}

class CustomGlassNavbar extends ConsumerWidget {
  final Widget child;
  final int currentIndex;
  final Function(int)? onTap;

  const CustomGlassNavbar({
    super.key,
    required this.child,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    
    // Consistent premium navbar height across all tabs to prevent floating button truncation
    final navbarHeight = 60.0;
    
    return Scaffold(
      body: child,
      extendBody: true,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: navbarHeight,
              decoration: BoxDecoration(
                color: colors.surface.withOpacity(0.6),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.home_outlined, Icons.home_rounded, 'mobile.nav.home'.tr(), colors, context),
                  _buildNavItem(1, Icons.explore_outlined, Icons.explore_rounded, 'mobile.nav.explore'.tr(), colors, context),
                  _buildStudioButton(context),
                  _buildNavItem(3, Icons.play_circle_outline, Icons.play_circle_rounded, 'mobile.nav.reels'.tr(), colors, context),
                  _buildNavItem(4, Icons.person_outline, Icons.person_rounded, 'mobile.nav.profile'.tr(), colors, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStudioButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/video-recording-studio'),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.zero,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1BFFFF).withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
          ),
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData selectedIcon, String label, ThemeAwareColors colors, BuildContext context, {int badgeCount = 0}) {
    final isSelected = currentIndex == index;
    final color = isSelected ? colors.gold : colors.textSecondary;
    
    return GestureDetector(
      onTap: () => onTap != null ? onTap!(index) : _handleNavigation(index, context),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                color: color,
                size: 24,
              ),
              if (badgeCount > 0)
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: colors.error,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      badgeCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _handleNavigation(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/explore');
        break;
      case 2:
        context.push('/video-recording-studio');
        break;
      case 3:
        context.go('/reels');
        break;
      case 4:
        context.go('/more');
        break;
    }
  }
}

class GlassNavbarSettings extends ConsumerWidget {
  const GlassNavbarSettings({super.key});

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
          Text('mobile.auto.glass_navbar_settings'.tr(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 16),
          
          _buildGlassControl(
            title: 'mobile.auto.glass_effect'.tr(),
            subtitle: 'mobile.auto.enable_glassmorphism_design'.tr(),
            colors: colors,
            value: true,
            onChanged: (value) {
            },
          ),
          
          SizedBox(height: 16),
          
          _buildSliderControl(
            title: 'mobile.auto.blur_intensity'.tr(),
            subtitle: 'mobile.auto.adjust_glass_blur_effect'.tr(),
            colors: colors,
            value: 10,
            min: 0,
            max: 20,
            onChanged: (value) {
            },
          ),
          
          SizedBox(height: 16),
          
          _buildSliderControl(
            title: 'mobile.auto.opacity'.tr(),
            subtitle: 'mobile.auto.adjust_navbar_transparency'.tr(),
            colors: colors,
            value: 0.8,
            min: 0.3,
            max: 1.0,
            onChanged: (value) {
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGlassControl({
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
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
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
        ),
      ],
    );
  }

  Widget _buildSliderControl({
    required String title,
    required String subtitle,
    required ThemeAwareColors colors,
    required double value,
    required double min,
    required double max,
    int? divisions,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              value.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colors.gold,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
          activeColor: colors.gold,
        ),
      ],
    );
  }
}
