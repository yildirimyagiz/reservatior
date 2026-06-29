import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentRoutingScreen extends ConsumerWidget {
  const PaymentRoutingScreen({super.key});

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
                    'payment.routing.title'.tr(),
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
              child: _RoutingSummary(
                totalTransactions: 384,
                costSaved: '\$23,400',
                avgCostReduction: 2.8,
                successRate: 97.2,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                Text(
                  'payment.routing.routing_logic'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                _RoutingLogicChart(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'payment.routing.recent_decisions'.tr(),
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'payment.routing.optimal'.tr(),
                        style: GoogleFonts.outfit(
                          color: AppColors.success,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...List.generate(8, (i) => _PaymentRouteTile(
                  transactionId: 'TXN-${2024000 + i}',
                  amount: '\$${(340 + i * 120).toStringAsFixed(0)}',
                  selectedRail: [
                    'Open Banking (A2A)',
                    'Card (Param)',
                    'Virtual Card',
                    'Bank Hold',
                    'Open Banking (VRP)',
                    'Card (Paratika)',
                    'Open Banking (A2A)',
                    'Card (Sipay)',
                  ][i],
                  alternativeRail: [
                    'Card (2.9%)',
                    'Open Banking (0.5%)',
                    'Card (2.5%)',
                    'Card (2.9%)',
                    'Card (2.9%)',
                    'Open Banking (0.5%)',
                    'Virtual Card (1.8%)',
                    'Open Banking (0.5%)',
                  ][i],
                  savings: ['1.8%', '2.4%', '0.7%', '1.2%', '2.1%', '1.5%', '1.3%', '2.0%'][i],
                  riskScore: i < 3 ? 12 : i < 5 ? 25 : i < 7 ? 40 : 55,
                  settlementSpeed: i < 3 ? 'Instant' : i < 5 ? 'Same Day' : i < 7 ? '24h' : '48h',
                  status: i < 6 ? 'Completed' : 'Pending',
                )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoutingSummary extends StatelessWidget {
  final int totalTransactions;
  final String costSaved;
  final double avgCostReduction;
  final double successRate;

  const _RoutingSummary({
    required this.totalTransactions,
    required this.costSaved,
    required this.avgCostReduction,
    required this.successRate,
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
                  color: AppColors.success.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.alt_route, color: AppColors.success, size: 22),
              ),
              const SizedBox(width: 12),
              Text(
                'payment.routing.smart_routing'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _RoutingMetric(label: 'payment.routing.transactions'.tr(), value: '$totalTransactions', color: AppColors.primary),
              _RoutingMetric(label: 'payment.routing.cost_saved'.tr(), value: costSaved, color: AppColors.success),
              _RoutingMetric(label: 'payment.routing.avg_reduction'.tr(), value: '$avgCostReduction%', color: AppColors.info),
              _RoutingMetric(label: 'payment.routing.success_rate'.tr(), value: '$successRate%', color: AppColors.warning),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

class _RoutingMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _RoutingMetric({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 18, color: color),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 11),
        ),
      ],
    );
  }
}

class _RoutingLogicChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LogicRow(
            condition: 'payment.routing.risk_low'.tr(),
            action: 'payment.routing.use_open_banking'.tr(),
            icon: Icons.check_circle,
            color: AppColors.success,
          ),
          const SizedBox(height: 8),
          _LogicRow(
            condition: 'payment.routing.card_high_prob'.tr(),
            action: 'payment.routing.use_psp'.tr(),
            icon: Icons.credit_card,
            color: AppColors.primary,
          ),
          const SizedBox(height: 8),
          _LogicRow(
            condition: 'payment.routing.else_fallback'.tr(),
            action: 'payment.routing.use_vcc'.tr(),
            icon: Icons.shield,
            color: AppColors.warning,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.info, size: 14),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'payment.routing.dynamic_msg'.tr(),
                    style: GoogleFonts.outfit(color: AppColors.info, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 150));
  }
}

class _LogicRow extends StatelessWidget {
  final String condition;
  final String action;
  final IconData icon;
  final Color color;

  const _LogicRow({
    required this.condition,
    required this.action,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.darkBorder.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${'payment.routing.if_prefix'.tr()}$condition',
                  style: GoogleFonts.outfit(
                    color: AppColors.textSecondaryDark,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  action,
                  style: GoogleFonts.outfit(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentRouteTile extends StatelessWidget {
  final String transactionId;
  final String amount;
  final String selectedRail;
  final String alternativeRail;
  final String savings;
  final int riskScore;
  final String settlementSpeed;
  final String status;

  const _PaymentRouteTile({
    required this.transactionId,
    required this.amount,
    required this.selectedRail,
    required this.alternativeRail,
    required this.savings,
    required this.riskScore,
    required this.settlementSpeed,
    required this.status,
  });

  Color _riskColor() {
    if (riskScore < 20) return AppColors.success;
    if (riskScore < 40) return AppColors.warning;
    return AppColors.error;
  }

  String _translateRail() {
    switch (selectedRail) {
      case 'Open Banking (A2A)':
        return 'payment.routing.open_banking'.tr();
      case 'Card (Param)':
        return 'payment.routing.card_param'.tr();
      case 'Virtual Card':
        return 'payment.routing.virtual_card'.tr();
      case 'Bank Hold':
        return 'payment.routing.bank_hold'.tr();
      case 'Open Banking (VRP)':
        return 'payment.routing.open_banking_vrp'.tr();
      case 'Card (Paratika)':
        return 'payment.routing.card_paratika'.tr();
      case 'Card (Sipay)':
        return 'payment.routing.card_sipay'.tr();
      default:
        return selectedRail;
    }
  }

  String _translateSpeed() {
    switch (settlementSpeed) {
      case 'Instant':
        return 'payment.routing.instant'.tr();
      case 'Same Day':
        return 'payment.routing.same_day'.tr();
      case '24h':
        return 'payment.routing.h24'.tr();
      case '48h':
        return 'payment.routing.h48'.tr();
      default:
        return settlementSpeed;
    }
  }

  String _translateStatus() {
    switch (status) {
      case 'Completed':
        return 'payment.routing.completed'.tr();
      case 'Pending':
        return 'payment.routing.pending'.tr();
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.alt_route, color: AppColors.success, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactionId,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'payment.routing.risk_score'.tr() + '$riskScore/100 • ${_translateSpeed()}',
                      style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 12),
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
                  Text(
                    'payment.routing.save_prefix'.tr() + savings,
                    style: GoogleFonts.outfit(
                      color: AppColors.success,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.darkBorder.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'payment.routing.selected_rail'.tr(),
                        style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 9),
                      ),
                      Text(
                        _translateRail(),
                        style: GoogleFonts.outfit(
                          color: AppColors.success,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.darkBorder.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'payment.routing.alternative'.tr(),
                        style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 9),
                      ),
                      Text(
                        alternativeRail,
                        style: GoogleFonts.outfit(color: AppColors.warning, fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _riskColor().withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'payment.routing.risk_score'.tr() + '$riskScore',
                  style: GoogleFonts.outfit(
                    color: _riskColor(),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _translateSpeed(),
                  style: GoogleFonts.outfit(
                    color: AppColors.info,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                _translateStatus(),
                style: GoogleFonts.outfit(
                  color: AppColors.success,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 50));
  }
}
