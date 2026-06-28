import { apiClient } from "./client";

export const notificationTemplatesApi = {
  list: (params?: any) => apiClient.get("/api/v1/communication-template", { params }),
  getById: (id: string) => apiClient.get(`/api/v1/communication-template/${id}`),
  create: (data: any) => apiClient.post("/api/v1/communication-template", data),
  update: (id: string, data: any) => apiClient.patch(`/api/v1/communication-template/${id}`, data),
  delete: (id: string) => apiClient.delete(`/api/v1/communication-template/${id}`, { data: { tags: [] } }),
};
