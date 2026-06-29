import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class EscrowVaultPage extends ConsumerWidget {
  const EscrowVaultPage({super.key});

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
                    'finance.escrow.title'.tr(),
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
                _SummaryCard(
                  totalLocked: '\$2,450,000',
                  totalAccounts: 128,
                  pendingReleases: 14,
                  disputedAmount: '\$124,500',
                ),
                const SizedBox(height: 20),
                Text(
                  'finance.escrow.recent_transactions'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ...List.generate(8, (i) => _EscrowTransactionTile(
                  id: 'ESC-${2024000 + i}',
                  amount: '\$${(15000 + i * 3200).toStringAsFixed(0)}',
                  status: i < 2 ? 'Released' : i < 5 ? 'Held' : 'Pending',
                  date: '2026-06-${10 + i}',
                  party: i.isEven ? 'finance.escrow.property_purchase'.tr() : 'finance.escrow.rental_deposit'.tr(),
                )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String totalLocked;
  final int totalAccounts;
  final int pendingReleases;
  final String disputedAmount;

  const _SummaryCard({
    required this.totalLocked,
    required this.totalAccounts,
    required this.pendingReleases,
    required this.disputedAmount,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.account_balance, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                'finance.escrow.total_locked'.tr(),
                style: GoogleFonts.outfit(
                  color: AppColors.textSecondaryDark,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            totalLocked,
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.darkBorder),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(label: 'finance.escrow.total_accounts'.tr(), value: '$totalAccounts', icon: Icons.account_balance_wallet),
              _StatItem(label: 'finance.escrow.status_pending'.tr(), value: '$pendingReleases', icon: Icons.hourglass_empty),
              _StatItem(label: 'finance.escrow.disputed_amount'.tr(), value: disputedAmount, icon: Icons.warning_amber),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatItem({required this.label, required this.value, required this.icon});

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
          style: GoogleFonts.outfit(
            color: AppColors.textSecondaryDark,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _EscrowTransactionTile extends StatelessWidget {
  final String id;
  final String amount;
  final String status;
  final String date;
  final String party;

  const _EscrowTransactionTile({
    required this.id,
    required this.amount,
    required this.status,
    required this.date,
    required this.party,
  });

  Color _statusColor() {
    switch (status) {
      case 'Released':
        return AppColors.success;
      case 'Held':
        return AppColors.warning;
      case 'Pending':
        return AppColors.info;
      default:
        return AppColors.textSecondaryDark;
    }
  }

  String get _translatedStatus {
    switch (status) {
      case 'Released':
        return 'finance.escrow.released'.tr();
      case 'Held':
        return 'finance.escrow.held'.tr();
      case 'Pending':
        return 'finance.escrow.status_pending'.tr();
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
            child: Icon(Icons.swap_horiz, color: _statusColor(), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  party,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'finance.escrow.transaction_format'.tr(namedArgs: {'id': id, 'date': date}),
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
                  fontSize: 14,
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
