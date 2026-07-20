import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class SagaHistoryPage extends ConsumerWidget {
  const SagaHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
        title: Text(
          'saga_flow.history'.tr(),
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
              child: _DateFilterCard(),
            ),
          ),
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
                  return _HistoryCard(index: index);
                },
                childCount: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateFilterCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: AppColors.primary, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'saga_flow.date_range'.tr(),
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Jan 1, 2024 - Jan 18, 2024',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
        ],
      ),
    ).animate().fadeIn().slideY();
  }
}

class _FilterChips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(label: 'All Types', isSelected: true),
          const SizedBox(width: 8),
          _FilterChip(label: 'BOOKING', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'PAYMENT', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'COMMISSION', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'VERIFICATION', isSelected: false),
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

class _HistoryCard extends StatelessWidget {
  final int index;

  const _HistoryCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final sagaTypes = ['BOOKING', 'PAYMENT', 'COMMISSION', 'VERIFICATION'];
    final sagaType = sagaTypes[index % sagaTypes.length];
    final statuses = ['completed', 'failed', 'completed', 'completed'];
    final status = statuses[index % statuses.length];
    final statusColors = {
      'completed': AppColors.success,
      'failed': AppColors.error,
      'cancelled': AppColors.warning,
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
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: statusColors[status],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      status.toUpperCase(),
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: statusColors[status],
                      ),
                    ),
                  ],
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
                'Jan ${18 - index}',
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
              Icon(Icons.timer, size: 14, color: Colors.white54),
              const SizedBox(width: 6),
              Text(
                'Duration: ${5 + index}m',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.check_circle, size: 14, color: statusColors[status]),
              const SizedBox(width: 6),
              Text(
                '${8 + index} steps completed',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
          if (status == 'failed') ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.error.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: AppColors.error, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Payment gateway timeout - Step 3 failed',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _HistoryActionButton(
                  label: 'View Details',
                  icon: Icons.visibility,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
              if (status == 'failed')
                Expanded(
                  child: _HistoryActionButton(
                    label: 'Retry',
                    icon: Icons.refresh,
                    color: AppColors.warning,
                  ),
                ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideX();
  }
}

class _HistoryActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _HistoryActionButton({
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
