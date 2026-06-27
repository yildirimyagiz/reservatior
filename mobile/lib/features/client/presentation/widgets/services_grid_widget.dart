import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicesGridWidget extends StatelessWidget {
  const ServicesGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        'title': 'mobile.leftovers.property_search'.tr(),
        'icon': Icons.search,
        'color': Colors.blue,
        'description': 'mobile.leftovers.find_your_perfect_property'.tr(),
      },
      {
        'title': 'mobile.leftovers.portfolio_management'.tr(),
        'icon': Icons.dashboard,
        'color': Colors.green,
        'description': 'mobile.leftovers.manage_your_properties'.tr(),
      },
      {
        'title': 'mobile.leftovers.ai_assistant'.tr(),
        'icon': Icons.psychology,
        'color': Colors.purple,
        'description': 'mobile.leftovers.smart_recommendations'.tr(),
      },
      {
        'title': 'mobile.leftovers.document_storage'.tr(),
        'icon': Icons.folder,
        'color': Colors.orange,
        'description': 'mobile.leftovers.secure_file_management'.tr(),
      },
      {
        'title': 'mobile.leftovers.market_analytics'.tr(),
        'icon': Icons.analytics,
        'color': Colors.red,
        'description': 'mobile.leftovers.real_time_insights'.tr(),
      },
      {
        'title': 'mobile.leftovers.smart_access'.tr(),
        'icon': Icons.vpn_key,
        'color': Colors.cyan,
        'description': 'mobile.leftovers.digital_property_access'.tr(),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('mobile.auto.our_services'.tr(),
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text('mobile.auto.everything_you_need_for_modern_real_estate_management'.tr(),
            style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return _buildServiceCard(service);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    final color = service['color'] as Color;

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateToService(service['title']),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    service['icon'] as IconData,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  service['title'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  service['description'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios, color: color, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToService(String serviceName) {
    // Navigate to specific service
    print('Navigate to $serviceName');
  }
}
