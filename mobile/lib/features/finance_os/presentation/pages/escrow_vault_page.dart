import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/enums/escrow_status.dart';
import 'package:reservatior/shared/providers/escrow_account_provider.dart';
import 'package:reservatior/features/os_dashboards/presentation/os_live_widgets.dart';

class EscrowVaultPage extends ConsumerWidget {
  const EscrowVaultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(escrowAccountListProvider);
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
                accountsAsync.when(
                  loading: () => const OsLiveLoading(),
                  error: (e, _) => OsLiveErrorCard(message: 'Failed to load escrow accounts: $e'),
                  data: (accounts) {
                    final locked = accounts.where((a) => a.status == EscrowStatus.HOLDING || a.status == EscrowStatus.PARTIALLY_RELEASED).fold<double>(0, (s, a) => s + a.totalAmount);
                    final disputed = accounts.where((a) => a.status == EscrowStatus.DISPUTED).fold<double>(0, (s, a) => s + a.totalAmount);
                    return _SummaryCard(
                      totalLocked: r'$' + _fmtAmount(locked),
                      totalAccounts: accounts.length,
                      pendingReleases: accounts.where((a) => a.status == EscrowStatus.PARTIALLY_RELEASED).length,
                      disputedAmount: r'$' + _fmtAmount(disputed),
                    );
                  },
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
                ...accountsAsync.when(
                  loading: () => [const OsLiveLoading()],
                  error: (e, _) => [OsLiveErrorCard(message: 'Failed to load escrow accounts: $e')],
                  data: (accounts) => accounts.take(8).map((a) => _EscrowTransactionTile(
                    id: a.id.toUpperCase().startsWith('ESC-') ? a.id : 'ESC-${a.id.substring(0, a.id.length.clamp(0, 6))}',
                    amount: r'$' + a.totalAmount.toStringAsFixed(0),
                    status: a.status,
                    date: a.heldAt.toIso8601String().substring(0, 10),
                    party: a.reservationId,
                  )).toList(),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

String _fmtAmount(double v) {
  if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
  if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}K';
  return v.toStringAsFixed(0);
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
  final EscrowStatus status;
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
      case EscrowStatus.FULLY_RELEASED:
        return AppColors.success;
      case EscrowStatus.HOLDING:
        return AppColors.warning;
      case EscrowStatus.PARTIALLY_RELEASED:
        return AppColors.info;
      case EscrowStatus.DISPUTED:
      case EscrowStatus.CANCELLED:
        return AppColors.error;
      default:
        return AppColors.textSecondaryDark;
    }
  }

  String get _translatedStatus {
    switch (status) {
      case EscrowStatus.FULLY_RELEASED:
        return 'finance.escrow.released'.tr();
      case EscrowStatus.HOLDING:
        return 'finance.escrow.held'.tr();
      case EscrowStatus.PARTIALLY_RELEASED:
        return 'finance.escrow.status_pending'.tr();
      default:
        return status.name;
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
    ).animate().fadeIn(delay: const Duration(milliseconds: 50));
  }
}
