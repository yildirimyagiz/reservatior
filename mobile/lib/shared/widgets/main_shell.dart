import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/notification_provider.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/shared/widgets/glass_navbar_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class MainShell extends ConsumerStatefulWidget {
  final Widget child;

  const MainShell({required this.child, super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  final TextEditingController _chatController = TextEditingController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);
    final currentIndex = _calculateSelectedIndex(context);
    
    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          GlassNavbarWidget(
            currentIndex: currentIndex,
            child: widget.child,
          ),
          
          // Floating Notification Ring (temporarily disabled)
          // if (unreadCount > 0)
          //   Positioned(
          //     right: 20,
          //     bottom: 110,
          //     child: _buildNotificationRing(context, unreadCount, colors),
          //   ),
            
          _SlidingHelpDesk(
            isHidden: false,
            bottomPosition: _calculateBottomPosition(currentIndex),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationRing(BuildContext context, int count, dynamic colors) {
    return GestureDetector(
      onTap: () => context.go('/notifications'),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: colors.primary.withOpacity(0.4), blurRadius: 15, spreadRadius: 2)
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.notifications_active_rounded, color: Colors.white, size: 24),
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                child: Text(
                  count > 9 ? '9+' : '$count',
                  style: GoogleFonts.outfit(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 2.seconds).scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 1.seconds, curve: Curves.easeInOut).then().scale(begin: const Offset(1.1, 1.1), end: const Offset(1, 1)),
    );
  }


  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/explore')) return 1;
    if (location.startsWith('/reels')) return 3;
    if (location.startsWith('/more')) return 4;
    return 0;
  }

  double _calculateBottomPosition(int currentIndex) {
    // Reels için video kontrollerinin ve navbar'mobile.leftovers._n_zerinde_ancak_180'.tr()deki detaylar ikonunun altında (110 seviyesi)
    if (currentIndex == 3) return 110; 
    // Diğer sayfalar için normal
    return 110;
  }
}

class _SlidingHelpDesk extends StatefulWidget {
  final bool isHidden;
  final double bottomPosition;
  const _SlidingHelpDesk({this.isHidden = false, this.bottomPosition = 110});

  @override
  State<_SlidingHelpDesk> createState() => _SlidingHelpDeskState();
}

class _SlidingHelpDeskState extends State<_SlidingHelpDesk> {
  bool _isOpened = false;
  final TextEditingController _chatController = TextEditingController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isHidden) {
      return const SizedBox.shrink();
    }

    return Consumer(
      builder: (context, ref, child) {
        final colors = ref.watch(themeAwareColorsProvider);
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn,
          right: 20,
          bottom: widget.bottomPosition, // Dynamic: higher on reels page
          child: GestureDetector(
            onTap: () {
              if (!_isOpened) {
                setState(() => _isOpened = true);
              } else {
                _showHelpDesk(context, ref, colors);
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isOpened)
                  GestureDetector(
                    onTap: () => setState(() => _isOpened = false),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close_rounded, color: Colors.white, size: 16),
                    ),
                  ),
                if (_isOpened) 
                  SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: colors.primary.withOpacity(0.4), blurRadius: 15, spreadRadius: 2)
                    ],
                  ),
                  child: Icon(Icons.chat_bubble_rounded, color: Colors.white, size: 24),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showHelpDesk(BuildContext context, WidgetRef ref, dynamic colors) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: 600,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: colors.border, borderRadius: BorderRadius.circular(2))),
            Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                children: [
                  CircleAvatar(backgroundColor: colors.primary, child: Icon(Icons.auto_awesome, color: Colors.white)),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('mobile.nav.conciergeTitle'.tr(), style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: colors.textPrimary)),
                      Text('mobile.nav.conciergeSubtitle'.tr(), style: GoogleFonts.outfit(fontSize: 12, color: colors.textSecondary)),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text(
                    'mobile.nav.conciergeMsg'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colors.textSecondary, height: 1.5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.border),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _chatController,
                        decoration: InputDecoration(
                          hintText: 'mobile.auto.mobile_nav_askanything'.tr(), 
                          border: InputBorder.none, 
                          filled: false, 
                          hintStyle: TextStyle(color: colors.textSecondary)
                        ),
                        onSubmitted: (val) {
                          if (val.isNotEmpty) {
                            ref.read(realtimeNotificationServiceProvider).sendChatMessage(val);
                            _chatController.clear();
                          }
                        },
                      )
                    ),
                    IconButton(
                      onPressed: () {
                        if (_chatController.text.isNotEmpty) {
                          ref.read(realtimeNotificationServiceProvider).sendChatMessage(_chatController.text);
                          _chatController.clear();
                        }
                      }, 
                      icon: Icon(Icons.send_rounded, color: colors.primary)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
