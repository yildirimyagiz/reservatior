import { apiClient } from "./client";

export interface AgentTeam {
  id: string;
  orgId: string;
  name: string;
  description?: string;
  teamLeadId: string;
  status: "ACTIVE" | "INACTIVE" | "SUSPENDED";
  createdAt: string;
  updatedAt: string;
  teamLead?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
  members?: {
    id: string;
    agentId: string;
    role: "LEAD" | "SENIOR_AGENT" | "JUNIOR_AGENT" | "SUPPORT";
    joinedAt: string;
    agent?: {
      id: string;
      firstName: string;
      lastName: string;
      email: string;
    };
  }[];
  statistics?: {
    totalMembers: number;
    totalDeals: number;
    totalCommission: number;
    averageRating: number;
  };
}

export const agentTeamsApi = {
  // Get all agent teams
  getAll: async (orgId: string): Promise<AgentTeam[]> => {
    const response = await apiClient.get<AgentTeam[]>(`/organizations/${orgId}/agent-teams`);
    return response;
  },

  // Get agent team by ID
  getById: async (orgId: string, id: string): Promise<AgentTeam> => {
    const response = await apiClient.get<AgentTeam>(`/organizations/${orgId}/agent-teams/${id}`);
    return response;
  },

  // Create new agent team
  create: async (orgId: string, data: Omit<AgentTeam, 'id' | 'createdAt' | 'updatedAt' | 'teamLead' | 'members' | 'statistics'>): Promise<AgentTeam> => {
    const response = await apiClient.post<AgentTeam>(`/organizations/${orgId}/agent-teams`, data);
    return response;
  },

  // Update agent team
  update: async (orgId: string, id: string, data: Partial<AgentTeam>): Promise<AgentTeam> => {
    const response = await apiClient.put<AgentTeam>(`/organizations/${orgId}/agent-teams/${id}`, data);
    return response;
  },

  // Delete agent team
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/agent-teams/${id}`);
  },

  // Add member to team
  addMember: async (orgId: string, teamId: string, agentId: string, role: "LEAD" | "SENIOR_AGENT" | "JUNIOR_AGENT" | "SUPPORT"): Promise<void> => {
    await apiClient.post(`/organizations/${orgId}/agent-teams/${teamId}/members`, { agentId, role });
  },

  // Remove member from team
  removeMember: async (orgId: string, teamId: string, agentId: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/agent-teams/${teamId}/members/${agentId}`);
  },

  // Update member role
  updateMemberRole: async (orgId: string, teamId: string, agentId: string, role: "LEAD" | "SENIOR_AGENT" | "JUNIOR_AGENT" | "SUPPORT"): Promise<void> => {
    await apiClient.patch(`/organizations/${orgId}/agent-teams/${teamId}/members/${agentId}`, { role });
  },

  // Get team members
  getMembers: async (orgId: string, teamId: string): Promise<AgentTeam['members']> => {
    const response = await apiClient.get<AgentTeam['members']>(`/organizations/${orgId}/agent-teams/${teamId}/members`);
    return response;
  },

  // Get team statistics
  getStatistics: async (orgId: string, teamId: string): Promise<AgentTeam['statistics']> => {
    const response = await apiClient.get<AgentTeam['statistics']>(`/organizations/${orgId}/agent-teams/${teamId}/statistics`);
    return response;
  },

  // Transfer team leadership
  transferLeadership: async (orgId: string, teamId: string, newTeamLeadId: string): Promise<AgentTeam> => {
    const response = await apiClient.patch<AgentTeam>(`/organizations/${orgId}/agent-teams/${teamId}/leadership`, { newTeamLeadId });
    return response;
  },

  // Get teams by agent
  getByAgent: async (orgId: string, agentId: string): Promise<AgentTeam[]> => {
    const response = await apiClient.get<AgentTeam[]>(`/organizations/${orgId}/agents/${agentId}/teams`);
    return response;
  },

  // Get team performance
  getPerformance: async (orgId: string, teamId: string, period: string): Promise<{
    totalDeals: number;
    totalRevenue: number;
    averageDealValue: number;
    conversionRate: number;
    memberPerformance: Array<{
      agentId: string;
      agentName: string;
      deals: number;
      revenue: number;
      rating: number;
    }>;
  }> => {
    const response = await apiClient.get<{
    totalDeals: number;
    totalRevenue: number;
    averageDealValue: number;
    conversionRate: number;
    memberPerformance: Array<{
      agentId: string;
      agentName: string;
      deals: number;
      revenue: number;
      rating: number;
    }>;
  }>(`/organizations/${orgId}/agent-teams/${teamId}/performance`, {
      params: { period }
    });
    return response;
  },

  // Update team status
  updateStatus: async (orgId: string, teamId: string, status: AgentTeam['status']): Promise<AgentTeam> => {
    const response = await apiClient.patch<AgentTeam>(`/organizations/${orgId}/agent-teams/${teamId}/status`, { status });
    return response;
  },

  // Generate team report
  generateReport: async (orgId: string, teamId: string, options: {
    period: string;
    format: "PDF" | "EXCEL" | "CSV";
    includeMembers: boolean;
    includePerformance: boolean;
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/agent-teams/${teamId}/report`, options, {
      responseType: 'blob'
    });
    return response;
  },
};
