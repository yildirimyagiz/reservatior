/**
 * DevAPI OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const devapiDashboards: DashboardConfig[] = [
  {
    id: 'devapi-executive',
    name: 'Executive Dashboard',
    description: 'High-level API metrics for executives',
    osModule: 'DevAPIOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'API Calls',
        metricName: 'api.calls',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active API Keys',
        metricName: 'keys.active',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Rate Limit Usage',
        metricName: 'rate_limit.usage',
        config: { format: 'percentage' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Latency',
        metricName: 'performance.avg_latency',
        config: { format: 'number' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'API Calls Trend',
        metricName: 'api.calls_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Latency Trend',
        metricName: 'performance.latency_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Top API Keys',
        metricName: 'keys.top',
        config: { columns: ['key', 'calls', 'errors', 'avg_latency', 'last_used'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'devapi-usage',
    name: 'Usage Dashboard',
    description: 'API usage and consumption metrics',
    osModule: 'DevAPIOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total API Calls',
        metricName: 'api.total_calls',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Calls Today',
        metricName: 'api.calls_today',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Error Rate',
        metricName: 'api.error_rate',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'API Calls by Endpoint',
        metricName: 'api.by_endpoint',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Usage Trend',
        metricName: 'api.usage_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Error Rate Trend',
        metricName: 'api.error_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Endpoint Usage',
        metricName: 'api.endpoint_usage',
        config: { columns: ['endpoint', 'calls', 'errors', 'avg_latency', 'p95_latency'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'devapi-keys',
    name: 'API Keys Dashboard',
    description: 'API key management and security metrics',
    osModule: 'DevAPIOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total API Keys',
        metricName: 'keys.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Keys',
        metricName: 'keys.active',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Revoked Keys',
        metricName: 'keys.revoked',
        config: { format: 'number' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Keys by Status',
        metricName: 'keys.by_status',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Key Usage',
        metricName: 'keys.usage',
        config: { chartType: 'bar' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Key Creation Trend',
        metricName: 'keys.creation_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'API Key Details',
        metricName: 'keys.details',
        config: { columns: ['key', 'status', 'created', 'last_used', 'calls'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register DevAPI OS dashboards
 */
export function registerDevAPIDashboards() {
  devapiDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[DevAPIOS] Registered ${devapiDashboards.length} dashboards`);
}
