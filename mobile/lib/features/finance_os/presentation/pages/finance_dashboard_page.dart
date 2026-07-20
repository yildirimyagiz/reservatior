import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'escrow_vault_page.dart';
import 'ledger_page.dart';
import 'payout_page.dart';
import 'settlement_page.dart';

class FinanceDashboardPage extends ConsumerWidget {
  const FinanceDashboardPage({super.key});

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
                    'finance.os.title'.tr(),
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
                _MetricGrid(),
                const SizedBox(height: 24),
                _FinanceModuleCard(
                  title: 'finance.os.escrow_vault'.tr(),
                  subtitle: 'finance.os.escrow_locked'.tr(),
                  icon: Icons.account_balance,
                  color: AppColors.primary,
                  route: '/finance-escrow',
                  onTap: () => context.push('/finance-escrow'),
                ),
                const SizedBox(height: 12),
                _FinanceModuleCard(
                  title: 'finance.os.general_ledger'.tr(),
                  subtitle: 'finance.os.ledger_net'.tr(),
                  icon: Icons.book,
                  color: AppColors.success,
                  route: '/finance-ledger',
                  onTap: () => context.push('/finance-ledger'),
                ),
                const SizedBox(height: 12),
                _FinanceModuleCard(
                  title: 'finance.os.payouts'.tr(),
                  subtitle: 'finance.os.payouts_pending'.tr(),
                  icon: Icons.payments,
                  color: AppColors.warning,
                  route: '/finance-payouts',
                  onTap: () => context.push('/finance-payouts'),
                ),
                const SizedBox(height: 12),
                _FinanceModuleCard(
                  title: 'finance.os.settlements'.tr(),
                  subtitle: 'finance.os.settlements_active'.tr(),
                  icon: Icons.checklist,
                  color: AppColors.info,
                  route: '/finance-settlements',
                  onTap: () => context.push('/finance-settlements'),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'finance_os.kpi_title'.tr(),
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _FinanceMetric(
                  label: 'finance_os.total_revenue'.tr(),
                  value: '\$328K',
                  trend: '+12.5%',
                  color: AppColors.success,
                  icon: Icons.trending_up,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _FinanceMetric(
                  label: 'finance_os.total_expenses'.tr(),
                  value: '\$213K',
                  trend: '+8.3%',
                  color: AppColors.error,
                  icon: Icons.credit_card,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _FinanceMetric(
                  label: 'finance_os.net_profit'.tr(),
                  value: '\$115K',
                  trend: '+18.7%',
                  color: AppColors.primary,
                  icon: Icons.account_balance_wallet,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _FinanceMetric(
                  label: 'finance_os.pending_commissions'.tr(),
                  value: '\$41K',
                  trend: '4 pending',
                  color: AppColors.warning,
                  icon: Icons.payments,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY();
  }
}

class _FinanceMetric extends StatelessWidget {
  final String label;
  final String value;
  final String trend;
  final Color color;
  final IconData icon;

  const _FinanceMetric({
    required this.label,
    required this.value,
    required this.trend,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                    color: Colors.white70,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
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
          Row(
            children: [
              Icon(Icons.arrow_upward, size: 12, color: color),
              const SizedBox(width: 4),
              Text(
                trend,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FinanceModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;
  final VoidCallback onTap;

  const _FinanceModuleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.route,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.outfit(
                          color: AppColors.textSecondaryDark,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: AppColors.textSecondaryDark, size: 14),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.05);
  }
}
