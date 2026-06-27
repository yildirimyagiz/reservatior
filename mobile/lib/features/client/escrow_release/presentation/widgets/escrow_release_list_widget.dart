import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class EscrowReleaseListWidget extends StatelessWidget {
  final List<EscrowRelease> items;
  const EscrowReleaseListWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty)
      return Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text('mobile.auto.no_escrow_release_items_found'.tr(),
            style: TextStyle(color: AppColors.textSecondaryDark),
          ),
        ),
      );

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, i) {
        final item = items[i];
        final heroTag = 'hero_escrow_release_${item.id}';
        String title = 'Item';
        try {
          title = (item as dynamic).name ?? (item as dynamic).title ?? item.id;
        } catch (_) {
          title = item.id;
        }

        return Card(
              elevation: 0,
              color: AppColors.darkCard,
              margin: const EdgeInsets.only(bottom: 12),
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
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.darkMuted,
                  size: 12,
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
