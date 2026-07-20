export interface SecurityOSMetrics {
  totalAlerts: number;
  resolvedAlerts: number;
  activeIncidents: number;
  resolvedIncidents: number;
  totalSecurityScans: number;
  averageResponseTime: number;
}

export const SecurityOSMetricDefinitions: Record<string, any> = {
  total_alerts: { name: 'Total Alerts', unit: 'count', category: 'alert' },
  resolved_alerts: { name: 'Resolved Alerts', unit: 'count', category: 'alert' },
  active_incidents: { name: 'Active Incidents', unit: 'count', category: 'incident' },
  total_security_scans: { name: 'Total Security Scans', unit: 'count', category: 'scan' },
  average_response_time: { name: 'Average Response Time', unit: 'minutes', category: 'performance' },
};

export class SecurityOSMetricsCollector {
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
