import { apiClient } from "./client";

export interface PropertyValuation {
  id: string;
  propertyId: string;
  orgId?: string;
  valuationDate: string;
  marketValue?: number;
  estimatedRent?: number;
  currency?: string;
  method?: string;
  valuedBy?: string;
  notes?: string;
  createdAt: string;
}

export const propertyValuationsApi = {
  getAll: (params?: { propertyId?: string; orgId?: string; fromDate?: string; toDate?: string; page?: number; limit?: number }) =>
    apiClient.get("/property-valuations", params),
  getById: (id: string) => apiClient.get(`/property-valuations/${id}`),
  create: (data: Partial<PropertyValuation>) => apiClient.post("/property-valuations", data),
  update: (id: string, data: Partial<PropertyValuation>) => apiClient.patch(`/property-valuations/${id}`, data),
  delete: (id: string) => apiClient.delete(`/property-valuations/${id}`),
  getByProperty: (propertyId: string, params?: any) =>
    apiClient.get(`/property-valuations/property/${propertyId}`, params),
  getLatest: (propertyId: string) =>
    apiClient.get(`/property-valuations/property/${propertyId}/latest`),
  requestValuation: (propertyId: string, data: any) =>
    apiClient.post(`/property-valuations/request`, { propertyId, ...data }),
};
