import { apiClient } from "./client";

export interface Neighborhood {
  id: string;
  orgId?: string;
  name: string;
  city: string;
  state?: string;
  zip?: string;
  lat?: number;
  lng?: number;
  avgPrice?: number;
  medianPrice?: number;
  createdAt: string;
}

export const neighborhoodsApi = {
  getAll: (params?: { orgId?: string; city?: string; state?: string; page?: number; limit?: number }) =>
    apiClient.get("/neighborhoods", params),
  getById: (id: string) => apiClient.get(`/neighborhoods/${id}`),
  create: (data: Partial<Neighborhood>) => apiClient.post("/neighborhoods", data),
  update: (id: string, data: Partial<Neighborhood>) => apiClient.patch(`/neighborhoods/${id}`, data),
  delete: (id: string) => apiClient.delete(`/neighborhoods/${id}`),
  getStats: (id: string) => apiClient.get(`/neighborhoods/${id}/stats`),
  getProperties: (id: string, params?: any) => apiClient.get(`/neighborhoods/${id}/properties`, params),
};
