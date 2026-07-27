/**
 * CRM OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const crmDashboards: DashboardConfig[] = [
  {
    id: 'crm-executive',
    name: 'Executive Dashboard',
    description: 'High-level CRM metrics for executives',
    osModule: 'CRMOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Contacts',
        metricName: 'contacts.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Deals',
        metricName: 'deals.active',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Pipeline Value',
        metricName: 'pipeline.value',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Conversion Rate',
        metricName: 'conversion.rate',
        config: { format: 'percentage' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Pipeline Trend',
        metricName: 'pipeline.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Conversion Trend',
        metricName: 'conversion.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Top Deals',
        metricName: 'deals.top',
        config: { columns: ['deal', 'contact', 'value', 'stage', 'probability'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'crm-pipeline',
    name: 'Pipeline Dashboard',
    description: 'Sales pipeline and deal management metrics',
    osModule: 'CRMOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Pipeline Value',
        metricName: 'pipeline.total_value',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Deal Size',
        metricName: 'deals.avg_size',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Deal Velocity',
        metricName: 'deals.velocity',
        config: { format: 'number' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Pipeline by Stage',
        metricName: 'pipeline.by_stage',
        config: { chartType: 'bar' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Deal Flow',
        metricName: 'deals.flow',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Win Rate by Stage',
        metricName: 'deals.win_rate',
        config: { chartType: 'line' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Pipeline Details',
        metricName: 'pipeline.details',
        config: { columns: ['stage', 'deals', 'value', 'avg_size', 'probability'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'crm-leads',
    name: 'Leads Dashboard',
    description: 'Lead generation and management metrics',
    osModule: 'CRMOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Leads',
        metricName: 'leads.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'New Leads Today',
        metricName: 'leads.today',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Lead Conversion Rate',
        metricName: 'leads.conversion_rate',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Lead Trend',
        metricName: 'leads.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Leads by Source',
        metricName: 'leads.by_source',
        config: { chartType: 'pie' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Lead Details',
        metricName: 'leads.details',
        config: { columns: ['name', 'source', 'status', 'score', 'assigned_to'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register CRM OS dashboards
 */
export function registerCRMDashboards() {
  crmDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[CRMOS] Registered ${crmDashboards.length} dashboards`);
}
