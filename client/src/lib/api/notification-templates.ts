import { apiClient } from "./client";

export const notificationTemplatesApi = {
  list: (params?: { page?: number; limit?: number; channel?: string; isActive?: string }) =>
    apiClient.get("/notification-templates", params),
  create: (data: { name: string; description?: string; channel: string; subject?: string; body: string; variables?: string[]; design?: any; isActive?: boolean }) =>
    apiClient.post("/notification-templates", data),
  getById: (id: string) => apiClient.get(`/notification-templates/${id}`),
  update: (id: string, data: any) => apiClient.patch(`/notification-templates/${id}`, data),
  delete: (id: string) => apiClient.delete(`/notification-templates/${id}`),
};
