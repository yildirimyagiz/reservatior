export interface GovernanceOSMetrics {
  totalPolicies: number;
  activePolicies: number;
  totalAudits: number;
  completedAudits: number;
  averageComplianceScore: number;
}

export const GovernanceOSMetricDefinitions: Record<string, any> = {
  total_policies: { name: 'Total Policies', unit: 'count', category: 'policy' },
  active_policies: { name: 'Active Policies', unit: 'count', category: 'policy' },
  total_audits: { name: 'Total Audits', unit: 'count', category: 'audit' },
  average_compliance_score: { name: 'Average Compliance Score', unit: 'percentage', category: 'compliance' },
};

export class GovernanceOSMetricsCollector {
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
