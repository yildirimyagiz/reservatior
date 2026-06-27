import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/shared/providers/notification_provider.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:url_launcher/url_launcher.dart';

class EnhancedBottomNavbar extends ConsumerStatefulWidget {
  final Widget child;
  final int currentIndex;
  final Function(int) onTap;

  const EnhancedBottomNavbar({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  ConsumerState<EnhancedBottomNavbar> createState() => _EnhancedBottomNavbarState();
}

class _EnhancedBottomNavbarState extends ConsumerState<EnhancedBottomNavbar>
    with TickerProviderStateMixin {
  late AnimationController _badgeAnimationController;
  late Animation<double> _badgeScaleAnimation;

  @override
  void initState() {
    super.initState();
    _badgeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _badgeScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _badgeAnimationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _badgeAnimationController.dispose();
    super.dispose();
  }

  void _animateBadge() {
    _badgeAnimationController.forward().then((_) {
      _badgeAnimationController.reverse();
    });
  }

  void _showAddListingBottomSheet(BuildContext context, ThemeAwareColors colors) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('İlan Tipi Seçin', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: colors.textPrimary)),
                SizedBox(height: 24),
                _buildAddListingOption(context, colors, Icons.business_rounded, 'Satılık Mülk Ekle', 'SALE'),
                SizedBox(height: 12),
                _buildAddListingOption(context, colors, Icons.vpn_key_rounded, 'Kiralık Mülk Ekle', 'RENT'),
                SizedBox(height: 12),
                _buildAddListingOption(context, colors, Icons.hotel_rounded, 'Otel / Günlük Kiralık', 'BOOKING'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddListingOption(BuildContext context, ThemeAwareColors colors, IconData icon, String title, String type) {
    return InkWell(
      onTap: () async {
        Navigator.pop(context);
        final url = Uri.parse('http://localhost:5173/host/new-listing?type=$type');
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: colors.gold.withOpacity(0.1),
          border: Border.all(color: colors.gold.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: colors.gold, size: 28),
            SizedBox(width: 16),
            Text(title, style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600, color: colors.gold)),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: colors.gold, size: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);
    final unreadCount = ref.watch(unreadNotificationsCountProvider);
    
    // Animate badge when count changes
    ref.listen(unreadNotificationsCountProvider, (previous, next) {
      if (previous != null && next != previous) {
        _animateBadge();
      }
    });

    return Scaffold(
      body: widget.child,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors.gold,
        child: Icon(Icons.add, color: colors.background),
        onPressed: () => _showAddListingBottomSheet(context, colors),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(
            top: BorderSide(
              color: colors.border.withOpacity(0.3),
              width: 0.5,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: colors.background.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.dashboard_outlined,
                  activeIcon: Icons.dashboard_rounded,
                  label: 'mobile.auto.home'.tr(),
                  index: 0,
                  colors: colors,
                ),
                _buildNavItem(
                  icon: Icons.movie_creation_outlined,
                  activeIcon: Icons.movie_creation_rounded,
                  label: 'mobile.auto.reels'.tr(),
                  index: 1,
                  colors: colors,
                ),
                _buildNavItem(
                  icon: Icons.search_rounded,
                  activeIcon: Icons.search_rounded,
                  label: 'mobile.auto.search'.tr(),
                  index: 2,
                  colors: colors,
                ),
                _buildNotificationNavItem(
                  unreadCount: unreadCount,
                  colors: colors,
                  index: 3,
                ),
                _buildNavItem(
                  icon: Icons.person_outline_rounded,
                  activeIcon: Icons.person_rounded,
                  label: 'mobile.auto.profile'.tr(),
                  index: 4,
                  colors: colors,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required ThemeAwareColors colors,
  }) {
    final isActive = widget.currentIndex == index;
    
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? colors.gold.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isActive ? activeIcon : icon,
                key: ValueKey(isActive ? activeIcon : icon),
                color: isActive ? colors.gold : colors.textSecondary,
                size: 24,
              ),
            ),
            SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? colors.gold : colors.textSecondary,
              ),
              child: Text(label),
            ),
          ],
        ),
      ).animate(target: isActive ? 1 : 0).scale(
        begin: const Offset(1.0, 1.0),
        end: const Offset(1.05, 1.05),
        duration: const Duration(milliseconds: 150),
      ),
    );
  }

  Widget _buildNotificationNavItem({
    required int unreadCount,
    required ThemeAwareColors colors,
    required int index,
  }) {
    final isActive = widget.currentIndex == index;
    
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? colors.gold.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isActive ? Icons.notifications : Icons.notifications_outlined,
                    key: ValueKey(isActive ? 'active' : 'inactive'),
                    color: isActive ? colors.gold : colors.textSecondary,
                    size: 24,
                  ),
                ),
                if (unreadCount > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: AnimatedBuilder(
                      animation: _badgeScaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _badgeScaleAnimation.value,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: colors.error,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: colors.surface, width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: colors.error.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              unreadCount > 99 ? '99+' : unreadCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
            SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? colors.gold : colors.textSecondary,
              ),
              child: Text('mobile.auto.alerts'.tr()),
            ),
          ],
        ),
      ).animate(target: isActive ? 1 : 0).scale(
        begin: const Offset(1.0, 1.0),
        end: const Offset(1.05, 1.05),
        duration: const Duration(milliseconds: 150),
      ),
    );
  }
}

class ModernBottomNavbar extends ConsumerWidget {
  final Widget child;
  final int currentIndex;
  final Function(int) onTap;

  const ModernBottomNavbar({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onTap,
  });

  void _showAddListingBottomSheet(BuildContext context, ThemeAwareColors colors) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('İlan Tipi Seçin', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: colors.textPrimary)),
                SizedBox(height: 24),
                _buildAddListingOption(context, colors, Icons.business_rounded, 'Satılık Mülk Ekle', 'SALE'),
                SizedBox(height: 12),
                _buildAddListingOption(context, colors, Icons.vpn_key_rounded, 'Kiralık Mülk Ekle', 'RENT'),
                SizedBox(height: 12),
                _buildAddListingOption(context, colors, Icons.hotel_rounded, 'Otel / Günlük Kiralık', 'BOOKING'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddListingOption(BuildContext context, ThemeAwareColors colors, IconData icon, String title, String type) {
    return InkWell(
      onTap: () async {
        Navigator.pop(context);
        final url = Uri.parse('http://localhost:5173/host/new-listing?type=$type');
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: colors.gold.withOpacity(0.1),
          border: Border.all(color: colors.gold.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: colors.gold, size: 28),
            SizedBox(width: 16),
            Text(title, style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600, color: colors.gold)),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: colors.gold, size: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    final unreadCount = ref.watch(unreadNotificationsCountProvider);
    
    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors.gold,
        child: Icon(Icons.add, color: colors.background),
        onPressed: () => _showAddListingBottomSheet(context, colors),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          border: Border(
            top: BorderSide(
              color: colors.border.withOpacity(0.3),
              width: 0.5,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: colors.background.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildModernNavItem(
                icon: Icons.home_rounded,
                label: 'mobile.auto.home'.tr(),
                index: 0,
                colors: colors,
                isActive: currentIndex == 0,
              ),
              _buildModernNavItem(
                icon: Icons.play_circle_rounded,
                label: 'mobile.auto.reels'.tr(),
                index: 1,
                colors: colors,
                isActive: currentIndex == 1,
              ),
              _buildModernNavItem(
                icon: Icons.explore_rounded,
                label: 'mobile.auto.search'.tr(),
                index: 2,
                colors: colors,
                isActive: currentIndex == 2,
              ),
              _buildModernNotificationItem(
                unreadCount: unreadCount,
                colors: colors,
                index: 3,
                isActive: currentIndex == 3,
              ),
              _buildModernNavItem(
                icon: Icons.person_rounded,
                label: 'mobile.auto.profile'.tr(),
                index: 4,
                colors: colors,
                isActive: currentIndex == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernNavItem({
    required IconData icon,
    required String label,
    required int index,
    required ThemeAwareColors colors,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isActive ? colors.gold : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: colors.gold.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                icon,
                color: isActive ? colors.background : colors.textSecondary,
                size: 24,
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? colors.gold : colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernNotificationItem({
    required int unreadCount,
    required ThemeAwareColors colors,
    required int index,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isActive ? colors.gold : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: colors.gold.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    Icons.notifications_rounded,
                    color: isActive ? colors.background : colors.textSecondary,
                    size: 24,
                  ),
                ),
                if (unreadCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: colors.error,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colors.surface, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: colors.error.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        unreadCount > 99 ? '99+' : unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 4),
            Text('mobile.auto.alerts'.tr(),
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? colors.gold : colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
