/**
 * Trust OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const trustDashboards: DashboardConfig[] = [
  {
    id: 'trust-executive',
    name: 'Executive Dashboard',
    description: 'High-level trust and verification metrics',
    osModule: 'TrustOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Verifications',
        metricName: 'verifications.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Completed',
        metricName: 'verifications.completed',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Pending',
        metricName: 'verifications.pending',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Trust Score',
        metricName: 'trust.avg_score',
        config: { format: 'decimal' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Verification Trend',
        metricName: 'verifications.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Trust Score Distribution',
        metricName: 'trust.score_distribution',
        config: { chartType: 'bar' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Recent Verifications',
        metricName: 'verifications.recent',
        config: { columns: ['entity', 'type', 'status', 'score', 'date'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'trust-verifications',
    name: 'Verifications Dashboard',
    description: 'Verification process metrics and status',
    osModule: 'TrustOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Verification Rate',
        metricName: 'verifications.rate',
        config: { format: 'percentage' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Processing Time',
        metricName: 'verifications.avg_time',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Success Rate',
        metricName: 'verifications.success_rate',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Verifications by Type',
        metricName: 'verifications.by_type',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Verification Status',
        metricName: 'verifications.status',
        config: { chartType: 'bar' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Processing Time Trend',
        metricName: 'verifications.time_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Verification Details',
        metricName: 'verifications.details',
        config: { columns: ['entity', 'type', 'status', 'processing_time', 'result'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'trust-scores',
    name: 'Trust Scores Dashboard',
    description: 'Trust score analytics and distribution',
    osModule: 'TrustOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Avg Trust Score',
        metricName: 'trust.avg_score',
        config: { format: 'decimal' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'High Trust Entities',
        metricName: 'trust.high_count',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Score Improvement',
        metricName: 'trust.improvement',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Score Distribution',
        metricName: 'trust.score_distribution',
        config: { chartType: 'bar' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Score by Entity Type',
        metricName: 'trust.by_entity_type',
        config: { chartType: 'pie' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Score Trend',
        metricName: 'trust.score_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Entity Trust Scores',
        metricName: 'trust.entity_scores',
        config: { columns: ['entity', 'type', 'score', 'tier', 'trend'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Trust OS dashboards
 */
export function registerTrustDashboards() {
  trustDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[TrustOS] Registered ${trustDashboards.length} dashboards`);
}
