import { apiClient } from "./client";

export interface AgentPerformance {
  id: string;
  orgId: string;
  agentId: string;
  period: string;
  periodType: "DAILY" | "WEEKLY" | "MONTHLY" | "QUARTERLY" | "YEARLY";
  leadsGenerated: number;
  showingsCompleted: number;
  offersSubmitted: number;
  dealsClosed: number;
  commissionEarned: number;
  successRate: number;
  averageDealValue: number;
  rating: number;
  reviewsCount: number;
  responseTime: number;
  clientSatisfactionScore: number;
  createdAt: string;
  updatedAt: string;
  agent?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
    phone?: string;
  };
}

export const agentPerformanceApi = {
  // Get all agent performance records
  getAll: async (orgId: string): Promise<AgentPerformance[]> => {
    const response = await apiClient.get<AgentPerformance[]>(`/organizations/${orgId}/agent-performance`);
    return response;
  },

  // Get agent performance by ID
  getById: async (orgId: string, id: string): Promise<AgentPerformance> => {
    const response = await apiClient.get<AgentPerformance>(`/organizations/${orgId}/agent-performance/${id}`);
    return response;
  },

  // Create new agent performance record
  create: async (orgId: string, data: Omit<AgentPerformance, 'id' | 'createdAt' | 'updatedAt' | 'agent'>): Promise<AgentPerformance> => {
    const response = await apiClient.post<AgentPerformance>(`/organizations/${orgId}/agent-performance`, data);
    return response;
  },

  // Update agent performance
  update: async (orgId: string, id: string, data: Partial<AgentPerformance>): Promise<AgentPerformance> => {
    const response = await apiClient.put<AgentPerformance>(`/organizations/${orgId}/agent-performance/${id}`, data);
    return response;
  },

  // Delete agent performance
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/agent-performance/${id}`);
  },

  // Get performance by agent
  getByAgent: async (orgId: string, agentId: string): Promise<AgentPerformance[]> => {
    const response = await apiClient.get<AgentPerformance[]>(`/organizations/${orgId}/agents/${agentId}/performance`);
    return response;
  },

  // Get performance by period
  getByPeriod: async (orgId: string, period: string, periodType: AgentPerformance['periodType']): Promise<AgentPerformance[]> => {
    const response = await apiClient.get<AgentPerformance[]>(`/organizations/${orgId}/agent-performance`, {
      params: { period, periodType }
    });
    return response;
  },

  // Get top performers
  getTopPerformers: async (orgId: string, limit: number = 10): Promise<AgentPerformance[]> => {
    const response = await apiClient.get<AgentPerformance[]>(`/organizations/${orgId}/agent-performance/top`, {
      params: { limit }
    });
    return response;
  },

  // Get performance statistics
  getStatistics: async (orgId: string): Promise<{
    totalAgents: number;
    averageRating: number;
    totalDeals: number;
    totalCommission: number;
    topPerformer: AgentPerformance;
    performanceByPeriod: Record<string, AgentPerformance[]>;
  }> => {
    const response = await apiClient.get<{
    totalAgents: number;
    averageRating: number;
    totalDeals: number;
    totalCommission: number;
    topPerformer: AgentPerformance;
    performanceByPeriod: Record<string, AgentPerformance[]>;
  }>(`/organizations/${orgId}/agent-performance/statistics`);
    return response;
  },

  // Generate performance report
  generateReport: async (orgId: string, options: {
    agentIds?: string[];
    periodType: AgentPerformance['periodType'];
    startDate: string;
    endDate: string;
    format: "PDF" | "EXCEL" | "CSV";
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/agent-performance/report`, options, {
      responseType: 'blob'
    });
    return response;
  },

  // Update performance metrics
  updateMetrics: async (orgId: string, id: string, metrics: {
    leadsGenerated?: number;
    showingsCompleted?: number;
    offersSubmitted?: number;
    dealsClosed?: number;
    commissionEarned?: number;
  }): Promise<AgentPerformance> => {
    const response = await apiClient.patch<AgentPerformance>(`/organizations/${orgId}/agent-performance/${id}/metrics`, metrics);
    return response;
  },

  // Calculate performance score
  calculateScore: async (orgId: string, agentId: string): Promise<{
    overallScore: number;
    productivityScore: number;
    qualityScore: number;
    clientSatisfactionScore: number;
    financialScore: number;
  }> => {
    const response = await apiClient.get<{
    overallScore: number;
    productivityScore: number;
    qualityScore: number;
    clientSatisfactionScore: number;
    financialScore: number;
  }>(`/organizations/${orgId}/agents/${agentId}/performance-score`);
    return response;
  },
};
