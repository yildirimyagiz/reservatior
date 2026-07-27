/**
 * Agent OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const agentDashboards: DashboardConfig[] = [
  {
    id: 'agent-executive',
    name: 'Executive Dashboard',
    description: 'High-level agent performance metrics for executives',
    osModule: 'AgentOS',
    refreshInterval: 300000, // 5 minutes
    widgets: [
      {
        type: 'metric',
        title: 'Total Agents',
        metricName: 'agents.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Agents',
        metricName: 'agents.active',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Total Commissions',
        metricName: 'commissions.total',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Performance',
        metricName: 'agents.avg_performance',
        config: { format: 'percentage' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Commission Trend',
        metricName: 'commissions.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Agent Activity',
        metricName: 'agents.activity',
        config: { chartType: 'bar', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Top Performing Agents',
        metricName: 'agents.top_performers',
        config: { columns: ['name', 'commissions', 'deals', 'performance'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'agent-performance',
    name: 'Performance Dashboard',
    description: 'Detailed agent performance metrics and KPIs',
    osModule: 'AgentOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Avg Commission per Agent',
        metricName: 'commissions.avg_per_agent',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Deals per Agent',
        metricName: 'agents.avg_deals',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Conversion Rate',
        metricName: 'agents.conversion_rate',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Performance Distribution',
        metricName: 'agents.performance_distribution',
        config: { chartType: 'bar' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Commission by Tier',
        metricName: 'commissions.by_tier',
        config: { chartType: 'pie' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Performance Trend',
        metricName: 'agents.performance_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Agent Performance Details',
        metricName: 'agents.performance_details',
        config: { columns: ['name', 'tier', 'commissions', 'deals', 'performance', 'conversion'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'agent-team',
    name: 'Team Dashboard',
    description: 'Agent team management and collaboration metrics',
    osModule: 'AgentOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Teams',
        metricName: 'teams.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Teams',
        metricName: 'teams.active',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Team Size',
        metricName: 'teams.avg_size',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Team Collaboration Score',
        metricName: 'teams.collaboration_score',
        config: { format: 'decimal' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Team Performance',
        metricName: 'teams.performance',
        config: { chartType: 'bar' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Team Growth',
        metricName: 'teams.growth',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Team Details',
        metricName: 'teams.details',
        config: { columns: ['name', 'size', 'performance', 'commissions', 'collaboration'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Agent OS dashboards
 */
export function registerAgentDashboards() {
  agentDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[AgentOS] Registered ${agentDashboards.length} dashboards`);
}
