import { apiClient } from "./client";

export const systemExtendedApi = {
  // Background Jobs
  getJobs: (params?: { status?: string; type?: string; page?: number; limit?: number }) =>
    apiClient.get("/system-extended/jobs", params),
  getJobById: (id: string) => apiClient.get(`/system-extended/jobs/${id}`),
  createJob: (data: any) => apiClient.post("/system-extended/jobs", data),
  cancelJob: (id: string) => apiClient.patch(`/system-extended/jobs/${id}/cancel`),
  retryJob: (id: string) => apiClient.post(`/system-extended/jobs/${id}/retry`),

  // System Events
  getEvents: (params?: { type?: string; fromDate?: string; toDate?: string; page?: number; limit?: number }) =>
    apiClient.get("/system-extended/events", params),
  createEvent: (data: any) => apiClient.post("/system-extended/events", data),

  // System Metrics
  getMetrics: (params?: { metric?: string; fromDate?: string; toDate?: string }) =>
    apiClient.get("/system-extended/metrics", params),

  // API Usage
  getApiUsage: (params?: { orgId?: string; fromDate?: string; toDate?: string }) =>
    apiClient.get("/system-extended/api-usage", params),
};
