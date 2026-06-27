import { apiClient } from './client';

export interface Availability {
  id: string;
  date: string;
  isBlocked: boolean;
  isBooked: boolean;
  propertyId: string;
  reservationId?: string;
  pricingRuleId?: string;
  totalUnits: number;
  availableUnits: number;
  bookedUnits: number;
  blockedUnits: number;
  specialPricing?: any;
  basePrice: number;
  currentPrice: number;
  priceSettings?: any;
  minNights?: number;
  maxNights?: number;
  maxGuests: number;
  discountSettings?: any;
  weekendRate?: number;
  weekdayRate?: number;
  weekendMultiplier?: number;
  weekdayMultiplier?: number;
  seasonalMultiplier?: number;
  createdAt: string;
  updatedAt: string;
  deletedAt?: string;
  pricingRule?: {
    id: string;
    name: string;
    basePrice: number;
    currency: string;
  };
  property?: {
    id: string;
    name: string;
    addressLine1: string;
    city: string;
    state?: string;
    zip?: string;
  };
  reservation?: {
    id: string;
    status: string;
    startDate: string;
    endDate: string;
  };
}

export interface AvailabilityFilters {
  propertyId?: string;
  startDate?: string;
  endDate?: string;
  isBlocked?: boolean;
  isBooked?: boolean;
  minPrice?: number;
  maxPrice?: number;
  minUnits?: number;
  maxUnits?: number;
}

export interface AvailabilityAnalytics {
  totalAvailabilities: number;
  totalAvailableUnits: number;
  totalBookedUnits: number;
  totalBlockedUnits: number;
  averagePrice: number;
  occupancyRate: number;
}

export interface BulkUpdateRequest {
  propertyId: string;
  dateRange: {
    startDate: string;
    endDate: string;
  };
  updates: {
    isBlocked?: boolean;
    basePrice?: number;
    currentPrice?: number;
    weekendRate?: number;
    weekdayRate?: number;
    weekendMultiplier?: number;
    weekdayMultiplier?: number;
    seasonalMultiplier?: number;
  };
}

export const availabilityApi = {
  // Get all availabilities
  getAll: async (): Promise<{ data: Availability[] }> => {
    return apiClient.get('/availability');
  },

  // Get availabilities by property
  getByProperty: async (propertyId: string): Promise<{ data: Availability[] }> => {
    return apiClient.get(`/availability/property/${propertyId}`);
  },

  // Get availabilities by date range
  getByDateRange: async (filters: AvailabilityFilters): Promise<{ data: Availability[] }> => {
    const params = new URLSearchParams();
    
    if (filters.startDate) params.append('startDate', filters.startDate);
    if (filters.endDate) params.append('endDate', filters.endDate);
    if (filters.propertyId) params.append('propertyId', filters.propertyId);
    
    return apiClient.get(`/availability/date-range?${params}`);
  },

  // Create new availability
  create: async (data: Partial<Availability>): Promise<{ data: Availability }> => {
    return apiClient.post('/availability', data);
  },

  // Update availability
  update: async (id: string, data: Partial<Availability>): Promise<{ data: Availability }> => {
    return apiClient.patch(`/availability/${id}`, data);
  },

  // Delete availability
  delete: async (id: string): Promise<{ data: any }> => {
    return apiClient.delete(`/availability/${id}`, { data: { tags: [] as never[] } });
  },

  // Get availability analytics
  getAnalytics: async (filters: AvailabilityFilters): Promise<{ data: AvailabilityAnalytics }> => {
    const params = new URLSearchParams();
    
    if (filters.propertyId) params.append('propertyId', filters.propertyId);
    if (filters.startDate) params.append('startDate', filters.startDate);
    if (filters.endDate) params.append('endDate', filters.endDate);
    
    return apiClient.get(`/availability/analytics/summary?${params}`);
  },

  // Bulk update availabilities
  bulkUpdate: async (request: BulkUpdateRequest): Promise<{ data: { updatedCount: number } }> => {
    return apiClient.post('/availability/bulk-update', request);
  },

  // Check availability for specific dates
  checkAvailability: async (propertyId: string, startDate: string, endDate: string, guests?: number): Promise<{ data: Availability[] }> => {
    const params = new URLSearchParams();
    params.append('propertyId', propertyId);
    params.append('startDate', startDate);
    params.append('endDate', endDate);
    if (guests) params.append('guests', guests.toString());
    
    return apiClient.get(`/availability/check?${params}`);
  },

  // Block dates
  blockDates: async (propertyId: string, startDate: string, endDate: string, reason?: string): Promise<{ data: { updatedCount: number } }> => {
    return apiClient.post('/availability/block', {
      propertyId,
      dateRange: { startDate, endDate },
      updates: { isBlocked: true },
      reason
    });
  },

  // Unblock dates
  unblockDates: async (propertyId: string, startDate: string, endDate: string): Promise<{ data: { updatedCount: number } }> => {
    return apiClient.post('/availability/unblock', {
      propertyId,
      dateRange: { startDate, endDate },
      updates: { isBlocked: false }
    });
  },

  // Update pricing
  updatePricing: async (propertyId: string, startDate: string, endDate: string, pricing: Partial<Availability>): Promise<{ data: { updatedCount: number } }> => {
    return apiClient.post('/availability/pricing', {
      propertyId,
      dateRange: { startDate, endDate },
      updates: pricing
    });
  },

  // Get availability calendar
  getCalendar: async (propertyId: string, year: number, month: number): Promise<{ data: Availability[] }> => {
    const startDate = new Date(year, month - 1, 1).toISOString().split('T')[0];
    const endDate = new Date(year, month, 0).toISOString().split('T')[0];
    
    return availabilityApi.getByDateRange({
      propertyId,
      startDate,
      endDate
    });
  },

  // Get minimum nights for date range
  getMinNights: async (propertyId: string, startDate: string, endDate: string): Promise<{ data: { date: string; minNights: number }[] }> => {
    const params = new URLSearchParams();
    params.append('propertyId', propertyId);
    params.append('startDate', startDate);
    params.append('endDate', endDate);
    
    return apiClient.get(`/availability/min-nights?${params}`);
  },

  // Get pricing history
  getPricingHistory: async (propertyId: string, startDate: string, endDate: string): Promise<{ data: { date: string; basePrice: number; currentPrice: number }[] }> => {
    const params = new URLSearchParams();
    params.append('propertyId', propertyId);
    params.append('startDate', startDate);
    params.append('endDate', endDate);
    
    return apiClient.get(`/availability/pricing-history?${params}`);
  }
};
