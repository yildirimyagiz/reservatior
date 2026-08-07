import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/enums/escrow_release_status.dart';
import 'package:reservatior/shared/enums/escrow_trigger_event.dart';
import 'package:reservatior/shared/models/escrow_release.dart';
import 'package:reservatior/shared/providers/escrow_release_provider.dart';
import 'package:reservatior/features/os_dashboards/presentation/os_live_widgets.dart';

class SettlementPage extends ConsumerWidget {
  const SettlementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final releasesAsync = ref.watch(escrowReleaseListProvider);
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
                    'finance.settlement.title'.tr(),
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
              child: _SettlementFlowChart(),
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
                      'finance.settlement.active'.tr(),
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'finance.settlement.risk_window'.tr(),
                        style: GoogleFonts.outfit(
                          color: AppColors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...releasesAsync.when(
                  loading: () => [const OsLiveLoading()],
                  error: (e, _) => [OsLiveErrorCard(message: 'Failed to load settlements: $e')],
                  data: (releases) => releases.take(6).map((r) {
                    final hasDispute = r.escrow.disputes.isNotEmpty;
                    final scheduled = r.scheduledAt?.difference(DateTime.now()).inDays ?? 0;
                    return _SettlementTile(
                      propertyId: r.escrowId,
                      guestName: r.escrow.reservationId,
                      amount: r'$' + r.amount.toStringAsFixed(0),
                      stage: _settlementStage(r),
                      daysRemaining: scheduled > 0 ? scheduled : 0,
                      checkInDate: r.escrow.heldAt.toIso8601String().substring(0, 10),
                      hasDispute: hasDispute,
                    );
                  }).toList(),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

String _settlementStage(EscrowRelease r) {
  if (r.status == EscrowReleaseStatus.COMPLETED) return 'Ready to Settle';
  switch (r.triggerEvent) {
    case EscrowTriggerEvent.CHECK_IN_COMPLETED:
      return 'Check-In';
    case EscrowTriggerEvent.CHECK_OUT_COMPLETED:
    case EscrowTriggerEvent.SURVEY_COMPLETED:
    case EscrowTriggerEvent.DISPUTE_RESOLVED:
      return 'Ready to Settle';
    default:
      return 'Risk Window';
  }
}

class _SettlementFlowChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stages = [
      ('finance.settlement.check_in_full'.tr(), Icons.login, AppColors.info, false),
      ('finance.settlement.risk_window'.tr(), Icons.timer, AppColors.warning, false),
      ('finance.settlement.review_title'.tr(), Icons.rate_review, AppColors.primary, false),
      ('finance.settlement.release_now'.tr(), Icons.check_circle, AppColors.success, true),
    ];

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
          Text(
            'finance.settlement.pipeline'.tr(),
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: List.generate(stages.length, (i) {
              final stage = stages[i];
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: stage.$4
                            ? AppColors.success.withValues(alpha: 0.2)
                            : stage.$3.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: stage.$4
                              ? AppColors.success
                              : stage.$3.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Icon(stage.$2, color: stage.$4 ? AppColors.success : stage.$3, size: 20),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      stage.$1,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        color: stage.$4 ? AppColors.success : AppColors.textSecondaryDark,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (i < stages.length - 1)
                      Container(
                        height: 2,
                        color: AppColors.darkBorder,
                        margin: const EdgeInsets.only(top: 8),
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

class _SettlementTile extends StatelessWidget {
  final String propertyId;
  final String guestName;
  final String amount;
  final String stage;
  final int daysRemaining;
  final String checkInDate;
  final bool hasDispute;

  const _SettlementTile({
    required this.propertyId,
    required this.guestName,
    required this.amount,
    required this.stage,
    required this.daysRemaining,
    required this.checkInDate,
    this.hasDispute = false,
  });

  Color _stageColor() {
    if (hasDispute) return AppColors.error;
    switch (stage) {
      case 'Check-In':
        return AppColors.info;
      case 'Risk Window':
        return AppColors.warning;
      case 'Ready to Settle':
        return AppColors.success;
      default:
        return AppColors.textSecondaryDark;
    }
  }

  String get _translatedStage {
    switch (stage) {
      case 'Check-In':
        return 'finance.settlement.check_in_full'.tr();
      case 'Risk Window':
        return 'finance.settlement.risk_window'.tr();
      case 'Ready to Settle':
        return 'finance.settlement.ready'.tr();
      default:
        return stage;
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
        border: Border.all(
          color: hasDispute ? AppColors.error.withValues(alpha: 0.2) : AppColors.darkBorder,
        ),
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
                  color: _stageColor().withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  hasDispute ? Icons.warning : Icons.check_circle_outline,
                  color: _stageColor(),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      guestName,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'finance.settlement.dispute_format'.tr(namedArgs: {'propertyId': propertyId, 'checkInDate': checkInDate}),
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
                  if (daysRemaining > 0)
                    Text(
                      'finance.settlement.days_left_format'.tr(namedArgs: {'days': '$daysRemaining'}),
                      style: GoogleFonts.outfit(
                        color: _stageColor(),
                        fontSize: 11,
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (hasDispute) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber, color: AppColors.error, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'finance.settlement.dispute_held'.tr(),
                    style: GoogleFonts.outfit(
                      color: AppColors.error,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              _StageBadge(label: _translatedStage, color: _stageColor()),
              const Spacer(),
              if (!hasDispute)
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    daysRemaining == 0 ? 'finance.settlement.release_now'.tr() : 'finance.settlement.view_details'.tr(),
                    style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: const Duration(milliseconds: 50));
  }
}

class _StageBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StageBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
