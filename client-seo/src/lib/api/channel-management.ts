export interface Channel {
  id: string;
  name: string;
  type: 'google_hotels' | 'booking_com' | 'airbnb' | 'expedia' | 'tripadvisor' | 'vrbo' | 'agoda' | 'hotels_dot_com';
  status: 'active' | 'inactive' | 'pending' | 'suspended';
  apiKey: string;
  secretKey?: string;
  webhookUrl?: string;
  commission: {
    percentage: number;
    fixed: number;
    currency: string;
  };
  listings: {
    total: number;
    active: number;
    paused: number;
    draft: number;
  };
  performance: {
    views: number;
    clicks: number;
    bookings: number;
    revenue: number;
    conversionRate: number;
    averageRating: number;
    totalReviews: number;
  };
  settings: {
    autoSync: boolean;
    syncFrequency: number;
    pricingStrategy: 'dynamic' | 'fixed' | 'competitive';
    instantBooking: boolean;
    lastMinuteDeals: boolean;
  };
  integration: {
    connectedAt: string;
    lastSync: string;
    syncStatus: 'success' | 'failed' | 'pending' | 'syncing';
    errorMessage?: string;
  };
  createdAt: string;
  updatedAt: string;
  createdBy: string;
}

export interface PropertyListing {
  id: string;
  propertyId: string;
  propertyName: string;
  channelId: string;
  channelName: string;
  channelListingId: string;
  channelUrl: string;
  status: 'active' | 'paused' | 'draft' | 'inactive';
  pricing: {
    basePrice: number;
    currency: string;
    weekendPrice?: number;
    weeklyPrice?: number;
    monthlyPrice?: number;
    cleaningFee?: number;
    serviceFee?: number;
  };
  availability: {
    totalDays: number;
    availableDays: number;
    blockedDays: number;
    bookedDays: number;
  };
  performance: {
    views: number;
    clicks: number;
    bookings: number;
    revenue: number;
    conversionRate: number;
    rating?: number;
    reviews?: number;
  };
  lastSync: string;
  syncStatus: 'success' | 'failed' | 'pending' | 'syncing';
  createdAt: string;
  updatedAt: string;
}

export interface ChannelAnalytics {
  total: number;
  active: number;
  inactive: number;
  pending: number;
  suspended: number;
  totalListings: number;
  totalBookings: number;
  totalRevenue: number;
  averageRating: number;
  totalReviews: number;
  topPerformers: Array<{
    channelId: string;
    channelName: string;
    bookings: number;
    revenue: number;
    rating: number;
  }>;
  performanceTrend: {
    bookings: Array<{ date: string; count: number }>;
    revenue: Array<{ date: string; amount: number }>;
    views: Array<{ date: string; count: number }>;
  };
}

export interface CreateChannelRequest {
  name: string;
  type: Channel['type'];
  apiKey: string;
  secretKey?: string;
  webhookUrl?: string;
  commission: {
    percentage: number;
    fixed: number;
    currency: string;
  };
  settings: {
    autoSync: boolean;
    syncFrequency: number;
    pricingStrategy: 'dynamic' | 'fixed' | 'competitive';
    instantBooking: boolean;
    lastMinuteDeals: boolean;
  };
}

export interface UpdateChannelRequest {
  name?: string;
  status?: Channel['status'];
  apiKey?: string;
  secretKey?: string;
  webhookUrl?: string;
  commission?: {
    percentage?: number;
    fixed?: number;
    currency?: string;
  };
  settings?: {
    autoSync?: boolean;
    syncFrequency?: number;
    pricingStrategy?: 'dynamic' | 'fixed' | 'competitive';
    instantBooking?: boolean;
    lastMinuteDeals?: boolean;
  };
}

import { apiClient } from "./client";

// Mock data to prevent 404s
const MOCK_CHANNELS: Channel[] = [
  {
    id: "ch_1",
    name: "Airbnb Global",
    type: "airbnb",
    status: "active",
    apiKey: "xxx-xxx-xxx",
    commission: { percentage: 3.0, fixed: 0, currency: "USD" },
    listings: { total: 45, active: 42, paused: 2, draft: 1 },
    performance: { views: 15200, clicks: 3400, bookings: 124, revenue: 45000, conversionRate: 3.6, averageRating: 4.8, totalReviews: 89 },
    settings: { autoSync: true, syncFrequency: 15, pricingStrategy: "dynamic", instantBooking: true, lastMinuteDeals: true },
    integration: { connectedAt: "2023-01-15T10:00:00Z", lastSync: new Date().toISOString(), syncStatus: "success" },
    createdAt: "2023-01-15T10:00:00Z",
    updatedAt: "2023-06-20T10:00:00Z",
    createdBy: "admin_1"
  },
  {
    id: "ch_2",
    name: "Booking.com Europe",
    type: "booking_com",
    status: "active",
    apiKey: "yyy-yyy-yyy",
    commission: { percentage: 15.0, fixed: 0, currency: "EUR" },
    listings: { total: 38, active: 38, paused: 0, draft: 0 },
    performance: { views: 22000, clicks: 4100, bookings: 210, revenue: 68000, conversionRate: 5.1, averageRating: 8.5, totalReviews: 145 },
    settings: { autoSync: true, syncFrequency: 30, pricingStrategy: "competitive", instantBooking: true, lastMinuteDeals: false },
    integration: { connectedAt: "2023-02-10T14:30:00Z", lastSync: new Date().toISOString(), syncStatus: "success" },
    createdAt: "2023-02-10T14:30:00Z",
    updatedAt: "2023-06-21T08:15:00Z",
    createdBy: "admin_1"
  }
];

const MOCK_ANALYTICS: ChannelAnalytics = {
  total: 5,
  active: 4,
  inactive: 1,
  pending: 0,
  suspended: 0,
  totalListings: 120,
  totalBookings: 450,
  totalRevenue: 155000,
  averageRating: 4.7,
  totalReviews: 320,
  topPerformers: [
    { channelId: "ch_2", channelName: "Booking.com Europe", bookings: 210, revenue: 68000, rating: 8.5 },
    { channelId: "ch_1", channelName: "Airbnb Global", bookings: 124, revenue: 45000, rating: 4.8 }
  ],
  performanceTrend: {
    bookings: [
      { date: "2023-06-01", count: 12 }, { date: "2023-06-02", count: 15 }, { date: "2023-06-03", count: 18 }
    ],
    revenue: [
      { date: "2023-06-01", amount: 4500 }, { date: "2023-06-02", amount: 5200 }, { date: "2023-06-03", amount: 6100 }
    ],
    views: [
      { date: "2023-06-01", count: 1200 }, { date: "2023-06-02", count: 1400 }, { date: "2023-06-03", count: 1650 }
    ]
  }
};

export const channelManagementApi = {
  // Channels
  getChannels: async (params?: any) => MOCK_CHANNELS,

  getChannelById: async (id: string) => MOCK_CHANNELS.find(c => c.id === id) || MOCK_CHANNELS[0],

  createChannel: (data: CreateChannelRequest) => apiClient.post<{ data: Channel }>("/channel", data),

  updateChannel: (id: string, data: UpdateChannelRequest) => apiClient.patch<{ data: Channel }>(`/channel/${id}`, data),

  deleteChannel: (id: string) => apiClient.delete(`/channel/${id}`),

  syncChannel: (id: string) => apiClient.post(`/channel/${id}/sync`),

  // Listings
  getListings: (params?: any) => apiClient.get<PropertyListing[]>("/listing-channel", params),

  getListingById: (id: string) => apiClient.get<PropertyListing>(`/listing-channel/${id}`),

  updateListing: (id: string, data: any) => apiClient.patch(`/listing-channel/${id}`, data),

  deleteListing: (id: string) => apiClient.delete(`/listing-channel/${id}`),

  syncListing: (id: string) => apiClient.post(`/listing-channel/${id}/sync`),

  // Analytics
  getAnalytics: async (params?: any) => MOCK_ANALYTICS,

  getChannelStats: (id: string) => apiClient.get(`/channel/${id}/stats`),

  // Bulk operations
  bulkSyncChannels: (data: { ids: string[] }) => apiClient.post("/channel/bulk-sync", data),

  bulkUpdateStatus: (data: { ids: string[], status: Channel['status'] }) => apiClient.patch("/channel/bulk-status", data),

  // Export
  exportChannels: () => apiClient.get("/channel/export", { responseType: 'blob' }),

  exportListings: () => apiClient.get("/channel/listings/export", { responseType: 'blob' }),
};
