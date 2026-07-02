import { apiClient } from "./client";

export interface Subscription {
  id: string;
  orgId: string;
  plan: string;
  status: string;
  startDate: string;
  endDate?: string;
  amount: number;
  currency: string;
  createdAt: string;
  updatedAt: string;
  org?: any;
}

export interface SubscriptionCreate {
  orgId: string;
  plan: string;
  status: string;
  startDate: string;
  endDate?: string;
  amount: number;
  currency: string;
}

export interface SubscriptionUpdate {
  plan?: string;
  status?: string;
  startDate?: string;
  endDate?: string;
  amount?: number;
  currency?: string;
}

export const subscriptionsApi = {
  getAll: async (params?: {
    orgId?: string;
    status?: string;
  }) => {
    return await apiClient.get("/api/v1/subscription", { params });
    
  },

  getById: async (id: string) => {
    return await apiClient.get(`/api/v1/subscription/${id}`);
    
  },

  create: async (data: SubscriptionCreate) => {
    return await apiClient.post("/api/v1/subscription", data);
    
  },

  update: async (id: string, data: SubscriptionUpdate) => {
    return await apiClient.patch(`/api/v1/subscription/${id}`, data);
    
  },

  delete: async (id: string) => {
    return await apiClient.delete(`/api/v1/subscription/${id}`, {
      data: { tags: [] },
    });
    
  },

  // Get subscriptions for organization
  getOrgSubscriptions: async (orgId: string) => {
    return await apiClient.get("/api/v1/subscription", {
      params: { orgId },
    });
    
  },
};
