import { apiClient } from "./client";

export interface ApiRoutes {
  id: string;
  orgId: string;
  name: string;
  description?: string;
  path: string;
  method: "GET" | "POST" | "PUT" | "DELETE" | "PATCH" | "OPTIONS" | "HEAD";
  controller?: string;
  action?: string;
  middleware?: Array<{
    type: "AUTHENTICATION" | "AUTHORIZATION" | "RATE_LIMITING" | "CORS" | "VALIDATION" | "LOGGING" | "CACHE" | "CUSTOM";
    name: string;
    config?: Record<string, any>;
    order: number;
  }>;
  parameters?: Array<{
    name: string;
    type: string;
    required: boolean;
    description?: string;
    defaultValue?: any;
    validation?: {
      rules: Array<{
        type: string;
        field: string;
        condition?: string;
        message?: string;
      }>;
      customValidator?: string;
    };
  }>;
  responses?: Array<{
    statusCode: number;
    description?: string;
    schema?: Record<string, any>;
    example?: any;
  }>;
  tags?: Array<string>;
  isPublic: boolean;
  isActive: boolean;
  version: string;
  deprecationWarning?: string;
  rateLimit?: {
    requests: number;
    period: "SECOND" | "MINUTE" | "HOUR" | "DAY";
    window?: number;
  };
  documentation?: {
    summary?: string;
    description?: string;
    externalUrl?: string;
    examples?: Array<{
      request: any;
      response: any;
      description?: string;
    }>;
  };
  testing?: {
    enabled: boolean;
    mockData?: Record<string, any>;
    testCases?: Array<{
      name: string;
      description?: string;
      request: any;
      expectedResponse: any;
    }>;
  };
  monitoring?: {
    enabled: boolean;
    metrics?: Array<{
      name: string;
      type: "COUNTER" | "GAUGE" | "HISTOGRAM" | "TIMER";
      description?: string;
    }>;
    alerts?: Array<{
      type: "ERROR_RATE" | "RESPONSE_TIME" | "THROUGHPUT" | "AVAILABILITY";
      threshold: number;
      condition: "GREATER_THAN" | "LESS_THAN" | "EQUAL_TO";
      notificationChannels: Array<string>;
    }>;
  };
  createdAt: string;
  updatedAt: string;
  createdBy?: string;
}

export const apiRoutesApi = {
  // Get all API routes
  getAll: async (orgId: string): Promise<ApiRoutes[]> => {
    const response = await apiClient.get<ApiRoutes[]>(`/organizations/${orgId}/api-routes`);
    return response;
  },

  // Get API route by ID
  getById: async (orgId: string, id: string): Promise<ApiRoutes> => {
    const response = await apiClient.get<ApiRoutes>(`/organizations/${orgId}/api-routes/${id}`);
    return response;
  },

  // Create new API route
  create: async (orgId: string, data: Omit<ApiRoutes, 'id' | 'createdAt' | 'updatedAt' | 'createdBy'>): Promise<ApiRoutes> => {
    const response = await apiClient.post<ApiRoutes>(`/organizations/${orgId}/api-routes`, data);
    return response;
  },

  // Update API route
  update: async (orgId: string, id: string, data: Partial<ApiRoutes>): Promise<ApiRoutes> => {
    const response = await apiClient.put<ApiRoutes>(`/organizations/${orgId}/api-routes/${id}`, data);
    return response;
  },

  // Delete API route
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/api-routes/${id}`);
  },

  // Get routes by controller
  getByController: async (orgId: string, controller: string): Promise<ApiRoutes[]> => {
    const response = await apiClient.get<ApiRoutes[]>(`/organizations/${orgId}/api-routes`, {
      params: { controller }
    });
    return response;
  },

  // Get routes by method
  getByMethod: async (orgId: string, method: ApiRoutes['method']): Promise<ApiRoutes[]> => {
    const response = await apiClient.get<ApiRoutes[]>(`/organizations/${orgId}/api-routes`, {
      params: { method }
    });
    return response;
  },

  // Get public routes
  getPublic: async (orgId: string): Promise<ApiRoutes[]> => {
    const response = await apiClient.get<ApiRoutes[]>(`/organizations/${orgId}/api-routes/public`);
    return response;
  },

  // Get private routes
  getPrivate: async (orgId: string): Promise<ApiRoutes[]> => {
    const response = await apiClient.get<ApiRoutes[]>(`/organizations/${orgId}/api-routes/private`);
    return response;
  },

  // Update route status
  updateStatus: async (orgId: string, id: string, isActive: boolean): Promise<ApiRoutes> => {
    const response = await apiClient.patch<ApiRoutes>(`/organizations/${orgId}/api-routes/${id}/status`, { isActive });
    return response;
  },

  // Test API route
  test: async (orgId: string, id: string, testData?: any): Promise<{
    success: boolean;
    responseTime: number;
    statusCode?: number;
    response?: any;
    error?: string;
    executionTime: number;
  }> => {
    const response = await apiClient.post<{
    success: boolean;
    responseTime: number;
    statusCode?: number;
    response?: any;
    error?: string;
    executionTime: number;
  }>(`/organizations/${orgId}/api-routes/${id}/test`, { testData });
    return response;
  },

  // Get route analytics
  getAnalytics: async (orgId: string, id: string, filters?: {
    startDate?: string;
    endDate?: string;
    interval?: "HOUR" | "DAY" | "WEEK" | "MONTH";
  }): Promise<{
    totalRequests: number;
    requestsByInterval: Array<{
      interval: string;
      count: number;
      averageResponseTime: number;
      errorRate: number;
    }>;
    requestsByStatus: Record<string, number>;
    requestsByEndpoint: Record<string, number>;
    averageResponseTime: number;
    errorRate: number;
    topEndpoints: Array<{
      path: string;
      method: string;
      count: number;
      averageResponseTime: number;
    }>;
  }> => {
    const response = await apiClient.get<{
    totalRequests: number;
    requestsByInterval: Array<{
      interval: string;
      count: number;
      averageResponseTime: number;
      errorRate: number;
    }>;
    requestsByStatus: Record<string, number>;
    requestsByEndpoint: Record<string, number>;
    averageResponseTime: number;
    errorRate: number;
    topEndpoints: Array<{
      path: string;
      method: string;
      count: number;
      averageResponseTime: number;
    }>;
  }>(`/organizations/${orgId}/api-routes/${id}/analytics`, {
      params: { ...filters }
    });
    return response;
  },

  // Export route documentation
  exportDocumentation: async (orgId: string, id: string, options: {
    format: "OPENAPI" | "SWAGGER" | "POSTMAN" | "INSOMNIA";
    includeExamples?: boolean;
    includeSchema?: boolean;
    includeTests?: boolean;
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/api-routes/${id}/export-docs`, options, {
      responseType: 'blob'
    });
    return response;
  },

  // Generate route from template
  generateFromTemplate: async (orgId: string, data: {
    templateId: string;
    name: string;
    path: string;
    method: ApiRoutes['method'];
    parameters?: Array<{
      name: string;
      type: string;
      required: boolean;
      description?: string;
      defaultValue?: any;
    }>;
    controller?: string;
    action?: string;
  }): Promise<ApiRoutes> => {
    const response = await apiClient.post<ApiRoutes>(`/organizations/${orgId}/api-routes/generate`, data);
    return response;
  },

  // Get route templates
  getTemplates: async (): Promise<Array<{
    id: string;
    name: string;
    description: string;
    method: ApiRoutes['method'];
    path: string;
    parameters: Array<{
      name: string;
      type: string;
      required: boolean;
      description?: string;
      defaultValue?: any;
    }>;
    controller?: string;
    action?: string;
    isPublic: boolean;
    usageCount: number;
  }>> => {
    const response = await apiClient.get<Array<{
    id: string;
    name: string;
    description: string;
    method: ApiRoutes['method'];
    path: string;
    parameters: Array<{
      name: string;
      type: string;
      required: boolean;
      description?: string;
      defaultValue?: any;
    }>;
    controller?: string;
    action?: string;
    isPublic: boolean;
    usageCount: number;
  }>>(`/organizations/current/api-routes/templates`);
    return response;
  },

  // Batch update routes
  batchUpdate: async (orgId: string, updates: Array<{
    id: string;
    data: Partial<ApiRoutes>;
  }>): Promise<ApiRoutes[]> => {
    const response = await apiClient.patch<ApiRoutes[]>(`/organizations/${orgId}/api-routes/batch`, { updates });
    return response;
  },

  // Get route dependencies
  getDependencies: async (orgId: string, id: string): Promise<Array<{
    routeId: string;
    dependencyType: "INTERNAL_ROUTE" | "EXTERNAL_SERVICE" | "SHARED_COMPONENT" | "DATABASE_TABLE" | "MIDDLEWARE";
    dependencyId: string;
    dependencyName: string;
    version?: string;
    isRequired: boolean;
    description?: string;
  }>> => {
    const response = await apiClient.get<Array<{
    routeId: string;
    dependencyType: "INTERNAL_ROUTE" | "EXTERNAL_SERVICE" | "SHARED_COMPONENT" | "DATABASE_TABLE" | "MIDDLEWARE";
    dependencyId: string;
    dependencyName: string;
    version?: string;
    isRequired: boolean;
    description?: string;
  }>>(`/organizations/${orgId}/api-routes/${id}/dependencies`);
    return response;
  },
};
