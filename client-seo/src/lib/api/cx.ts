import { apiClient } from "./client";

export interface Cx {
  id: string;
  orgId: string;
  name: string;
  type: "CUSTOMER_SERVICE" | "SALES" | "SUPPORT" | "SUCCESS" | "ONBOARDING" | "RETENTION" | "FEEDBACK" | "SURVEY" | "ANALYTICS" | "CUSTOM";
  category: string;
  status: "ACTIVE" | "INACTIVE" | "PAUSED" | "ARCHIVED" | "UNDER_REVIEW";
  priority: "LOW" | "MEDIUM" | "HIGH" | "URGENT";
  description?: string;
  configuration: {
    channels: Array<{
      type: "EMAIL" | "PHONE" | "CHAT" | "SMS" | "SOCIAL_MEDIA" | "WEB_FORM" | "MOBILE_APP" | "API";
      enabled: boolean;
      settings?: Record<string, any>;
      escalationRules?: Array<{
        condition: string;
        action: string;
        target: string;
        timeout?: number;
      }>;
    }>;
    workflows: Array<{
      id: string;
      name: string;
      trigger: {
        type: string;
        conditions: Array<{
          field: string;
          operator: string;
          value: any;
        }>;
      };
      actions: Array<{
        type: string;
        config: Record<string, any>;
        delay?: number;
      }>;
      isActive: boolean;
      order: number;
    }>;
    automation: {
      enabled: boolean;
      rules: Array<{
        name: string;
        conditions: Array<{
          field: string;
          operator: string;
          value: any;
        }>;
        actions: Array<{
          type: string;
          config: Record<string, any>;
        }>;
        isActive: boolean;
      }>;
    };
    templates: Array<{
      id: string;
      name: string;
      type: "EMAIL" | "SMS" | "CHAT" | "NOTIFICATION";
      content: string;
      variables?: Record<string, any>;
      isActive: boolean;
    }>;
    sla: {
      enabled: boolean;
      responseTime: number;
      resolutionTime: number;
      businessHours?: {
        timezone: string;
        days: Array<{
          day: number;
          openTime: string;
          closeTime: string;
          isActive: boolean;
        }>;
        holidays?: Array<{
          date: string;
          name: string;
          isRecurring: boolean;
        }>;
      };
    };
    routing: {
      enabled: boolean;
      rules: Array<{
        name: string;
        conditions: Array<{
          field: string;
          operator: string;
          value: any;
        }>;
        target: string;
        priority?: number;
        weight?: number;
      }>;
      fallbackTarget: string;
    };
  };
  metrics: {
    totalInteractions: number;
    averageResponseTime: number;
    averageResolutionTime: number;
    customerSatisfaction: number;
    firstContactResolution: number;
    escalationRate: number;
    abandonmentRate: number;
    agentPerformance: Array<{
      agentId: string;
      agentName: string;
      totalInteractions: number;
      averageResponseTime: number;
      averageResolutionTime: number;
      customerSatisfaction: number;
      firstContactResolution: number;
      escalations: number;
    }>;
    channelPerformance: Array<{
      channelType: string;
      totalInteractions: number;
      averageResponseTime: number;
      customerSatisfaction: number;
      resolutionRate: number;
    }>;
    trends: Array<{
      date: string;
      interactions: number;
      responseTime: number;
      resolutionTime: number;
      satisfaction: number;
    }>;
  };
  integrations: Array<{
    type: string;
    name: string;
    status: "CONNECTED" | "DISCONNECTED" | "ERROR" | "PENDING";
    settings: Record<string, any>;
    lastSync?: string;
    errorMessage?: string;
  }>;
  team: Array<{
    id: string;
    name: string;
    role: "AGENT" | "SUPERVISOR" | "MANAGER" | "ADMIN";
    isActive: boolean;
    skills?: Array<string>;
    capacity?: {
      maxConcurrent: number;
      maxDaily: number;
    };
    availability?: {
      timezone: string;
      schedule: Array<{
        day: number;
        startTime: string;
        endTime: string;
        isAvailable: boolean;
      }>;
    };
  }>;
  knowledgeBase?: {
    enabled: boolean;
    articles: Array<{
      id: string;
      title: string;
      content: string;
      category: string;
      tags: Array<string>;
      usageCount: number;
      lastUpdated: string;
    }>;
    categories: Array<{
      id: string;
      name: string;
      description?: string;
      parent?: string;
      articleCount: number;
    }>;
  };
  settings: {
    language: string;
    timezone: string;
    dateFormat: string;
    timeFormat: string;
    currency: string;
    notifications: {
      email: boolean;
      sms: boolean;
      push: boolean;
      desktop: boolean;
    };
    security: {
      twoFactorAuth: boolean;
      sessionTimeout: number;
      ipRestrictions?: Array<string>;
    };
  };
  createdAt: string;
  updatedAt: string;
  createdBy: string;
  updatedBy?: string;
}

export const cxApi = {
  // Get all CX configurations
  getAll: async (orgId: string): Promise<Cx[]> => {
    return await apiClient.get(`/organizations/${orgId}/cx`);
  },

  // Get CX configuration by ID
  getById: async (orgId: string, id: string): Promise<Cx> => {
    return await apiClient.get(`/organizations/${orgId}/cx/${id}`);
  },

  // Create new CX configuration
  create: async (orgId: string, data: Omit<Cx, 'id' | 'createdAt' | 'updatedAt' | 'metrics' | 'createdBy' | 'updatedBy'>): Promise<Cx> => {
    return await apiClient.post(`/organizations/${orgId}/cx`, data);
  },

  // Update CX configuration
  update: async (orgId: string, id: string, data: Partial<Cx>): Promise<Cx> => {
    return await apiClient.put(`/organizations/${orgId}/cx/${id}`, data);
  },

  // Delete CX configuration
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/cx/${id}`);
  },

  // Get CX configurations by type
  getByType: async (orgId: string, type: Cx['type']): Promise<Cx[]> => {
    return await apiClient.get(`/organizations/${orgId}/cx`, {
      params: { type }
    });
  },

  // Get CX configurations by status
  getByStatus: async (orgId: string, status: Cx['status']): Promise<Cx[]> => {
    return await apiClient.get(`/organizations/${orgId}/cx`, {
      params: { status }
    });
  },

  // Update CX configuration status
  updateStatus: async (orgId: string, id: string, data: {
    status: Cx['status'];
    notes?: string;
  }): Promise<Cx> => {
    return await apiClient.patch(`/organizations/${orgId}/cx/${id}/status`, data);
  },

  // Get CX metrics
  getMetrics: async (orgId: string, id: string, filters?: {
    startDate?: string;
    endDate?: string;
    channel?: string;
    agentId?: string;
    teamId?: string;
  }): Promise<Cx['metrics']> => {
    return await apiClient.get(`/organizations/${orgId}/cx/${id}/metrics`, {
      params: { ...filters }
    });
  },

  // Update CX configuration
  updateConfiguration: async (orgId: string, id: string, data: Partial<Cx['configuration']>): Promise<Cx> => {
    return await apiClient.patch(`/organizations/${orgId}/cx/${id}/configuration`, data);
  },

  // Add channel to CX configuration
  addChannel: async (orgId: string, id: string, data: {
    type: Cx['configuration']['channels'][0]['type'];
    enabled: boolean;
    settings?: Record<string, any>;
    escalationRules?: Array<{
      condition: string;
      action: string;
      target: string;
      timeout?: number;
    }>;
  }): Promise<Cx> => {
    return await apiClient.post(`/organizations/${orgId}/cx/${id}/channels`, data);
  },

  // Update channel
  updateChannel: async (orgId: string, id: string, channelId: string, data: Partial<Cx['configuration']['channels'][0]>): Promise<Cx> => {
    return await apiClient.put(`/organizations/${orgId}/cx/${id}/channels/${channelId}`, data);
  },

  // Remove channel from CX configuration
  removeChannel: async (orgId: string, id: string, channelId: string): Promise<Cx> => {
    return await apiClient.delete(`/organizations/${orgId}/cx/${id}/channels/${channelId}`);
  },

  // Add workflow to CX configuration
  addWorkflow: async (orgId: string, id: string, data: {
    name: string;
    trigger: {
      type: string;
      conditions: Array<{
        field: string;
        operator: string;
        value: any;
      }>;
    };
    actions: Array<{
      type: string;
      config: Record<string, any>;
      delay?: number;
    }>;
    isActive: boolean;
    order: number;
  }): Promise<Cx> => {
    return await apiClient.post(`/organizations/${orgId}/cx/${id}/workflows`, data);
  },

  // Update workflow
  updateWorkflow: async (orgId: string, id: string, workflowId: string, data: Partial<Cx['configuration']['workflows'][0]>): Promise<Cx> => {
    return await apiClient.put(`/organizations/${orgId}/cx/${id}/workflows/${workflowId}`, data);
  },

  // Remove workflow from CX configuration
  removeWorkflow: async (orgId: string, id: string, workflowId: string): Promise<Cx> => {
    return await apiClient.delete(`/organizations/${orgId}/cx/${id}/workflows/${workflowId}`);
  },

  // Test workflow
  testWorkflow: async (orgId: string, id: string, workflowId: string, data: {
    testData: Record<string, any>;
    simulateConditions?: boolean;
  }): Promise<{
    success: boolean;
    triggeredActions: Array<{
      type: string;
      config: Record<string, any>;
      executed: boolean;
      error?: string;
    }>;
    executionTime: number;
    errors?: Array<{
      step: string;
      error: string;
      details?: any;
    }>;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/cx/${id}/workflows/${workflowId}/test`, data);
  },

  // Add team member to CX configuration
  addTeamMember: async (orgId: string, id: string, data: {
    name: string;
    role: Cx['team'][0]['role'];
    isActive: boolean;
    skills?: Array<string>;
    capacity?: {
      maxConcurrent: number;
      maxDaily: number;
    };
    availability?: {
      timezone: string;
      schedule: Array<{
        day: number;
        startTime: string;
        endTime: string;
        isAvailable: boolean;
      }>;
    };
  }): Promise<Cx> => {
    return await apiClient.post(`/organizations/${orgId}/cx/${id}/team`, data);
  },

  // Update team member
  updateTeamMember: async (orgId: string, id: string, memberId: string, data: Partial<Cx['team'][0]>): Promise<Cx> => {
    return await apiClient.put(`/organizations/${orgId}/cx/${id}/team/${memberId}`, data);
  },

  // Remove team member from CX configuration
  removeTeamMember: async (orgId: string, id: string, memberId: string): Promise<Cx> => {
    return await apiClient.delete(`/organizations/${orgId}/cx/${id}/team/${memberId}`);
  },

  // Get CX analytics
  getAnalytics: async (orgId: string, id: string, filters?: {
    startDate?: string;
    endDate?: string;
    channel?: string;
    agentId?: string;
    teamId?: string;
    metric?: string;
  }): Promise<{
    overview: {
      totalInteractions: number;
      averageResponseTime: number;
      averageResolutionTime: number;
      customerSatisfaction: number;
      firstContactResolution: number;
      escalationRate: number;
      abandonmentRate: number;
    };
    trends: Array<{
      date: string;
      interactions: number;
      responseTime: number;
      resolutionTime: number;
      satisfaction: number;
    }>;
    channelBreakdown: Array<{
      channel: string;
      interactions: number;
      responseTime: number;
      satisfaction: number;
      resolutionRate: number;
    }>;
    agentPerformance: Array<{
      agentId: string;
      agentName: string;
      interactions: number;
      responseTime: number;
      resolutionTime: number;
      satisfaction: number;
      firstContactResolution: number;
      escalations: number;
    }>;
    workflowPerformance: Array<{
      workflowId: string;
      workflowName: string;
      executions: number;
      successRate: number;
      averageExecutionTime: number;
      errors: number;
    }>;
  }> => {
    return await apiClient.get(`/organizations/${orgId}/cx/${id}/analytics`, {
      params: { ...filters }
    });
  },

  // Export CX configuration
  export: async (orgId: string, id: string, options: {
    format: "JSON" | "CSV" | "EXCEL";
    includeMetrics?: boolean;
    includeConfiguration?: boolean;
    includeTeam?: boolean;
    startDate?: string;
    endDate?: string;
  }): Promise<Blob> => {
    return await apiClient.get(`/organizations/${orgId}/cx/${id}/export`, {
      params: options
    });
  },

  // Import CX configuration
  import: async (orgId: string, data: {
    format: "JSON" | "CSV" | "EXCEL";
    file?: File;
    url?: string;
    mergeStrategy: "REPLACE" | "MERGE" | "SKIP_CONFLICTS";
    validateOnly?: boolean;
  }): Promise<{
    imported: number;
    updated: number;
    conflicts: Array<{
      field: string;
      value: string;
      conflict: string;
    }>;
    errors: Array<{
      field: string;
      message: string;
      value: any;
    }>;
  }> => {
    const formData = new FormData();
    formData.append('format', data.format);
    if (data.file) {
      formData.append('file', data.file);
    }
    if (data.url) {
      formData.append('url', data.url);
    }
    formData.append('mergeStrategy', data.mergeStrategy);
    formData.append('validateOnly', String(data.validateOnly || false));

    const response = await fetch(`${apiClient['baseURL']}/organizations/${orgId}/cx/import`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${typeof window !== "undefined" ? localStorage.getItem("auth_token") : ""}`,
      },
      body: formData
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    return await response.json() as {
      imported: number;
      updated: number;
      conflicts: Array<{
        row: number;
        field: string;
        value: string;
        conflict: string;
      }>;
      errors: Array<{
        row: number;
        field: string;
        message: string;
        value: any;
      }>;
    };
  },
};
