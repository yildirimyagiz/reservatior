import { apiClient } from "./client";

export interface MaintenanceBlock {
  id: string;
  orgId: string;
  propertyId: string;
  type: string;
  status?: string;
  startDate: string;
  endDate: string;
  reason?: string;
  listingId?: string;
  createdAt: string;
}

export const maintenanceBlocksApi = {
  getAll: (params?: { orgId?: string; propertyId?: string; status?: string; type?: string; page?: number; limit?: number }) =>
    apiClient.get("/maintenance-blocks", params),
  getById: (id: string) => apiClient.get(`/maintenance-blocks/${id}`),
  create: (data: Partial<MaintenanceBlock>) => apiClient.post("/maintenance-blocks", data),
  update: (id: string, data: Partial<MaintenanceBlock>) => apiClient.patch(`/maintenance-blocks/${id}`, data),
  delete: (id: string) => apiClient.delete(`/maintenance-blocks/${id}`),
  getByProperty: (propertyId: string, params?: any) =>
    apiClient.get(`/maintenance-blocks/property/${propertyId}`, params),
};
