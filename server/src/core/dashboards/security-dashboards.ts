/**
 * Security OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const securityDashboards: DashboardConfig[] = [
  {
    id: 'security-executive',
    name: 'Executive Dashboard',
    description: 'High-level security metrics for executives',
    osModule: 'SecurityOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Threats Blocked',
        metricName: 'threats.blocked',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Security Score',
        metricName: 'security.score',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Alerts',
        metricName: 'alerts.active',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Compliance',
        metricName: 'compliance.score',
        config: { format: 'percentage' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Threat Trend',
        metricName: 'threats.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Security Score Trend',
        metricName: 'security.score_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Recent Threats',
        metricName: 'threats.recent',
        config: { columns: ['threat', 'type', 'severity', 'status', 'date'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'security-threats',
    name: 'Threats Dashboard',
    description: 'Security threat monitoring and metrics',
    osModule: 'SecurityOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Threats',
        metricName: 'threats.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Threats Blocked',
        metricName: 'threats.blocked',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Threat Response Time',
        metricName: 'threats.response_time',
        config: { format: 'number' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Threats by Type',
        metricName: 'threats.by_type',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Threat Severity',
        metricName: 'threats.severity',
        config: { chartType: 'bar' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Threat Trend',
        metricName: 'threats.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Threat Details',
        metricName: 'threats.details',
        config: { columns: ['threat', 'type', 'severity', 'status', 'response_time'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'security-incidents',
    name: 'Incidents Dashboard',
    description: 'Security incident management metrics',
    osModule: 'SecurityOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Incidents',
        metricName: 'incidents.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Resolved Incidents',
        metricName: 'incidents.resolved',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Incident Resolution Rate',
        metricName: 'incidents.resolution_rate',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Incidents by Severity',
        metricName: 'incidents.by_severity',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Incident Trend',
        metricName: 'incidents.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Resolution Time Trend',
        metricName: 'incidents.resolution_time_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Incident Details',
        metricName: 'incidents.details',
        config: { columns: ['incident', 'severity', 'status', 'resolution_time', 'date'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Security OS dashboards
 */
export function registerSecurityDashboards() {
  securityDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[SecurityOS] Registered ${securityDashboards.length} dashboards`);
}
