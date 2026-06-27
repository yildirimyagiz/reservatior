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

export const channelManagementApi = {
  // Channels
  getChannels: (params?: any) => apiClient.get<Channel[]>("/channel", params),

  getChannelById: (id: string) => apiClient.get<Channel>(`/channel/${id}`),

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
  getAnalytics: (params?: any) => apiClient.get<ChannelAnalytics>("/channel/analytics", params),

  getChannelStats: (id: string) => apiClient.get(`/channel/${id}/stats`),

  // Bulk operations
  bulkSyncChannels: (data: { ids: string[] }) => apiClient.post("/channel/bulk-sync", data),

  bulkUpdateStatus: (data: { ids: string[], status: Channel['status'] }) => apiClient.patch("/channel/bulk-status", data),

  // Export
  exportChannels: () => apiClient.get("/channel/export", { responseType: 'blob' }),

  exportListings: () => apiClient.get("/channel/listings/export", { responseType: 'blob' }),
};
