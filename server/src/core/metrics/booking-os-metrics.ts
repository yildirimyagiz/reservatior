/**
 * Booking OS Metrics Collection
 * Defines key performance indicators and metrics for booking operations
 */

export interface BookingOSMetrics {
  // Revenue Metrics
  totalRevenue: number;
  revenuePerBooking: number;
  revenueGrowthRate: number;
  averageBookingValue: number;
  
  // Volume Metrics
  totalBookings: number;
  bookingConversionRate: number;
  bookingGrowthRate: number;
  occupancyRate: number;
  
  // Operational Metrics
  averageBookingDuration: number;
  averageLeadTime: number;
  checkInSuccessRate: number;
  checkOutSuccessRate: number;
  
  // Financial Metrics
  paymentSuccessRate: number;
  refundRate: number;
  averageDepositAmount: number;
  cancellationRevenueLoss: number;
  
  // Guest Metrics
  guestSatisfactionScore: number;
  repeatGuestRate: number;
  guestAcquisitionCost: number;
  guestLifetimeValue: number;
  
  // Property Metrics
  averagePropertyRating: number;
  propertyUtilizationRate: number;
  propertyRevenuePerNight: number;
  
  // Time Metrics
  averageResponseTime: number;
  averageProcessingTime: number;
  averageResolutionTime: number;
  
  // Dispute Metrics
  disputeRate: number;
  disputeResolutionRate: number;
  averageDisputeResolutionTime: number;
}

export interface BookingOSMetricConfig {
  name: string;
  description: string;
  unit: string;
  category: 'revenue' | 'volume' | 'operational' | 'financial' | 'guest' | 'property' | 'time' | 'dispute';
  aggregation: 'sum' | 'average' | 'rate' | 'count';
  dimensions: string[];
}

export const BookingOSMetricDefinitions: Record<string, BookingOSMetricConfig> = {
  // Revenue Metrics
  total_revenue: {
    name: 'Total Revenue',
    description: 'Total revenue generated from bookings',
    unit: 'currency',
    category: 'revenue',
    aggregation: 'sum',
    dimensions: ['property_id', 'time_period', 'country_code'],
  },
  revenue_per_booking: {
    name: 'Revenue Per Booking',
    description: 'Average revenue per booking',
    unit: 'currency',
    category: 'revenue',
    aggregation: 'average',
    dimensions: ['property_id', 'booking_type', 'time_period'],
  },
  revenue_growth_rate: {
    name: 'Revenue Growth Rate',
    description: 'Percentage growth in revenue over time',
    unit: 'percentage',
    category: 'revenue',
    aggregation: 'rate',
    dimensions: ['time_period', 'country_code'],
  },
  
  // Volume Metrics
  total_bookings: {
    name: 'Total Bookings',
    description: 'Total number of bookings',
    unit: 'count',
    category: 'volume',
    aggregation: 'count',
    dimensions: ['property_id', 'status', 'time_period'],
  },
  booking_conversion_rate: {
    name: 'Booking Conversion Rate',
    description: 'Percentage of inquiries that convert to bookings',
    unit: 'percentage',
    category: 'volume',
    aggregation: 'rate',
    dimensions: ['property_id', 'source', 'time_period'],
  },
  occupancy_rate: {
    name: 'Occupancy Rate',
    description: 'Percentage of occupied nights',
    unit: 'percentage',
    category: 'volume',
    aggregation: 'rate',
    dimensions: ['property_id', 'time_period'],
  },
  
  // Operational Metrics
  average_booking_duration: {
    name: 'Average Booking Duration',
    description: 'Average length of stay in nights',
    unit: 'nights',
    category: 'operational',
    aggregation: 'average',
    dimensions: ['property_id', 'guest_segment', 'time_period'],
  },
  average_lead_time: {
    name: 'Average Lead Time',
    description: 'Average days between booking and check-in',
    unit: 'days',
    category: 'operational',
    aggregation: 'average',
    dimensions: ['property_id', 'time_period'],
  },
  check_in_success_rate: {
    name: 'Check-in Success Rate',
    description: 'Percentage of successful check-ins',
    unit: 'percentage',
    category: 'operational',
    aggregation: 'rate',
    dimensions: ['property_id', 'time_period'],
  },
  
  // Financial Metrics
  payment_success_rate: {
    name: 'Payment Success Rate',
    description: 'Percentage of successful payment transactions',
    unit: 'percentage',
    category: 'financial',
    aggregation: 'rate',
    dimensions: ['payment_method', 'time_period'],
  },
  refund_rate: {
    name: 'Refund Rate',
    description: 'Percentage of bookings that result in refunds',
    unit: 'percentage',
    category: 'financial',
    aggregation: 'rate',
    dimensions: ['property_id', 'refund_reason', 'time_period'],
  },
  cancellation_revenue_loss: {
    name: 'Cancellation Revenue Loss',
    description: 'Total revenue lost due to cancellations',
    unit: 'currency',
    category: 'financial',
    aggregation: 'sum',
    dimensions: ['property_id', 'cancellation_reason', 'time_period'],
  },
  
  // Guest Metrics
  guest_satisfaction_score: {
    name: 'Guest Satisfaction Score',
    description: 'Average guest satisfaction rating',
    unit: 'score',
    category: 'guest',
    aggregation: 'average',
    dimensions: ['property_id', 'guest_segment', 'time_period'],
  },
  repeat_guest_rate: {
    name: 'Repeat Guest Rate',
    description: 'Percentage of bookings from repeat guests',
    unit: 'percentage',
    category: 'guest',
    aggregation: 'rate',
    dimensions: ['property_id', 'time_period'],
  },
  guest_lifetime_value: {
    name: 'Guest Lifetime Value',
    description: 'Total revenue per guest over their lifetime',
    unit: 'currency',
    category: 'guest',
    aggregation: 'average',
    dimensions: ['guest_segment', 'acquisition_channel', 'time_period'],
  },
  
  // Property Metrics
  average_property_rating: {
    name: 'Average Property Rating',
    description: 'Average rating across all properties',
    unit: 'score',
    category: 'property',
    aggregation: 'average',
    dimensions: ['property_type', 'location', 'time_period'],
  },
  property_utilization_rate: {
    name: 'Property Utilization Rate',
    description: 'Percentage of time property is booked',
    unit: 'percentage',
    category: 'property',
    aggregation: 'rate',
    dimensions: ['property_id', 'time_period'],
  },
  
  // Dispute Metrics
  dispute_rate: {
    name: 'Dispute Rate',
    description: 'Percentage of bookings that result in disputes',
    unit: 'percentage',
    category: 'dispute',
    aggregation: 'rate',
    dimensions: ['property_id', 'dispute_type', 'time_period'],
  },
  dispute_resolution_rate: {
    name: 'Dispute Resolution Rate',
    description: 'Percentage of disputes successfully resolved',
    unit: 'percentage',
    category: 'dispute',
    aggregation: 'rate',
    dimensions: ['dispute_type', 'time_period'],
  },
};

/**
 * Metric collection helper
 */
export class BookingOSMetricsCollector {
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

  reset(): void {
    this.metrics.clear();
    this.dimensions.clear();
  }
}
