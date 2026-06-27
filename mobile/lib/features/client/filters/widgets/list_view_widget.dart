import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ListViewWidget extends StatelessWidget {
  final Map<String, dynamic> filters;
  final Function(Map<String, dynamic>) onPropertyTap;

  const ListViewWidget({
    super.key,
    required this.filters,
    required this.onPropertyTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, dynamic>> properties = [
      {
        'id': 1,
        'title': 'mobile.leftovers.luxury_villa_in_palm_jumeirah'.tr(),
        'price': '\$2,500,000',
        'location': 'mobile.leftovers.palm_jumeirah_dubai'.tr(),
        'bedrooms': 5,
        'bathrooms': 6,
        'area': 'mobile.leftovers.4_500_sqft'.tr(),
        'type': 'Villa',
        'image': 'https://images.unsplash.com/photo-1691272477702-0a2edae135f2',
        'semanticLabel':
            'mobile.leftovers.modern_white_luxury_villa_with_palm_tree'.tr(),
        'verified': true,
        'videoFreshness': 'new',
        'watchRate': 92,
      },
      {
        'id': 2,
        'title': 'mobile.leftovers.modern_apartment_in_downtown'.tr(),
        'price': '\$850,000',
        'location': 'mobile.leftovers.downtown_dubai'.tr(),
        'bedrooms': 2,
        'bathrooms': 3,
        'area': 'mobile.leftovers.1_800_sqft'.tr(),
        'type': 'Apartment',
        'image':
            'https://img.rocket.new/generatedImages/rocket_gen_img_13b6136d7-1766551461726.png',
        'semanticLabel':
            'mobile.leftovers.contemporary_apartment_interior_with_flo'.tr(),
        'verified': true,
        'videoFreshness': 'recent',
        'watchRate': 85,
      },
      {
        'id': 3,
        'title': 'mobile.leftovers.beachfront_penthouse'.tr(),
        'price': '\$3,200,000',
        'location': 'mobile.leftovers.dubai_marina'.tr(),
        'bedrooms': 4,
        'bathrooms': 5,
        'area': 'mobile.leftovers.3_800_sqft'.tr(),
        'type': 'Penthouse',
        'image':
            'https://img.rocket.new/generatedImages/rocket_gen_img_10f7fd659-1766936729005.png',
        'semanticLabel':
            'mobile.leftovers.luxurious_penthouse_terrace_with_ocean_v'.tr(),
        'verified': true,
        'videoFreshness': 'new',
        'watchRate': 95,
      },
      {
        'id': 4,
        'title': 'mobile.leftovers.family_townhouse'.tr(),
        'price': '\$1,450,000',
        'location': 'mobile.leftovers.arabian_ranches'.tr(),
        'bedrooms': 3,
        'bathrooms': 4,
        'area': 'mobile.leftovers.2_600_sqft'.tr(),
        'type': 'Townhouse',
        'image':
            'https://img.rocket.new/generatedImages/rocket_gen_img_1e9655d1d-1767666490160.png',
        'semanticLabel':
            'mobile.leftovers.spacious_townhouse_with_landscaped_garde'.tr(),
        'verified': false,
        'videoFreshness': 'older',
        'watchRate': 68,
      },
      {
        'id': 5,
        'title': 'mobile.leftovers.studio_apartment_in_business_bay'.tr(),
        'price': '\$420,000',
        'location': 'mobile.leftovers.business_bay_dubai'.tr(),
        'bedrooms': 1,
        'bathrooms': 1,
        'area': 'mobile.leftovers.650_sqft'.tr(),
        'type': 'Studio',
        'image':
            'https://img.rocket.new/generatedImages/rocket_gen_img_132626547-1766145574497.png',
        'semanticLabel':
            'mobile.leftovers.compact_studio_apartment_with_modern_fur'.tr(),
        'verified': true,
        'videoFreshness': 'recent',
        'watchRate': 78,
      },
    ];

    return Column(
      children: [
        // Results Header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          color: theme.colorScheme.surface,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${properties.length} Properties Found',
                style: theme.textTheme.titleMedium,
              ),
              Row(
                children: [
                  Text('mobile.auto.sort_by'.tr(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.outline),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Text('mobile.auto.relevance'.tr(), style: theme.textTheme.bodySmall),
                        SizedBox(width: 1.w),
                        Icon(
                          Icons.arrow_drop_down,
                          color: theme.colorScheme.onSurface,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Property List
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            itemCount: properties.length,
            separatorBuilder: (context, index) => SizedBox(height: 1.h),
            itemBuilder: (context, index) {
              final property = properties[index];
              return _buildPropertyCard(context, theme, property);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyCard(
    BuildContext context,
    ThemeData theme,
    Map<String, dynamic> property,
  ) {
    return InkWell(
      onTap: () => onPropertyTap(property),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Image.network(
                    property['image'],
                    width: 30.w,
                    height: 20.h,
                    fit: BoxFit.cover,
                  ),
                ),
                // Video Freshness Badge
                Positioned(
                  top: 1.h,
                  left: 2.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: property['videoFreshness'] == 'new'
                          ? const Color(0xFF27AE60)
                          : property['videoFreshness'] == 'recent'
                          ? const Color(0xFF4A90E2)
                          : const Color(0xFF7F8C8D),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.videocam,
                          color: Colors.white,
                          size: 12,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          property['videoFreshness'] == 'new'
                              ? 'New'
                              : property['videoFreshness'] == 'recent'
                              ? 'Recent'
                              : 'Older',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Watch Rate
                Positioned(
                  bottom: 1.h,
                  left: 2.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.play_circle_outline,
                          color: Colors.white,
                          size: 12,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          '${property['watchRate']}%',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Property Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            property['title'],
                            style: theme.textTheme.titleSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (property['verified'])
                          Container(
                            padding: EdgeInsets.all(1.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4A90E2).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.verified,
                              color: Color(0xFF4A90E2),
                              size: 16,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: theme.colorScheme.onSurfaceVariant,
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Expanded(
                          child: Text(
                            property['location'],
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      property['price'],
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF4A90E2),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        _buildPropertyFeature(
                          theme,
                          Icons.king_bed,
                          '${property['bedrooms']}',
                        ),
                        SizedBox(width: 3.w),
                        _buildPropertyFeature(
                          theme,
                          Icons.bathtub,
                          '${property['bathrooms']}',
                        ),
                        SizedBox(width: 3.w),
                        _buildPropertyFeature(
                          theme,
                          Icons.square_foot,
                          property['area'],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyFeature(ThemeData theme, IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.onSurfaceVariant, size: 16),
        SizedBox(width: 1.w),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
