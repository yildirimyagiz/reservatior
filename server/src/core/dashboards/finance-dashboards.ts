/**
 * Finance OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const financeDashboards: DashboardConfig[] = [
  {
    id: 'finance-executive',
    name: 'Executive Dashboard',
    description: 'High-level financial metrics for executives',
    osModule: 'FinanceOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Revenue',
        metricName: 'revenue.total',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Total Expenses',
        metricName: 'expenses.total',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Net Profit',
        metricName: 'profit.net',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Profit Margin',
        metricName: 'profit.margin',
        config: { format: 'percentage' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Revenue Trend',
        metricName: 'revenue.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Expense Trend',
        metricName: 'expenses.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Financial Summary',
        metricName: 'finance.summary',
        config: { columns: ['category', 'revenue', 'expenses', 'profit', 'margin'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'finance-revenue',
    name: 'Revenue Dashboard',
    description: 'Detailed revenue metrics and breakdowns',
    osModule: 'FinanceOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Monthly Recurring Revenue',
        metricName: 'revenue.mrr',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Average Transaction Value',
        metricName: 'revenue.avg_transaction',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Revenue Growth Rate',
        metricName: 'revenue.growth_rate',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Revenue by Source',
        metricName: 'revenue.by_source',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Revenue by Region',
        metricName: 'revenue.by_region',
        config: { chartType: 'bar' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Revenue Forecast',
        metricName: 'revenue.forecast',
        config: { chartType: 'line', forecast: true },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Revenue Breakdown',
        metricName: 'revenue.breakdown',
        config: { columns: ['source', 'revenue', 'transactions', 'avg_value', 'growth'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'finance-expenses',
    name: 'Expenses Dashboard',
    description: 'Expense tracking and analysis',
    osModule: 'FinanceOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Expenses',
        metricName: 'expenses.total',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Operating Expenses',
        metricName: 'expenses.operating',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Cost Reduction',
        metricName: 'expenses.reduction',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Expenses by Category',
        metricName: 'expenses.by_category',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Expense Trend',
        metricName: 'expenses.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Budget vs Actual',
        metricName: 'expenses.budget_comparison',
        config: { chartType: 'bar' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Expense Details',
        metricName: 'expenses.details',
        config: { columns: ['category', 'amount', 'budget', 'variance', 'trend'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Finance OS dashboards
 */
export function registerFinanceDashboards() {
  financeDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[FinanceOS] Registered ${financeDashboards.length} dashboards`);
}
