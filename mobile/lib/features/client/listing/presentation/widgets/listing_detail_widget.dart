import 'package:flutter/material.dart' hide Notification, Route;
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/listing_service.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/ai_service_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

class ListingDetailWidget extends ConsumerWidget {
  final Listing item;
  const ListingDetailWidget({super.key, required this.item});

  Future<void> _triggerAiVideo(BuildContext context, WidgetRef ref) async {
    try {
      final dio = DioClient(); // Assuming DioClient is accessible or injected
      final service = ListingService(dio);

      final task = await service
          .triggerAiTask(item.orgId, item.propertyId, 'REELS_VIDEO_GEN', {
            'listingId': item.id,
            'propertyTitle': item.title,
            'photos': item.property.propertyPhotos
                .map((p) => p.url)
                .toList(),
            'style': 'LUXURY',
          });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('AI Video task started! Status: ${task.status.name}'),
          backgroundColor: Colors.indigo,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error triggering AI: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('mobile.auto.listing_details'.tr(),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              if (item.category != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${item.category!.icon ?? "🏠"} ${item.category!.translations.isNotEmpty ? item.category!.translations.first.name : item.category!.slug}',
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12),
          Divider(),
          SizedBox(height: 12),
          Text(
            'Title: ${item.title ?? "Untitled"}',
            style: const TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Price: \${item.priceCurrency ?? "\$"} \${item.price ?? 0}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 24),

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo[50]!, Colors.blue[50]!],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.indigo[100]!),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.indigo, size: 20),
                    SizedBox(width: 8),
                    Text('mobile.auto.ai_marketing_suite'.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _triggerAiVideo(context, ref),
                    icon: Icon(Icons.video_call_rounded),
                    label: Text('mobile.auto.generate_viral_reels_video'.tr()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text('mobile.auto.uses_comfyui_engine_to_generate_videos_from_photos'.tr(),
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
