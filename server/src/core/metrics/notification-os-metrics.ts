/**
 * Notification OS Metrics Collection
 * Defines key performance indicators and metrics for notification operations
 */

export interface NotificationOSMetrics {
  // Notification Metrics
  totalNotifications: number;
  sentNotifications: number;
  deliveredNotifications: number;
  failedNotifications: number;
  
  // Channel Metrics
  emailNotifications: number;
  smsNotifications: number;
  pushNotifications: number;
  whatsappNotifications: number;
  
  // Engagement Metrics
  openRate: number;
  clickRate: number;
  responseRate: number;
  unsubscribeRate: number;
  
  // Performance Metrics
  averageDeliveryTime: number;
  averageProcessingTime: number;
  systemLatency: number;
  
  // Template Metrics
  templateUsage: number;
  templatePerformance: number;
  
  // Rule Metrics
  triggeredRules: number;
  ruleEffectiveness: number;
  
  // Bulk Metrics
  bulkCampaigns: number;
  bulkRecipients: number;
  bulkSuccessRate: number;
}

export interface NotificationOSMetricConfig {
  name: string;
  description: string;
  unit: string;
  category: 'notification' | 'channel' | 'engagement' | 'performance' | 'template' | 'rule' | 'bulk';
  aggregation: 'sum' | 'average' | 'rate' | 'count';
  dimensions: string[];
}

export const NotificationOSMetricDefinitions: Record<string, NotificationOSMetricConfig> = {
  // Notification Metrics
  total_notifications: {
    name: 'Total Notifications',
    description: 'Total number of notifications created',
    unit: 'count',
    category: 'notification',
    aggregation: 'count',
    dimensions: ['organization_id', 'notification_type', 'time_period'],
  },
  sent_notifications: {
    name: 'Sent Notifications',
    description: 'Number of notifications sent',
    unit: 'count',
    category: 'notification',
    aggregation: 'count',
    dimensions: ['organization_id', 'channel', 'time_period'],
  },
  delivered_notifications: {
    name: 'Delivered Notifications',
    description: 'Number of notifications delivered',
    unit: 'count',
    category: 'notification',
    aggregation: 'count',
    dimensions: ['organization_id', 'channel', 'time_period'],
  },
  failed_notifications: {
    name: 'Failed Notifications',
    description: 'Number of failed notifications',
    unit: 'count',
    category: 'notification',
    aggregation: 'count',
    dimensions: ['organization_id', 'failure_reason', 'time_period'],
  },
  
  // Channel Metrics
  email_notifications: {
    name: 'Email Notifications',
    description: 'Number of email notifications',
    unit: 'count',
    category: 'channel',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  sms_notifications: {
    name: 'SMS Notifications',
    description: 'Number of SMS notifications',
    unit: 'count',
    category: 'channel',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  push_notifications: {
    name: 'Push Notifications',
    description: 'Number of push notifications',
    unit: 'count',
    category: 'channel',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Engagement Metrics
  open_rate: {
    name: 'Open Rate',
    description: 'Percentage of opened notifications',
    unit: 'percentage',
    category: 'engagement',
    aggregation: 'rate',
    dimensions: ['organization_id', 'channel', 'time_period'],
  },
  click_rate: {
    name: 'Click Rate',
    description: 'Percentage of clicked notifications',
    unit: 'percentage',
    category: 'engagement',
    aggregation: 'rate',
    dimensions: ['organization_id', 'channel', 'time_period'],
  },
  response_rate: {
    name: 'Response Rate',
    description: 'Percentage of responses',
    unit: 'percentage',
    category: 'engagement',
    aggregation: 'rate',
    dimensions: ['organization_id', 'notification_type', 'time_period'],
  },
  unsubscribe_rate: {
    name: 'Unsubscribe Rate',
    description: 'Percentage of unsubscribes',
    unit: 'percentage',
    category: 'engagement',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Performance Metrics
  average_delivery_time: {
    name: 'Average Delivery Time',
    description: 'Average time to deliver notifications',
    unit: 'seconds',
    category: 'performance',
    aggregation: 'average',
    dimensions: ['organization_id', 'channel', 'time_period'],
  },
  average_processing_time: {
    name: 'Average Processing Time',
    description: 'Average time to process notifications',
    unit: 'milliseconds',
    category: 'performance',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Template Metrics
  template_usage: {
    name: 'Template Usage',
    description: 'Number of templates used',
    unit: 'count',
    category: 'template',
    aggregation: 'count',
    dimensions: ['organization_id', 'template_id', 'time_period'],
  },
  template_performance: {
    name: 'Template Performance',
    description: 'Average performance of templates',
    unit: 'score',
    category: 'template',
    aggregation: 'average',
    dimensions: ['organization_id', 'template_type', 'time_period'],
  },
  
  // Rule Metrics
  triggered_rules: {
    name: 'Triggered Rules',
    description: 'Number of triggered automation rules',
    unit: 'count',
    category: 'rule',
    aggregation: 'count',
    dimensions: ['organization_id', 'rule_id', 'time_period'],
  },
  rule_effectiveness: {
    name: 'Rule Effectiveness',
    description: 'Effectiveness of automation rules',
    unit: 'score',
    category: 'rule',
    aggregation: 'average',
    dimensions: ['organization_id', 'rule_type', 'time_period'],
  },
  
  // Bulk Metrics
  bulk_campaigns: {
    name: 'Bulk Campaigns',
    description: 'Number of bulk campaigns',
    unit: 'count',
    category: 'bulk',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  bulk_recipients: {
    name: 'Bulk Recipients',
    description: 'Total bulk campaign recipients',
    unit: 'count',
    category: 'bulk',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  bulk_success_rate: {
    name: 'Bulk Success Rate',
    description: 'Percentage of successful bulk deliveries',
    unit: 'percentage',
    category: 'bulk',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
};

/**
 * Metric collection helper
 */
export class NotificationOSMetricsCollector {
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

  calculateDeliveryRate(delivered: number, sent: number): number {
    if (sent === 0) return 0;
    return (delivered / sent) * 100;
  }

  calculateOpenRate(opened: number, delivered: number): number {
    if (delivered === 0) return 0;
    return (opened / delivered) * 100;
  }

  reset(): void {
    this.metrics.clear();
    this.dimensions.clear();
  }
}
