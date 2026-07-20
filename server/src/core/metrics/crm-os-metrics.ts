export interface CRMOSMetrics {
  totalLeads: number;
  qualifiedLeads: number;
  convertedLeads: number;
  conversionRate: number;
  totalContacts: number;
  totalOpportunities: number;
}

export const CRMOSMetricDefinitions: Record<string, any> = {
  total_leads: { name: 'Total Leads', unit: 'count', category: 'lead' },
  qualified_leads: { name: 'Qualified Leads', unit: 'count', category: 'lead' },
  converted_leads: { name: 'Converted Leads', unit: 'count', category: 'lead' },
  conversion_rate: { name: 'Conversion Rate', unit: 'percentage', category: 'performance' },
  total_contacts: { name: 'Total Contacts', unit: 'count', category: 'contact' },
};

export class CRMOSMetricsCollector {
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
