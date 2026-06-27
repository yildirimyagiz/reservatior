import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:intl/intl.dart';

class NotificationListWidget extends StatefulWidget {
  final List<Notification> items;
  final Function(String)? onMarkAsRead;
  final Function(String)? onDelete;
  final Function(Notification)? onTap;
  final bool showActions;
  final bool showTimestamp;
  final bool showStatus;

  const NotificationListWidget({
    super.key,
    required this.items,
    this.onMarkAsRead,
    this.onDelete,
    this.onTap,
    this.showActions = true,
    this.showTimestamp = true,
    this.showStatus = true,
  });

  @override
  State<NotificationListWidget> createState() => _NotificationListWidgetState();
}

class _NotificationListWidgetState extends State<NotificationListWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return _buildEmptyState();

    return ListView.builder(
      itemCount: widget.items.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, i) {
        final item = widget.items[i];
        final heroTag = 'hero_notification_${item.id}';
        final isUnread = item.status == NotificationStatus.UNREAD;
        final isRead = item.status == NotificationStatus.READ;

        String title = 'Item';
        try {
          title = (item as dynamic).name ?? (item as dynamic).title ?? item.id;
        } catch (_) {
          title = item.id;
        }

        return Card(
              elevation: isUnread ? 2 : 0,
              color: isUnread
                  ? AppColors.darkCard.withOpacity(0.95)
                  : AppColors.darkCard.withOpacity(0.7),
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isUnread
                      ? AppColors.gold.withOpacity(0.3)
                      : AppColors.darkBorder,
                  width: isUnread ? 1 : 0.5,
                ),
              ),
              child: widget.showActions
                  ? _buildSlidableItem(
                      item,
                      heroTag,
                      title,
                      isUnread,
                      isRead,
                      i,
                    )
                  : _buildSimpleItem(item, heroTag, title, isUnread, isRead, i),
            )
            .animate()
            .fadeIn(duration: 400.ms, delay: (i * 50).ms)
            .slideY(begin: 0.1, end: 0);
      },
    );
  }

  Widget _buildSlidableItem(
    Notification item,
    String heroTag,
    String title,
    bool isUnread,
    bool isRead,
    int index,
  ) {
    return Slidable(
      key: Key(item.id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          if (isUnread && widget.onMarkAsRead != null)
            SlidableAction(
              onPressed: (_) => widget.onMarkAsRead!(item.id),
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
              icon: Icons.mark_email_read,
              label: 'mobile.auto.read'.tr(),
            ),
          if (widget.onDelete != null)
            SlidableAction(
              onPressed: (_) => widget.onDelete!(item.id),
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'mobile.auto.delete'.tr(),
            ),
        ],
      ),
      child: _buildItemContent(item, heroTag, title, isUnread, isRead, index),
    );
  }

  Widget _buildSimpleItem(
    Notification item,
    String heroTag,
    String title,
    bool isUnread,
    bool isRead,
    int index,
  ) {
    return _buildItemContent(item, heroTag, title, isUnread, isRead, index);
  }

  Widget _buildItemContent(
    Notification item,
    String heroTag,
    String title,
    bool isUnread,
    bool isRead,
    int index,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showStatus)
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: isUnread ? AppColors.gold : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          const SizedBox(width: 12),
          Hero(
            tag: heroTag,
            child: CircleAvatar(
              backgroundColor: AppColors.darkSurface,
              child: Icon(
                _getNotificationIcon(item.ruleKey),
                color: isUnread ? AppColors.gold : AppColors.darkMuted,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.textPrimaryDark,
                fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          if (isUnread)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('mobile.auto.new'.tr(),
                style: TextStyle(
                  color: AppColors.darkBg,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.body.length > 50
                ? '${item.body.substring(0, 50)}...'
                : item.body,
            style: TextStyle(
              color: AppColors.textSecondaryDark,
              fontSize: 12,
              fontWeight: isUnread ? FontWeight.w500 : FontWeight.normal,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (widget.showTimestamp) const SizedBox(height: 4),
          if (widget.showTimestamp)
            Text(
              _formatTimestamp(item.createdAt),
              style: TextStyle(color: AppColors.darkMuted, fontSize: 10),
            ),
        ],
      ),
      trailing: widget.showActions
          ? const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.darkMuted,
              size: 12,
            )
          : null,
      onTap: () => widget.onTap?.call(item),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none_outlined,
              color: AppColors.darkMuted,
              size: 64,
            ),
            SizedBox(height: 16),
            Text('mobile.auto.no_notifications_yet'.tr(),
              style: TextStyle(
                color: AppColors.textSecondaryDark,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'mobile.leftovers.you_re_all_caught_up_check_back_later_fo'.tr(),
              style: TextStyle(color: AppColors.darkMuted, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getNotificationIcon(String? ruleKey) {
    switch (ruleKey?.toLowerCase()) {
      case 'message':
      case 'chat':
        return Icons.message_outlined;
      case 'property':
      case 'listing':
        return Icons.home_outlined;
      case 'booking':
      case 'reservation':
        return Icons.calendar_today_outlined;
      case 'payment':
      case 'transaction':
        return Icons.payment_outlined;
      case 'document':
      case 'contract':
        return Icons.description_outlined;
      case 'system':
      case 'admin':
        return Icons.settings_outlined;
      case 'alert':
      case 'warning':
        return Icons.warning_amber_outlined;
      case 'success':
        return Icons.check_circle_outline;
      case 'error':
        return Icons.error_outline;
      case 'task':
      case 'todo':
        return Icons.task_alt_outlined;
      case 'lead':
      case 'client':
        return Icons.person_outline;
      case 'agent':
        return Icons.support_agent_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'mobile.leftovers.just_now'.tr();
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('mobile.leftovers.mmm_d_yyyy'.tr()).format(timestamp);
    }
  }
}
