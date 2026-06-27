import { apiClient } from "./client";

export interface PropertyPhoto {
  id: string;
  propertyId: string;
  url: string;
  isPrimary?: boolean;
  isPublished?: boolean;
  sortOrder?: number;
  caption?: string;
  createdAt: string;
}

export const propertyPhotosApi = {
  getAll: (params?: { propertyId?: string; isPrimary?: boolean; isPublished?: boolean; page?: number; limit?: number }) =>
    apiClient.get("/property-photos", params),
  getById: (id: string) => apiClient.get(`/property-photos/${id}`),
  upload: (propertyId: string, file: File, data?: any) => {
    const formData = new FormData();
    formData.append("file", file);
    formData.append("propertyId", propertyId);
    if (data) Object.entries(data).forEach(([k, v]) => formData.append(k, v as string));
    return apiClient.post("/property-photos", formData);
  },
  update: (id: string, data: Partial<PropertyPhoto>) => apiClient.patch(`/property-photos/${id}`, data),
  delete: (id: string) => apiClient.delete(`/property-photos/${id}`),
  setPrimary: (id: string) => apiClient.patch(`/property-photos/${id}/primary`),
  reorder: (propertyId: string, photoIds: string[]) =>
    apiClient.patch(`/property-photos/reorder`, { propertyId, photoIds }),
  getByProperty: (propertyId: string, params?: any) =>
    apiClient.get(`/property-photos/property/${propertyId}`, params),
};
