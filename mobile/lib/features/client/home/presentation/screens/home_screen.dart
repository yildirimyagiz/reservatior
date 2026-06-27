import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/notification_provider.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/shared/widgets/main_shell.dart';
import 'package:reservatior/shared/widgets/listing_management_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Feature Pages
import 'package:reservatior/features/client/home/presentation/pages/home_admin_page.dart';
import 'package:reservatior/features/client/home/presentation/pages/home_client_page.dart';
import 'package:reservatior/features/client/property/presentation/widgets/property_feed.dart';

import 'package:reservatior/shared/providers/role_provider.dart';
import 'package:reservatior/shared/enums/member_role_key.dart';

import 'package:reservatior/features/client/payment/presentation/screens/smart_checkout_screen.dart';
import 'package:reservatior/features/client/home/presentation/widgets/animated_logo_avatar_widget.dart';
import 'package:reservatior/features/client/home/presentation/widgets/quick_actions_widget.dart';
import 'package:reservatior/features/client/home/presentation/widgets/home_hero_widget.dart';
import 'package:reservatior/features/client/home/presentation/widgets/home_portfolio_balance_widget.dart';
import 'package:reservatior/features/client/home/presentation/widgets/home_sync_ticker_widget.dart';
import 'package:reservatior/features/client/home/presentation/widgets/home_search_hub_widget.dart';
import 'package:reservatior/features/client/home/presentation/widgets/home_neural_hub_widget.dart';
import 'package:reservatior/features/client/home/presentation/widgets/home_ai_picks_widget.dart';
import 'package:reservatior/features/client/home/presentation/widgets/home_features_grid_widget.dart';
import 'package:reservatior/features/client/home/presentation/widgets/home_cta_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLanguagePreference();
    });
  }

  Future<void> _checkLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final hasChosen = prefs.getBool('has_chosen_language') ?? false;
    if (!hasChosen) {
      _showLanguageSelectionDialog();
    }
  }

  void _showLanguageSelectionDialog() {
    final List<Map<String, String>> languages = [
      {'code': 'tr', 'name': 'mobile.leftovers.t_rk_e'.tr(), 'flag': '🇹🇷'},
      {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
      {'code': 'de', 'name': 'Deutsch', 'flag': '🇩🇪'},
      {'code': 'fr', 'name': 'mobile.leftovers.fran_ais'.tr(), 'flag': '🇫🇷'},
      {'code': 'pt', 'name': 'mobile.leftovers.portugu_s'.tr(), 'flag': '🇵🇹'},
      {'code': 'nl', 'name': 'Nederlands', 'flag': '🇳🇱'},
      {'code': 'ru', 'name': 'Русский', 'flag': '🇷🇺'},
      {'code': 'zh', 'name': '中文', 'flag': '🇨🇳'},
      {'code': 'pl', 'name': 'Polski', 'flag': '🇵🇱'},
      {'code': 'fi', 'name': 'Suomi', 'flag': '🇫🇮'},
      {'code': 'no', 'name': 'Norsk', 'flag': '🇳🇴'},
      {'code': 'da', 'name': 'Dansk', 'flag': '🇩🇰'},
    ];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false, // Prevent dismissing
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon Glow Header
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1.5),
                    ),
                    child: Icon(Icons.language_rounded, color: AppColors.primary, size: 30),
                  ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
                  SizedBox(height: 16),
                  
                  Text(
                    'client.src.welcome_to_reservatior'.tr(),
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'mobile.auto.please_choose_your_preferred_language'.tr(),
                    style: GoogleFonts.outfit(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Scrollable Language List Hub to support all 12 locales elegantly without overflow
                  SizedBox(
                    height: 320,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        final lang = languages[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.02),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.04)),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                            leading: Text(
                              lang['flag']!,
                              style: const TextStyle(fontSize: 24),
                            ),
                            title: Text(
                              lang['name']!,
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            trailing: Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.primary.withOpacity(0.5),
                            ),
                            onTap: () async {
                              await context.setLocale(Locale(lang['code']!));
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setBool('has_chosen_language', true);
                              Navigator.pop(context);
                              
                              // Trigger state rebuild on HomeScreen
                              if (mounted) setState(() {});
                            },
                          ),
                        ).animate().fadeIn(delay: (index * 60).ms).slideY(begin: 0.1);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ).animate().scale(duration: 500.ms, curve: Curves.fastOutSlowIn).fadeIn(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);
    final unreadCount = ref.watch(unreadNotificationsCountProvider);
    final authState = ref.watch(authProvider);
    final userName = authState.user?.name ?? 'mobile.auto.guest'.tr();
    final greeting = _getGreeting();
    
    final userRole = ref.watch(userRoleProvider);
    // Determine the view mode. If role is null, we default to full view (Admin/Agent) for demo purposes.
    final isB2B = userRole == null || userRole.role == MemberRoleKey.AGENCY_ADMIN || userRole.role == MemberRoleKey.AGENT || userRole.role == MemberRoleKey.ORG_ADMIN;
    final isOwner = userRole?.role == MemberRoleKey.OWNER;
    final isTenant = userRole?.role == MemberRoleKey.TENANT_GUEST;

    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(context, colors, unreadCount, userName, greeting),
          
          if (isB2B || isOwner) const HomePortfolioBalanceWidget(),
          if (isB2B || isOwner) const HomeSyncTickerWidget(),
          
          if (isB2B || isTenant) const HomeHeroWidget(),
          if (isB2B || isTenant) const HomeSearchHubWidget(),
          
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverToBoxAdapter(child: QuickActionsWidget()),
          ),
          
          if (isB2B) const HomeNeuralHubWidget(),
          if (isB2B || isTenant) const HomeAIPicksWidget(),
          if (isB2B) const HomeFeaturesGridWidget(),
          if (isB2B || isTenant) const HomeCtaWidget(),
          
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'mobile.auto.good_morning'.tr();
    if (hour < 17) return 'mobile.auto.good_afternoon'.tr();
    return 'mobile.auto.good_evening'.tr();
  }

  Widget _buildSliverAppBar(BuildContext context, ThemeAwareColors colors, int unreadCount, String userName, String greeting) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: colors.background.withOpacity(0.95),
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 80,
      title: Row(
        children: [
          const AnimatedLogoAvatarWidget(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  greeting,
                  style: GoogleFonts.outfit(fontSize: 12, color: Colors.white60, fontWeight: FontWeight.w500),
                ),
                Text(
                  userName,
                  style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: -0.5),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ).animate().fadeIn(delay: 1600.ms, duration: 400.ms).slideX(begin: -0.1),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => ListingManagementModal.show(context),
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
            ),
            child: Icon(Icons.add_home_work_rounded, color: AppColors.primary, size: 20),
          ),
          tooltip: 'mobile.auto.send_listing'.tr(),
        ).animate().fadeIn(delay: 200.ms),
        IconButton(
          onPressed: () => context.go('/search'),
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Icon(Icons.search_rounded, color: Colors.white, size: 20),
          ),
        ).animate().fadeIn(delay: 250.ms),
        IconButton(
          onPressed: () => context.go('/messages'),
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 20),
          ),
        ).animate().fadeIn(delay: 275.ms),
        Stack(
          children: [
            IconButton(
              onPressed: () => context.go('/notifications'),
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Icon(Icons.notifications_none_rounded, color: Colors.white, size: 20),
              ),
            ),
            if (unreadCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.background, width: 2),
                  ),
                ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 1.seconds),
              ),
          ],
        ).animate().fadeIn(delay: 300.ms),
        SizedBox(width: 12),
      ],
    );
  }
}
