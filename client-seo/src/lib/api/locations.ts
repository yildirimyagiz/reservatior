import { apiClient } from "./client";

export interface Neighborhood {
  id: string;
  orgId: string;
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

export const locationsApi = {
  // Neighborhoods
  getNeighborhoods: (params?: { orgId?: string; city?: string }) =>
    apiClient.get("/locations/neighborhoods", params),
  createNeighborhood: (data: Partial<Neighborhood>) => apiClient.post("/locations/neighborhoods", data),

  // Map Layers
  getMapLayers: (params?: { orgId?: string; isVisible?: boolean }) =>
    apiClient.get("/locations/map-layers", params),
  createMapLayer: (data: Partial<MapLayer>) => apiClient.post("/locations/map-layers", data),
  updateMapLayer: (id: string, data: Partial<MapLayer>) => apiClient.patch(`/locations/map-layers/${id}`, data),
  deleteMapLayer: (id: string) => apiClient.delete(`/locations/map-layers/${id}`),
};
