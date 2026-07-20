import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class BookingManagementPage extends ConsumerWidget {
  const BookingManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
        title: Text(
          'booking_os.bookings'.tr(),
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
                  return _BookingCard(index: index);
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
          _FilterChip(label: 'Checked-in', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'Pending', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'Checked-out', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'Cancelled', isSelected: false),
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

class _BookingCard extends StatelessWidget {
  final int index;

  const _BookingCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final statuses = ['checked-in', 'pending', 'checked-out'];
    final status = statuses[index % statuses.length];
    final statusColors = {
      'checked-in': AppColors.success,
      'pending': AppColors.warning,
      'checked-out': AppColors.info,
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
              const Spacer(),
              Text(
                '#${1000 + index}',
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
            'Marina Residences #${['4B', '7A', '12C', '3D'][index % 4]}',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Guest: ${['John Doe', 'Jane Smith', 'Bob Johnson', 'Alice Brown'][index % 4]}',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.white54),
              const SizedBox(width: 8),
              Text(
                'Check-in: Jan ${15 + index}',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.white60,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.event, size: 16, color: Colors.white54),
              const SizedBox(width: 8),
              Text(
                'Check-out: Jan ${20 + index}',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'View Details',
                  icon: Icons.visibility,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionButton(
                  label: 'Check-in/out',
                  icon: Icons.qr_code_scanner,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideX();
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _ActionButton({
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
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
