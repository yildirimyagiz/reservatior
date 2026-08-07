import 'package:reservatior/features/admin/dynamic/dynamic_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/shared/providers/agent_provider.dart';
import 'package:reservatior/shared/providers/exchange_rate_provider.dart';
import 'package:reservatior/shared/providers/document_analysis_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/shared/providers/system_trigger_provider.dart';
import 'package:reservatior/shared/services/sse_trigger_service.dart';
import 'package:flutter_animate/flutter_animate.dart';


class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final triggerState = ref.watch(systemTriggerProvider);

    if (user == null) {
      return Scaffold(
        backgroundColor: colors.background,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(context, user, colors),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildClientKPIStats(context, colors),
                SizedBox(height: 32),

                _buildSectionHeader(
                  'mobile.dashboard.quickActions'.tr(),
                  Icons.grid_view_rounded,
                  colors,
                ),
                const SizedBox(height: 16),
                _buildQuickActions(context, colors),
                SizedBox(height: 32),

                _buildSectionHeader(
                  'mobile.dashboard.performanceSummary'.tr(),
                  Icons.area_chart_outlined,
                  colors,
                ),
                const SizedBox(height: 16),
                _buildRevenueChartCard(context, colors),
                SizedBox(height: 32),

                _buildSectionHeader(
                  'mobile.dashboard.intelligenceHub'.tr(),
                  Icons.auto_awesome_outlined,
                  colors,
                ),
                const SizedBox(height: 16),
                _buildActiveAiTasks(triggerState, colors),
                const SizedBox(height: 24),
                DocumentAnalysisQuickView(
                  orgId: user.organizationId ?? 'global',
                  colors: colors,
                ),
                SizedBox(height: 32),

                _buildSectionHeader(
                  'mobile.dashboard.recentActivity'.tr(),
                  Icons.history_toggle_off_rounded,
                  colors,
                ),
                const SizedBox(height: 16),
                _buildRecentActivity(colors),
                SizedBox(height: 32),

                _buildSectionHeader(
                  'mobile.dashboard.securityIntegrity'.tr(),
                  Icons.shield_outlined,
                  colors,
                ),
                const SizedBox(height: 16),
                _buildComplianceSecurity(context, colors),
                const SizedBox(height: 120),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, dynamic user, ThemeAwareColors colors) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.12),
              Colors.transparent,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.white.withOpacity(0.05) 
                  : Colors.black.withOpacity(0.05),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/home');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.border),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: colors.textPrimary,
                      size: 20,
                    ),
                  ),
                ),
                Row(
                  children: [
                    _buildTopAction(Icons.search_rounded, () => context.push('/search'), colors),
                    const SizedBox(width: 12),
                    _buildTopAction(Icons.chat_bubble_outline_rounded, () => context.push('/messages'), colors),
                    const SizedBox(width: 12),
                    _buildTopAction(Icons.notifications_outlined, () => context.push('/notifications'), colors),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'mobile.dashboard.welcome'.tr(),
              style: GoogleFonts.outfit(
                color: colors.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              '${user.name ?? 'mobile.dashboard.agent'.tr()} ✨',
              style: GoogleFonts.outfit(
                color: colors.textPrimary,
                fontSize: 32,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'mobile.dashboard.summaryMessage'.tr(),
              style: GoogleFonts.outfit(
                color: colors.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClientKPIStats(BuildContext context, ThemeAwareColors colors) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildKPICard(
                context,
                'mobile.leftovers.total_revenue'.tr(),
                '\$42.5k',
                '+12.5%',
                Icons.account_balance_wallet_rounded,
                Colors.orange,
                colors,
                route: '/analytics',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildKPICard(
                context,
                'mobile.leftovers.active_listings'.tr(),
                '128',
                '+4.3%',
                Icons.business_rounded,
                Colors.blue,
                colors,
                route: '/listings',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildKPICard(
                context,
                'mobile.leftovers.new_leads'.tr(),
                '342',
                '-2.1%',
                Icons.people_outline_rounded,
                Colors.purple,
                colors,
                isDown: true,
                route: '/leads',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildKPICard(
                context,
                'mobile.leftovers.ai_verification'.tr(),
                '98.2%',
                '+0.5%',
                Icons.auto_awesome_rounded,
                Colors.amber,
                colors,
                route: '/ai-studio',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKPICard(
    BuildContext context,
    String title,
    String value,
    String change,
    IconData icon,
    MaterialColor iconColor,
    ThemeAwareColors colors, {
    bool isDown = false,
    String? route,
  }) {
    return InkWell(
      onTap: route != null ? () => context.push(route) : null,
      borderRadius: BorderRadius.circular(20),
      child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isDown
                      ? Colors.red.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      isDown ? Icons.arrow_downward : Icons.arrow_upward,
                      size: 12,
                      color: isDown ? Colors.red : Colors.green,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      change,
                      style: TextStyle(
                        color: isDown ? Colors.red : Colors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.outfit(
              color: colors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.outfit(
              color: colors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildRevenueChartCard(BuildContext context, ThemeAwareColors colors) {
    return InkWell(
      onTap: () => context.push('/analytics'),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('mobile.auto.revenue_analysis'.tr(),
                      style: GoogleFonts.outfit(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text('mobile.auto.weekly_cash_flow_and_forecasts'.tr(),
                      style: GoogleFonts.outfit(
                        color: colors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'mobile.dashboard.ai_analysis'.tr(),
                        style: GoogleFonts.outfit(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Placeholder for the area chart
            Center(
              child: Icon(
                Icons.show_chart_rounded,
                size: 48,
                color: colors.border,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopAction(IconData icon, VoidCallback onTap, ThemeAwareColors colors) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: colors.border),
        ),
        child: Icon(
          icon,
          color: colors.textPrimary,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, ThemeAwareColors colors) {
    final actions = [
      {'icon': Icons.home_work_rounded, 'label': 'Listings', 'route': '/listings', 'color': Colors.blue},
      {'icon': Icons.groups_rounded, 'label': 'CRM', 'route': '/leads', 'color': Colors.indigo},
      {'icon': Icons.calendar_month_rounded, 'label': 'Viewings', 'route': '/viewings', 'color': Colors.amber},
      {'icon': Icons.insights_rounded, 'label': 'Analytics', 'route': '/analytics', 'color': Colors.green},
      {'icon': Icons.psychology_alt_rounded, 'label': 'mobile.leftovers.ai_studio'.tr(), 'route': '/ai-studio', 'color': Colors.purple},
      {'icon': Icons.handshake_rounded, 'label': 'Deals', 'route': '/deals', 'color': Colors.blue},
      {'icon': Icons.calendar_today_rounded, 'label': 'Today', 'route': '/today', 'color': Colors.green},
      {'icon': Icons.description_rounded, 'label': 'Files', 'route': '/files', 'color': Colors.orange},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final action = actions[index];
        return InkWell(
          onTap: () => context.push(action['route'] as String),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (action['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  action['icon'] as IconData,
                  color: action['color'] as Color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                action['label'] as String,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  color: colors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(
    String title,
    IconData icon,
    ThemeAwareColors colors,
  ) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 14,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: GoogleFonts.outfit(
            color: colors.textPrimary.withOpacity(0.9),
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
  Widget _buildActiveAiTasks(SystemTriggerState triggerState, ThemeAwareColors colors) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              const Icon(Icons.psychology_outlined, color: AppColors.primary, size: 22),
              const SizedBox(width: 8),
              Text(
                'Yapay Zeka Operasyon Merkezi',
                style: GoogleFonts.outfit(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              // SSE Connection Status Dot
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: (triggerState.isOffline
                          ? Colors.red
                          : triggerState.isConnected
                              ? Colors.green
                              : Colors.amber)
                      .withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: triggerState.isOffline
                        ? Colors.red
                        : triggerState.isConnected
                            ? Colors.green
                            : Colors.amber,
                    shape: BoxShape.circle,
                  ),
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true)).fade(begin: 0.4, end: 1.0, duration: 1.seconds),
              if (triggerState.isOffline) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cloud_off, color: Colors.red, size: 11),
                      const SizedBox(width: 4),
                      Text(
                        'Çevrimdışı',
                        style: GoogleFonts.outfit(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${triggerState.tasks.length} Görev',
                  style: GoogleFonts.outfit(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Active Tasks List
          if (triggerState.isLoading && triggerState.tasks.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
            )
          else if (triggerState.tasks.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Icon(Icons.dns_outlined, color: colors.textSecondary.withOpacity(0.2), size: 36),
                    const SizedBox(height: 8),
                    Text(
                      'Şu an aktif bir arka plan görevi bulunmuyor.',
                      style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
            )
          else
            ...triggerState.tasks.asMap().entries.map((entry) {
              final task = entry.value;
              final index = entry.key;
              return Padding(
                padding: EdgeInsets.only(bottom: index == triggerState.tasks.length - 1 ? 0 : 16),
                child: _buildTaskProgress(task, colors),
              );
            }),

          // Divider and Live Event Stream
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Colors.white10),
          ),

          Row(
            children: [
              const Icon(Icons.sensors_rounded, color: Colors.blueAccent, size: 18),
              const SizedBox(width: 8),
              Text(
                'CANLI SİSTEM AKIŞI (SSE)',
                style: GoogleFonts.outfit(
                  color: colors.textPrimary.withOpacity(0.6),
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          if (triggerState.liveEvents.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: triggerState.isOffline ? Colors.red : Colors.white24,
                        shape: BoxShape.circle,
                      ),
                    ).animate(onPlay: (c) => c.repeat(reverse: true)).fade(begin: 0.3, end: 1.0, duration: 800.ms),
                    const SizedBox(width: 8),
                    Text(
                      triggerState.isOffline
                          ? 'Çevrimdışısınız — bağlantı kurulunca akış devam edecek'
                          : 'Canlı olay akışı bekleniyor...',
                      style: GoogleFonts.outfit(color: colors.textSecondary.withOpacity(0.5), fontSize: 11),
                    ),
                  ],
                ),
              ),
            )
          else
            ...triggerState.liveEvents.asMap().entries.map((entry) {
              final event = entry.value;
              return _buildLiveEventItem(event, colors);
            }),
        ],
      ),
    );
  }

  Widget _buildTaskProgress(TriggerTask task, ThemeAwareColors colors) {
    final progress = task.progress / 100.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: GoogleFonts.outfit(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    task.description,
                    style: GoogleFonts.outfit(
                      color: colors.textSecondary,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _getStatusBadge(task.status, colors),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 4,
                  backgroundColor: colors.background,
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${(progress * 100).toInt()}%',
              style: GoogleFonts.outfit(
                color: colors.textPrimary,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLiveEventItem(SseEvent event, ThemeAwareColors colors) {
    final details = _getLiveEventDetails(event.event);
    final String title = details['title'] as String;
    final IconData icon = details['icon'] as IconData;
    final Color color = details['color'] as Color;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Tetiklendi • ${event.timestamp.hour.toString().padLeft(2, '0')}:${event.timestamp.minute.toString().padLeft(2, '0')}:${event.timestamp.second.toString().padLeft(2, '0')}',
                  style: GoogleFonts.outfit(
                    color: colors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 4,
                  spreadRadius: 2,
                )
              ]
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1, 1), end: const Offset(1.5, 1.5), duration: 600.ms),
        ],
      ),
    ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.1);
  }

  Map<String, dynamic> _getLiveEventDetails(String eventName) {
    switch (eventName) {
      case 'LEASE_EXPIRY_APPROACHING':
        return {
          'title': 'Kira Yenileme Yaklaşıyor',
          'icon': Icons.access_time_rounded,
          'color': Colors.amber,
        };
      case 'RENT_PAYMENT_OVERDUE':
        return {
          'title': 'Gecikmiş Kira Tespiti',
          'icon': Icons.warning_amber_rounded,
          'color': Colors.red,
        };
      case 'TENANT_APPLICATION_APPROVED':
        return {
          'title': 'Akıllı Sözleşme Üretimi',
          'icon': Icons.file_copy_rounded,
          'color': Colors.blue,
        };
      case 'INVOICE_UPLOADED':
        return {
          'title': 'Fatura OCR & Bütçe Kontrolü',
          'icon': Icons.check_circle_outline_rounded,
          'color': Colors.green,
        };
      case 'QUARTERLY_TAX_REVIEW':
        return {
          'title': 'Çeyreklik Vergi Taraması',
          'icon': Icons.analytics_rounded,
          'color': Colors.purple,
        };
      case 'SECURITY_INCIDENT_CREATED':
        return {
          'title': 'Güvenlik İhlali Bildirimi',
          'icon': Icons.shield_rounded,
          'color': Colors.red,
        };
      case 'DOCUMENT_EXPIRED':
        return {
          'title': 'Belge Süresi Doldu',
          'icon': Icons.warning_rounded,
          'color': Colors.orange,
        };
      case 'VIEWING_COMPLETED':
        return {
          'title': 'Gösterim Geri Bildirim Analizi',
          'icon': Icons.auto_awesome_rounded,
          'color': Colors.cyan,
        };
      default:
        return {
          'title': 'Sistem Olayı: $eventName',
          'icon': Icons.sensors_rounded,
          'color': Colors.grey,
        };
    }
  }

  Widget _getStatusBadge(String status, ThemeAwareColors colors) {
    Color bg;
    Color text;
    String label;

    switch (status) {
      case 'PENDING':
      case 'QUEUED':
        bg = Colors.grey.withOpacity(0.1);
        text = Colors.grey;
        label = 'KUYRUKTA';
        break;
      case 'IN_PROGRESS':
      case 'PROCESSING':
      case 'RUNNING':
        bg = Colors.blue.withOpacity(0.1);
        text = Colors.blue;
        label = 'İŞLENİYOR';
        break;
      case 'FULFILLED':
      case 'COMPLETED':
        bg = Colors.green.withOpacity(0.1);
        text = Colors.green;
        label = 'TAMAMLANDI';
        break;
      case 'FAILED':
        bg = Colors.red.withOpacity(0.1);
        text = Colors.red;
        label = 'HATA';
        break;
      default:
        bg = Colors.grey.withOpacity(0.1);
        text = Colors.grey;
        label = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          color: text,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRecentActivity(ThemeAwareColors colors) {
    final activities = [
      {'title': 'mobile.leftovers.lead_follow_up_sarah_j'.tr(), 'time': '12:30', 'status': 'PENDING', 'icon': Icons.person_add_alt_1_rounded},
      {'title': 'mobile.leftovers.escrow_release_8921'.tr(), 'time': '11:45', 'status': 'COMPLETED', 'icon': Icons.payments_rounded},
      {'title': 'mobile.leftovers.viewing_scheduled_villa_sunset'.tr(), 'time': '10:20', 'status': 'CONFIRMED', 'icon': Icons.calendar_today_rounded},
    ];

    return Column(
      children: activities.map((a) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(a['icon'] as IconData, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a['title'] as String,
                    style: GoogleFonts.outfit(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Today, ${a['time']}',
                    style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 11),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                a['status'] as String,
                style: GoogleFonts.outfit(
                  color: colors.textSecondary,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildComplianceSecurity(BuildContext context, ThemeAwareColors colors) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        children: [
          _buildComplianceItem('mobile.leftovers.kvkk_compliance'.tr(), 1.0, Colors.greenAccent, colors),
          const SizedBox(height: 20),
          _buildComplianceItem(
            'mobile.leftovers.escrow_health'.tr(),
            0.85,
            Colors.blueAccent,
            colors,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DynamicAdminScreen(modelName: 'EscrowOverview')),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text('mobile.auto.annual_insurance_renewal_required_for_3_properties'.tr(),
                    style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceItem(
    String label,
    double value,
    Color color,
    ThemeAwareColors colors, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.outfit(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${(value * 100).toInt()}%',
                    style: GoogleFonts.outfit(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  if (onTap != null)
                    Icon(Icons.chevron_right, size: 14, color: color),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 6,
              backgroundColor: colors.background,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      ),
    );
  }
}

class AgentPerformanceStats extends ConsumerWidget {
  final String agentId;
  final ThemeAwareColors colors;
  const AgentPerformanceStats({
    super.key,
    required this.agentId,
    required this.colors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final perf = ref.watch(agentPerformanceProvider(agentId));

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
        boxShadow: ref.watch(themeModeProvider) == ThemeMode.dark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('mobile.auto.efficiency_score'.tr(),
                    style: GoogleFonts.outfit(
                      color: colors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  perf.when(
                    data: (data) {
                      final val = data.isNotEmpty ? (data[0]['value'] ?? 0) : 0;
                      return Text(
                        '$val%',
                        style: GoogleFonts.outfit(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      );
                    },
                    loading: () => Text(
                      '...',
                      style: TextStyle(fontSize: 32, color: colors.textPrimary),
                    ),
                    error: (_, __) => Text('mobile.auto.n_a'.tr(),
                      style: TextStyle(fontSize: 32, color: colors.textPrimary),
                    ),
                  ),
                ],
              ),
              const Icon(Icons.bolt, color: AppColors.primary, size: 32),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.72,
              minHeight: 6,
              backgroundColor: colors.background,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.history,
                color: colors.textSecondary.withOpacity(0.5),
                size: 12,
              ),
              SizedBox(width: 4),
              Text('mobile.auto.updated_2_minutes_ago'.tr(),
                style: GoogleFonts.outfit(
                  color: colors.textSecondary.withOpacity(0.5),
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ExchangeRateOverview extends ConsumerWidget {
  final ThemeAwareColors colors;
  const ExchangeRateOverview({super.key, required this.colors});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rate = ref.watch(
      exchangeRateLatestProvider((base: 'USD', quote: 'EUR')),
    );

    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            'mobile.leftovers.usd_eur'.tr(),
            rate.when(
              data: (r) => r.rate.toStringAsFixed(4),
              loading: () => '...',
              error: (_, __) => '---',
            ),
            Icons.currency_exchange,
            Colors.blueAccent,
            colors,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            'mobile.leftovers.live_market'.tr(),
            'Active',
            Icons.sensors,
            Colors.greenAccent,
            colors,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String label,
    String value,
    IconData icon,
    Color color,
    ThemeAwareColors colors,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: GoogleFonts.outfit(
              color: colors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.outfit(
              color: colors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class DocumentAnalysisQuickView extends ConsumerWidget {
  final String orgId;
  final ThemeAwareColors colors;
  const DocumentAnalysisQuickView({
    super.key,
    required this.orgId,
    required this.colors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyses = ref.watch(documentAnalysisListProvider(orgId));

    return analyses.when(
      data: (data) {
        if (data.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('mobile.auto.no_analyzed_documents_found_for_your_organization'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.textSecondary),
              ),
            ),
          );
        }
        return Column(
          children: data
              .take(5)
              .map(
                (a) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.border),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: colors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.description_outlined,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                    title: Text(
                      a.documentName ?? 'mobile.leftovers.untitled_analysis'.tr(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        color: colors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Icon(
                          Icons.verified_outlined,
                          size: 14,
                          color: (a.confidence ?? 0) > 0.8
                              ? Colors.greenAccent
                              : Colors.orangeAccent,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Score: ${((a.confidence ?? 0) * 100).toStringAsFixed(0)}%',
                          style: GoogleFonts.outfit(
                            color: (a.confidence ?? 0) > 0.8
                                ? Colors.greenAccent
                                : Colors.orangeAccent,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: colors.textSecondary.withOpacity(0.5),
                      size: 20,
                    ),
                    onTap: () {},
                  ),
                ),
              )
              .toList(),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      error: (e, __) => Text(
        'System connection error: $e',
        style: const TextStyle(color: Colors.redAccent, fontSize: 12),
      ),
    );
  }

}
