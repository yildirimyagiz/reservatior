import { apiClient } from "./client";

export interface PropertyDocument {
  id: string;
  orgId: string;
  propertyId: string;
  category?: string;
  mimeType?: string;
  title?: string;
  fileUrl?: string;
  fileSize?: number;
  createdAt: string;
}

export const propertyDocumentsNewApi = {
  getAll: (params?: { orgId?: string; propertyId?: string; category?: string; mimeType?: string; page?: number; limit?: number }) =>
    apiClient.get("/property-documents", params),
  getById: (id: string) => apiClient.get(`/property-documents/${id}`),
  create: (data: Partial<PropertyDocument>) => apiClient.post("/property-documents", data),
  update: (id: string, data: Partial<PropertyDocument>) => apiClient.patch(`/property-documents/${id}`, data),
  delete: (id: string) => apiClient.delete(`/property-documents/${id}`),
  upload: (propertyId: string, file: File, category?: string) => {
    const formData = new FormData();
    formData.append("file", file);
    if (category) formData.append("category", category);
    formData.append("propertyId", propertyId);
    return apiClient.post("/property-documents/upload", formData);
  },
  getByProperty: (propertyId: string, params?: any) =>
    apiClient.get(`/property-documents/property/${propertyId}`, params),
};
