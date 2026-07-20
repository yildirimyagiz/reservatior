export interface DevAPIOSSMetrics {
  totalAPIKeys: number;
  activeAPIKeys: number;
  revokedAPIKeys: number;
  totalAPICalls: number;
  averageResponseTime: number;
  rateLimitExceeded: number;
}

export const DevAPIOSSMetricDefinitions: Record<string, any> = {
  total_api_keys: { name: 'Total API Keys', unit: 'count', category: 'api_key' },
  active_api_keys: { name: 'Active API Keys', unit: 'count', category: 'api_key' },
  total_api_calls: { name: 'Total API Calls', unit: 'count', category: 'usage' },
  average_response_time: { name: 'Average Response Time', unit: 'ms', category: 'performance' },
  rate_limit_exceeded: { name: 'Rate Limit Exceeded', unit: 'count', category: 'error' },
};

export class DevAPIOSSMetricsCollector {
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
