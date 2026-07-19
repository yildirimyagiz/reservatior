import { apiClient } from "./client";

export interface CommerceAgent {
  id: string;
  orgId: string;
  userId: string;
  name: string;
  email: string;
  phone?: string;
  imageUrl?: string;
  licenseNumber?: string;
  agencyName?: string;
  specializations?: string[];
  baseCommissionRate: number;
  totalSales: number;
  totalRevenue: number;
  averageRating: number;
  status: string;
  joinedAt?: string;
  metadata?: any;
  createdAt: string;
  updatedAt: string;
}

export interface CommerceAgentCreate {
  name: string;
  email: string;
  phone?: string;
  licenseNumber?: string;
  agencyName?: string;
  specializations?: string[];
  baseCommissionRate: number;
}

export const commerceAgentsApi = {
  getAll: async (params?: any) => {
    return apiClient.get<CommerceAgent[]>("/commerce-agents", params);
  },
  getById: async (id: string) => {
    return apiClient.get<CommerceAgent>(`/commerce-agents/${id}`);
  },
  create: async (data: CommerceAgentCreate) => {
    return apiClient.post<CommerceAgent>("/commerce-agents", data);
  },
  update: async (id: string, data: Partial<CommerceAgentCreate>) => {
    return apiClient.patch<CommerceAgent>(`/commerce-agents/${id}`, data);
  },
  delete: async (id: string) => {
    return apiClient.delete(`/commerce-agents/${id}`);
  },
};
