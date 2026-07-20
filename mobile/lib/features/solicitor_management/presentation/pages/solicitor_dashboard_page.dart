import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'solicitor_list_page.dart';

class SolicitorDashboardPage extends ConsumerWidget {
  const SolicitorDashboardPage({super.key});

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
                    'solicitor_management.title'.tr(),
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
                _SolicitorStatsCard(),
                const SizedBox(height: 24),
                _SolicitorModuleCard(
                  title: 'solicitor_management.all_solicitors'.tr(),
                  subtitle: 'solicitor_management.all_solicitors_sub'.tr(),
                  icon: Icons.people,
                  color: AppColors.primary,
                  route: '/solicitor-list',
                  onTap: () => context.push('/solicitor-list'),
                ),
                const SizedBox(height: 12),
                _SolicitorModuleCard(
                  title: 'solicitor_management.pending'.tr(),
                  subtitle: 'solicitor_management.pending_sub'.tr(),
                  icon: Icons.pending,
                  color: AppColors.warning,
                  route: '/solicitor-list?filter=pending',
                  onTap: () => context.push('/solicitor-list?filter=pending'),
                ),
                const SizedBox(height: 12),
                _SolicitorModuleCard(
                  title: 'solicitor_management.disputes'.tr(),
                  subtitle: 'solicitor_management.disputes_sub'.tr(),
                  icon: Icons.warning,
                  color: AppColors.error,
                  route: '/solicitor-list?filter=disputes',
                  onTap: () => context.push('/solicitor-list?filter=disputes'),
                ),
                const SizedBox(height: 24),
                _RecentSolicitorsCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SolicitorStatsCard extends StatelessWidget {
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
              Icon(Icons.scale, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'solicitor_management.stats'.tr(),
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
                child: _SolicitorMetric(
                  label: 'solicitor_management.total'.tr(),
                  value: '24',
                  color: AppColors.primary,
                  icon: Icons.people,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SolicitorMetric(
                  label: 'solicitor_management.verified'.tr(),
                  value: '18',
                  color: AppColors.success,
                  icon: Icons.verified,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SolicitorMetric(
                  label: 'solicitor_management.engaged'.tr(),
                  value: '4',
                  color: AppColors.warning,
                  icon: Icons.handshake,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SolicitorMetric(
                  label: 'solicitor_management.disputes'.tr(),
                  value: '2',
                  color: AppColors.error,
                  icon: Icons.warning,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY();
  }
}

class _SolicitorMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _SolicitorMetric({
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

class _SolicitorModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;
  final VoidCallback onTap;

  const _SolicitorModuleCard({
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

class _RecentSolicitorsCard extends StatelessWidget {
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
              Icon(Icons.history, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'solicitor_management.recent'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(3, (index) => _RecentSolicitorItem(
            name: ['John Smith', 'Sarah Brown', 'Mike Wilson'][index],
            firm: ['Smith & Co Legal', 'Brown & Partners', 'Wilson Legal Services'][index],
            type: ['TENANT_INTERNATIONAL_LAWYER', 'LOCAL_LEGAL_COUNSEL', 'LANDLORD_REPRESENTATIVE'][index],
            status: ['VERIFIED', 'ENGAGED', 'DISPUTE_OPEN'][index],
          )),
        ],
      ),
    ).animate().fadeIn().slideY(delay: 200.ms);
  }
}

class _RecentSolicitorItem extends StatelessWidget {
  final String name;
  final String firm;
  final String type;
  final String status;

  const _RecentSolicitorItem({
    required this.name,
    required this.firm,
    required this.type,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final statusColors = {
      'VERIFIED': AppColors.success,
      'ENGAGED': AppColors.warning,
      'DISPUTE_OPEN': AppColors.error,
      'COMPLETED': AppColors.info,
      'TERMINATED': AppColors.error,
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.person, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  firm,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColors[status]!.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: statusColors[status],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
