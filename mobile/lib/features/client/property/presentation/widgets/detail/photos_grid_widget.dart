import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class PhotosGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> photos;

  const PhotosGridWidget({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Text('mobile.auto.no_photos_available'.tr(),
            style: TextStyle(color: Colors.white24, fontSize: 12),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(5.w),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            photo['url'] as String? ?? 'https://picsum.photos/400/400',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: AppColors.darkSurface,
              child: const Icon(Icons.broken_image, color: Colors.white10),
            ),
          ),
        );
      },
    ).animate().fadeIn(duration: 600.ms);
  }
}
