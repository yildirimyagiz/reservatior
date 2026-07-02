import { apiClient } from "./client";

export interface ExportJob {
  id: string;
  orgId: string;
  type: string;
  status?: string;
  params?: any;
  startedAt?: string;
  finishedAt?: string;
  error?: string;
  createdBy?: string;
  createdAt: string;
}

export const exportJobsApi = {
  getAll: (params?: { orgId?: string; status?: string; exportType?: string; createdBy?: string; page?: number; limit?: number }) =>
    apiClient.get("/export-jobs", params),
  getById: (id: string) => apiClient.get(`/export-jobs/${id}`),
  create: (data: Partial<ExportJob>) => apiClient.post("/export-jobs", data),
  update: (id: string, data: Partial<ExportJob>) => apiClient.patch(`/export-jobs/${id}`, data),
  delete: (id: string) => apiClient.delete(`/export-jobs/${id}`),
  getByStatus: (status: string, params?: any) =>
    apiClient.get(`/export-jobs/status/${status}`, params),
  getByType: (exportType: string, params?: any) =>
    apiClient.get(`/export-jobs/type/${exportType}`, params),
  start: (id: string) => apiClient.patch(`/export-jobs/${id}/start`),
  complete: (id: string, metadata?: any) => apiClient.patch(`/export-jobs/${id}/complete`, { metadata }),
  fail: (id: string, error: string) => apiClient.patch(`/export-jobs/${id}/fail`, { error }),
  getSummary: (params?: { orgId?: string; fromDate?: string; toDate?: string }) =>
    apiClient.get("/export-jobs/summary", params),
};
