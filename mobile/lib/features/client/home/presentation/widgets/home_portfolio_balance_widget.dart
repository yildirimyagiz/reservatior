import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:reservatior/shared/providers/dashboard_summary_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePortfolioBalanceWidget extends ConsumerWidget {
  const HomePortfolioBalanceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(dashboardSummaryProvider);
    final formatCurrency = NumberFormat.currency(locale: 'tr_TR', symbol: '₺', decimalDigits: 0);

    return SliverToBoxAdapter(
      child: summaryAsync.when(
        data: (data) {
          final portfolioValue = data['portfolioValue'] ?? 0;
          final activeLeases = data['activeLeases'] ?? 0;
          final monthlyYield = data['monthlyYield'] ?? 0;
          final aiValuation = data['aiValuation'] ?? 0.0;

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(0xFF10B981).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xFF10B981).withOpacity(0.3)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.shield_rounded, color: Color(0xFF10B981), size: 12),
                                  SizedBox(width: 4),
                                  Text('mobile.auto.100_legal_escrow_shield'.tr(), style: GoogleFonts.outfit(color: Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ).animate().fadeIn(delay: 600.ms),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.account_balance_wallet_rounded, color: AppColors.primaryLight, size: 16),
                            SizedBox(width: 8),
                            Text('mobile.auto.total_portfolio_value'.tr(), style: GoogleFonts.outfit(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          formatCurrency.format(portfolioValue),
                          style: GoogleFonts.outfit(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900, letterSpacing: -1),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFF10B981).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.trending_up_rounded, color: Color(0xFF10B981), size: 28),
                    ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: -4, end: 4, duration: 2.seconds),
                  ],
                ),
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMiniStat('mobile.auto.active_leases'.tr(), activeLeases.toString(), Icons.key_rounded, Color(0xFF3B82F6)),
                      Container(width: 1, height: 30, color: Colors.white.withOpacity(0.1)),
                      _buildMiniStat('mobile.auto.monthly_yield'.tr(), formatCurrency.format(monthlyYield), Icons.payments_rounded, Color(0xFF10B981)),
                      Container(width: 1, height: 30, color: Colors.white.withOpacity(0.1)),
                      _buildMiniStat('mobile.auto.ai_valuation'.tr(), '+${aiValuation}%', Icons.auto_graph_rounded, Color(0xFF8B5CF6)),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1);
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('mobile.auto.error_loading_portfolio_data'.tr())),
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 14),
            SizedBox(width: 6),
            Text(label, style: GoogleFonts.outfit(color: Colors.white54, fontSize: 11)),
          ],
        ),
        SizedBox(height: 6),
        Text(value, style: GoogleFonts.outfit(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
