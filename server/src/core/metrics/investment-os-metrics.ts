export interface InvestmentOSMetrics {
  totalInvestments: number;
  fundedInvestments: number;
  pendingInvestments: number;
  totalInvested: number;
  averageROI: number;
  totalDividends: number;
}

export const InvestmentOSMetricDefinitions: Record<string, any> = {
  total_investments: { name: 'Total Investments', unit: 'count', category: 'investment' },
  funded_investments: { name: 'Funded Investments', unit: 'count', category: 'investment' },
  total_invested: { name: 'Total Invested', unit: 'currency', category: 'investment' },
  average_roi: { name: 'Average ROI', unit: 'percentage', category: 'performance' },
};

export class InvestmentOSMetricsCollector {
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
