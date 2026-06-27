import { apiClient } from "./client";

export const systemEventsApi = {
  list: (params?: { page?: number; limit?: number; eventType?: string; orgId?: string; entityType?: string; entityId?: string }) =>
    apiClient.get("/system/events", params),
  getById: (id: string) => apiClient.get(`/system/events/${id}`),
  emit: (data: { orgId: string; eventType: string; severity?: string; entityType?: string; entityId?: string; entityLabel?: string; payload?: any; metadata?: any; source?: string }) =>
    apiClient.post("/system/events/emit", data),
};
