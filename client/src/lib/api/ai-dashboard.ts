import { apiClient } from "./client";

export interface AIDashboard {
  id: string;
  orgId: string;
  userId?: string;
  agentId?: string;
  dashboardType: "ANALYTICS" | "PERFORMANCE" | "LEAD_GENERATION" | "PROPERTY_VALUATION" | "MARKET_INSIGHTS" | "CUSTOM";
  title: string;
  description?: string;
  config: {
    layout: "GRID" | "LIST" | "CARDS" | "CHARTS";
    widgets: Array<{
      id: string;
      type: string;
      title: string;
      size: "SMALL" | "MEDIUM" | "LARGE";
      position: {
        x: number;
        y: number;
        w: number;
        h: number;
      };
      config: Record<string, any>;
      dataSource: string;
      refreshInterval?: number;
    }>;
    filters?: Array<{
      id: string;
      name: string;
      type: string;
      field: string;
      operator: string;
      value: any;
      options?: any[];
    }>;
    dateRange?: {
      preset?: "TODAY" | "WEEK" | "MONTH" | "QUARTER" | "YEAR" | "CUSTOM";
      startDate?: string;
      endDate?: string;
    };
  };
  isDefault: boolean;
  isActive: boolean;
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
}

export const aiDashboardApi = {
  // Get all AI dashboards
  getAll: async (orgId: string): Promise<AIDashboard[]> => {
    const response = await apiClient.get<AIDashboard[]>(`/organizations/${orgId}/ai-dashboards`);
    return response;
  },

  // Get AI dashboard by ID
  getById: async (orgId: string, id: string): Promise<AIDashboard> => {
    const response = await apiClient.get<AIDashboard>(`/organizations/${orgId}/ai-dashboards/${id}`);
    return response;
  },

  // Create new AI dashboard
  create: async (orgId: string, data: Omit<AIDashboard, 'id' | 'createdAt' | 'updatedAt' | 'user' | 'agent'>): Promise<AIDashboard> => {
    const response = await apiClient.post<AIDashboard>(`/organizations/${orgId}/ai-dashboards`, data);
    return response;
  },

  // Update AI dashboard
  update: async (orgId: string, id: string, data: Partial<AIDashboard>): Promise<AIDashboard> => {
    const response = await apiClient.put<AIDashboard>(`/organizations/${orgId}/ai-dashboards/${id}`, data);
    return response;
  },

  // Delete AI dashboard
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/ai-dashboards/${id}`);
  },

  // Get dashboards by user
  getByUser: async (orgId: string, userId: string): Promise<AIDashboard[]> => {
    const response = await apiClient.get<AIDashboard[]>(`/organizations/${orgId}/users/${userId}/ai-dashboards`);
    return response;
  },

  // Get dashboards by agent
  getByAgent: async (orgId: string, agentId: string): Promise<AIDashboard[]> => {
    const response = await apiClient.get<AIDashboard[]>(`/organizations/${orgId}/agents/${agentId}/ai-dashboards`);
    return response;
  },

  // Update dashboard status
  updateStatus: async (orgId: string, id: string, isActive: boolean): Promise<AIDashboard> => {
    const response = await apiClient.patch<AIDashboard>(`/organizations/${orgId}/ai-dashboards/${id}/status`, { isActive });
    return response;
  },

  // Set as default dashboard
  setAsDefault: async (orgId: string, id: string): Promise<AIDashboard> => {
    const response = await apiClient.patch<AIDashboard>(`/organizations/${orgId}/ai-dashboards/${id}/default`);
    return response;
  },

  // Duplicate dashboard
  duplicate: async (orgId: string, id: string, newName: string): Promise<AIDashboard> => {
    const response = await apiClient.post<AIDashboard>(`/organizations/${orgId}/ai-dashboards/${id}/duplicate`, { newName });
    return response;
  },

  // Get dashboard data
  getDashboardData: async (orgId: string, dashboardId: string, filters?: {
    dateRange?: {
      startDate?: string;
      endDate?: string;
    };
    filters?: Record<string, any>;
  }): Promise<{
    widgets: Array<{
      id: string;
      data: any;
      lastUpdated: string;
    }>;
    metadata: {
      generatedAt: string;
      dataSource: string;
      processingTime: number;
    };
  }> => {
    const response = await apiClient.get<{
    widgets: Array<{
      id: string;
      data: any;
      lastUpdated: string;
    }>;
    metadata: {
      generatedAt: string;
      dataSource: string;
      processingTime: number;
    };
  }>(`/organizations/${orgId}/ai-dashboards/${dashboardId}/data`, {
      params: { ...filters }
    });
    return response;
  },

  // Update dashboard layout
  updateLayout: async (orgId: string, id: string, layout: AIDashboard['config']['layout']): Promise<AIDashboard> => {
    const response = await apiClient.patch<AIDashboard>(`/organizations/${orgId}/ai-dashboards/${id}/layout`, { layout });
    return response;
  },

  // Add widget to dashboard
  addWidget: async (orgId: string, id: string, widget: AIDashboard['config']['widgets'][0]): Promise<AIDashboard> => {
    const response = await apiClient.post<AIDashboard>(`/organizations/${orgId}/ai-dashboards/${id}/widgets`, widget);
    return response;
  },

  // Update widget
  updateWidget: async (orgId: string, id: string, widgetId: string, data: Partial<AIDashboard['config']['widgets'][0]>): Promise<AIDashboard> => {
    const response = await apiClient.put<AIDashboard>(`/organizations/${orgId}/ai-dashboards/${id}/widgets/${widgetId}`, data);
    return response;
  },

  // Remove widget from dashboard
  removeWidget: async (orgId: string, id: string, widgetId: string): Promise<AIDashboard> => {
    const response = await apiClient.delete<AIDashboard>(`/organizations/${orgId}/ai-dashboards/${id}/widgets/${widgetId}`);
    return response;
  },

  // Get dashboard templates
  getTemplates: async (orgId: string): Promise<Array<{
    id: string;
    name: string;
    description: string;
    dashboardType: AIDashboard['dashboardType'];
    config: AIDashboard['config'];
    isPublic: boolean;
    usageCount: number;
  }>> => {
    const response = await apiClient.get<Array<{
    id: string;
    name: string;
    description: string;
    dashboardType: AIDashboard['dashboardType'];
    config: AIDashboard['config'];
    isPublic: boolean;
    usageCount: number;
  }>>(`/organizations/${orgId}/ai-dashboards/templates`);
    return response;
  },

  // Create dashboard from template
  createFromTemplate: async (orgId: string, templateId: string, data: {
    name: string;
    description?: string;
    userId?: string;
    agentId?: string;
  }): Promise<AIDashboard> => {
    const response = await apiClient.post<AIDashboard>(`/organizations/${orgId}/ai-dashboards/from-template`, { templateId, ...data });
    return response;
  },

  // Share dashboard
  share: async (orgId: string, id: string, data: {
    shareWith: "USERS" | "AGENTS" | "TEAMS" | "PUBLIC";
    userIds?: string[];
    agentIds?: string[];
    teamIds?: string[];
    permissions?: Array<{
      type: "VIEW" | "EDIT" | "SHARE";
      userId?: string;
      agentId?: string;
    }>;
    expiresAt?: string;
  }): Promise<{
    shareUrl: string;
    shareToken: string;
    expiresAt: string;
  }> => {
    const response = await apiClient.post<{
    shareUrl: string;
    shareToken: string;
    expiresAt: string;
  }>(`/organizations/${orgId}/ai-dashboards/${id}/share`, data);
    return response;
  },

  // Get shared dashboards
  getShared: async (orgId: string): Promise<Array<{
    id: string;
    title: string;
    sharedBy: {
      id: string;
      name: string;
    };
    sharedAt: string;
    permissions: string[];
    expiresAt?: string;
  }>> => {
    const response = await apiClient.get<Array<{
    id: string;
    title: string;
    sharedBy: {
      id: string;
      name: string;
    };
    sharedAt: string;
    permissions: string[];
    expiresAt?: string;
  }>>(`/organizations/${orgId}/ai-dashboards/shared`);
    return response;
  },
};
