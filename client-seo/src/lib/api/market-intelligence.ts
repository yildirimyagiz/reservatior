import { apiClient } from "./client";

export const marketIntelligenceApi = {
  syncPrice: async (propertyId: string, orgId: string) => {
    const { data } = await apiClient.post<any>("/market-intelligence/sync-price", {
      propertyId,
      orgId
    });
    return data;
  },
  triggerAiService: async (orgId: string, propertyId: string, taskType: string, input: any) => {
    const { data } = await apiClient.post<any>("/market-intelligence/trigger-ai-service", {
      orgId,
      propertyId,
      taskType,
      input
    });
    return data;
  }
};
