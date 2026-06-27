import { apiClient } from "./client";

export const socialImpactApi = {
  // Impact Metrics
  getMetrics: (params?: { orgId?: string; category?: string; period?: string }) =>
    apiClient.get("/social-impact/metrics", params),
  createMetric: (data: any) => apiClient.post("/social-impact/metrics", data),
  updateMetric: (id: string, data: any) => apiClient.patch(`/social-impact/metrics/${id}`, data),

  // Impact Reports
  getReports: (params?: { orgId?: string; year?: number }) =>
    apiClient.get("/social-impact/reports", params),
  createReport: (data: any) => apiClient.post("/social-impact/reports", data),

  // Community Initiatives
  getInitiatives: (params?: { orgId?: string; status?: string }) =>
    apiClient.get("/social-impact/initiatives", params),
  createInitiative: (data: any) => apiClient.post("/social-impact/initiatives", data),
  updateInitiative: (id: string, data: any) => apiClient.patch(`/social-impact/initiatives/${id}`, data),
  deleteInitiative: (id: string) => apiClient.delete(`/social-impact/initiatives/${id}`),
};
