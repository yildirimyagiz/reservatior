import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/facility.dart';
import 'package:reservatior/shared/providers/facility_provider.dart';

class FacilitiesScreen extends ConsumerWidget {
  const FacilitiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFacilities = ref.watch(facilityListProvider);
    final facilities = asyncFacilities.value ?? <Facility>[];

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Facilities',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                asyncFacilities.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Could not load facilities',
                      style: GoogleFonts.outfit(color: Colors.white54)),
                  data: (data) {
                    if (facilities.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            Icon(Icons.crib_outlined, color: Colors.white24, size: 32),
                            const SizedBox(height: 10),
                            Text('No facilities here',
                                style: GoogleFonts.outfit(
                                    color: Colors.white38, fontSize: 13)),
                          ],
                        ),
                      );
                    }
                    return Column(
                      children: facilities
                          .map((f) => _FacilityTile(facility: f))
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _FacilityTile extends StatelessWidget {
  final Facility facility;
  const _FacilityTile({required this.facility});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.crib_outlined, color: AppColors.primary, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      facility.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    Text(
                      'Property #${facility.propertyId}',
                      style: GoogleFonts.outfit(
                          color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
              if (facility.feeAmount != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    '${facility.feeAmount!.toStringAsFixed(0)} '
                    '${facility.feeCurrency ?? 'USD'}',
                    style: GoogleFonts.outfit(
                        color: AppColors.gold,
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                  ),
                ),
            ],
          ),
          if (facility.notes != null && facility.notes!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              facility.notes!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.construction, color: Colors.white24, size: 13),
              const SizedBox(width: 4),
              Text(
                'Fee applies' + (facility.feeAmount == null ? '' : ''),
                style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
              ),
              const Spacer(),
              Icon(Icons.access_time, color: Colors.white24, size: 13),
              const SizedBox(width: 4),
              Text(
                DateFormat.yMMMd().format(facility.createdAt),
                style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
              ),
            ],
          ),
        ],
      ).animate().fadeIn(),
    );
  }
}
