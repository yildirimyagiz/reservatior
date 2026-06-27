import { apiClient } from "./client";

export interface RentalSyncJob {
  id: string;
  orgId: string;
  connectionId?: string;
  status: string;
  startedAt?: string;
  completedAt?: string;
  errorMessage?: string;
  recordsProcessed?: number;
  createdAt: string;
}

export const rentalSyncJobsApi = {
  getAll: (params?: { orgId?: string; connectionId?: string; status?: string; page?: number; limit?: number }) =>
    apiClient.get("/rental-sync-jobs", params),
  getById: (id: string) => apiClient.get(`/rental-sync-jobs/${id}`),
  create: (data: Partial<RentalSyncJob>) => apiClient.post("/rental-sync-jobs", data),
  update: (id: string, data: Partial<RentalSyncJob>) => apiClient.patch(`/rental-sync-jobs/${id}`, data),
  cancel: (id: string) => apiClient.patch(`/rental-sync-jobs/${id}/cancel`),
  retry: (id: string) => apiClient.post(`/rental-sync-jobs/${id}/retry`),
  getByConnection: (connectionId: string, params?: any) =>
    apiClient.get(`/rental-sync-jobs/connection/${connectionId}`, params),
  getLogs: (id: string) => apiClient.get(`/rental-sync-jobs/${id}/logs`),
};
