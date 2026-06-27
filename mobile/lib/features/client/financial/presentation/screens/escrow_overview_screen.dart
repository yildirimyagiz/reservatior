import 'package:reservatior/features/client/financial/data/models/escrow_account.dart';
import 'package:reservatior/features/client/financial/providers/financial_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class EscrowOverviewScreen extends ConsumerWidget {
  const EscrowOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);

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
          'mobile.finance.escrowTitle'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: ref.watch(escrowAccountsProvider).when(
        data: (accounts) {
          final totalHeld = accounts.where((a) => a.status == 'HOLDING').fold(0.0, (s, a) => s + a.depositAmount);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildFinancialBrief(colors, totalHeld),
              const SizedBox(height: 32),
              _buildTabHeader('mobile.finance.escrowActive'.tr(), colors),
              const SizedBox(height: 16),
              if (accounts.isEmpty) Center(child: Text('mobile.finance.no_escrow'.tr(), style: GoogleFonts.outfit(color: colors.textSecondary))),
              ...accounts.asMap().entries.map((entry) => _buildEscrowCard(entry.value, colors, entry.key)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error loading escrow: $error')),
      ),
    );
  }

  Widget _buildFinancialBrief(ThemeAwareColors colors, double totalHeld) {
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
          Text(
            'mobile.finance.escrowProtected'.tr(),
            style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Text(
            '${totalHeld.toStringAsFixed(2)}',
            style: GoogleFonts.outfit(
              color: colors.textPrimary,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              _buildBriefItem('mobile.finance.escrowHolding'.tr(), '\$842K', Colors.blueAccent, colors),
              const Spacer(),
              _buildBriefItem('mobile.finance.escrowDisputed'.tr(), '\$125K', Colors.orangeAccent, colors),
              const Spacer(),
              _buildBriefItem('mobile.finance.escrowReleased'.tr(), '\$281K', Colors.greenAccent, colors),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBriefItem(String label, String value, Color color, ThemeAwareColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTabHeader(String label, ThemeAwareColors colors) {
    return Text(
      label,
      style: GoogleFonts.outfit(
        color: colors.textPrimary.withOpacity(0.4),
        fontSize: 11,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildEscrowCard(EscrowAccount e, ThemeAwareColors colors, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.account_balance_wallet_rounded, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${'mobile.finance.escrowReservation'.tr()}${e.reservationId}',
                      style: GoogleFonts.outfit(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '${'mobile.finance.escrowClient'.tr()}${e.clientName}',
                      style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 11),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(e.status, colors),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('mobile.finance.escrowHeldAmount'.tr(), style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 10)),
                  Text('\$${e.depositAmount.toStringAsFixed(2)}', style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('mobile.finance.escrowHeldSince'.tr(), style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 10)),
                  Text(e.heldAt != null ? e.heldAt.toString().split(' ')[0] : 'mobile.leftovers.unknown_date'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.info_outline, size: 14, color: Colors.blueAccent),
              const SizedBox(width: 6),
              Text(
                e.status == 'HOLDING' ? 'mobile.finance.escrowNextStep1'.tr() : 'mobile.finance.escrowNextStep3'.tr(),
                style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 11),
              ),
              const Spacer(),
              Icon(Icons.chevron_right, size: 18, color: colors.textSecondary),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 100 * index)).slideX(begin: 0.1);
  }

  Widget _buildStatusBadge(String status, ThemeAwareColors colors) {
    Color color;
    switch (status) {
      case 'HOLDING': color = Colors.blueAccent; break;
      case 'FULLY_RELEASED': color = Colors.greenAccent; break;
      case 'DISPUTED': color = Colors.orangeAccent; break;
      default: color = colors.textSecondary;
    }
    
    String statusText;
    switch (status) {
      case 'HOLDING': statusText = 'mobile.finance.escrowHolding'.tr(); break;
      case 'FULLY_RELEASED': statusText = 'mobile.finance.escrowFullyReleased'.tr(); break;
      case 'DISPUTED': statusText = 'mobile.finance.escrowDisputed'.tr(); break;
      default: statusText = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        statusText,
        style: GoogleFonts.outfit(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  static final _mockEscrows = [
    {
      'resId': '9021',
      'client': 'mobile.leftovers.marcus_aurelius'.tr(),
      'amount': '12,400.00',
      'status': 'HOLDING',
      'date': 'mobile.leftovers.oct_12_2024'.tr(),
      'nextStep': 'mobile.finance.escrowNextStep1'.tr(),
    },
    {
      'resId': '8842',
      'client': 'mobile.leftovers.selina_kyle'.tr(),
      'amount': '45,000.00',
      'status': 'DISPUTED',
      'date': 'mobile.leftovers.sep_28_2024'.tr(),
      'nextStep': 'mobile.finance.escrowNextStep2'.tr(),
    },
    {
      'resId': '9105',
      'client': 'mobile.leftovers.bruce_wayne'.tr(),
      'amount': '150,000.00',
      'status': 'HOLDING',
      'date': 'mobile.leftovers.oct_15_2024'.tr(),
      'nextStep': 'mobile.finance.escrowNextStep3'.tr(),
    },
  ];
}
