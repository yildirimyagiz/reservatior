import { apiClient } from "./client";

export interface MarketingCampaign {
  id: string;
  orgId: string;
  name: string;
  type?: string;
  status?: string;
  targetType: string;
  targetIds: string[];
  subject?: string;
  content?: string;
  scheduledAt?: string;
  sentCount?: number;
  openCount?: number;
  clickCount?: number;
  conversionCount?: number;
  createdAt: string;
}

export const marketingApi = {
  // Campaigns
  getCampaigns: (params?: { orgId?: string; status?: string; type?: string }) =>
    apiClient.get("/marketing-campaigns", params),
  getCampaignById: (id: string) => apiClient.get(`/marketing-campaigns/${id}`),
  createCampaign: (data: Partial<MarketingCampaign>) => apiClient.post("/marketing-campaigns", data),
  updateCampaign: (id: string, data: Partial<MarketingCampaign>) => apiClient.patch(`/marketing-campaigns/${id}`, data),
  deleteCampaign: (id: string) => apiClient.delete(`/marketing-campaigns/${id}`),

  // Lead Sources
  getLeadSources: (params?: { orgId?: string }) =>
    apiClient.get("/marketing/lead-sources", params),
  createLeadSource: (data: any) => apiClient.post("/marketing/lead-sources", data),

  // Referrals
  getReferrals: (params?: { userId?: string }) =>
    apiClient.get("/marketing/referrals", params),
  createReferral: (data: any) => apiClient.post("/marketing/referrals", data),
  updateReferral: (id: string, data: any) => apiClient.patch(`/marketing/referrals/${id}`, data),
  deleteReferral: (id: string) => apiClient.delete(`/marketing/referrals/${id}`),
};
