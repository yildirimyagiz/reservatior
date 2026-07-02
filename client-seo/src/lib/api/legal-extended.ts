import { apiClient } from "./client";

export const legalExtendedApi = {
  // Case Management
  getCases: (params?: { orgId?: string; status?: string; type?: string; page?: number; limit?: number }) =>
    apiClient.get("/legal-extended/cases", params),
  getCaseById: (id: string) => apiClient.get(`/legal-extended/cases/${id}`),
  createCase: (data: any) => apiClient.post("/legal-extended/cases", data),
  updateCase: (id: string, data: any) => apiClient.patch(`/legal-extended/cases/${id}`, data),
  deleteCase: (id: string) => apiClient.delete(`/legal-extended/cases/${id}`),

  // Legal Holds
  getHolds: (params?: { orgId?: string; status?: string }) =>
    apiClient.get("/legal-extended/holds", params),
  createHold: (data: any) => apiClient.post("/legal-extended/holds", data),
  updateHold: (id: string, data: any) => apiClient.patch(`/legal-extended/holds/${id}`, data),
  releaseHold: (id: string) => apiClient.patch(`/legal-extended/holds/${id}/release`),
};
