/**
 * Notification OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const notificationDashboards: DashboardConfig[] = [
  {
    id: 'notification-overview',
    name: 'Notification Overview',
    description: 'Overview of notification system metrics',
    osModule: 'NotificationOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Sent',
        metricName: 'notifications.total_sent',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Pending Queue',
        metricName: 'notifications.pending_queue',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Delivery Rate',
        metricName: 'notifications.delivery_rate',
        config: { format: 'percentage' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Failed Notifications',
        metricName: 'notifications.failed',
        config: { format: 'number' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Notifications Sent Trend',
        metricName: 'notifications.sent_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Notifications by Channel',
        metricName: 'notifications.by_channel',
        config: { chartType: 'pie' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Recent Notifications',
        metricName: 'notifications.recent',
        config: { columns: ['type', 'channel', 'status', 'sent_at', 'user'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'notification-channels',
    name: 'Channel Performance',
    description: 'Performance metrics by notification channel',
    osModule: 'NotificationOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Email Delivery Rate',
        metricName: 'channels.email.delivery_rate',
        config: { format: 'percentage' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'SMS Delivery Rate',
        metricName: 'channels.sms.delivery_rate',
        config: { format: 'percentage' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'WhatsApp Delivery Rate',
        metricName: 'channels.whatsapp.delivery_rate',
        config: { format: 'percentage' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Push Delivery Rate',
        metricName: 'channels.push.delivery_rate',
        config: { format: 'percentage' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Channel Volume Trend',
        metricName: 'channels.volume_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Channel Latency',
        metricName: 'channels.latency',
        config: { chartType: 'bar' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Channel Performance',
        metricName: 'channels.performance',
        config: { columns: ['channel', 'sent', 'delivered', 'failed', 'delivery_rate', 'avg_latency'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'notification-rules',
    name: 'Notification Rules',
    description: 'Notification rules and automation metrics',
    osModule: 'NotificationOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Active Rules',
        metricName: 'rules.active',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Rules Triggered Today',
        metricName: 'rules.triggered_today',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Average Trigger Rate',
        metricName: 'rules.avg_trigger_rate',
        config: { format: 'number' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Rule Triggers Trend',
        metricName: 'rules.triggers_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Rules by Event Type',
        metricName: 'rules.by_event_type',
        config: { chartType: 'bar' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Top Performing Rules',
        metricName: 'rules.top_performing',
        config: { columns: ['rule_name', 'event_type', 'triggers', 'notifications_sent', 'efficiency'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'notification-user-preferences',
    name: 'User Preferences',
    description: 'User notification preferences and engagement',
    osModule: 'NotificationOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Users with Preferences',
        metricName: 'preferences.users_set',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Digest Enabled',
        metricName: 'preferences.digest_enabled',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Quiet Hours Set',
        metricName: 'preferences.quiet_hours_set',
        config: { format: 'number' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Channel Preferences',
        metricName: 'preferences.channel_distribution',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Digest Frequency Distribution',
        metricName: 'preferences.digest_frequency',
        config: { chartType: 'bar' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Preference Changes Trend',
        metricName: 'preferences.changes_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Preference Patterns',
        metricName: 'preferences.patterns',
        config: { columns: ['pattern', 'user_count', 'percentage', 'engagement_rate'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Notification OS dashboards
 */
export function registerNotificationDashboards() {
  notificationDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[NotificationOS] Registered ${notificationDashboards.length} dashboards`);
}
