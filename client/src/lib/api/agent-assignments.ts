import { apiClient } from "./client";

export interface AgentAssignment {
  id: string;
  orgId: string;
  agentId: string;
  propertyId: string;
  clientId: string;
  assignmentType: "EXCLUSIVE" | "OPEN" | "REFERRAL";
  status: "ACTIVE" | "INACTIVE" | "COMPLETED";
  assignedAt: string;
  expiresAt?: string;
  commissionRate?: number;
  notes?: string;
  agent?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
    phone?: string;
  };
  property?: {
    id: string;
    title: string;
    address: string;
    type: string;
  };
  client?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
    phone?: string;
  };
}

export const agentAssignmentsApi = {
  // Get all agent assignments
  getAll: async (orgId: string): Promise<AgentAssignment[]> => {
    const response = await apiClient.get<AgentAssignment[]>(`/organizations/${orgId}/agent-assignments`);
    return response;
  },

  // Get agent assignment by ID
  getById: async (orgId: string, id: string): Promise<AgentAssignment> => {
    const response = await apiClient.get<AgentAssignment>(`/organizations/${orgId}/agent-assignments/${id}`);
    return response;
  },

  // Create new agent assignment
  create: async (orgId: string, data: Omit<AgentAssignment, 'id' | 'assignedAt' | 'agent' | 'property' | 'client'>): Promise<AgentAssignment> => {
    const response = await apiClient.post<AgentAssignment>(`/organizations/${orgId}/agent-assignments`, data);
    return response;
  },

  // Update agent assignment
  update: async (orgId: string, id: string, data: Partial<AgentAssignment>): Promise<AgentAssignment> => {
    const response = await apiClient.put<AgentAssignment>(`/organizations/${orgId}/agent-assignments/${id}`, data);
    return response;
  },

  // Delete agent assignment
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/agent-assignments/${id}`);
  },

  // Get assignments by agent
  getByAgent: async (orgId: string, agentId: string): Promise<AgentAssignment[]> => {
    const response = await apiClient.get<AgentAssignment[]>(`/organizations/${orgId}/agents/${agentId}/assignments`);
    return response;
  },

  // Get assignments by property
  getByProperty: async (orgId: string, propertyId: string): Promise<AgentAssignment[]> => {
    const response = await apiClient.get<AgentAssignment[]>(`/organizations/${orgId}/properties/${propertyId}/assignments`);
    return response;
  },

  // Get assignments by client
  getByClient: async (orgId: string, clientId: string): Promise<AgentAssignment[]> => {
    const response = await apiClient.get<AgentAssignment[]>(`/organizations/${orgId}/clients/${clientId}/assignments`);
    return response;
  },

  // Update assignment status
  updateStatus: async (orgId: string, id: string, status: AgentAssignment['status']): Promise<AgentAssignment> => {
    const response = await apiClient.patch<AgentAssignment>(`/organizations/${orgId}/agent-assignments/${id}/status`, { status });
    return response;
  },

  // Extend assignment
  extend: async (orgId: string, id: string, expiresAt: string): Promise<AgentAssignment> => {
    const response = await apiClient.patch<AgentAssignment>(`/organizations/${orgId}/agent-assignments/${id}/extend`, { expiresAt });
    return response;
  },

  // Get assignment statistics
  getStatistics: async (orgId: string): Promise<{
    total: number;
    active: number;
    expired: number;
    byType: Record<string, number>;
    byStatus: Record<string, number>;
  }> => {
    const response = await apiClient.get<{
    total: number;
    active: number;
    expired: number;
    byType: Record<string, number>;
    byStatus: Record<string, number>;
  }>(`/organizations/${orgId}/agent-assignments/statistics`);
    return response;
  },
};
