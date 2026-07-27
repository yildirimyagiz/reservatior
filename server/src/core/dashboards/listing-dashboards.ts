/**
 * Listing OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const listingDashboards: DashboardConfig[] = [
  {
    id: 'listing-executive',
    name: 'Executive Dashboard',
    description: 'High-level listing metrics for executives',
    osModule: 'ListingOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Listings',
        metricName: 'listings.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Listings',
        metricName: 'listings.active',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Pending',
        metricName: 'listings.pending',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Total Views',
        metricName: 'listings.views',
        config: { format: 'number' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Listing Trend',
        metricName: 'listings.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Views Trend',
        metricName: 'listings.views_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Top Listings',
        metricName: 'listings.top',
        config: { columns: ['property', 'views', 'inquiries', 'status', 'price'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'listing-performance',
    name: 'Performance Dashboard',
    description: 'Listing performance metrics and analytics',
    osModule: 'ListingOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Avg Views per Listing',
        metricName: 'listings.avg_views',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Inquiries',
        metricName: 'listings.avg_inquiries',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Conversion Rate',
        metricName: 'listings.conversion_rate',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Performance by Type',
        metricName: 'listings.performance_by_type',
        config: { chartType: 'bar' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Views Distribution',
        metricName: 'listings.views_distribution',
        config: { chartType: 'pie' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Performance Trend',
        metricName: 'listings.performance_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Listing Performance',
        metricName: 'listings.performance',
        config: { columns: ['property', 'views', 'inquiries', 'conversion', 'engagement'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'listing-views',
    name: 'Views Dashboard',
    description: 'Listing views and engagement metrics',
    osModule: 'ListingOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Views',
        metricName: 'views.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Unique Visitors',
        metricName: 'views.unique',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Session Duration',
        metricName: 'views.avg_duration',
        config: { format: 'number' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Views Trend',
        metricName: 'views.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Views by Source',
        metricName: 'views.by_source',
        config: { chartType: 'pie' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Listing Views Details',
        metricName: 'views.details',
        config: { columns: ['property', 'total_views', 'unique', 'avg_duration', 'bounce_rate'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Listing OS dashboards
 */
export function registerListingDashboards() {
  listingDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[ListingOS] Registered ${listingDashboards.length} dashboards`);
}
