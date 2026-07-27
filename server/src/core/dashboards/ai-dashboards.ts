/**
 * AI OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const aiDashboards: DashboardConfig[] = [
  {
    id: 'ai-executive',
    name: 'Executive Dashboard',
    description: 'High-level AI metrics for executives',
    osModule: 'AIOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'AI Models',
        metricName: 'models.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Predictions',
        metricName: 'predictions.total',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Accuracy',
        metricName: 'models.accuracy',
        config: { format: 'percentage' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Processing Time',
        metricName: 'performance.avg_time',
        config: { format: 'number' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Prediction Trend',
        metricName: 'predictions.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Accuracy Trend',
        metricName: 'models.accuracy_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Top Models',
        metricName: 'models.top',
        config: { columns: ['name', 'type', 'predictions', 'accuracy', 'processing_time'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'ai-models',
    name: 'Models Dashboard',
    description: 'AI model performance and metrics',
    osModule: 'AIOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Active Models',
        metricName: 'models.active',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Model Accuracy',
        metricName: 'models.avg_accuracy',
        config: { format: 'percentage' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Model Deployments',
        metricName: 'models.deployments',
        config: { format: 'number' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Models by Type',
        metricName: 'models.by_type',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Model Performance',
        metricName: 'models.performance',
        config: { chartType: 'bar' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Accuracy Trend',
        metricName: 'models.accuracy_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Model Details',
        metricName: 'models.details',
        config: { columns: ['name', 'type', 'accuracy', 'predictions', 'status'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'ai-predictions',
    name: 'Predictions Dashboard',
    description: 'AI prediction metrics and analytics',
    osModule: 'AIOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Predictions',
        metricName: 'predictions.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Predictions Today',
        metricName: 'predictions.today',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Prediction Accuracy',
        metricName: 'predictions.accuracy',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Prediction Trend',
        metricName: 'predictions.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Predictions by Type',
        metricName: 'predictions.by_type',
        config: { chartType: 'pie' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Prediction Details',
        metricName: 'predictions.details',
        config: { columns: ['type', 'count', 'accuracy', 'avg_confidence'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register AI OS dashboards
 */
export function registerAIDashboards() {
  aiDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[AIOS] Registered ${aiDashboards.length} dashboards`);
}
