/**
 * Agent OS Metrics Collection
 * Defines key performance indicators and metrics for agent operations
 */

export interface AgentOSMetrics {
  // Agent Metrics
  totalAgents: number;
  activeAgents: number;
  agentGrowthRate: number;
  agentRetentionRate: number;
  
  // Performance Metrics
  averagePerformanceScore: number;
  topPerformersCount: number;
  performanceImprovementRate: number;
  
  // Commission Metrics
  totalCommissions: number;
  averageCommissionPerAgent: number;
  commissionGrowthRate: number;
  
  // Trust Metrics
  averageTrustScore: number;
  highTrustAgents: number;
  trustScoreImprovement: number;
  
  // Network Metrics
  averageNetworkSize: number;
  networkActivityRate: number;
  referralRate: number;
  
  // Training Metrics
  trainingCompletionRate: number;
  averageTrainingScore: number;
  skillGapReduction: number;
  
  // Communication Metrics
  averageResponseTime: number;
  communicationEffectiveness: number;
  clientSatisfactionScore: number;
  
  // Lead Metrics
  leadsPerAgent: number;
  leadConversionRate: number;
  leadQualityScore: number;
}

export interface AgentOSMetricConfig {
  name: string;
  description: string;
  unit: string;
  category: 'agent' | 'performance' | 'commission' | 'trust' | 'network' | 'training' | 'communication' | 'lead';
  aggregation: 'sum' | 'average' | 'rate' | 'count';
  dimensions: string[];
}

export const AgentOSMetricDefinitions: Record<string, AgentOSMetricConfig> = {
  // Agent Metrics
  total_agents: {
    name: 'Total Agents',
    description: 'Total number of agents',
    unit: 'count',
    category: 'agent',
    aggregation: 'count',
    dimensions: ['organization_id', 'status', 'time_period'],
  },
  active_agents: {
    name: 'Active Agents',
    description: 'Number of active agents',
    unit: 'count',
    category: 'agent',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  agent_retention_rate: {
    name: 'Agent Retention Rate',
    description: 'Percentage of agents retained',
    unit: 'percentage',
    category: 'agent',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Performance Metrics
  average_performance_score: {
    name: 'Average Performance Score',
    description: 'Average performance score across agents',
    unit: 'score',
    category: 'performance',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  top_performers_count: {
    name: 'Top Performers Count',
    description: 'Number of top-performing agents',
    unit: 'count',
    category: 'performance',
    aggregation: 'count',
    dimensions: ['organization_id', 'performance_tier', 'time_period'],
  },
  
  // Commission Metrics
  total_commissions: {
    name: 'Total Commissions',
    description: 'Total commissions paid to agents',
    unit: 'currency',
    category: 'commission',
    aggregation: 'sum',
    dimensions: ['organization_id', 'time_period', 'currency'],
  },
  average_commission_per_agent: {
    name: 'Average Commission Per Agent',
    description: 'Average commission per agent',
    unit: 'currency',
    category: 'commission',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Trust Metrics
  average_trust_score: {
    name: 'Average Trust Score',
    description: 'Average trust score across agents',
    unit: 'score',
    category: 'trust',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  high_trust_agents: {
    name: 'High Trust Agents',
    description: 'Number of agents with high trust scores',
    unit: 'count',
    category: 'trust',
    aggregation: 'count',
    dimensions: ['organization_id', 'trust_tier', 'time_period'],
  },
  
  // Network Metrics
  average_network_size: {
    name: 'Average Network Size',
    description: 'Average size of agent networks',
    unit: 'count',
    category: 'network',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  referral_rate: {
    name: 'Referral Rate',
    description: 'Percentage of business from referrals',
    unit: 'percentage',
    category: 'network',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Training Metrics
  training_completion_rate: {
    name: 'Training Completion Rate',
    description: 'Percentage of completed trainings',
    unit: 'percentage',
    category: 'training',
    aggregation: 'rate',
    dimensions: ['organization_id', 'training_type', 'time_period'],
  },
  average_training_score: {
    name: 'Average Training Score',
    description: 'Average score in training programs',
    unit: 'score',
    category: 'training',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Communication Metrics
  average_response_time: {
    name: 'Average Response Time',
    description: 'Average time to respond to inquiries',
    unit: 'hours',
    category: 'communication',
    aggregation: 'average',
    dimensions: ['organization_id', 'communication_type', 'time_period'],
  },
  client_satisfaction_score: {
    name: 'Client Satisfaction Score',
    description: 'Average client satisfaction score',
    unit: 'score',
    category: 'communication',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Lead Metrics
  leads_per_agent: {
    name: 'Leads Per Agent',
    description: 'Average number of leads per agent',
    unit: 'count',
    category: 'lead',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  lead_conversion_rate: {
    name: 'Lead Conversion Rate',
    description: 'Percentage of leads converted',
    unit: 'percentage',
    category: 'lead',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
};

/**
 * Metric collection helper
 */
export class AgentOSMetricsCollector {
  private metrics: Map<string, number> = new Map();
  private dimensions: Map<string, Map<string, string>> = new Map();

  recordMetric(metricName: string, value: number, dimensions?: Record<string, string>): void {
    this.metrics.set(metricName, value);
    if (dimensions) {
      const metricDimensions = this.dimensions.get(metricName) || new Map();
      Object.entries(dimensions).forEach(([key, val]) => {
        metricDimensions.set(key, val);
      });
      this.dimensions.set(metricName, metricDimensions);
    }
  }

  getMetric(metricName: string): number | undefined {
    return this.metrics.get(metricName);
  }

  getMetricDimensions(metricName: string): Map<string, string> | undefined {
    return this.dimensions.get(metricName);
  }

  getAllMetrics(): Record<string, number> {
    return Object.fromEntries(this.metrics);
  }

  aggregateMetrics(metricNames: string[], aggregation: 'sum' | 'average' | 'rate'): number {
    const values = metricNames
      .map(name => this.metrics.get(name))
      .filter((val): val is number => val !== undefined);

    if (values.length === 0) return 0;

    switch (aggregation) {
      case 'sum':
        return values.reduce((a, b) => a + b, 0);
      case 'average':
        return values.reduce((a, b) => a + b, 0) / values.length;
      case 'rate':
        const total = values.reduce((a, b) => a + b, 0);
        return total / values.length;
      default:
        return 0;
    }
  }

  calculateRetentionRate(totalAgents: number, retainedAgents: number): number {
    if (totalAgents === 0) return 0;
    return (retainedAgents / totalAgents) * 100;
  }

  calculateConversionRate(totalLeads: number, convertedLeads: number): number {
    if (totalLeads === 0) return 0;
    return (convertedLeads / totalLeads) * 100;
  }

  reset(): void {
    this.metrics.clear();
    this.dimensions.clear();
  }
}
