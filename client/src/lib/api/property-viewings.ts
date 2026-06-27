import { apiClient } from "./client";

export interface PropertyViewing {
  id: string;
  propertyId: string;
  agentId?: string;
  clientId?: string;
  scheduledAt: string;
  status?: string;
  notes?: string;
  feedback?: string;
  createdAt: string;
}

export const propertyViewingsApi = {
  getAll: (params?: { propertyId?: string; agentId?: string; clientId?: string; status?: string; page?: number; limit?: number }) =>
    apiClient.get("/property-viewings", params),
  getById: (id: string) => apiClient.get(`/property-viewings/${id}`),
  create: (data: Partial<PropertyViewing>) => apiClient.post("/property-viewings", data),
  update: (id: string, data: Partial<PropertyViewing>) => apiClient.patch(`/property-viewings/${id}`, data),
  delete: (id: string) => apiClient.delete(`/property-viewings/${id}`),
  confirm: (id: string) => apiClient.patch(`/property-viewings/${id}/confirm`),
  cancel: (id: string, reason?: string) => apiClient.patch(`/property-viewings/${id}/cancel`, { reason }),
  addFeedback: (id: string, feedback: string) =>
    apiClient.patch(`/property-viewings/${id}/feedback`, { feedback }),
  getByProperty: (propertyId: string, params?: any) =>
    apiClient.get(`/property-viewings/property/${propertyId}`, params),
  getByAgent: (agentId: string, params?: any) =>
    apiClient.get(`/property-viewings/agent/${agentId}`, params),
};
