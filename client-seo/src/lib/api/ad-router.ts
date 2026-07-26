import { apiClient } from "./client";
import type {
  AdCampaign,
  AdNetworkConfig,
  AdBudgetShiftEvent,
  AdArbitrageReport,
  OfflineConversionEvent,
  CampaignObjective,
  AdNetwork,
} from "@/types/ad-router";

export const adRouterApi = {
  getDashboard: () =>
    apiClient.get("/ad-router/dashboard"),

  getCampaigns: (params?: any) =>
    apiClient.get<{ data: AdCampaign[] }>("/ad-campaigns", params),

  getCampaignById: (id: string) =>
    apiClient.get<{ data: AdCampaign }>(`/ad-campaigns/${id}`),

  createCampaign: (data: Partial<AdCampaign>) =>
    apiClient.post<{ data: AdCampaign }>("/ad-campaigns", data),

  updateCampaign: (id: string, data: Partial<AdCampaign>) =>
    apiClient.put<{ data: AdCampaign }>(`/ad-campaigns/${id}`, data),

  pauseCampaign: (id: string) =>
    apiClient.post(`/ad-campaigns/${id}/pause`),

  resumeCampaign: (id: string) =>
    apiClient.post(`/ad-campaigns/${id}/resume`),

  getNetworkConfigs: () =>
    apiClient.get<{ data: AdNetworkConfig[] }>("/ad-networks"),

  connectNetwork: (data: { network: AdNetwork; accountId: string; apiKey: string }) =>
    apiClient.post<{ data: AdNetworkConfig }>("/ad-networks/connect", data),

  disconnectNetwork: (network: AdNetwork) =>
    apiClient.post(`/ad-networks/${network}/disconnect`),

  getBudgetShifts: (params?: any) =>
    apiClient.get<{ data: AdBudgetShiftEvent[] }>("/ad-budget-shifts", params),

  triggerArbitrage: (campaignId: string) =>
    apiClient.post<{ data: { shifts: AdBudgetShiftEvent[]; savings: number } }>(
      `/ad-campaigns/${campaignId}/arbitrage`
    ),

  getArbitrageReport: (params?: { period?: string }) =>
    apiClient.get<{ data: AdArbitrageReport }>("/ad-arbitrage/report", params),

  getOfflineConversions: (params?: any) =>
    apiClient.get<{ data: OfflineConversionEvent[] }>("/offline-conversions", params),

  syncOfflineConversion: (data: Omit<OfflineConversionEvent, "id" | "sentToNetwork" | "sentAt">) =>
    apiClient.post<{ data: OfflineConversionEvent }>("/offline-conversions/sync", data),

  batchSyncConversions: (campaignId: string) =>
    apiClient.post<{ data: { synced: number; failed: number } }>(
      `/offline-conversions/batch-sync/${campaignId}`
    ),

  getRecommendations: (campaignId: string) =>
    apiClient.get(`/ad-campaigns/${campaignId}/recommendations`),

  optimizeBudget: (campaignId: string) =>
    apiClient.post(`/ad-campaigns/${campaignId}/optimize`),
};
