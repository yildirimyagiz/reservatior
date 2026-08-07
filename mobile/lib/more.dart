import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/shared/widgets/language_currency_dropdown_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final isAdmin = user?.role == 'ADMIN' || user?.role == 'SUPER_ADMIN';
    final isAgent = user?.role == 'AGENT' || isAdmin;
    
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'mobile.profile.hubTitle'.tr(),
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontStyle: FontStyle.italic,
            color: colors.textPrimary,
          ),
        ),
        actions: [
          const LanguageCurrencyDropdownWidget(),
          IconButton(
            icon: Icon(Icons.settings_outlined, color: colors.textSecondary.withOpacity(0.5)),
            onPressed: () => context.push('/settings'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
        physics: const BouncingScrollPhysics(),
        children: [
          // ── USER PROFILE PREVIEW ───────────────────────────
          _buildProfilePreview(context, user, colors),
          SizedBox(height: 32),
          
          // ── NEURAL INTELLIGENCE (AI HUB) ──────────────────────
          _SectionHeader('mobile.profile.neuralIntelligence'.tr(), colors),
          _MenuGroup(colors: colors, items: [
            _MenuEntry(
              icon: Icons.auto_awesome_outlined,
              label: 'mobile.profile.bookingCenter'.tr(),
              subtitle: 'mobile.profile.bookingCenterDesc'.tr(),
              color: Colors.purple,
              route: '/booking-center',
              isNew: true,
            ),
            _MenuEntry(
              icon: Icons.radar,
              label: 'mobile.profile.marketIntel'.tr(),
              subtitle: 'mobile.profile.marketIntelDesc'.tr(),
              color: Colors.orange,
              route: '/market-intel',
            ),
            _MenuEntry(
              icon: Icons.psychology_alt_rounded,
              label: 'mobile.profile.aiValuation'.tr(),
              subtitle: 'mobile.profile.aiValuationDesc'.tr(),
              color: Colors.green,
              route: '/ai-studio',
            ),
            _MenuEntry(
              icon: Icons.public_outlined,
              label: 'Global Rental OS',
              subtitle: '23 Countries · Revenue DAG · Neural Swarm',
              color: const Color(0xFF10B981),
              route: '/global-rental-os',
              isNew: true,
            ),
          ]).animate().fadeIn(duration: 400.ms),

          // ── AGENCY OPERATIONS (ROLE-BASED) ───────────────────
          if (isAgent) ...[
            _SectionHeader('mobile.profile.agencyOperations'.tr(), colors),
            _MenuGroup(colors: colors, items: [
              _MenuEntry(
                icon: Icons.dashboard_customize_outlined,
                label: 'mobile.profile.adminDashboard'.tr(),
                subtitle: 'mobile.profile.adminDashboardDesc'.tr(),
                color: Colors.purpleAccent,
                route: '/dashboard',
              ),
              _MenuEntry(
                icon: Icons.business_center_outlined,
                label: 'mobile.profile.listingManagement'.tr(),
                subtitle: 'mobile.profile.listingManagementDesc'.tr(),
                color: AppColors.primary,
                route: '/listings',
              ),
              _MenuEntry(
                icon: Icons.people_outline,
                label: 'mobile.profile.leadManagement'.tr(),
                subtitle: 'mobile.profile.leadManagementDesc'.tr(),
                color: Colors.blue,
                route: '/leads',
              ),
              _MenuEntry(
                icon: Icons.today_rounded,
                label: 'mobile.profile.propertyViewings'.tr(),
                subtitle: 'mobile.profile.propertyViewingsDesc'.tr(),
                color: Colors.amber,
                route: '/viewings',
              ),
              _MenuEntry(
                icon: Icons.insights_rounded,
                label: 'mobile.profile.corporateAnalytics'.tr(),
                subtitle: 'mobile.profile.corporateAnalyticsDesc'.tr(),
                color: Colors.green,
                route: '/analytics',
              ),
              _MenuEntry(
                icon: Icons.payments_outlined,
                label: 'mobile.profile.financials'.tr(),
                subtitle: 'mobile.profile.financialsDesc'.tr(),
                color: AppColors.success,
                route: '/financial',
              ),
            ]).animate().fadeIn(duration: 400.ms, delay: 100.ms),
          ],

          // ── SYSTEM ADMINISTRATION (ADMIN-ONLY) ───────────────
          if (isAdmin) ...[
            _SectionHeader('mobile.profile.systemAdmin'.tr(), colors),
            _MenuGroup(colors: colors, items: [
              _MenuEntry(
                icon: Icons.admin_panel_settings_rounded,
                label: 'mobile.profile.adminModules'.tr(),
                subtitle: 'mobile.profile.adminModulesDesc'.tr(),
                color: Colors.redAccent,
                route: '/admin-hub',
              ),
            ]).animate().fadeIn(duration: 400.ms, delay: 120.ms),
          ],


          // ── CORE TOOLS ───────────────────────────────────────
          _SectionHeader('mobile.profile.coreWorkspace'.tr(), colors),
          _MenuGroup(colors: colors, items: [
            _MenuEntry(
              icon: Icons.home_outlined,
              label: 'mobile.profile.myProperties'.tr(),
              subtitle: 'mobile.profile.myPropertiesDesc'.tr(),
              color: colors.textPrimary.withOpacity(0.7),
              route: '/properties',
            ),
            _MenuEntry(
              icon: Icons.calendar_today_outlined,
              label: 'mobile.profile.dynamicCalendar'.tr(),
              subtitle: 'mobile.profile.dynamicCalendarDesc'.tr(),
              color: colors.textPrimary.withOpacity(0.7),
              route: '/calendar',
            ),
            _MenuEntry(
              icon: Icons.description_outlined,
              label: 'mobile.profile.documents'.tr(),
              subtitle: 'mobile.profile.documentsDesc'.tr(),
              color: colors.textPrimary.withOpacity(0.7),
              route: '/files',
            ),
          ]).animate().fadeIn(duration: 400.ms, delay: 150.ms),

          // ── SYSTEM & SUPPORT ─────────────────────────────────
          _SectionHeader('mobile.profile.system'.tr(), colors),
          _MenuGroup(colors: colors, items: [
            _MenuEntry(
              icon: Icons.help_outline,
              label: 'mobile.profile.supportCenter'.tr(),
              subtitle: 'mobile.profile.supportCenterDesc'.tr(),
              color: colors.textSecondary.withOpacity(0.5),
              route: '/support',
            ),
            _MenuEntry(
              icon: Icons.policy_outlined,
              label: 'mobile.profile.privacyPolicy'.tr(),
              subtitle: 'mobile.profile.privacyPolicyDesc'.tr(),
              color: colors.textSecondary.withOpacity(0.5),
              route: '/privacy',
            ),
            _MenuEntry(
              icon: Icons.gavel_rounded,
              label: 'mobile.profile.termsOfService'.tr(),
              subtitle: 'mobile.profile.termsOfServiceDesc'.tr(),
              color: colors.textSecondary.withOpacity(0.5),
              route: '/terms',
            ),
          ]).animate().fadeIn(duration: 400.ms, delay: 200.ms).slideY(begin: 0.1, end: 0),

          const SizedBox(height: 48),
          
          // ── LOGOUT ──────────────────────────────────────────
          _MenuTile(
            colors: colors,
            isFirst: true, 
            isLast: true, 
            entry: _MenuEntry(
              icon: Icons.logout_rounded,
              label: 'mobile.profile.signOut'.tr(),
              subtitle: 'mobile.profile.signOutDesc'.tr(),
              color: Colors.red.withOpacity(0.8),
              route: '/logout',
              onTap: () async {
                await ref.read(authProvider.notifier).logout();
                if (context.mounted) context.go('/welcome');
              },
            ),
          ),

          const SizedBox(height: 32),
          _buildFooter(colors),
        ],
      ),
    );
  }

  Widget _buildProfilePreview(BuildContext context, dynamic user, ThemeAwareColors colors) {
    return GestureDetector(
      onTap: () => context.push('/profile'),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: colors.border),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: const Icon(Icons.person, color: AppColors.primary, size: 32),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? 'mobile.profile.guestUser'.tr(),
                    style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 4),
                  Text(
                    (user?.role ?? 'mobile.profile.tenant'.tr()).toUpperCase(),
                    style: GoogleFonts.outfit(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: colors.textSecondary.withOpacity(0.05), shape: BoxShape.circle),
              child: Icon(Icons.chevron_right_rounded, color: colors.textSecondary.withOpacity(0.3)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(ThemeAwareColors colors) {
    return Center(
      child: Column(
        children: [
          Text('mobile.auto.reservatior'.tr(),
            style: GoogleFonts.outfit(
              color: colors.textSecondary.withOpacity(0.2),
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'mobile.profile.versionInfo'.tr(),
            style: TextStyle(color: colors.textSecondary.withOpacity(0.1), fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  final ThemeAwareColors colors;
  const _SectionHeader(this.text, this.colors);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 12, left: 8),
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.outfit(
          color: colors.textSecondary.withOpacity(0.4),
          fontSize: 9,
          fontWeight: FontWeight.w900,
          letterSpacing: 2.5,
        ),
      ),
    );
  }
}

class _MenuGroup extends StatelessWidget {
  final List<_MenuEntry> items;
  final ThemeAwareColors colors;
  const _MenuGroup({required this.items, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        children: items.asMap().entries.map((e) {
          final item = e.value;
          final isFirst = e.key == 0;
          final isLast = e.key == items.length - 1;
          return _MenuTile(entry: item, isFirst: isFirst, isLast: isLast, colors: colors);
        }).toList(),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final _MenuEntry entry;
  final bool isFirst;
  final bool isLast;
  final ThemeAwareColors colors;
  const _MenuTile({required this.entry, required this.isFirst, required this.isLast, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: entry.onTap ?? () => context.push(entry.route),
          borderRadius: BorderRadius.vertical(
            top: isFirst ? const Radius.circular(24) : Radius.zero,
            bottom: isLast ? const Radius.circular(24) : Radius.zero,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: entry.color.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(entry.icon, size: 22, color: entry.color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              entry.label,
                              style: GoogleFonts.outfit(
                                color: colors.textPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          if (entry.isNew) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text('mobile.profile.new'.tr(), style: const TextStyle(color: AppColors.primary, fontSize: 8, fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        entry.subtitle,
                        style: GoogleFonts.outfit(color: colors.textSecondary.withOpacity(0.5), fontSize: 11),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: colors.textSecondary.withOpacity(0.2), size: 20),
              ],
            ),
          ),
        ),
        if (!isLast)
          Divider(
            color: colors.border,
            height: 1,
            indent: 84,
          ),
      ],
    );
  }
}

class _MenuEntry {
  final IconData icon;
  final String label, subtitle, route;
  final Color color;
  final int? badge;
  final bool isNew;
  final VoidCallback? onTap;
  const _MenuEntry({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.route,
    this.badge,
    this.isNew = false,
    this.onTap,
  });
}