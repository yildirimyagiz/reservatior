/**
 * Investment OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const investmentDashboards: DashboardConfig[] = [
  {
    id: 'investment-executive',
    name: 'Executive Dashboard',
    description: 'High-level investment metrics for executives',
    osModule: 'InvestmentOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Investments',
        metricName: 'investments.total',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Projects',
        metricName: 'projects.active',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'ROI',
        metricName: 'performance.roi',
        config: { format: 'percentage' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Investors',
        metricName: 'investors.total',
        config: { format: 'number' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Investment Trend',
        metricName: 'investments.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'ROI Trend',
        metricName: 'performance.roi_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Top Investments',
        metricName: 'investments.top',
        config: { columns: ['project', 'investment', 'roi', 'status', 'investor'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'investment-portfolio',
    name: 'Portfolio Dashboard',
    description: 'Investment portfolio performance metrics',
    osModule: 'InvestmentOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Portfolio Value',
        metricName: 'portfolio.value',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg ROI',
        metricName: 'portfolio.avg_roi',
        config: { format: 'percentage' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Portfolio Growth',
        metricName: 'portfolio.growth',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Portfolio by Type',
        metricName: 'portfolio.by_type',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Portfolio Performance',
        metricName: 'portfolio.performance',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Risk Distribution',
        metricName: 'portfolio.risk',
        config: { chartType: 'bar' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Portfolio Details',
        metricName: 'portfolio.details',
        config: { columns: ['project', 'type', 'value', 'roi', 'risk', 'status'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'investment-roi',
    name: 'ROI Dashboard',
    description: 'Return on investment analytics',
    osModule: 'InvestmentOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total ROI',
        metricName: 'roi.total',
        config: { format: 'percentage' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Annual ROI',
        metricName: 'roi.annual',
        config: { format: 'percentage' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Best Performing',
        metricName: 'roi.best',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'ROI Trend',
        metricName: 'roi.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'ROI by Project',
        metricName: 'roi.by_project',
        config: { chartType: 'bar' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'ROI Details',
        metricName: 'roi.details',
        config: { columns: ['project', 'investment', 'return', 'roi', 'period'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Investment OS dashboards
 */
export function registerInvestmentDashboards() {
  investmentDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[InvestmentOS] Registered ${investmentDashboards.length} dashboards`);
}
