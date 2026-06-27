import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/features/client/financial/providers/financial_providers.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    final walletAsyncValue = ref.watch(walletProvider);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: colors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'mobile.finance.globalWallet'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: walletAsyncValue.when(
        data: (wallet) => _buildWalletContent(wallet, colors, context),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error loading wallet: $error', style: TextStyle(color: colors.textPrimary))),
      ),
    );
  }

  Widget _buildWalletContent(Map<String, dynamic> wallet, ThemeAwareColors colors, BuildContext context) {
    final balance = wallet['balance'] ?? 0.0;
    final currency = wallet['currency'] ?? 'USD';
    final coupons = (wallet['coupons'] as List?) ?? [];
    final history = (wallet['history'] as List?) ?? [];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildBalanceCard(balance, currency, colors),
        const SizedBox(height: 32),
        Text(
          'mobile.finance.activeCoupons'.tr(),
          style: GoogleFonts.outfit(
            color: colors.textPrimary.withOpacity(0.4),
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        if (coupons.isEmpty)
          Center(child: Text('mobile.finance.no_coupons'.tr(), style: GoogleFonts.outfit(color: colors.textSecondary))),
        ...coupons.map((coupon) => _buildCouponCard(coupon, currency, colors)).toList(),
        
        const SizedBox(height: 32),
        Text(
          'mobile.finance.recentTransactions'.tr(),
          style: GoogleFonts.outfit(
            color: colors.textPrimary.withOpacity(0.4),
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        ...history.map((tx) => _buildTransactionCard(tx, currency, colors)).toList(),
      ],
    );
  }

  Widget _buildBalanceCard(double balance, String currency, ThemeAwareColors colors) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet_rounded, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'mobile.finance.availableBalance'.tr(),
                style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                balance.toStringAsFixed(2),
                style: GoogleFonts.outfit(
                  color: colors.textPrimary,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                currency,
                style: GoogleFonts.outfit(
                  color: colors.textPrimary.withOpacity(0.6),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildCouponCard(Map<String, dynamic> coupon, String defaultCurrency, ThemeAwareColors colors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      coupon['code'] ?? '',
                      style: GoogleFonts.outfit(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      coupon['region'] ?? 'GLOBAL',
                      style: GoogleFonts.outfit(color: Colors.orangeAccent, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                coupon['type'] == 'PERCENTAGE' 
                    ? '${coupon['discount']}% OFF'
                    : '${coupon['discount']} $defaultCurrency OFF',
                style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 12),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'mobile.finance.expires'.tr(),
                style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                coupon['expiresAt'] != null ? coupon['expiresAt'].toString().split(' ')[0] : '',
                style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1);
  }

  Widget _buildTransactionCard(Map<String, dynamic> tx, String currency, ThemeAwareColors colors) {
    final isCredit = tx['type'] == 'CREDIT';
    final amountColor = isCredit ? Colors.greenAccent : colors.textPrimary;
    final prefix = isCredit ? '+' : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isCredit ? Colors.greenAccent.withOpacity(0.1) : Colors.redAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isCredit ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded, 
              color: isCredit ? Colors.greenAccent : Colors.redAccent, 
              size: 16
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx['description'] ?? 'Transaction',
                  style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  tx['date'] != null ? tx['date'].toString().split(' ')[0] : '',
                  style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            '$prefix${tx['amount']} $currency',
            style: GoogleFonts.outfit(
              color: amountColor,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1);
  }
}
