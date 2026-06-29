import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class PayoutPage extends ConsumerWidget {
  const PayoutPage({super.key});

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
                    'finance.payout.title'.tr(),
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _PayoutSummaryCard(
                pendingAmount: '\$187,400',
                processingCount: 14,
                completedThisMonth: 89,
                totalPaid: '\$1,240,000',
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'finance.payout.scheduled'.tr(),
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list, size: 18),
                      label: Text(
                        'finance.payout.filter'.tr(),
                        style: GoogleFonts.outfit(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...List.generate(10, (i) => _PayoutTile(
                  recipient: i.isEven ? 'John Smith (Agent)' : 'ABC Property Management',
                  amount: '\$${(12400 + i * 3400).toStringAsFixed(0)}',
                  status: i < 3 ? 'Pending' : i < 6 ? 'Processing' : 'Completed',
                  date: '2026-06-${20 + i}',
                  method: i.isEven ? 'finance.payout.bank_transfer'.tr() : 'finance.payout.card'.tr(),
                )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _PayoutSummaryCard extends StatelessWidget {
  final String pendingAmount;
  final int processingCount;
  final int completedThisMonth;
  final String totalPaid;

  const _PayoutSummaryCard({
    required this.pendingAmount,
    required this.processingCount,
    required this.completedThisMonth,
    required this.totalPaid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'finance.payout.pending_amount'.tr(),
                style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 13),
              ),
              Text(
                pendingAmount,
                style: GoogleFonts.outfit(
                  color: AppColors.warning,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.darkBorder),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _PayoutStat(label: 'finance.payout.processing'.tr(), value: '$processingCount', icon: Icons.sync),
              _PayoutStat(label: 'finance.payout.completed'.tr(), value: '$completedThisMonth', icon: Icons.check_circle),
              _PayoutStat(label: 'finance.payout.total_paid'.tr(), value: totalPaid, icon: Icons.payments),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

class _PayoutStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _PayoutStat({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 11),
        ),
      ],
    );
  }
}

class _PayoutTile extends StatelessWidget {
  final String recipient;
  final String amount;
  final String status;
  final String date;
  final String method;

  const _PayoutTile({
    required this.recipient,
    required this.amount,
    required this.status,
    required this.date,
    required this.method,
  });

  Color _statusColor() {
    switch (status) {
      case 'Completed':
        return AppColors.success;
      case 'Processing':
        return AppColors.info;
      case 'Pending':
        return AppColors.warning;
      default:
        return AppColors.textSecondaryDark;
    }
  }

  String get _translatedStatus {
    switch (status) {
      case 'Pending':
        return 'finance.payout.status_pending'.tr();
      case 'Processing':
        return 'finance.payout.status_processing'.tr();
      case 'Completed':
        return 'finance.payout.status_completed'.tr();
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _statusColor().withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.account_balance, color: _statusColor(), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipient,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$date • $method',
                  style: GoogleFonts.outfit(
                    color: AppColors.textSecondaryDark,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _statusColor().withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _translatedStatus,
                  style: GoogleFonts.outfit(
                    color: _statusColor(),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 50));
  }
}
