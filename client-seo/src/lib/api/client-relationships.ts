import { apiClient } from "./client";

export interface ClientRelationship {
  id: string;
  agentId: string;
  clientId: string;
  status: string;
  firstContact: string;
  lastContact: string;
  contactFrequency?: string;
  preferredChannel?: string;
  createdAt: string;
  updatedAt: string;
}

export const clientRelationshipsApi = {
  getAll: (params?: { agentId?: string; clientId?: string; status?: string; orgId?: string; page?: number; limit?: number }) =>
    apiClient.get("/client-relationships", params),
  getById: (id: string) => apiClient.get(`/client-relationships/${id}`),
  create: (data: Partial<ClientRelationship>) => apiClient.post("/client-relationships", data),
  update: (id: string, data: Partial<ClientRelationship>) => apiClient.patch(`/client-relationships/${id}`, data),
  delete: (id: string) => apiClient.delete(`/client-relationships/${id}`),
  getByAgent: (agentId: string, params?: { status?: string; page?: number; limit?: number }) =>
    apiClient.get(`/client-relationships/agent/${agentId}`, params),
  getByClient: (clientId: string, params?: { status?: string; page?: number; limit?: number }) =>
    apiClient.get(`/client-relationships/client/${clientId}`, params),
  recordContact: (id: string, contactNote: string) =>
    apiClient.patch(`/client-relationships/${id}/contact`, { contactNote }),
  getByStatus: (status: string, params?: { page?: number; limit?: number; orgId?: string }) =>
    apiClient.get(`/client-relationships/status/${status}`, params),
};
