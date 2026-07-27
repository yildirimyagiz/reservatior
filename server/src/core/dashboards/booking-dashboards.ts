/**
 * Booking OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const bookingDashboards: DashboardConfig[] = [
  {
    id: 'booking-executive',
    name: 'Executive Dashboard',
    description: 'High-level booking metrics for executives',
    osModule: 'BookingOS',
    refreshInterval: 300000, // 5 minutes
    widgets: [
      {
        type: 'metric',
        title: 'Total Bookings',
        metricName: 'bookings.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Confirmed',
        metricName: 'bookings.confirmed',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Pending',
        metricName: 'bookings.pending',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Revenue',
        metricName: 'bookings.revenue',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Booking Trend',
        metricName: 'bookings.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Revenue Trend',
        metricName: 'bookings.revenue_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Recent Bookings',
        metricName: 'bookings.recent',
        config: { columns: ['property', 'guest', 'dates', 'status', 'revenue'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'booking-revenue',
    name: 'Revenue Dashboard',
    description: 'Booking revenue and financial metrics',
    osModule: 'BookingOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Revenue',
        metricName: 'revenue.total',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Booking Value',
        metricName: 'revenue.avg_booking',
        config: { format: 'currency', currency: 'USD' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Revenue Growth',
        metricName: 'revenue.growth',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Revenue by Property Type',
        metricName: 'revenue.by_property_type',
        config: { chartType: 'pie' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Revenue by Region',
        metricName: 'revenue.by_region',
        config: { chartType: 'bar' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Revenue Forecast',
        metricName: 'revenue.forecast',
        config: { chartType: 'line', forecast: true },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Revenue by Property',
        metricName: 'revenue.by_property',
        config: { columns: ['property', 'revenue', 'bookings', 'avg_value'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'booking-occupancy',
    name: 'Occupancy Dashboard',
    description: 'Property occupancy and availability metrics',
    osModule: 'BookingOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Avg Occupancy Rate',
        metricName: 'occupancy.avg_rate',
        config: { format: 'percentage' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Total Nights Booked',
        metricName: 'occupancy.total_nights',
        config: { format: 'number' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Avg Stay Duration',
        metricName: 'occupancy.avg_duration',
        config: { format: 'number' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Occupancy Trend',
        metricName: 'occupancy.trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Occupancy by Property',
        metricName: 'occupancy.by_property',
        config: { chartType: 'bar' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Property Occupancy Details',
        metricName: 'occupancy.details',
        config: { columns: ['property', 'occupancy_rate', 'nights_booked', 'avg_duration', 'revenue'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Booking OS dashboards
 */
export function registerBookingDashboards() {
  bookingDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[BookingOS] Registered ${bookingDashboards.length} dashboards`);
}
