import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class FinancialDashboardScreen extends ConsumerWidget {
  const FinancialDashboardScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text(
          'mobile.finance.title'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildBalanceCard(colors),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMiniCard(
                  'mobile.finance.income'.tr(),
                  '\$28,450',
                  Icons.trending_up_rounded,
                  Colors.green,
                  colors,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildMiniCard(
                  'mobile.finance.expenses'.tr(),
                  '\$8,230',
                  Icons.trending_down_rounded,
                  Colors.red,
                  colors,
                ),
              ),
            ],
          ).animate().fadeIn(delay: 100.ms),
          SizedBox(height: 24),
          Text(
            'mobile.finance.recentTx'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._transactions.asMap().entries.map(
            (e) => _buildTransactionRow(e.value, colors, e.key),
          ),
          const SizedBox(height: 24),
          _buildQuickActions(colors),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(ThemeAwareColors colors) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'mobile.finance.totalBalance'.tr(),
            style: GoogleFonts.outfit(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            '\$142,580.00',
            style: GoogleFonts.outfit(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_upward,
                      size: 14,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'mobile.finance.balanceChange'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildMiniCard(
    String title,
    String value,
    IconData icon,
    Color color,
    ThemeAwareColors colors,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(color: colors.textSecondary, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionRow(
    Map<String, dynamic> tx,
    ThemeAwareColors colors,
    int idx,
  ) {
    final isIncome = tx['amount'] > 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (tx['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              tx['icon'] as IconData,
              color: tx['color'] as Color,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx['title'] as String,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                    fontSize: 14,
                  ),
                ),
                Text(
                  tx['date'] as String,
                  style: TextStyle(color: colors.textSecondary, fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            '${isIncome ? "+" : ""}\$${(tx['amount'] as num).abs().toStringAsFixed(0)}',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w700,
              color: isIncome ? Colors.green : Colors.red,
              fontSize: 15,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 50 * idx)).slideX(begin: 0.03);
  }

  Widget _buildQuickActions(ThemeAwareColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'mobile.finance.quickActions'.tr(),
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildAction(
                'mobile.finance.invoice'.tr(),
                Icons.receipt_long_rounded,
                Colors.blue,
                colors,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildAction(
                'mobile.finance.budget'.tr(),
                Icons.account_balance_wallet_rounded,
                Colors.green,
                colors,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildAction(
                'mobile.finance.reports'.tr(),
                Icons.bar_chart_rounded,
                Colors.purple,
                colors,
              ),
            ),
          ],
        ).animate().fadeIn(delay: 300.ms),
      ],
    );
  }

  Widget _buildAction(
    String label,
    IconData icon,
    Color color,
    ThemeAwareColors colors,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  static final _transactions = [
    {
      'title': 'mobile.finance.tx1'.tr(),
      'date': 'mobile.finance.date1'.tr(),
      'amount': 3500,
      'icon': Icons.home_rounded,
      'color': Colors.green,
    },
    {
      'title': 'mobile.finance.tx2'.tr(),
      'date': 'mobile.finance.date2'.tr(),
      'amount': -450,
      'icon': Icons.build_rounded,
      'color': Colors.orange,
    },
    {
      'title': 'mobile.finance.tx3'.tr(),
      'date': 'mobile.finance.date3'.tr(),
      'amount': 12500,
      'icon': Icons.handshake_rounded,
      'color': Colors.blue,
    },
    {
      'title': 'mobile.finance.tx4'.tr(),
      'date': 'mobile.finance.date4'.tr(),
      'amount': -1200,
      'icon': Icons.shield_rounded,
      'color': Colors.red,
    },
    {
      'title': 'mobile.finance.tx5'.tr(),
      'date': 'mobile.finance.date5'.tr(),
      'amount': 2800,
      'icon': Icons.event_available_rounded,
      'color': Colors.teal,
    },
  ];
}
