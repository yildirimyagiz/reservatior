/**
 * Analytics OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const analyticsDashboards: DashboardConfig[] = [
  {
    id: 'analytics-executive',
    name: 'Executive Dashboard',
    description: 'High-level business metrics and KPIs for executives',
    osModule: 'AnalyticsOS',
    refreshInterval: 300000, // 5 minutes
    widgets: [
      {
        type: 'metric',
        title: 'Total Revenue',
        metricName: 'revenue.total',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Properties',
        metricName: 'properties.active',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Users',
        metricName: 'users.active',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Revenue Trend',
        metricName: 'revenue.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'User Growth',
        metricName: 'users.growth',
        config: { chartType: 'bar', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Top Performing Agents',
        metricName: 'agents.top_performers',
        config: { columns: ['name', 'revenue', 'deals', 'conversion_rate'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'analytics-revenue',
    name: 'Revenue Analytics',
    description: 'Detailed revenue metrics and breakdowns',
    osModule: 'AnalyticsOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Monthly Recurring Revenue',
        metricName: 'revenue.mrr',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Average Deal Size',
        metricName: 'revenue.avg_deal_size',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Revenue Growth Rate',
        metricName: 'revenue.growth_rate',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Revenue by Source',
        metricName: 'revenue.by_source',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Revenue by Region',
        metricName: 'revenue.by_region',
        config: { chartType: 'bar' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Revenue Forecast',
        metricName: 'revenue.forecast',
        config: { chartType: 'line', forecast: true },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Revenue by Property Type',
        metricName: 'revenue.by_property_type',
        config: { columns: ['property_type', 'revenue', 'deals', 'avg_price'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'analytics-property',
    name: 'Property Analytics',
    description: 'Property performance metrics and insights',
    osModule: 'AnalyticsOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Properties',
        metricName: 'properties.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Published Properties',
        metricName: 'properties.published',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Pending Approval',
        metricName: 'properties.pending',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Average Days to Publish',
        metricName: 'properties.avg_days_to_publish',
        config: { format: 'number' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Property Views Trend',
        metricName: 'properties.views_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Property Inquiries',
        metricName: 'properties.inquiries',
        config: { chartType: 'bar', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'heatmap',
        title: 'Property Performance by Region',
        metricName: 'properties.performance_heatmap',
        config: { metric: 'views_per_property' },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'analytics-user',
    name: 'User Analytics',
    description: 'User behavior and engagement metrics',
    osModule: 'AnalyticsOS',
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
        title: 'Daily Active Users',
        metricName: 'users.dau',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Monthly Active Users',
        metricName: 'users.mau',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Conversion Rate',
        metricName: 'users.conversion_rate',
        config: { format: 'percentage' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'User Acquisition Trend',
        metricName: 'users.acquisition_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'User Retention',
        metricName: 'users.retention',
        config: { chartType: 'area' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'User Segments',
        metricName: 'users.segments',
        config: { columns: ['segment', 'users', 'conversion_rate', 'avg_revenue'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'analytics-ai',
    name: 'AI Analytics',
    description: 'AI-powered insights and recommendations',
    osModule: 'AnalyticsOS',
    refreshInterval: 600000, // 10 minutes
    widgets: [
      {
        type: 'metric',
        title: 'AI Predictions Accuracy',
        metricName: 'ai.prediction_accuracy',
        config: { format: 'percentage' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'AI Recommendations Generated',
        metricName: 'ai.recommendations_generated',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'AI Recommendations Accepted',
        metricName: 'ai.recommendations_accepted',
        config: { format: 'number' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'AI Model Performance',
        metricName: 'ai.model_performance',
        config: { chartType: 'line' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'AI Feature Usage',
        metricName: 'ai.feature_usage',
        config: { chartType: 'bar' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Active AI Insights',
        metricName: 'ai.active_insights',
        config: { columns: ['type', 'confidence', 'impact', 'action_items'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Analytics OS dashboards
 */
export function registerAnalyticsDashboards() {
  analyticsDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[AnalyticsOS] Registered ${analyticsDashboards.length} dashboards`);
}
