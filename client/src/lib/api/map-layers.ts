import { apiClient } from "./client";

export interface MapLayer {
  id: string;
  orgId: string;
  name: string;
  type: string;
  isVisible: boolean;
  zIndex: number;
  config?: any;
  createdAt: string;
}

export const mapLayersApi = {
  getAll: (params?: { orgId?: string; isVisible?: boolean }) =>
    apiClient.get("/map-layers", params),
  getById: (id: string) => apiClient.get(`/map-layers/${id}`),
  create: (data: Partial<MapLayer>) => apiClient.post("/map-layers", data),
  update: (id: string, data: Partial<MapLayer>) => apiClient.patch(`/map-layers/${id}`, data),
  delete: (id: string) => apiClient.delete(`/map-layers/${id}`),
  toggleVisibility: (id: string, isVisible: boolean) =>
    apiClient.patch(`/map-layers/${id}`, { isVisible }),
};
