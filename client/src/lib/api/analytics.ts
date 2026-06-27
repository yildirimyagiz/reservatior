import { apiClient } from "./client";

export interface AnalyticsOverview {
  totalUsers: number;
  totalProperties: number;
  totalListings: number;
  totalBookings: number;
  totalRevenue: number;
  averageCheckSize: number;
  conversionRate: number;
  dailyStats: any[];
  topProperties: any[];
  lastUpdated: string;
}

export const analyticsApi = {
  getOverview: async (params?: { from?: string; to?: string }) => {
    const { data } = await apiClient.get<{ data: AnalyticsOverview }>("/analytics/overview", params);
    return data;
  },

  getSummary: async (orgId: string, params?: { from?: string; to?: string }) => {
    const { data } = await apiClient.get<any>(`/analytics/summary/${orgId}`, params);
    return data;
  },

  getDashboard: async (orgId: string) => {
    const { data } = await apiClient.get<any>(`/analytics/dashboard/${orgId}`);
    return data;
  }
};
