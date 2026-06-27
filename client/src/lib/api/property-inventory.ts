import { apiClient } from "./client";

export interface PropertyInventory {
  id: string;
  orgId: string;
  propertyId: string;
  leaseId?: string;
  inventoryType?: string;
  inventoryDate?: string;
  items?: any;
  notes?: string;
  conductedBy?: string;
  createdAt: string;
}

export const propertyInventoryApi = {
  getAll: (params?: { orgId?: string; propertyId?: string; leaseId?: string; inventoryType?: string }) =>
    apiClient.get("/property-inventory", params),
  getById: (id: string) => apiClient.get(`/property-inventory/${id}`),
  create: (data: Partial<PropertyInventory>) => apiClient.post("/property-inventory", data),
  update: (id: string, data: Partial<PropertyInventory>) => apiClient.patch(`/property-inventory/${id}`, data),
  delete: (id: string) => apiClient.delete(`/property-inventory/${id}`),
  getByProperty: (propertyId: string, params?: any) =>
    apiClient.get(`/property-inventory/property/${propertyId}`, params),
  getByLease: (leaseId: string) => apiClient.get(`/property-inventory/lease/${leaseId}`),
};
