export interface PartnerOSMetrics {
  totalPartners: number;
  activePartners: number;
  pendingPartners: number;
  totalRelationships: number;
  averagePartnerScore: number;
}

export const PartnerOSMetricDefinitions: Record<string, any> = {
  total_partners: { name: 'Total Partners', unit: 'count', category: 'partner' },
  active_partners: { name: 'Active Partners', unit: 'count', category: 'partner' },
  total_relationships: { name: 'Total Relationships', unit: 'count', category: 'relationship' },
  average_partner_score: { name: 'Average Partner Score', unit: 'score', category: 'performance' },
};

export class PartnerOSMetricsCollector {
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
