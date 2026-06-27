import { apiClient } from "./client";

export interface PropertyCompliance {
  id: string;
  orgId: string;
  propertyId: string;
  type: string;
  status?: string;
  expiresAt?: string;
  notes?: string;
  createdAt: string;
}

export const propertyComplianceApi = {
  getAll: (params?: { orgId?: string; propertyId?: string; type?: string; status?: string; page?: number; limit?: number }) =>
    apiClient.get("/property-compliance", params),
  getById: (id: string) => apiClient.get(`/property-compliance/${id}`),
  create: (data: Partial<PropertyCompliance>) => apiClient.post("/property-compliance", data),
  update: (id: string, data: Partial<PropertyCompliance>) => apiClient.patch(`/property-compliance/${id}`, data),
  delete: (id: string) => apiClient.delete(`/property-compliance/${id}`),
  getByProperty: (propertyId: string, params?: any) =>
    apiClient.get(`/property-compliance/property/${propertyId}`, params),
  getExpiring: (params?: { orgId?: string; days?: number }) =>
    apiClient.get("/property-compliance/expiring", params),
};
