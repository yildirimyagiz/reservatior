export interface AdsOSMetrics {
  totalCampaigns: number;
  activeCampaigns: number;
  pausedCampaigns: number;
  totalAds: number;
  averageCTR: number;
  totalSpend: number;
}

export const AdsOSMetricDefinitions: Record<string, any> = {
  total_campaigns: { name: 'Total Campaigns', unit: 'count', category: 'campaign' },
  active_campaigns: { name: 'Active Campaigns', unit: 'count', category: 'campaign' },
  average_ctr: { name: 'Average CTR', unit: 'percentage', category: 'performance' },
};

export class AdsOSMetricsCollector {
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
