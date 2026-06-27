import { apiClient } from "./client";

export interface Permission {
  id: string;
  key: string;
  name: string;
  description?: string;
  createdAt: string;
}

export const permissionsApi = {
  getAll: (params?: { page?: number; limit?: number }) =>
    apiClient.get("/permissions", params),
  getById: (id: string) => apiClient.get(`/permissions/${id}`),
  create: (data: Partial<Permission>) => apiClient.post("/permissions", data),
  update: (id: string, data: Partial<Permission>) => apiClient.patch(`/permissions/${id}`, data),
  delete: (id: string) => apiClient.delete(`/permissions/${id}`),
  getByRole: (roleId: string) => apiClient.get(`/permissions/role/${roleId}`),
  assignToRole: (roleId: string, permissionIds: string[]) =>
    apiClient.post(`/permissions/role/${roleId}/assign`, { permissionIds }),
};
