import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/shared/providers/agent_os_providers.dart';
import 'package:reservatior/features/os_dashboards/presentation/os_live_widgets.dart';

class VerificationPage extends ConsumerWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgId = ref.watch(authProvider).user?.organizationId ?? '';
    final verificationsAsync = ref.watch(agentVerificationsProvider(orgId));
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
                    'agent.verification.title'.tr(),
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
              child: verificationsAsync.when(
                loading: () => const OsLiveLoading(),
                error: (e, _) => OsLiveErrorCard(message: 'Failed to load verifications: $e'),
                data: (data) => _VerificationSummary(
                  verified: data.verified,
                  pending: data.pending,
                  expired: data.expired,
                  totalAgents: data.totalAgents,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                Text(
                  'agent.verification.agent_status'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ...verificationsAsync.when(
                  loading: () => [const OsLiveLoading()],
                  error: (e, _) => [OsLiveErrorCard(message: 'Failed to load verifications: $e')],
                  data: (data) => data.agents.take(8).map((a) => _VerificationTile(
                    agentName: a.agentName,
                    status: a.status,
                    idType: a.idType,
                    verifiedDate: a.verifiedDate,
                    expiryDate: a.expiryDate ?? '—',
                    score: a.score,
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

class _VerificationSummary extends StatelessWidget {
  final int verified;
  final int pending;
  final int expired;
  final int totalAgents;

  const _VerificationSummary({
    required this.verified,
    required this.pending,
    required this.expired,
    required this.totalAgents,
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
              _VerificationStat(label: 'agent.verification.verified_label'.tr(), value: '$verified', icon: Icons.verified_user, color: AppColors.success),
              _VerificationStat(label: 'agent.verification.pending_label'.tr(), value: '$pending', icon: Icons.access_time, color: AppColors.warning),
              _VerificationStat(label: 'agent.verification.expired_label'.tr(), value: '$expired', icon: Icons.error_outline, color: AppColors.error),
              _VerificationStat(label: 'agent.verification.total_label'.tr(), value: '$totalAgents', icon: Icons.people, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: verified / totalAgents,
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
                'agent.verification.percent_format'.tr(namedArgs: {'percent': '${(verified / totalAgents * 100).toStringAsFixed(0)}'}),
                style: GoogleFonts.outfit(color: AppColors.success, fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text(
                'agent.verification.expired_format'.tr(namedArgs: {'count': '$expired'}),
                style: GoogleFonts.outfit(color: AppColors.error, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

class _VerificationStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _VerificationStat({required this.label, required this.value, required this.icon, required this.color});

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

class _VerificationTile extends StatelessWidget {
  final String agentName;
  final String status;
  final String idType;
  final String? verifiedDate;
  final String expiryDate;
  final int score;

  const _VerificationTile({
    required this.agentName,
    required this.status,
    required this.idType,
    this.verifiedDate,
    required this.expiryDate,
    required this.score,
  });

  Color _statusColor() {
    switch (status) {
      case 'Verified':
        return AppColors.success;
      case 'Pending':
        return AppColors.warning;
      case 'Expired':
        return AppColors.error;
      default:
        return AppColors.textSecondaryDark;
    }
  }

  String _statusLabel() {
    switch (status) {
      case 'Verified':
        return 'agent.verification.status_verified'.tr();
      case 'Pending':
        return 'agent.verification.status_pending'.tr();
      case 'Expired':
        return 'agent.verification.status_expired'.tr();
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
        border: Border.all(
          color: status == 'Expired'
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
            child: Icon(
              status == 'Verified' ? Icons.verified : status == 'Pending' ? Icons.access_time : Icons.error_outline,
              color: _statusColor(),
              size: 20,
            ),
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
                  'agent.verification.id_format'.tr(namedArgs: {'type': idType, 'date': expiryDate}),
                  style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _statusColor().withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '$score',
                style: GoogleFonts.outfit(
                  color: _statusColor(),
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
