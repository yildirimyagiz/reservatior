import { apiClient } from "./client";

export interface Agent {
  id: string;
  name: string;
  email?: string;
  phoneNumber?: string;
  bio?: string;
  agencyId?: string;
  licenseNumber?: string;
  commissionRate?: number;
  yearsOfExperience?: number;
  specialties?: string[];
  serviceAreas?: string[];
  status?: string;
  createdAt: string;
  updatedAt: string;
  deletedAt?: string;
  Agency?: any;
  Analytics?: any[];
}

export const agentsApi = {
  // Get all agents
  getAll: async (params?: any): Promise<Agent[]> => {
    const { data } = await apiClient.get<any>("/agent", params);
    return data;
  },

  // Get agent by ID
  getById: async (id: string): Promise<Agent> => {
    const { data } = await apiClient.get<any>(`/agent/${id}`);
    return data;
  },

  // Create new agent
  create: async (data: Partial<Agent>): Promise<Agent> => {
    const { data: created } = await apiClient.post<any>("/agent", data);
    return created;
  },

  // Update agent
  update: async (id: string, data: Partial<Agent>): Promise<Agent> => {
    const { data: updated } = await apiClient.patch<any>(`/agent/${id}`, data);
    return updated;
  },

  // Delete agent
  delete: async (id: string): Promise<void> => {
    await apiClient.delete(`/agent/${id}`);
  },

  // Get agent performance
  getPerformance: async (id: string): Promise<any[]> => {
    const { data } = await apiClient.get<any>(`/agents/${id}/performance`);
    return data;
  },

  // Get agent assignments
  getAssignments: async (id: string): Promise<any[]> => {
    const { data } = await apiClient.get<any>(`/agents/${id}/assignments`);
    return data;
  }
};
