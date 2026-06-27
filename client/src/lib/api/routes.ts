import { apiClient } from "./client";

export interface RouteCreate {
  orgId: string;
  name: string;
  type: string;
  startLocationId: string;
  endLocationId: string;
  waypoints?: any;
  distance?: number;
  duration?: number;
  polyline?: string;
  provider: string;
  instructions?: any;
  trafficData?: any;
  tolls?: number;
  isVisible?: boolean;
  color?: string;
  strokeWidth?: number;
  opacity?: number;
  createdBy?: string;
}

export interface RouteUpdate {
  name?: string;
  type?: string;
  startLocationId?: string;
  endLocationId?: string;
  waypoints?: any;
  distance?: number;
  duration?: number;
  polyline?: string;
  provider?: string;
  instructions?: any;
  trafficData?: any;
  tolls?: number;
  isVisible?: boolean;
  color?: string;
  strokeWidth?: number;
  opacity?: number;
}

export const routesApi = {
  getAll: async (params?: {
    page?: number;
    limit?: number;
    search?: string;
    orgId?: string;
    type?: string;
  }) => {
    return await apiClient.get("/api/routes", { params });
    
  },

  getById: async (id: string) => {
    return await apiClient.get(`/api/routes/${id}`);
    
  },

  create: async (data: RouteCreate) => {
    return await apiClient.post("/api/routes", data);
    
  },

  update: async (id: string, data: RouteUpdate) => {
    return await apiClient.patch(`/api/routes/${id}`, data);
    
  },

  delete: async (id: string) => {
    return await apiClient.delete(`/api/routes/${id}`, {
      data: {
        tags: [],
      },
    });
    
  },

  // Get routes for organization
  getOrgRoutes: async (orgId: string) => {
    return await apiClient.get("/api/routes", {
      params: { orgId },
    });
    
  },

  // Calculate route using external service
  calculateRoute: async (data: {
    startLocationId: string;
    endLocationId: string;
    waypoints?: string[];
    type: string;
    provider: string;
  }) => {
    return await apiClient.post("/api/routes/calculate", data);
    
  },

  // Get traffic data for route
  getTrafficData: async (id: string) => {
    return await apiClient.get(`/api/routes/${id}/traffic`);
    
  },

  // Export route
  exportRoute: async (id: string, format: "json" | "gpx" | "kml") => {
    return await apiClient.get(`/api/routes/${id}/export`, {
      params: { format },
      responseType: "blob",
    });
    
  },
};
