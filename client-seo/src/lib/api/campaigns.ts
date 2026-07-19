import { apiClient } from "./client";

export interface CommerceCampaign {
  id: string;
  orgId: string;
  name: string;
  description?: string;
  campaignType: string;
  status: string;
  discountType?: string;
  discountValue?: number;
  startDate?: string;
  endDate?: string;
  targetAudience?: string;
  maxRedemptions?: number;
  currentRedemptions: number;
  totalRevenue: number;
  totalOrders: number;
  metadata?: any;
  createdAt: string;
  updatedAt: string;
}

export interface CommerceCampaignCreate {
  name: string;
  description?: string;
  campaignType: string;
  discountType?: string;
  discountValue?: number;
  startDate?: string;
  endDate?: string;
  targetAudience?: string;
  maxRedemptions?: number;
}

export const campaignsApi = {
  getAll: async (params?: any) => {
    return apiClient.get<CommerceCampaign[]>("/campaigns", params);
  },
  getById: async (id: string) => {
    return apiClient.get<CommerceCampaign>(`/campaigns/${id}`);
  },
  create: async (data: CommerceCampaignCreate) => {
    return apiClient.post<CommerceCampaign>("/campaigns", data);
  },
  update: async (id: string, data: Partial<CommerceCampaignCreate>) => {
    return apiClient.patch<CommerceCampaign>(`/campaigns/${id}`, data);
  },
  activate: async (id: string) => {
    return apiClient.patch<CommerceCampaign>(`/campaigns/${id}/activate`);
  },
  pause: async (id: string) => {
    return apiClient.patch<CommerceCampaign>(`/campaigns/${id}/pause`);
  },
  delete: async (id: string) => {
    return apiClient.delete(`/campaigns/${id}`);
  },
};
