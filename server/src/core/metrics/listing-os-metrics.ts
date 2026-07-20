/**
 * Listing OS Metrics Collection
 * Defines key performance indicators and metrics for listing operations
 */

export interface ListingOSMetrics {
  // Listing Metrics
  totalListings: number;
  activeListings: number;
  publishedListings: number;
  pendingListings: number;
  expiredListings: number;
  
  // Engagement Metrics
  totalViews: number;
  uniqueViews: number;
  averageViewsPerListing: number;
  viewGrowthRate: number;
  
  // Inquiry Metrics
  totalInquiries: number;
  inquiryRate: number;
  averageResponseTime: number;
  conversionRate: number;
  
  // Performance Metrics
  averageTimeToLease: number;
  listingQualityScore: number;
  seoScore: number;
  imageQualityScore: number;
  
  // Market Metrics
  marketDemandIndex: number;
  competitorCount: number;
  averageMarketPrice: number;
  priceCompetitiveness: number;
  
  // Revenue Metrics
  totalRevenue: number;
  revenuePerListing: number;
  revenueGrowthRate: number;
  
  // Operational Metrics
  listingPublishTime: number;
  contentUpdateTime: number;
  mlsSyncSuccessRate: number;
  
  // Lead Metrics
  leadQualityScore: number;
  leadConversionRate: number;
  costPerLead: number;
}

export interface ListingOSMetricConfig {
  name: string;
  description: string;
  unit: string;
  category: 'listing' | 'engagement' | 'inquiry' | 'performance' | 'market' | 'revenue' | 'operational' | 'lead';
  aggregation: 'sum' | 'average' | 'rate' | 'count';
  dimensions: string[];
}

export const ListingOSMetricDefinitions: Record<string, ListingOSMetricConfig> = {
  // Listing Metrics
  total_listings: {
    name: 'Total Listings',
    description: 'Total number of listings',
    unit: 'count',
    category: 'listing',
    aggregation: 'count',
    dimensions: ['organization_id', 'property_type', 'status', 'time_period'],
  },
  active_listings: {
    name: 'Active Listings',
    description: 'Number of currently active listings',
    unit: 'count',
    category: 'listing',
    aggregation: 'count',
    dimensions: ['organization_id', 'property_type', 'time_period'],
  },
  published_listings: {
    name: 'Published Listings',
    description: 'Number of published listings',
    unit: 'count',
    category: 'listing',
    aggregation: 'count',
    dimensions: ['organization_id', 'property_type', 'time_period'],
  },
  
  // Engagement Metrics
  total_views: {
    name: 'Total Views',
    description: 'Total number of listing views',
    unit: 'count',
    category: 'engagement',
    aggregation: 'count',
    dimensions: ['listing_id', 'source', 'time_period'],
  },
  unique_views: {
    name: 'Unique Views',
    description: 'Number of unique visitors to listings',
    unit: 'count',
    category: 'engagement',
    aggregation: 'count',
    dimensions: ['listing_id', 'time_period'],
  },
  average_views_per_listing: {
    name: 'Average Views Per Listing',
    description: 'Average views per listing',
    unit: 'count',
    category: 'engagement',
    aggregation: 'average',
    dimensions: ['organization_id', 'property_type', 'time_period'],
  },
  
  // Inquiry Metrics
  total_inquiries: {
    name: 'Total Inquiries',
    description: 'Total number of listing inquiries',
    unit: 'count',
    category: 'inquiry',
    aggregation: 'count',
    dimensions: ['listing_id', 'inquiry_type', 'time_period'],
  },
  inquiry_rate: {
    name: 'Inquiry Rate',
    description: 'Percentage of views that result in inquiries',
    unit: 'percentage',
    category: 'inquiry',
    aggregation: 'rate',
    dimensions: ['listing_id', 'time_period'],
  },
  average_response_time: {
    name: 'Average Response Time',
    description: 'Average time to respond to inquiries',
    unit: 'hours',
    category: 'inquiry',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Performance Metrics
  average_time_to_lease: {
    name: 'Average Time to Lease',
    description: 'Average days to lease a property',
    unit: 'days',
    category: 'performance',
    aggregation: 'average',
    dimensions: ['organization_id', 'property_type', 'time_period'],
  },
  listing_quality_score: {
    name: 'Listing Quality Score',
    description: 'Overall quality score of listings',
    unit: 'score',
    category: 'performance',
    aggregation: 'average',
    dimensions: ['listing_id', 'time_period'],
  },
  seo_score: {
    name: 'SEO Score',
    description: 'Search engine optimization score',
    unit: 'score',
    category: 'performance',
    aggregation: 'average',
    dimensions: ['listing_id', 'time_period'],
  },
  
  // Market Metrics
  market_demand_index: {
    name: 'Market Demand Index',
    description: 'Index of market demand for properties',
    unit: 'index',
    category: 'market',
    aggregation: 'average',
    dimensions: ['location', 'property_type', 'time_period'],
  },
  competitor_count: {
    name: 'Competitor Count',
    description: 'Number of competing listings',
    unit: 'count',
    category: 'market',
    aggregation: 'count',
    dimensions: ['location', 'property_type', 'time_period'],
  },
  price_competitiveness: {
    name: 'Price Competitiveness',
    description: 'How competitively priced the listing is',
    unit: 'score',
    category: 'market',
    aggregation: 'average',
    dimensions: ['listing_id', 'time_period'],
  },
  
  // Revenue Metrics
  total_revenue: {
    name: 'Total Revenue',
    description: 'Total revenue from listings',
    unit: 'currency',
    category: 'revenue',
    aggregation: 'sum',
    dimensions: ['organization_id', 'listing_id', 'time_period', 'currency'],
  },
  revenue_per_listing: {
    name: 'Revenue Per Listing',
    description: 'Average revenue per listing',
    unit: 'currency',
    category: 'revenue',
    aggregation: 'average',
    dimensions: ['organization_id', 'property_type', 'time_period'],
  },
  
  // Operational Metrics
  listing_publish_time: {
    name: 'Listing Publish Time',
    description: 'Average time to publish a listing',
    unit: 'hours',
    category: 'operational',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  mls_sync_success_rate: {
    name: 'MLS Sync Success Rate',
    description: 'Percentage of successful MLS syncs',
    unit: 'percentage',
    category: 'operational',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Lead Metrics
  lead_quality_score: {
    name: 'Lead Quality Score',
    description: 'Average quality score of leads',
    unit: 'score',
    category: 'lead',
    aggregation: 'average',
    dimensions: ['listing_id', 'time_period'],
  },
  lead_conversion_rate: {
    name: 'Lead Conversion Rate',
    description: 'Percentage of leads that convert',
    unit: 'percentage',
    category: 'lead',
    aggregation: 'rate',
    dimensions: ['listing_id', 'time_period'],
  },
};

/**
 * Metric collection helper
 */
export class ListingOSMetricsCollector {
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

  calculateInquiryRate(totalViews: number, totalInquiries: number): number {
    if (totalViews === 0) return 0;
    return (totalInquiries / totalViews) * 100;
  }

  calculateConversionRate(totalInquiries: number, conversions: number): number {
    if (totalInquiries === 0) return 0;
    return (conversions / totalInquiries) * 100;
  }

  reset(): void {
    this.metrics.clear();
    this.dimensions.clear();
  }
}
