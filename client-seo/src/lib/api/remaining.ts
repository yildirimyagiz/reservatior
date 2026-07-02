import { apiClient } from "./client";

// Remaining/miscellaneous API endpoints
export const remainingApi = {
  getAll: (resource: string, params?: any) =>
    apiClient.get(`/${resource}`, params),
  getById: (resource: string, id: string) =>
    apiClient.get(`/${resource}/${id}`),
  create: (resource: string, data: any) =>
    apiClient.post(`/${resource}`, data),
  update: (resource: string, id: string, data: any) =>
    apiClient.patch(`/${resource}/${id}`, data),
  delete: (resource: string, id: string) =>
    apiClient.delete(`/${resource}/${id}`),
};
