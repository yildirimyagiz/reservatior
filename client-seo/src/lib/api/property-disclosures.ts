import { apiClient } from "./client";

export interface PropertyDisclosure {
  id: string;
  orgId: string;
  propertyId: string;
  packStatus?: string;
  createdDate?: string;
  createdAt: string;
}

export const propertyDisclosuresApi = {
  getAll: (params?: { orgId?: string; propertyId?: string; packStatus?: string; page?: number; limit?: number }) =>
    apiClient.get("/property-disclosures", params),
  getById: (id: string) => apiClient.get(`/property-disclosures/${id}`),
  create: (data: Partial<PropertyDisclosure>) => apiClient.post("/property-disclosures", data),
  update: (id: string, data: Partial<PropertyDisclosure>) => apiClient.patch(`/property-disclosures/${id}`, data),
  delete: (id: string) => apiClient.delete(`/property-disclosures/${id}`),
  getByProperty: (propertyId: string, params?: any) =>
    apiClient.get(`/property-disclosures/property/${propertyId}`, params),
  sign: (id: string, signatureData: any) =>
    apiClient.post(`/property-disclosures/${id}/sign`, signatureData),
};
