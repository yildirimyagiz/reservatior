import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/models.dart';

class SocialExportHub extends StatelessWidget {
  final String title;
  final String description;
  final String? mediaUrl;

  const SocialExportHub({
    super.key,
    required this.title,
    required this.description,
    this.mediaUrl,
  });

  static void show(BuildContext context, {required String title, required String description, String? mediaUrl}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => SocialExportHub(
        title: title,
        description: description,
        mediaUrl: mediaUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 24),
          Text('mobile.auto.export_to_social_media'.tr(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text('mobile.auto.optimize_share_your_property_content'.tr(),
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 32),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.5,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _SocialCard(
                icon: Icons.chat_bubble_outline,
                label: 'mobile.auto.whatsapp'.tr(),
                color: const Color(0xFF25D366),
                onTap: () => _launchSocial('whatsapp://send?text=${Uri.encodeComponent("$title\n\n$description\n\n$mediaUrl")}'),
              ),
              _SocialCard(
                icon: Icons.camera_alt_outlined,
                label: 'mobile.auto.instagram'.tr(),
                color: const Color(0xFFE4405F),
                onTap: () => _launchSocial('https://www.instagram.com/'),
              ),
              _SocialCard(
                icon: Icons.play_circle_outline,
                label: 'mobile.auto.youtube'.tr(),
                color: const Color(0xFFFF0000),
                onTap: () => _launchSocial('https://studio.youtube.com/'),
              ),
              _SocialCard(
                icon: Icons.work_outline,
                label: 'mobile.auto.linkedin'.tr(),
                color: const Color(0xFF0077B5),
                onTap: () => _launchSocial('https://www.linkedin.com/sharing/share-offsite/?url=${Uri.encodeComponent(mediaUrl ?? "")}'),
              ),
            ],
          ),
          SizedBox(height: 24),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('mobile.auto.cancel'.tr(), style: TextStyle(color: Colors.white54)),
          ),
        ],
      ),
    );
  }

  Future<void> _launchSocial(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Fallback or error message
    }
  }
}

class _SocialCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SocialCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
