import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class SagaMonitorPage extends ConsumerWidget {
  const SagaMonitorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
        title: Text(
          'saga_flow.monitor'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _FilterChips(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _SagaInstanceCard(index: index);
                },
                childCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(label: 'All', isSelected: true),
          const SizedBox(width: 8),
          _FilterChip(label: 'Running', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'Pending', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'Failed', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'Completed', isSelected: false),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _FilterChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border.withOpacity(0.3),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.w500,
          fontSize: 13,
          color: isSelected ? Colors.white : Colors.white70,
        ),
      ),
    );
  }
}

class _SagaInstanceCard extends StatelessWidget {
  final int index;

  const _SagaInstanceCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final sagaTypes = ['BOOKING', 'PAYMENT', 'COMMISSION', 'VERIFICATION'];
    final sagaType = sagaTypes[index % sagaTypes.length];
    final statuses = ['running', 'pending', 'failed', 'completed'];
    final status = statuses[index % statuses.length];
    final statusColors = {
      'running': AppColors.success,
      'pending': AppColors.warning,
      'failed': AppColors.error,
      'completed': AppColors.info,
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColors[status]!.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: statusColors[status],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  sagaType,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'ID: ${1000 + index}',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${['Booking Creation', 'Payment Processing', 'Commission Payout', 'Identity Verification'][index % 4]} #${1000 + index}',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: Colors.white54),
              const SizedBox(width: 6),
              Text(
                'Started: ${index * 5}m ago',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.timer, size: 14, color: Colors.white54),
              const SizedBox(width: 6),
              Text(
                'Duration: ${10 + index * 2}m',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (status == 'running') ...[
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0.3 + (index * 0.1),
                      backgroundColor: AppColors.cardBg.withValues(alpha: 0.5),
                      valueColor: AlwaysStoppedAnimation<Color>(statusColors[status]!),
                      minHeight: 6,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${((0.3 + index * 0.1) * 100).toInt()}%',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          Row(
            children: [
              Expanded(
                child: _SagaActionButton(
                  label: 'View Details',
                  icon: Icons.visibility,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _SagaActionButton(
                  label: 'Retry',
                  icon: Icons.refresh,
                  color: AppColors.warning,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _SagaActionButton(
                  label: 'Cancel',
                  icon: Icons.cancel,
                  color: AppColors.error,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideX();
  }
}

class _SagaActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _SagaActionButton({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              fontSize: 11,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
