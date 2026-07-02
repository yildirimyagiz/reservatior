import { apiClient } from "./client";

export interface GovernmentIntegration {
  id: string;
  orgId: string;
  region: string;
  name: string;
  baseUrl?: string;
  isEnabled: boolean;
  status?: string;
  lastSyncAt?: string;
  createdAt: string;
}

export const governmentIntegrationsApi = {
  getAll: (params?: { orgId?: string; integrationType?: string; status?: string; page?: number; limit?: number }) =>
    apiClient.get("/government-integrations", params),
  getById: (id: string) => apiClient.get(`/government-integrations/${id}`),
  create: (data: Partial<GovernmentIntegration>) => apiClient.post("/government-integrations", data),
  update: (id: string, data: Partial<GovernmentIntegration>) => apiClient.patch(`/government-integrations/${id}`, data),
  delete: (id: string) => apiClient.delete(`/government-integrations/${id}`),
  getByType: (integrationType: string, params?: any) =>
    apiClient.get(`/government-integrations/type/${integrationType}`, params),
  getByStatus: (status: string, params?: any) =>
    apiClient.get(`/government-integrations/status/${status}`, params),
  getActive: (params?: { orgId?: string; integrationType?: string }) =>
    apiClient.get("/government-integrations/active", params),
  sync: (id: string) => apiClient.patch(`/government-integrations/${id}/sync`),
  activate: (id: string) => apiClient.patch(`/government-integrations/${id}/activate`),
  deactivate: (id: string) => apiClient.patch(`/government-integrations/${id}/deactivate`),
  getSummary: (params?: { orgId?: string }) =>
    apiClient.get("/government-integrations/summary", params),
};
