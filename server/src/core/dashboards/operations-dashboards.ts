/**
 * Operations OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const operationsDashboards: DashboardConfig[] = [
  {
    id: 'operations-executive',
    name: 'Executive Dashboard',
    description: 'High-level operations metrics for executives',
    osModule: 'OperationsOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Tasks',
        metricName: 'tasks.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Completed',
        metricName: 'tasks.completed',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Pending',
        metricName: 'tasks.pending',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Efficiency',
        metricName: 'operations.efficiency',
        config: { format: 'percentage' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Task Trend',
        metricName: 'tasks.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Efficiency Trend',
        metricName: 'operations.efficiency_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Recent Tasks',
        metricName: 'tasks.recent',
        config: { columns: ['task', 'type', 'status', 'assigned_to', 'due_date'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'operations-tasks',
    name: 'Tasks Dashboard',
    description: 'Task management and completion metrics',
    osModule: 'OperationsOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Tasks',
        metricName: 'tasks.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Completion Time',
        metricName: 'tasks.avg_completion_time',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Task Success Rate',
        metricName: 'tasks.success_rate',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Tasks by Status',
        metricName: 'tasks.by_status',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Task Trend',
        metricName: 'tasks.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Tasks by Category',
        metricName: 'tasks.by_category',
        config: { chartType: 'bar' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Task Details',
        metricName: 'tasks.details',
        config: { columns: ['task', 'category', 'status', 'assigned_to', 'completion_time'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'operations-efficiency',
    name: 'Efficiency Dashboard',
    description: 'Operational efficiency metrics',
    osModule: 'OperationsOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Overall Efficiency',
        metricName: 'efficiency.overall',
        config: { format: 'percentage' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Resource Utilization',
        metricName: 'efficiency.resource_utilization',
        config: { format: 'percentage' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Process Improvement',
        metricName: 'efficiency.improvement',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Efficiency Trend',
        metricName: 'efficiency.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Efficiency by Department',
        metricName: 'efficiency.by_department',
        config: { chartType: 'bar' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Efficiency Metrics',
        metricName: 'efficiency.metrics',
        config: { columns: ['department', 'efficiency', 'utilization', 'tasks_completed', 'avg_time'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Operations OS dashboards
 */
export function registerOperationsDashboards() {
  operationsDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[OperationsOS] Registered ${operationsDashboards.length} dashboards`);
}
