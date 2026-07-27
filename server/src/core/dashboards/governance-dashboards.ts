/**
 * Governance OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const governanceDashboards: DashboardConfig[] = [
  {
    id: 'governance-executive',
    name: 'Executive Dashboard',
    description: 'High-level governance metrics for executives',
    osModule: 'GovernanceOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Active Policies',
        metricName: 'policies.active',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Compliance Score',
        metricName: 'compliance.score',
        config: { format: 'percentage' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Audits Completed',
        metricName: 'audits.completed',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Risk Level',
        metricName: 'risk.level',
        config: { format: 'decimal' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Compliance Trend',
        metricName: 'compliance.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Risk Assessment',
        metricName: 'risk.assessment',
        config: { chartType: 'bar' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Recent Audits',
        metricName: 'audits.recent',
        config: { columns: ['audit', 'type', 'status', 'score', 'date'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'governance-compliance',
    name: 'Compliance Dashboard',
    description: 'Compliance monitoring and metrics',
    osModule: 'GovernanceOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Overall Compliance',
        metricName: 'compliance.overall',
        config: { format: 'percentage' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'GDPR Compliance',
        metricName: 'compliance.gdpr',
        config: { format: 'percentage' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'CCPA Compliance',
        metricName: 'compliance.ccpa',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Compliance by Framework',
        metricName: 'compliance.by_framework',
        config: { chartType: 'bar' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Compliance Trend',
        metricName: 'compliance.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Violations by Type',
        metricName: 'compliance.violations',
        config: { chartType: 'pie' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Compliance Details',
        metricName: 'compliance.details',
        config: { columns: ['framework', 'score', 'status', 'violations', 'last_audit'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'governance-audits',
    name: 'Audits Dashboard',
    description: 'Audit management and results',
    osModule: 'GovernanceOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Audits',
        metricName: 'audits.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Pending Audits',
        metricName: 'audits.pending',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Audit Success Rate',
        metricName: 'audits.success_rate',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Audits by Type',
        metricName: 'audits.by_type',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Audit Results',
        metricName: 'audits.results',
        config: { chartType: 'bar' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Audit Trend',
        metricName: 'audits.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Audit Details',
        metricName: 'audits.details',
        config: { columns: ['audit', 'type', 'status', 'score', 'findings', 'date'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Governance OS dashboards
 */
export function registerGovernanceDashboards() {
  governanceDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[GovernanceOS] Registered ${governanceDashboards.length} dashboards`);
}
