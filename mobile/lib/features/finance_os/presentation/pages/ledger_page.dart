import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class LedgerPage extends ConsumerWidget {
  const LedgerPage({super.key});

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
                    'finance.ledger.title'.tr(),
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
              child: _LedgerSummaryRow(
                totalCredits: '\$4,230,000',
                totalDebits: '\$3,890,000',
                netBalance: '\$340,000',
                entryCount: 1248,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                Text(
                  'finance.ledger.recent_entries'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ...List.generate(12, (i) => _LedgerEntryTile(
                  description: i.isEven ? 'Commission Payout - Listing #${2400 + i}' : 'Escrow Release - Deposit #${1800 + i}',
                  amount: '\$${(8500 + i * 1200).toStringAsFixed(0)}',
                  type: i.isEven ? 'Credit' : 'Debit',
                  date: '2026-06-${15 + i}',
                  category: i % 3 == 0 ? 'finance.ledger.commission_cat'.tr() : i % 3 == 1 ? 'finance.ledger.escrow_cat'.tr() : 'finance.ledger.fee_cat'.tr(),
                )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _LedgerSummaryRow extends StatelessWidget {
  final String totalCredits;
  final String totalDebits;
  final String netBalance;
  final int entryCount;

  const _LedgerSummaryRow({
    required this.totalCredits,
    required this.totalDebits,
    required this.netBalance,
    required this.entryCount,
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
              _LedgerStat(label: 'finance.ledger.total_credits'.tr(), value: totalCredits, color: AppColors.success),
              _LedgerStat(label: 'finance.ledger.total_debits'.tr(), value: totalDebits, color: AppColors.error),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.darkBorder),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'finance.ledger.net_balance'.tr(),
                style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 14),
              ),
              Text(
                netBalance,
                style: GoogleFonts.outfit(
                  color: AppColors.success,
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'finance.ledger.entries_period'.tr(namedArgs: {'count': '$entryCount'}),
                style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

class _LedgerStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _LedgerStat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.outfit(
            color: color,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

class _LedgerEntryTile extends StatelessWidget {
  final String description;
  final String amount;
  final String type;
  final String date;
  final String category;

  const _LedgerEntryTile({
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final isCredit = type == 'Credit';
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (isCredit ? AppColors.success : AppColors.error).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isCredit ? Icons.arrow_upward : Icons.arrow_downward,
              color: isCredit ? AppColors.success : AppColors.error,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        category,
                        style: GoogleFonts.outfit(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      date,
                      style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '$amount',
            style: GoogleFonts.outfit(
              color: isCredit ? AppColors.success : AppColors.error,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 40));
  }
}
