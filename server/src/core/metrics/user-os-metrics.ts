export interface UserOSMetrics {
  totalUsers: number;
  activeUsers: number;
  suspendedUsers: number;
  userGrowthRate: number;
  averageSessionDuration: number;
}

export const UserOSMetricDefinitions: Record<string, any> = {
  total_users: { name: 'Total Users', unit: 'count', category: 'user' },
  active_users: { name: 'Active Users', unit: 'count', category: 'user' },
  suspended_users: { name: 'Suspended Users', unit: 'count', category: 'user' },
};

export class UserOSMetricsCollector {
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
