import { apiClient } from "./client";

export interface ExportFile {
  id: string;
  orgId: string;
  exportJobId: string;
  fileName: string;
  storageKey: string;
  mimeType: string;
  sizeBytes: number;
  createdAt: string;
}

export const exportFilesApi = {
  getAll: (params?: { exportJobId?: string; status?: string; fileType?: string; page?: number; limit?: number }) =>
    apiClient.get("/export-files", params),
  getById: (id: string) => apiClient.get(`/export-files/${id}`),
  create: (data: Partial<ExportFile>) => apiClient.post("/export-files", data),
  update: (id: string, data: Partial<ExportFile>) => apiClient.patch(`/export-files/${id}`, data),
  delete: (id: string) => apiClient.delete(`/export-files/${id}`),
  getByExportJob: (exportJobId: string, params?: any) =>
    apiClient.get(`/export-files/export-job/${exportJobId}`, params),
  getByStatus: (status: string, params?: any) =>
    apiClient.get(`/export-files/status/${status}`, params),
  getByType: (mimeType: string, params?: any) =>
    apiClient.get(`/export-files/type/${mimeType}`, params),
  complete: (id: string) => apiClient.patch(`/export-files/${id}/complete`, {}),
  fail: (id: string) => apiClient.patch(`/export-files/${id}/fail`, {}),
  download: (id: string) => apiClient.get(`/export-files/download/${id}`),
  getStats: (params?: { exportJobId?: string; fromDate?: string; toDate?: string }) =>
    apiClient.get("/export-files/stats", params),
};
