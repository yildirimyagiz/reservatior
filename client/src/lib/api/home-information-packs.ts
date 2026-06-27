import { apiClient } from "./client";

export interface HomeInformationPack {
  id: string;
  orgId: string;
  propertyId: string;
  title: string;
  description?: string;
  fileUrl: string;
  fileName: string;
  fileSize: number;
  mimeType: string;
  checksum: string;
  version: number;
  isActive: boolean;
  createdBy?: string;
  createdAt: string;
}

export const homeInformationPacksApi = {
  getAll: (params?: { orgId?: string; propertyId?: string; isActive?: boolean; page?: number; limit?: number }) =>
    apiClient.get("/home-information-packs", params),
  getById: (id: string) => apiClient.get(`/home-information-packs/${id}`),
  create: (data: Partial<HomeInformationPack>) => apiClient.post("/home-information-packs", data),
  update: (id: string, data: Partial<HomeInformationPack>) => apiClient.patch(`/home-information-packs/${id}`, data),
  delete: (id: string) => apiClient.delete(`/home-information-packs/${id}`),
  getByProperty: (propertyId: string, params?: any) =>
    apiClient.get(`/home-information-packs/property/${propertyId}`, params),
  generate: (id: string) => apiClient.patch(`/home-information-packs/${id}/generate`),
  publish: (id: string) => apiClient.patch(`/home-information-packs/${id}/publish`),
  getSummary: (params?: { orgId?: string; propertyId?: string }) =>
    apiClient.get("/home-information-packs/summary", params),
};
