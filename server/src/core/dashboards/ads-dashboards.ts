/**
 * Ads OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const adsDashboards: DashboardConfig[] = [
  {
    id: 'ads-executive',
    name: 'Executive Dashboard',
    description: 'High-level advertising metrics for executives',
    osModule: 'AdsOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Active Campaigns',
        metricName: 'campaigns.active',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Total Spend',
        metricName: 'spend.total',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Impressions',
        metricName: 'impressions.total',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'CTR',
        metricName: 'performance.ctr',
        config: { format: 'percentage' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Spend Trend',
        metricName: 'spend.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Performance Trend',
        metricName: 'performance.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Top Campaigns',
        metricName: 'campaigns.top',
        config: { columns: ['name', 'platform', 'spend', 'impressions', 'ctr', 'conversions'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'ads-campaigns',
    name: 'Campaigns Dashboard',
    description: 'Campaign performance and management metrics',
    osModule: 'AdsOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Campaigns',
        metricName: 'campaigns.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Campaign Spend',
        metricName: 'campaigns.avg_spend',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Campaign Success Rate',
        metricName: 'campaigns.success_rate',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Campaigns by Platform',
        metricName: 'campaigns.by_platform',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Campaign Status',
        metricName: 'campaigns.status',
        config: { chartType: 'bar' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Campaign Performance',
        metricName: 'campaigns.performance',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Campaign Details',
        metricName: 'campaigns.details',
        config: { columns: ['name', 'platform', 'status', 'spend', 'impressions', 'ctr', 'conversions'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'ads-performance',
    name: 'Performance Dashboard',
    description: 'Ad performance metrics and analytics',
    osModule: 'AdsOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Avg CTR',
        metricName: 'performance.avg_ctr',
        config: { format: 'percentage' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg CPC',
        metricName: 'performance.avg_cpc',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Conversion Rate',
        metricName: 'performance.conversion_rate',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'CTR Trend',
        metricName: 'performance.ctr_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Performance by Platform',
        metricName: 'performance.by_platform',
        config: { chartType: 'bar' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'ROAS Trend',
        metricName: 'performance.roas_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Performance by Campaign',
        metricName: 'performance.by_campaign',
        config: { columns: ['campaign', 'ctr', 'cpc', 'conversions', 'roas'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Ads OS dashboards
 */
export function registerAdsDashboards() {
  adsDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[AdsOS] Registered ${adsDashboards.length} dashboards`);
}
