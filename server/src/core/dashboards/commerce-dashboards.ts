/**
 * Commerce OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const commerceDashboards: DashboardConfig[] = [
  {
    id: 'commerce-executive',
    name: 'Executive Dashboard',
    description: 'High-level commerce metrics for executives',
    osModule: 'CommerceOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Orders',
        metricName: 'orders.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Total Revenue',
        metricName: 'revenue.total',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Products',
        metricName: 'products.total',
        config: { format: 'number' },
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
        title: 'Orders Trend',
        metricName: 'orders.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Revenue Trend',
        metricName: 'revenue.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Recent Orders',
        metricName: 'orders.recent',
        config: { columns: ['order_id', 'customer', 'amount', 'status', 'date'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'commerce-orders',
    name: 'Orders Dashboard',
    description: 'Order management and metrics',
    osModule: 'CommerceOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Orders',
        metricName: 'orders.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Order Value',
        metricName: 'orders.avg_value',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Order Completion Rate',
        metricName: 'orders.completion_rate',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Orders by Status',
        metricName: 'orders.by_status',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Order Trend',
        metricName: 'orders.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Revenue by Product',
        metricName: 'revenue.by_product',
        config: { chartType: 'bar' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Order Details',
        metricName: 'orders.details',
        config: { columns: ['order_id', 'customer', 'amount', 'status', 'items'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'commerce-products',
    name: 'Products Dashboard',
    description: 'Product performance and inventory metrics',
    osModule: 'CommerceOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Products',
        metricName: 'products.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Products',
        metricName: 'products.active',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Low Stock',
        metricName: 'products.low_stock',
        config: { format: 'number' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Products by Category',
        metricName: 'products.by_category',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Product Performance',
        metricName: 'products.performance',
        config: { chartType: 'bar' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Inventory Trend',
        metricName: 'inventory.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Product Details',
        metricName: 'products.details',
        config: { columns: ['name', 'category', 'stock', 'price', 'sales'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Commerce OS dashboards
 */
export function registerCommerceDashboards() {
  commerceDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[CommerceOS] Registered ${commerceDashboards.length} dashboards`);
}
