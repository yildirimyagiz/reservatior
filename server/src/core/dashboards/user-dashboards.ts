/**
 * User OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const userDashboards: DashboardConfig[] = [
  {
    id: 'user-executive',
    name: 'Executive Dashboard',
    description: 'High-level user metrics for executives',
    osModule: 'UserOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Users',
        metricName: 'users.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Users',
        metricName: 'users.active',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'New This Month',
        metricName: 'users.new',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Engagement Rate',
        metricName: 'users.engagement',
        config: { format: 'percentage' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'User Growth Trend',
        metricName: 'users.growth_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Engagement Trend',
        metricName: 'users.engagement_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Recent Users',
        metricName: 'users.recent',
        config: { columns: ['user', 'email', 'status', 'joined', 'last_active'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'user-growth',
    name: 'Growth Dashboard',
    description: 'User growth and acquisition metrics',
    osModule: 'UserOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Users',
        metricName: 'users.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'New Users Today',
        metricName: 'users.today',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Growth Rate',
        metricName: 'users.growth_rate',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'User Growth Trend',
        metricName: 'users.growth_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Users by Acquisition Channel',
        metricName: 'users.by_channel',
        config: { chartType: 'pie' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Growth Details',
        metricName: 'users.growth_details',
        config: { columns: ['channel', 'new_users', 'growth_rate', 'cost_per_user'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'user-engagement',
    name: 'Engagement Dashboard',
    description: 'User engagement and activity metrics',
    osModule: 'UserOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Active Users',
        metricName: 'users.active',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Daily Active Users',
        metricName: 'users.dau',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Session Duration',
        metricName: 'users.avg_session',
        config: { format: 'number' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Engagement Trend',
        metricName: 'users.engagement_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Activity by Time',
        metricName: 'users.activity_by_time',
        config: { chartType: 'bar' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Engagement Metrics',
        metricName: 'users.engagement_metrics',
        config: { columns: ['metric', 'value', 'change', 'trend'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register User OS dashboards
 */
export function registerUserDashboards() {
  userDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[UserOS] Registered ${userDashboards.length} dashboards`);
}
