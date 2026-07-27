/**
 * Partner OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const partnerDashboards: DashboardConfig[] = [
  {
    id: 'partner-executive',
    name: 'Executive Dashboard',
    description: 'High-level partner metrics for executives',
    osModule: 'PartnerOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Partners',
        metricName: 'partners.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Partnerships',
        metricName: 'partnerships.active',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Partner Revenue',
        metricName: 'revenue.total',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Satisfaction',
        metricName: 'partners.satisfaction',
        config: { format: 'decimal' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Partner Trend',
        metricName: 'partners.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Revenue Trend',
        metricName: 'revenue.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Top Partners',
        metricName: 'partners.top',
        config: { columns: ['partner', 'type', 'revenue', 'satisfaction', 'status'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'partner-relationships',
    name: 'Relationships Dashboard',
    description: 'Partner relationship management metrics',
    osModule: 'PartnerOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Partners',
        metricName: 'partners.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Partners',
        metricName: 'partners.active',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Partnership Duration',
        metricName: 'partnerships.avg_duration',
        config: { format: 'number' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Partners by Type',
        metricName: 'partners.by_type',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Partner Status',
        metricName: 'partners.status',
        config: { chartType: 'bar' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Partnership Growth',
        metricName: 'partnerships.growth',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Partner Details',
        metricName: 'partners.details',
        config: { columns: ['partner', 'type', 'status', 'duration', 'satisfaction'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'partner-revenue',
    name: 'Revenue Dashboard',
    description: 'Partner revenue and performance metrics',
    osModule: 'PartnerOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Partner Revenue',
        metricName: 'revenue.total',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Revenue per Partner',
        metricName: 'revenue.avg_per_partner',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Revenue Growth',
        metricName: 'revenue.growth',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Revenue by Partner',
        metricName: 'revenue.by_partner',
        config: { chartType: 'bar' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Revenue Trend',
        metricName: 'revenue.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Revenue by Type',
        metricName: 'revenue.by_type',
        config: { chartType: 'pie' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Revenue Details',
        metricName: 'revenue.details',
        config: { columns: ['partner', 'revenue', 'growth', 'contribution', 'status'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Partner OS dashboards
 */
export function registerPartnerDashboards() {
  partnerDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[PartnerOS] Registered ${partnerDashboards.length} dashboards`);
}
