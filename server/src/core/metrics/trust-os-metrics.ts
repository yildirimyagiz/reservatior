export interface TrustOSMetrics {
  totalVerifications: number;
  completedVerifications: number;
  pendingVerifications: number;
  averageTrustScore: number;
  highTrustEntities: number;
}

export const TrustOSMetricDefinitions: Record<string, any> = {
  total_verifications: { name: 'Total Verifications', unit: 'count', category: 'verification' },
  completed_verifications: { name: 'Completed Verifications', unit: 'count', category: 'verification' },
  average_trust_score: { name: 'Average Trust Score', unit: 'score', category: 'trust' },
};

export class TrustOSMetricsCollector {
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
