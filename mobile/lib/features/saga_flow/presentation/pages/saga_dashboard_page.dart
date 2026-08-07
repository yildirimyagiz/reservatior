import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

class SagaDashboardPage extends ConsumerWidget {
  const SagaDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
                  title: Text(
                    'saga_flow.title'.tr(),
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _SagaStatusCard(),
                const SizedBox(height: 24),
                _SagaModuleCard(
                  title: 'saga_flow.monitor'.tr(),
                  subtitle: 'saga_flow.monitor_sub'.tr(),
                  icon: Icons.monitor_heart,
                  color: AppColors.primary,
                  route: '/saga-monitor',
                  onTap: () => context.push('/saga-monitor'),
                ),
                const SizedBox(height: 12),
                _SagaModuleCard(
                  title: 'saga_flow.config'.tr(),
                  subtitle: 'saga_flow.config_sub'.tr(),
                  icon: Icons.settings,
                  color: AppColors.success,
                  route: '/saga-config',
                  onTap: () => context.push('/saga-config'),
                ),
                const SizedBox(height: 12),
                _SagaModuleCard(
                  title: 'saga_flow.history'.tr(),
                  subtitle: 'saga_flow.history_sub'.tr(),
                  icon: Icons.history,
                  color: AppColors.warning,
                  route: '/saga-history',
                  onTap: () => context.push('/saga-history'),
                ),
                const SizedBox(height: 24),
                _ActiveSagasCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SagaStatusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_tree, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'saga_flow.status'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _SagaMetric(
                  label: 'saga_flow.running'.tr(),
                  value: '12',
                  color: AppColors.success,
                  icon: Icons.play_circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SagaMetric(
                  label: 'saga_flow.pending'.tr(),
                  value: '8',
                  color: AppColors.warning,
                  icon: Icons.pending,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SagaMetric(
                  label: 'saga_flow.failed'.tr(),
                  value: '2',
                  color: AppColors.error,
                  icon: Icons.error,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SagaMetric(
                  label: 'saga_flow.completed'.tr(),
                  value: '156',
                  color: AppColors.info,
                  icon: Icons.check_circle,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY();
  }
}

class _SagaMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _SagaMetric({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SagaModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;
  final VoidCallback onTap;

  const _SagaModuleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.route,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cardBg.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white38,
              size: 16,
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideX();
  }
}

class _ActiveSagasCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.list_alt, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'saga_flow.active_sagas'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(3, (index) => _ActiveSagaItem(
            name: ['Booking Creation', 'Payment Processing', 'Commission Payout'][index],
            type: ['BOOKING', 'PAYMENT', 'COMMISSION'][index],
            progress: [0.75, 0.45, 0.90][index],
            status: ['running', 'running', 'running'][index],
          )),
        ],
      ),
    ).animate().fadeIn().slideY(delay: 200.ms);
  }
}

class _ActiveSagaItem extends StatelessWidget {
  final String name;
  final String type;
  final double progress;
  final String status;

  const _ActiveSagaItem({
    required this.name,
    required this.type,
    required this.progress,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final statusColors = {
      'running': AppColors.success,
      'pending': AppColors.warning,
      'failed': AppColors.error,
      'completed': AppColors.info,
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColors[status]!.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  type,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: statusColors[status],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.cardBg.withValues(alpha: 0.5),
                    valueColor: AlwaysStoppedAnimation<Color>(statusColors[status]!),
                    minHeight: 6,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${(progress * 100).toInt()}%',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
