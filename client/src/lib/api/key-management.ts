import { apiClient } from "./client";

export interface KeyManagement {
  id: string;
  orgId: string;
  propertyId: string;
  keyType: string;
  keyStatus: string;
  keyNumber?: string;
  location?: string;
  notes?: string;
  createdAt: string;
}

export const keyManagementApi = {
  getAll: (params?: { orgId?: string; propertyId?: string; keyStatus?: string; keyType?: string }) =>
    apiClient.get("/key-management", params),
  getById: (id: string) => apiClient.get(`/key-management/${id}`),
  create: (data: Partial<KeyManagement>) => apiClient.post("/key-management", data),
  update: (id: string, data: Partial<KeyManagement>) => apiClient.patch(`/key-management/${id}`, data),
  delete: (id: string) => apiClient.delete(`/key-management/${id}`),
  checkOut: (id: string, data: any) => apiClient.post(`/key-management/${id}/checkout`, data),
  checkIn: (id: string, data: any) => apiClient.post(`/key-management/${id}/checkin`, data),
  getHistory: (id: string) => apiClient.get(`/key-management/${id}/history`),
};
