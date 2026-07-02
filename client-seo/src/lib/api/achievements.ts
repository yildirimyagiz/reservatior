import { apiClient } from "./client";

export interface Achievement {
  id: string;
  orgId: string;
  userId?: string;
  agentId?: string;
  teamId?: string;
  title: string;
  description: string;
  type: "SALES" | "LISTINGS" | "CLIENT_SATISFACTION" | "RESPONSE_TIME" | "CONVERSION_RATE" | "REVENUE" | "PROPERTIES_SOLD" | "DEALS_CLOSED" | "CUSTOM";
  category: string;
  value: number;
  unit: string;
  targetValue?: number;
  achievedAt?: string;
  expiresAt?: string;
  status: "PENDING" | "ACHIEVED" | "EXPIRED" | "CANCELLED";
  badge?: {
    id: string;
    name: string;
    icon: string;
    color: string;
  };
  rewards?: Array<{
    id: string;
    name: string;
    description: string;
    value: number;
    type: "BONUS" | "COMMISSION" | "POINTS" | "RECOGNITION";
  }>;
  createdAt: string;
  updatedAt: string;
  user?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
  agent?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
  team?: {
    id: string;
    name: string;
  };
}

export const achievementsApi = {
  // Get all achievements
  getAll: async (orgId: string): Promise<Achievement[]> => {
    const response = await apiClient.get<Achievement[]>(`/organizations/${orgId}/achievements`);
    return response;
  },

  // Get achievement by ID
  getById: async (orgId: string, id: string): Promise<Achievement> => {
    const response = await apiClient.get<Achievement>(`/organizations/${orgId}/achievements/${id}`);
    return response;
  },

  // Create new achievement
  create: async (orgId: string, data: Omit<Achievement, 'id' | 'createdAt' | 'updatedAt' | 'user' | 'agent' | 'team'>): Promise<Achievement> => {
    const response = await apiClient.post<Achievement>(`/organizations/${orgId}/achievements`, data);
    return response;
  },

  // Update achievement
  update: async (orgId: string, id: string, data: Partial<Achievement>): Promise<Achievement> => {
    const response = await apiClient.put<Achievement>(`/organizations/${orgId}/achievements/${id}`, data);
    return response;
  },

  // Delete achievement
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/achievements/${id}`);
  },

  // Get achievements by user
  getByUser: async (orgId: string, userId: string): Promise<Achievement[]> => {
    const response = await apiClient.get<Achievement[]>(`/organizations/${orgId}/users/${userId}/achievements`);
    return response;
  },

  // Get achievements by agent
  getByAgent: async (orgId: string, agentId: string): Promise<Achievement[]> => {
    const response = await apiClient.get<Achievement[]>(`/organizations/${orgId}/agents/${agentId}/achievements`);
    return response;
  },

  // Get achievements by team
  getByTeam: async (orgId: string, teamId: string): Promise<Achievement[]> => {
    const response = await apiClient.get<Achievement[]>(`/organizations/${orgId}/teams/${teamId}/achievements`);
    return response;
  },

  // Update achievement status
  updateStatus: async (orgId: string, id: string, status: Achievement['status']): Promise<Achievement> => {
    const response = await apiClient.patch<Achievement>(`/organizations/${orgId}/achievements/${id}/status`, { status });
    return response;
  },

  // Award achievement
  award: async (orgId: string, id: string, data: {
    userId?: string;
    agentId?: string;
    teamId?: string;
    awardedAt: string;
    notes?: string;
  }): Promise<Achievement> => {
    const response = await apiClient.post<Achievement>(`/organizations/${orgId}/achievements/${id}/award`, data);
    return response;
  },

  // Get achievement statistics
  getStatistics: async (orgId: string): Promise<{
    total: number;
    pending: number;
    achieved: number;
    expired: number;
    cancelled: number;
    byType: Record<string, number>;
    byCategory: Record<string, number>;
    topPerformers: Array<{
      userId?: string;
      agentId?: string;
      name: string;
      achievementCount: number;
      totalValue: number;
    }>;
  }> => {
    const response = await apiClient.get<{
      total: number;
      pending: number;
      achieved: number;
      expired: number;
      cancelled: number;
      byType: Record<string, number>;
      byCategory: Record<string, number>;
      topPerformers: Array<{
        userId?: string;
        agentId?: string;
        name: string;
        achievementCount: number;
        totalValue: number;
      }>;
    }>(`/organizations/${orgId}/achievements/statistics`);
    return response;
  },

  // Get achievement templates
  getTemplates: async (orgId: string): Promise<Array<{
    id: string;
    name: string;
    description: string;
    type: Achievement['type'];
    category: string;
    defaultValue: number;
    unit: string;
    badge?: {
      name: string;
      icon: string;
      color: string;
    };
  }>> => {
    const response = await apiClient.get<Array<{
      id: string;
      name: string;
      description: string;
      type: Achievement['type'];
      category: string;
      defaultValue: number;
      unit: string;
      badge?: {
        name: string;
        icon: string;
        color: string;
      };
    }>>(`/organizations/${orgId}/achievements/templates`);
    return response;
  },

  // Bulk award achievements
  bulkAward: async (orgId: string, data: Array<{
    achievementId: string;
    userId?: string;
    agentId?: string;
    teamId?: string;
    awardedAt: string;
    notes?: string;
  }>): Promise<Achievement[]> => {
    const response = await apiClient.post<Achievement[]>(`/organizations/${orgId}/achievements/bulk-award`, data);
    return response;
  },

  // Generate achievement report
  generateReport: async (orgId: string, options: {
    type?: Achievement['type'];
    category?: string;
    userId?: string;
    agentId?: string;
    teamId?: string;
    status?: Achievement['status'];
    startDate?: string;
    endDate?: string;
    format: "PDF" | "EXCEL" | "CSV";
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/achievements/report`, options, {
      responseType: 'blob'
    });
    return response;
  },
};
