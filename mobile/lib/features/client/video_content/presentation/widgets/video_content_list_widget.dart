import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/widgets/social_export_hub.dart';
import 'package:easy_localization/easy_localization.dart';

class VideoContentListWidget extends StatelessWidget {
  final List<VideoContent> items;
  const VideoContentListWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty)
      return Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text('mobile.auto.no_video_content_items_found'.tr(),
            style: TextStyle(color: AppColors.textSecondaryDark),
          ),
        ),
      );

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, i) {
        final item = items[i];
        final heroTag = 'hero_video_content_${item.id}';
        String title = 'Item';
        try {
          title = (item as dynamic).name ?? (item as dynamic).title ?? item.id;
        } catch (_) {
          title = item.id;
        }

        return Card(
              elevation: 0,
              color: AppColors.darkCard,
              margin: EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.darkBorder, width: 0.5),
              ),
              child: ListTile(
                leading: Hero(
                  tag: heroTag,
                  child: CircleAvatar(
                    backgroundColor: AppColors.darkSurface,
                    child: Icon(
                      Icons.extension_outlined,
                      color: AppColors.gold,
                      size: 20,
                    ),
                  ),
                ),
                title: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimaryDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text('mobile.auto.id'.tr().split('').first + item.id.split('-').first,
                  style: const TextStyle(
                    color: AppColors.textSecondaryDark,
                    fontSize: 11,
                  ),
                ),
                trailing: PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: AppColors.darkMuted,
                    size: 20,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'export',
                      child: Row(
                        children: [
                          const Icon(Icons.share, size: 18),
                          SizedBox(width: 8),
                          Text('mobile.auto.export_share'.tr()),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (val) {
                    if (val == 'export') {
                      SocialExportHub.show(
                        context,
                        title: title,
                        description: 'mobile.leftovers.property_media_ready_for_social_sharing'.tr(),
                        mediaUrl: item.url,
                      );
                    }
                  },
                ),
                onTap: () {},
              ),
            )
            .animate()
            .fadeIn(duration: 400.ms, delay: (i * 50).ms)
            .slideY(begin: 0.1, end: 0);
      },
    );
  }
}
