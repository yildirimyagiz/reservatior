import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentActivityWidget extends StatelessWidget {
  const RecentActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'title': 'mobile.leftovers.new_property_added'.tr(),
        'description': 'mobile.leftovers.luxury_villa_in_palm_jumeirah'.tr(),
        'icon': Icons.add_home,
        'color': Colors.green,
        'time': 'mobile.leftovers.10_minutes_ago'.tr(),
      },
      {
        'title': 'mobile.leftovers.client_inquiry'.tr(),
        'description': 'mobile.leftovers.john_smith_interested_in_marina_property'.tr(),
        'icon': Icons.person,
        'color': Colors.blue,
        'time': 'mobile.leftovers.1_hour_ago'.tr(),
      },
      {
        'title': 'mobile.leftovers.document_uploaded'.tr(),
        'description': 'mobile.leftovers.property_deed_for_dubai_hills'.tr(),
        'icon': Icons.upload_file,
        'color': Colors.purple,
        'time': 'mobile.leftovers.2_hours_ago'.tr(),
      },
      {
        'title': 'mobile.leftovers.viewing_scheduled'.tr(),
        'description': 'mobile.leftovers.property_tour_for_downtown_apartment'.tr(),
        'icon': Icons.calendar_today,
        'color': Colors.orange,
        'time': 'mobile.leftovers.3_hours_ago'.tr(),
      },
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('mobile.auto.recent_activity'.tr(),
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => _viewAllActivity(),
                child: Text('mobile.auto.view_all'.tr(),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          ...activities.map(
            (activity) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildActivityCard(activity),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    final color = activity['color'] as Color;

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(activity['icon'] as IconData, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity['title'] as String,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                activity['description'] as String,
                style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Text(
          activity['time'] as String,
          style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[500]),
        ),
      ],
    );
  }

  void _viewAllActivity() {
    print('View all activity');
  }
}
