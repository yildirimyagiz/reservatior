import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class CompliancePage extends ConsumerWidget {
  const CompliancePage({super.key});

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
                    'agent.compliance.title'.tr(),
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
              child: _ComplianceSummary(
                totalRecords: 156,
                pendingReview: 12,
                compliant: 144,
                flaggedIssues: 4,
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
                      'agent.compliance.pending_reviews'.tr(),
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'agent.compliance.pending_count'.tr(namedArgs: {'count': '12'}),
                        style: GoogleFonts.outfit(
                          color: AppColors.warning,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...List.generate(6, (i) => _ComplianceTile(
                  agentName: i.isEven ? 'Emily Carter' : 'David Kim',
                  documentType: i % 3 == 0 ? 'License' : i % 3 == 1 ? 'Background Check' : 'Certification',
                  status: i < 2 ? 'Approved' : i < 4 ? 'Pending' : 'Flagged',
                  date: '2026-06-${10 + i * 2}',
                  score: i == 0 ? 98 : i == 1 ? 95 : i == 2 ? 72 : i == 3 ? 88 : 45,
                )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComplianceSummary extends StatelessWidget {
  final int totalRecords;
  final int pendingReview;
  final int compliant;
  final int flaggedIssues;

  const _ComplianceSummary({
    required this.totalRecords,
    required this.pendingReview,
    required this.compliant,
    required this.flaggedIssues,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ComplianceStat(label: 'agent.compliance.total'.tr(), value: '$totalRecords', icon: Icons.description, color: AppColors.primary),
              _ComplianceStat(label: 'agent.compliance.compliant'.tr(), value: '$compliant', icon: Icons.check_circle, color: AppColors.success),
              _ComplianceStat(label: 'agent.compliance.pending'.tr(), value: '$pendingReview', icon: Icons.hourglass_empty, color: AppColors.warning),
              _ComplianceStat(label: 'agent.compliance.flagged'.tr(), value: '$flaggedIssues', icon: Icons.flag, color: AppColors.error),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: compliant / totalRecords,
              backgroundColor: AppColors.darkBorder,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'agent.compliance.rate_format'.tr(namedArgs: {'rate': '${(compliant / totalRecords * 100).toStringAsFixed(1)}'}),
                style: GoogleFonts.outfit(color: AppColors.success, fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text(
                'agent.compliance.issues_format'.tr(namedArgs: {'count': '$flaggedIssues'}),
                style: GoogleFonts.outfit(color: AppColors.error, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

class _ComplianceStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _ComplianceStat({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            fontSize: 18,
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

class _ComplianceTile extends StatelessWidget {
  final String agentName;
  final String documentType;
  final String status;
  final String date;
  final int score;

  const _ComplianceTile({
    required this.agentName,
    required this.documentType,
    required this.status,
    required this.date,
    required this.score,
  });

  Color _statusColor() {
    switch (status) {
      case 'Approved':
        return AppColors.success;
      case 'Pending':
        return AppColors.warning;
      case 'Flagged':
        return AppColors.error;
      default:
        return AppColors.textSecondaryDark;
    }
  }

  String _statusLabel() {
    switch (status) {
      case 'Approved':
        return 'agent.compliance.approved'.tr();
      case 'Pending':
        return 'agent.compliance.status_pending'.tr();
      case 'Flagged':
        return 'agent.compliance.flagged_status'.tr();
      default:
        return status;
    }
  }

  Color _scoreColor() {
    if (score >= 90) return AppColors.success;
    if (score >= 70) return AppColors.warning;
    return AppColors.error;
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
          color: status == 'Flagged'
              ? AppColors.error.withValues(alpha: 0.2)
              : AppColors.darkBorder,
        ),
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
            child: Icon(Icons.gavel, color: _statusColor(), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  agentName,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '$documentType • $date',
                  style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _scoreColor().withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '$score',
                style: GoogleFonts.outfit(
                  color: _scoreColor(),
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _statusColor().withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              _statusLabel(),
              style: GoogleFonts.outfit(
                color: _statusColor(),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 50));
  }
}
