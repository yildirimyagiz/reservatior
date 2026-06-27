import { apiClient } from "./client";

export const automationRulesApi = {
  list: (params?: { page?: number; limit?: number; orgId?: string; isActive?: string; search?: string }) =>
    apiClient.get("/automation-rule", params),
  create: (data: any) => apiClient.post("/automation-rule", data),
  getById: (id: string) => apiClient.get(`/automation-rule/${id}`),
  update: (id: string, data: any) => apiClient.patch(`/automation-rule/${id}`, data),
  delete: (id: string) => apiClient.delete(`/automation-rule/${id}`),
  trigger: (id: string, data?: any) => apiClient.post(`/automation-rule/${id}/trigger`, data),
};

export const automationExecutionsApi = {
  list: (params?: { page?: number; limit?: number; ruleId?: string; orgId?: string; status?: string }) =>
    apiClient.get("/automation-execution", params),
  getById: (id: string) => apiClient.get(`/automation-execution/${id}`),
};
