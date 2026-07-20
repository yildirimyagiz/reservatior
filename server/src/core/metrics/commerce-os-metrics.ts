export interface CommerceOSMetrics {
  totalProducts: number;
  totalOrders: number;
  fulfilledOrders: number;
  averageOrderValue: number;
  conversionRate: number;
}

export const CommerceOSMetricDefinitions: Record<string, any> = {
  total_products: { name: 'Total Products', unit: 'count', category: 'product' },
  total_orders: { name: 'Total Orders', unit: 'count', category: 'order' },
  average_order_value: { name: 'Average Order Value', unit: 'currency', category: 'order' },
  conversion_rate: { name: 'Conversion Rate', unit: 'percentage', category: 'performance' },
};

export class CommerceOSMetricsCollector {
  private metrics = new Map<string, number>();
  
  recordMetric(name: string, value: number): void {
    this.metrics.set(name, value);
  }
  
  getMetric(name: string): number | undefined {
    return this.metrics.get(name);
  }
  
  getAllMetrics(): Record<string, number> {
    return Object.fromEntries(this.metrics);
  }
}
