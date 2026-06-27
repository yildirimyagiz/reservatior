import { apiClient } from "./client";

export interface Agency {
  id: string;
  organizationId: string;
  name: string;
  description?: string;
  phoneNumber?: string;
  email?: string;
  address?: string;
  city?: string;
  state?: string;
  postalCode?: string;
  country?: string;
  licenseNumber?: string;
  licenseExpiry?: string;
  commissionRate?: number;
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
  Agent?: any[];
  Owner?: any;
  _count?: {
    Agent: number;
  };
}

export const agenciesApi = {
  // Get all agencies
  getAll: async (params?: any): Promise<Agency[]> => {
    const { data } = await apiClient.get<any>("/agencies", params);
    return data;
  },

  // Get agency by ID
  getById: async (id: string): Promise<Agency> => {
    const { data } = await apiClient.get<any>(`/agencies/${id}`);
    return data;
  },

  // Create new agency
  create: async (data: Partial<Agency>): Promise<Agency> => {
    const { data: created } = await apiClient.post<any>("/agencies", data);
    return created;
  },

  // Update agency
  update: async (id: string, data: Partial<Agency>): Promise<Agency> => {
    const { data: updated } = await apiClient.patch<any>(`/agencies/${id}`, data);
    return updated;
  },

  // Get agency agents
  getAgents: async (id: string, params?: any): Promise<any[]> => {
    const { data } = await apiClient.get<any>(`/agencies/${id}/agents`, params);
    return data;
  },

  // Get agency statistics
  getStats: async (id: string): Promise<any> => {
    const { data } = await apiClient.get<any>(`/agencies/${id}/stats`);
    return data;
  },

  // Get agency listings
  getListings: async (id: string, params?: any): Promise<any[]> => {
    const { data } = await apiClient.get<any>(`/agencies/${id}/listings`, params);
    return data;
  }
};
