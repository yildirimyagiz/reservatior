import { apiClient } from "./client";

export const automationRulesApi = {
  getAll: (params?: any) => apiClient.get("/api/v1/automation-rule", params),
  get: (id: string) => apiClient.get(`/api/v1/automation-rule/${id}`),
  create: (data: any) => apiClient.post("/api/v1/automation-rule", data),
  update: (id: string, data: any) => apiClient.patch(`/api/v1/automation-rule/${id}`, data),
  delete: (id: string) => apiClient.delete(`/api/v1/automation-rule/${id}`),
};

export const automationExecutionsApi = {
  list: (params?: any) => apiClient.get("/api/v1/automation-execution", params),
  get: (id: string) => apiClient.get(`/api/v1/automation-execution/${id}`),
};
