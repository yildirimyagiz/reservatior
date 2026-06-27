import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class NeighborhoodInsightsWidget extends StatelessWidget {
  const NeighborhoodInsightsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final neighborhoods = [
      {
        'name': 'mobile.leftovers.downtown_dubai'.tr(),
        'avgPrice': '\$1.2M',
        'growth': '+12%',
        'score': 4.8,
        'highlights': ['mobile.leftovers.burj_khalifa'.tr(), 'mobile.leftovers.dubai_mall'.tr(), 'mobile.leftovers.metro_access'.tr()],
        'color': Colors.blue,
      },
      {
        'name': 'mobile.leftovers.dubai_marina'.tr(),
        'avgPrice': '\$850K',
        'growth': '+8%',
        'score': 4.6,
        'highlights': ['mobile.leftovers.beach_access'.tr(), 'mobile.leftovers.walk_promenade'.tr(), 'Restaurants'],
        'color': Colors.cyan,
      },
      {
        'name': 'mobile.leftovers.palm_jumeirah'.tr(),
        'avgPrice': '\$2.5M',
        'growth': '+15%',
        'score': 4.9,
        'highlights': ['mobile.leftovers.beach_front'.tr(), 'mobile.leftovers.luxury_villas'.tr(), 'mobile.leftovers.atlantis_hotel'.tr()],
        'color': Colors.purple,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text('mobile.auto.neighborhood_insights'.tr(),
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text('mobile.auto.discover_the_best_areas_to_live_based_on_market_trends'.tr(),
          style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),

        // Neighborhood Cards
        ...neighborhoods
            .map(
              (neighborhood) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildNeighborhoodCard(neighborhood),
              ),
            )
            .toList(),
      ],
    );
  }

  Widget _buildNeighborhoodCard(Map<String, dynamic> neighborhood) {
    final color = neighborhood['color'] as Color;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.1), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      neighborhood['name'] as String,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Avg Price: ${neighborhood['avgPrice']}',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            neighborhood['growth'] as String,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Rating
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: color, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        neighborhood['score'].toString(),
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Highlights
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('mobile.auto.key_highlights'.tr(),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (neighborhood['highlights'] as List<String>).map((
                    highlight,
                  ) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: color.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        highlight,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Explore neighborhood
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: Text('mobile.auto.explore_properties'.tr(),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
