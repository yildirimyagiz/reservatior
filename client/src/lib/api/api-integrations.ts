import { apiClient } from "./client";

export interface ApiIntegrations {
  id: string;
  orgId: string;
  name: string;
  description?: string;
  type: "REST_API" | "WEBHOOK" | "SOAP_API" | "GRAPHQL" | "DATABASE" | "FILE_IMPORT" | "CUSTOM";
  status: "ACTIVE" | "INACTIVE" | "ERROR" | "DEPRECATED";
  config: {
    baseUrl: string;
    version?: string;
    authentication: {
      type: "API_KEY" | "OAUTH2" | "BASIC_AUTH" | "BEARER_TOKEN" | "CUSTOM";
      credentials?: Record<string, any>;
    };
    headers?: Record<string, string>;
    rateLimit?: {
      requests: number;
      period: "SECOND" | "MINUTE" | "HOUR" | "DAY";
      burst?: number;
    };
    timeout?: number;
    retryPolicy?: {
      maxAttempts: number;
      backoffMultiplier: number;
      maxDelay: number;
    };
  };
  endpoints?: Array<{
    id: string;
    name: string;
    method: "GET" | "POST" | "PUT" | "DELETE" | "PATCH";
    path: string;
    description?: string;
    parameters?: Array<{
      name: string;
      type: string;
      required: boolean;
      description?: string;
    }>;
    responseSchema?: Record<string, any>;
  }>;
  webhooks?: Array<{
    id: string;
    event: string;
    url: string;
    secret?: string;
    isActive: boolean;
    retryPolicy?: {
      maxAttempts: number;
      delay: number;
    };
  }>;
  statistics: {
    totalRequests: number;
    successfulRequests: number;
    failedRequests: number;
    averageResponseTime: number;
    lastRequestAt?: string;
    errorRate: number;
    requestsByEndpoint: Record<string, number>;
    requestsByStatus: Record<string, number>;
  };
  createdAt: string;
  updatedAt: string;
  lastSyncAt?: string;
  createdBy?: string;
}

export const apiIntegrationsApi = {
  // Get all API integrations
  getAll: async (orgId: string): Promise<ApiIntegrations[]> => {
    const response = await apiClient.get<ApiIntegrations[]>(`/organizations/${orgId}/api-integrations`);
    return response;
  },

  // Get API integration by ID
  getById: async (orgId: string, id: string): Promise<ApiIntegrations> => {
    const response = await apiClient.get<ApiIntegrations>(`/organizations/${orgId}/api-integrations/${id}`);
    return response;
  },

  // Create new API integration
  create: async (orgId: string, data: Omit<ApiIntegrations, 'id' | 'createdAt' | 'updatedAt' | 'statistics' | 'lastSyncAt' | 'createdBy'>): Promise<ApiIntegrations> => {
    const response = await apiClient.post<ApiIntegrations>(`/organizations/${orgId}/api-integrations`, data);
    return response;
  },

  // Update API integration
  update: async (orgId: string, id: string, data: Partial<ApiIntegrations>): Promise<ApiIntegrations> => {
    const response = await apiClient.put<ApiIntegrations>(`/organizations/${orgId}/api-integrations/${id}`, data);
    return response;
  },

  // Delete API integration
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/api-integrations/${id}`);
  },

  // Test API integration
  test: async (orgId: string, id: string): Promise<{
    success: boolean;
    responseTime: number;
    statusCode?: number;
    error?: string;
    testData?: any;
  }> => {
    const response = await apiClient.post<{
    success: boolean;
    responseTime: number;
    statusCode?: number;
    error?: string;
    testData?: any;
  }>(`/organizations/${orgId}/api-integrations/${id}/test`);
    return response;
  },

  // Sync API integration
  sync: async (orgId: string, id: string): Promise<ApiIntegrations> => {
    const response = await apiClient.post<ApiIntegrations>(`/organizations/${orgId}/api-integrations/${id}/sync`);
    return response;
  },

  // Get integration logs
  getLogs: async (orgId: string, id: string, filters?: {
    startDate?: string;
    endDate?: string;
    level?: "INFO" | "WARN" | "ERROR" | "DEBUG";
    limit?: number;
  }): Promise<Array<{
    id: string;
    timestamp: string;
    level: string;
    message: string;
    details?: any;
    requestId?: string;
  }>> => {
    const response = await apiClient.get<Array<{
    id: string;
    timestamp: string;
    level: string;
    message: string;
    details?: any;
    requestId?: string;
  }>>(`/organizations/${orgId}/api-integrations/${id}/logs`, {
      params: { ...filters }
    });
    return response;
  },

  // Update integration status
  updateStatus: async (orgId: string, id: string, status: ApiIntegrations['status']): Promise<ApiIntegrations> => {
    const response = await apiClient.patch<ApiIntegrations>(`/organizations/${orgId}/api-integrations/${id}/status`, { status });
    return response;
  },

  // Get integration statistics
  getStatistics: async (orgId: string, id: string): Promise<ApiIntegrations['statistics']> => {
    const response = await apiClient.get<ApiIntegrations['statistics']>(`/organizations/${orgId}/api-integrations/${id}/statistics`);
    return response;
  },

  // Reset integration statistics
  resetStatistics: async (orgId: string, id: string): Promise<void> => {
    await apiClient.post(`/organizations/${orgId}/api-integrations/${id}/reset-statistics`);
  },

  // Get available integration types
  getAvailableTypes: async (): Promise<Array<{
    type: string;
    name: string;
    description: string;
    supportedFeatures: string[];
    pricing?: {
      setupCost: number;
      monthlyCost: number;
      requestCost?: number;
    };
  }>> => {
    const response = await apiClient.get<Array<{
    type: string;
    name: string;
    description: string;
    supportedFeatures: string[];
    pricing?: {
      setupCost: number;
      monthlyCost: number;
      requestCost?: number;
    };
  }>>(`/organizations/current/api-integrations/available-types`);
    return response;
  },

  // Get integration templates
  getTemplates: async (): Promise<Array<{
    id: string;
    name: string;
    description: string;
    type: ApiIntegrations['type'];
    config: ApiIntegrations['config'];
    isPublic: boolean;
    usageCount: number;
  }>> => {
    const response = await apiClient.get<Array<{
    id: string;
    name: string;
    description: string;
    type: ApiIntegrations['type'];
    config: ApiIntegrations['config'];
    isPublic: boolean;
    usageCount: number;
  }>>(`/organizations/current/api-integrations/templates`);
    return response;
  },

  // Create integration from template
  createFromTemplate: async (orgId: string, templateId: string, data: {
    name: string;
    description?: string;
    overrideConfig?: Partial<ApiIntegrations['config']>;
  }): Promise<ApiIntegrations> => {
    const response = await apiClient.post<ApiIntegrations>(`/organizations/${orgId}/api-integrations/from-template`, { templateId, ...data });
    return response;
  },

  // Generate API documentation
  generateDocumentation: async (orgId: string, id: string, options: {
    format: "HTML" | "PDF" | "MARKDOWN" | "OPENAPI";
    includeExamples?: boolean;
    includeAuthentication?: boolean;
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/api-integrations/${id}/documentation`, options, {
      responseType: 'blob'
    });
    return response;
  },

  // Export integration configuration
  exportConfig: async (orgId: string, id: string, options: {
    format: "JSON" | "YAML" | "ENV";
    includeSecrets?: boolean;
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/api-integrations/${id}/export-config`, options, {
      responseType: 'blob'
    });
    return response;
  },

  // Import integration configuration
  importConfig: async (orgId: string, data: {
    config: string;
    format: "JSON" | "YAML" | "ENV";
    mergeStrategy?: "OVERWRITE" | "MERGE" | "SKIP";
  }): Promise<ApiIntegrations> => {
    const response = await apiClient.post<ApiIntegrations>(`/organizations/${orgId}/api-integrations/import-config`, data);
    return response;
  },

  // Get integration usage analytics
  getUsageAnalytics: async (orgId: string, id: string, filters?: {
    startDate?: string;
    endDate?: string;
    endpoint?: string;
  }): Promise<{
    totalRequests: number;
    requestsByDay: Array<{
      date: string;
      count: number;
      successRate: number;
    }>;
    requestsByEndpoint: Record<string, number>;
    errorsByType: Record<string, number>;
    averageResponseTime: number;
    costAnalysis: {
      totalCost: number;
      costPerRequest: number;
    };
  }> => {
    const response = await apiClient.get<{
    totalRequests: number;
    requestsByDay: Array<{
      date: string;
      count: number;
      successRate: number;
    }>;
    requestsByEndpoint: Record<string, number>;
    errorsByType: Record<string, number>;
    averageResponseTime: number;
    costAnalysis: {
      totalCost: number;
      costPerRequest: number;
    };
  }>(`/organizations/${orgId}/api-integrations/${id}/usage-analytics`, {
      params: { ...filters }
    });
    return response;
  },
};
