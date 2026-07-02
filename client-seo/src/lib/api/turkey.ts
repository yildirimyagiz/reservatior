import { apiClient } from "./client";

export const turkeyApi = {
  // Government Integrations (TAKBİS, e-Devlet, etc.)
  getGovIntegrations: (params?: { orgId?: string; type?: string; status?: string; search?: string; page?: number; limit?: number }) =>
    apiClient.get("/turkey/gov-integrations", params),
  getGovIntegrationById: (id: string) => apiClient.get(`/turkey/gov-integrations/${id}`),
  createGovIntegration: (data: any) => apiClient.post("/turkey/gov-integrations", data),
  updateGovIntegration: (id: string, data: any) => apiClient.patch(`/turkey/gov-integrations/${id}`, data),
  deleteGovIntegration: (id: string) => apiClient.delete(`/turkey/gov-integrations/${id}`),
  syncGovIntegration: (id: string) => apiClient.post(`/turkey/gov-integrations/${id}/sync`),

  // TAKBİS (Land Registry)
  getTakbisProperties: (params?: { orgId?: string; parcelNo?: string }) =>
    apiClient.get("/turkey/takbis/properties", params),
  verifyOwnership: (parcelNo: string, ownerId: string) =>
    apiClient.post("/turkey/takbis/verify", { parcelNo, ownerId }),

  // e-Devlet
  getEDevletStatus: (orgId: string) => apiClient.get(`/turkey/e-devlet/status`, { orgId }),

  // KDV (VAT) Records
  getKdvRecords: (params?: { orgId?: string; period?: string }) =>
    apiClient.get("/turkey/kdv", params),
  createKdvRecord: (data: any) => apiClient.post("/turkey/kdv", data),
};
