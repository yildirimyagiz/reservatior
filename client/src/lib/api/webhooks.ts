import { apiClient } from "./client";

export interface Webhooks {
  id: string;
  orgId: string;
  name: string;
  description?: string;
  url: string;
  events: Array<{
    type: string;
    action: string;
    resource: string;
    description?: string;
  }>;
  status: "ACTIVE" | "INACTIVE" | "ERROR" | "PAUSED";
  configuration: {
    secret?: string;
    signatureHeader?: string;
    signatureAlgorithm?: "SHA256" | "SHA1" | "MD5";
    timeout?: number;
    retryPolicy: {
      enabled: boolean;
      maxRetries: number;
      retryDelay: number;
      backoffMultiplier: number;
      maxDelay: number;
    };
    headers?: Record<string, string>;
    queryParameters?: Record<string, string>;
    authentication?: {
      type: "NONE" | "BASIC_AUTH" | "API_KEY" | "BEARER_TOKEN" | "CUSTOM";
      credentials?: Record<string, any>;
    };
    filtering: {
      enabled: boolean;
      conditions: Array<{
        field: string;
        operator: string;
        value: any;
        logic?: "AND" | "OR";
      }>;
    };
    transformation: {
      enabled: boolean;
      template?: string;
      mapping?: Record<string, string>;
      customScript?: string;
    };
  };
  statistics: {
    totalDeliveries: number;
    successfulDeliveries: number;
    failedDeliveries: number;
    averageResponseTime: number;
    lastDelivery?: string;
    lastSuccess?: string;
    lastFailure?: string;
    successRate: number;
    errorRate: number;
    uptime: number;
  };
  logs: Array<{
    id: string;
    eventId: string;
    eventType: string;
    eventAction: string;
    resource: string;
    status: "PENDING" | "DELIVERED" | "FAILED" | "RETRYING";
    attempt: number;
    maxAttempts: number;
    responseCode?: number;
    responseTime?: number;
    error?: string;
    payload?: Record<string, any>;
    headers?: Record<string, string>;
    timestamp: string;
    nextRetry?: string;
  }>;
  security: {
    ipWhitelist?: Array<string>;
    allowedOrigins?: Array<string>;
    rateLimiting?: {
      enabled: boolean;
      requestsPerMinute?: number;
      requestsPerHour?: number;
      requestsPerDay?: number;
    };
    encryption: {
      enabled: boolean;
      algorithm?: string;
    };
  };
  testing: {
    lastTest?: string;
    testResults?: Array<{
      timestamp: string;
      status: "SUCCESS" | "FAILURE";
      responseCode?: number;
      responseTime?: number;
      error?: string;
      payload?: Record<string, any>;
    }>;
  };
  createdAt: string;
  updatedAt: string;
  createdBy: string;
  updatedBy?: string;
  creator?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
  updater?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
}

export const webhooksApi = {
  // Get all webhooks
  getAll: async (orgId: string): Promise<Webhooks[]> => {
    return await apiClient.get(`/organizations/${orgId}/webhooks`);
    
  },

  // Get webhook by ID
  getById: async (orgId: string, id: string): Promise<Webhooks> => {
    return await apiClient.get(`/organizations/${orgId}/webhooks/${id}`);
    
  },

  // Create new webhook
  create: async (orgId: string, data: Omit<Webhooks, 'id' | 'createdAt' | 'updatedAt' | 'statistics' | 'logs' | 'testing' | 'creator' | 'updater'>): Promise<Webhooks> => {
    return await apiClient.post(`/organizations/${orgId}/webhooks`, data);
    
  },

  // Update webhook
  update: async (orgId: string, id: string, data: Partial<Webhooks>): Promise<Webhooks> => {
    return await apiClient.put(`/organizations/${orgId}/webhooks/${id}`, data);
    
  },

  // Delete webhook
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/webhooks/${id}`);
  },

  // Get webhooks by status
  getByStatus: async (orgId: string, status: Webhooks['status']): Promise<Webhooks[]> => {
    return await apiClient.get(`/organizations/${orgId}/webhooks`, {
      params: { status }
    });
    
  },

  // Search webhooks
  search: async (orgId: string, query: string, filters?: {
    status?: Webhooks['status'];
    event?: string;
    url?: string;
  }): Promise<Webhooks[]> => {
    return await apiClient.get(`/organizations/${orgId}/webhooks/search`, {
      params: { query, ...filters }
    });
    
  },

  // Update webhook status
  updateStatus: async (orgId: string, id: string, data: {
    status: Webhooks['status'];
    reason?: string;
  }): Promise<Webhooks> => {
    return await apiClient.patch(`/organizations/${orgId}/webhooks/${id}/status`, data);
    
  },

  // Test webhook
  test: async (orgId: string, id: string, data?: {
    eventType?: string;
    eventAction?: string;
    resource?: string;
    payload?: Record<string, any>;
  }): Promise<{
    success: boolean;
    testId: string;
    message: string;
    responseCode?: number;
    responseTime?: number;
    error?: string;
    deliveredPayload?: Record<string, any>;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/webhooks/${id}/test`, data);
    
  },

  // Get webhook logs
  getLogs: async (orgId: string, id: string, filters?: {
    status?: Webhooks['logs'][0]['status'];
    eventType?: string;
    startDate?: string;
    endDate?: string;
    limit?: number;
    offset?: number;
  }): Promise<Webhooks['logs']> => {
    return await apiClient.get(`/organizations/${orgId}/webhooks/${id}/logs`, {
      params: { ...filters }
    });
    
  },

  // Get webhook statistics
  getStatistics: async (orgId: string, id: string, filters?: {
    startDate?: string;
    endDate?: string;
    period?: "HOUR" | "DAY" | "WEEK" | "MONTH";
  }): Promise<Webhooks['statistics']> => {
    return await apiClient.get(`/organizations/${orgId}/webhooks/${id}/statistics`, {
      params: { ...filters }
    });
    
  },

  // Retry failed deliveries
  retryFailed: async (orgId: string, id: string, data?: {
    logIds?: Array<string>;
    all?: boolean;
  }): Promise<{
    success: boolean;
    message: string;
    retriedCount: number;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/webhooks/${id}/retry-failed`, data);
    
  },

  // Get available events
  getAvailableEvents: async (): Promise<Array<{
    type: string;
    action: string;
    resource: string;
    description?: string;
    payload?: Record<string, any>;
    example?: Record<string, any>;
  }>> => {
    return await apiClient.get(`/organizations/current/webhooks/events`);
    
  },

  // Validate webhook URL
  validateUrl: async (url: string): Promise<{
    valid: boolean;
    reachable: boolean;
    responseCode?: number;
    responseTime?: number;
    error?: string;
    recommendations?: Array<string>;
  }> => {
    return await apiClient.post(`/organizations/current/webhooks/validate-url`, { url });
    
  },

  // Generate webhook secret
  generateSecret: async (): Promise<{
    secret: string;
    algorithm: string;
    expiresAt?: string;
  }> => {
    return await apiClient.post(`/organizations/current/webhooks/generate-secret`);
    
  },

  // Get webhook statistics (organization level)
  getOrganizationStatistics: async (orgId: string, filters?: {
    startDate?: string;
    endDate?: string;
    status?: Webhooks['status'];
  }): Promise<{
    total: number;
    active: number;
    inactive: number;
    error: number;
    paused: number;
    totalDeliveries: number;
    successfulDeliveries: number;
    failedDeliveries: number;
    averageResponseTime: number;
    overallSuccessRate: number;
    overallErrorRate: number;
    byStatus: Record<string, number>;
    byEventType: Array<{
      eventType: string;
      deliveries: number;
      successRate: number;
    }>;
    trends: Array<{
      date: string;
      deliveries: number;
      successes: number;
      failures: number;
      averageResponseTime: number;
    }>;
  }> => {
    return await apiClient.get(`/organizations/${orgId}/webhooks/statistics`, {
      params: { ...filters }
    });
    
  },

  // Export webhooks
  export: async (orgId: string, options: {
    status?: Webhooks['status'];
    format: "JSON" | "CSV" | "EXCEL";
    includeConfiguration?: boolean;
    includeLogs?: boolean;
    includeStatistics?: boolean;
    startDate?: string;
    endDate?: string;
  }): Promise<Blob> => {
    return await apiClient.post(`/organizations/${orgId}/webhooks/export`, options, {
      responseType: 'blob'
    });
    
  },

  // Import webhooks
  import: async (orgId: string, data: {
    format: "JSON" | "CSV" | "EXCEL";
    file?: File;
    url?: string;
    mapping?: Record<string, string>;
    mergeStrategy: "REPLACE" | "MERGE" | "SKIP_CONFLICTS";
    validateOnly?: boolean;
  }): Promise<{
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
  }> => {
    const formData = new FormData();
    formData.append('format', data.format);
    if (data.file) {
      formData.append('file', data.file);
    }
    if (data.url) {
      formData.append('url', data.url);
    }
    if (data.mapping) {
      formData.append('mapping', JSON.stringify(data.mapping));
    }
    formData.append('mergeStrategy', data.mergeStrategy);
    formData.append('validateOnly', String(data.validateOnly || false));

    return await apiClient.post(`/organizations/${orgId}/webhooks/import`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    
  },
};
