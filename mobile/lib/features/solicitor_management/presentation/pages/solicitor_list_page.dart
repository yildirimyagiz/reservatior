import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'solicitor_details_page.dart';

class SolicitorListPage extends ConsumerWidget {
  final String? filter;

  const SolicitorListPage({super.key, this.filter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
        title: Text(
          'solicitor_management.all_solicitors'.tr(),
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
              child: _SearchBar(),
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
                  return _SolicitorCard(index: index);
                },
                childCount: 24,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.white54, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'solicitor_management.search'.tr(),
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.white60,
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
          _FilterChip(label: 'VERIFIED', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'ENGAGED', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'DISPUTE_OPEN', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'COMPLETED', isSelected: false),
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

class _SolicitorCard extends StatelessWidget {
  final int index;

  const _SolicitorCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final solicitorTypes = [
      'TENANT_INTERNATIONAL_LAWYER',
      'LOCAL_LEGAL_COUNSEL',
      'LANDLORD_REPRESENTATIVE'
    ];
    final solicitorType = solicitorTypes[index % solicitorTypes.length];
    final statuses = ['VERIFIED', 'ENGAGED', 'DISPUTE_OPEN', 'COMPLETED', 'TERMINATED'];
    final status = statuses[index % statuses.length];
    final statusColors = {
      'VERIFIED': AppColors.success,
      'ENGAGED': AppColors.warning,
      'DISPUTE_OPEN': AppColors.error,
      'COMPLETED': AppColors.info,
      'TERMINATED': AppColors.error,
    };

    return GestureDetector(
      onTap: () => context.push('/solicitor-details?id=${1000 + index}'),
      child: Container(
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
                    status,
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
                    solicitorType,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
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
              ['John Smith', 'Sarah Brown', 'Mike Wilson', 'Emma Davis'][index % 4],
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              ['Smith & Co Legal', 'Brown & Partners', 'Wilson Legal Services', 'Davis Solicitors'][index % 4],
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.white60,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.email, size: 14, color: Colors.white54),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    ['john@smithlegal.com', 'sarah@brownpartners.com', 'mike@wilsonlegal.com', 'emma@davissolicitors.com'][index % 4],
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone, size: 14, color: Colors.white54),
                const SizedBox(width: 6),
                Text(
                  ['+44 20 7123 4567', '+44 20 7234 5678', '+44 20 7345 6789', '+44 20 7456 7890'][index % 4],
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideX();
  }
}
