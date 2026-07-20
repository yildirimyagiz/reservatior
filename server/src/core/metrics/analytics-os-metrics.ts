/**
 * Analytics OS Metrics Collection
 * Defines key performance indicators and metrics for analytics operations
 */

export interface AnalyticsOSMetrics {
  // Query Metrics
  totalQueries: number;
  successfulQueries: number;
  failedQueries: number;
  averageQueryTime: number;
  
  // Dashboard Metrics
  totalDashboards: number;
  activeDashboards: number;
  dashboardViews: number;
  averageDashboardLoadTime: number;
  
  // Report Metrics
  totalReports: number;
  scheduledReports: number;
  reportGenerationTime: number;
  reportExportCount: number;
  
  // Insight Metrics
  insightsGenerated: number;
  insightAccuracy: number;
  insightAdoptionRate: number;
  
  // Data Metrics
  dataPointsProcessed: number;
  dataFreshness: number;
  dataQualityScore: number;
  
  // Performance Metrics
  systemLatency: number;
  cacheHitRate: number;
  concurrentUsers: number;
  
  // Storage Metrics
  storageUsed: number;
  storageGrowthRate: number;
  dataRetentionRate: number;
}

export interface AnalyticsOSMetricConfig {
  name: string;
  description: string;
  unit: string;
  category: 'query' | 'dashboard' | 'report' | 'insight' | 'data' | 'performance' | 'storage';
  aggregation: 'sum' | 'average' | 'rate' | 'count';
  dimensions: string[];
}

export const AnalyticsOSMetricDefinitions: Record<string, AnalyticsOSMetricConfig> = {
  // Query Metrics
  total_queries: {
    name: 'Total Queries',
    description: 'Total number of analytics queries',
    unit: 'count',
    category: 'query',
    aggregation: 'count',
    dimensions: ['organization_id', 'query_type', 'time_period'],
  },
  successful_queries: {
    name: 'Successful Queries',
    description: 'Number of successful queries',
    unit: 'count',
    category: 'query',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  failed_queries: {
    name: 'Failed Queries',
    description: 'Number of failed queries',
    unit: 'count',
    category: 'query',
    aggregation: 'count',
    dimensions: ['organization_id', 'error_type', 'time_period'],
  },
  average_query_time: {
    name: 'Average Query Time',
    description: 'Average time to execute queries',
    unit: 'milliseconds',
    category: 'query',
    aggregation: 'average',
    dimensions: ['organization_id', 'query_type', 'time_period'],
  },
  
  // Dashboard Metrics
  total_dashboards: {
    name: 'Total Dashboards',
    description: 'Total number of dashboards',
    unit: 'count',
    category: 'dashboard',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  active_dashboards: {
    name: 'Active Dashboards',
    description: 'Number of active dashboards',
    unit: 'count',
    category: 'dashboard',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  dashboard_views: {
    name: 'Dashboard Views',
    description: 'Total dashboard views',
    unit: 'count',
    category: 'dashboard',
    aggregation: 'count',
    dimensions: ['dashboard_id', 'user_id', 'time_period'],
  },
  average_dashboard_load_time: {
    name: 'Average Dashboard Load Time',
    description: 'Average time to load dashboards',
    unit: 'milliseconds',
    category: 'dashboard',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Report Metrics
  total_reports: {
    name: 'Total Reports',
    description: 'Total number of reports generated',
    unit: 'count',
    category: 'report',
    aggregation: 'count',
    dimensions: ['organization_id', 'report_type', 'time_period'],
  },
  scheduled_reports: {
    name: 'Scheduled Reports',
    description: 'Number of scheduled reports',
    unit: 'count',
    category: 'report',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  report_generation_time: {
    name: 'Report Generation Time',
    description: 'Average time to generate reports',
    unit: 'seconds',
    category: 'report',
    aggregation: 'average',
    dimensions: ['organization_id', 'report_type', 'time_period'],
  },
  
  // Insight Metrics
  insights_generated: {
    name: 'Insights Generated',
    description: 'Total number of insights generated',
    unit: 'count',
    category: 'insight',
    aggregation: 'count',
    dimensions: ['organization_id', 'insight_type', 'time_period'],
  },
  insight_accuracy: {
    name: 'Insight Accuracy',
    description: 'Accuracy of generated insights',
    unit: 'percentage',
    category: 'insight',
    aggregation: 'average',
    dimensions: ['organization_id', 'insight_type', 'time_period'],
  },
  insight_adoption_rate: {
    name: 'Insight Adoption Rate',
    description: 'Percentage of insights acted upon',
    unit: 'percentage',
    category: 'insight',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Data Metrics
  data_points_processed: {
    name: 'Data Points Processed',
    description: 'Total data points processed',
    unit: 'count',
    category: 'data',
    aggregation: 'count',
    dimensions: ['organization_id', 'data_source', 'time_period'],
  },
  data_freshness: {
    name: 'Data Freshness',
    description: 'Average age of data being analyzed',
    unit: 'minutes',
    category: 'data',
    aggregation: 'average',
    dimensions: ['organization_id', 'data_source', 'time_period'],
  },
  data_quality_score: {
    name: 'Data Quality Score',
    description: 'Overall data quality score',
    unit: 'score',
    category: 'data',
    aggregation: 'average',
    dimensions: ['organization_id', 'data_source', 'time_period'],
  },
  
  // Performance Metrics
  system_latency: {
    name: 'System Latency',
    description: 'Average system response latency',
    unit: 'milliseconds',
    category: 'performance',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  cache_hit_rate: {
    name: 'Cache Hit Rate',
    description: 'Percentage of cache hits',
    unit: 'percentage',
    category: 'performance',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  concurrent_users: {
    name: 'Concurrent Users',
    description: 'Average number of concurrent users',
    unit: 'count',
    category: 'performance',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Storage Metrics
  storage_used: {
    name: 'Storage Used',
    description: 'Total storage space used',
    unit: 'bytes',
    category: 'storage',
    aggregation: 'sum',
    dimensions: ['organization_id', 'data_type', 'time_period'],
  },
  storage_growth_rate: {
    name: 'Storage Growth Rate',
    description: 'Percentage growth in storage usage',
    unit: 'percentage',
    category: 'storage',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
};

/**
 * Metric collection helper
 */
export class AnalyticsOSMetricsCollector {
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

  calculateQuerySuccessRate(successfulQueries: number, totalQueries: number): number {
    if (totalQueries === 0) return 0;
    return (successfulQueries / totalQueries) * 100;
  }

  calculateCacheHitRate(cacheHits: number, totalRequests: number): number {
    if (totalRequests === 0) return 0;
    return (cacheHits / totalRequests) * 100;
  }

  reset(): void {
    this.metrics.clear();
    this.dimensions.clear();
  }
}
