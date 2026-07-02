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
      credentials?: Record<string, unknown>;
    };
    filtering: {
      enabled: boolean;
      conditions: Array<{
        field: string;
        operator: string;
        value: unknown;
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
    payload?: Record<string, unknown>;
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
  getAll: async (params?: { orgId?: string }): Promise<Webhooks[]> => {
    return await apiClient.get(`/api/v1/webhook`, { params });
  },

  // Get webhook by ID
  getById: async (id: string): Promise<Webhooks> => {
    return await apiClient.get(`/api/v1/webhook/${id}`);
  },

  // Create new webhook
  create: async (data: Omit<Webhooks, 'id' | 'createdAt' | 'updatedAt' | 'statistics' | 'logs' | 'testing' | 'creator' | 'updater'>): Promise<Webhooks> => {
    return await apiClient.post(`/api/v1/webhook`, data);
  },

  // Update webhook
  update: async (id: string, data: Partial<Webhooks>): Promise<Webhooks> => {
    return await apiClient.patch(`/api/v1/webhook/${id}`, data);
  },

  // Delete webhook
  delete: async (id: string): Promise<void> => {
    await apiClient.delete(`/api/v1/webhook/${id}`);
  },

  // Get webhooks by status
  getByStatus: async (status: Webhooks['status']): Promise<Webhooks[]> => {
    return await apiClient.get(`/api/v1/webhook`, {
      params: { status }
    });
  },

  // Search webhooks
  search: async (query: string, filters?: {
    status?: Webhooks['status'];
    event?: string;
    url?: string;
  }): Promise<Webhooks[]> => {
    return await apiClient.get(`/api/v1/webhook/search`, {
      params: { query, ...filters }
    });
  },

  // Update webhook status
  updateStatus: async (id: string, data: {
    status: Webhooks['status'];
    reason?: string;
  }): Promise<Webhooks> => {
    return await apiClient.patch(`/api/v1/webhook/${id}/status`, data);
  },

  // Test webhook
  test: async (id: string, data?: {
    eventType?: string;
    eventAction?: string;
    resource?: string;
    payload?: Record<string, unknown>;
  }): Promise<{
    success: boolean;
    testId: string;
    message: string;
    responseCode?: number;
    responseTime?: number;
    error?: string;
    deliveredPayload?: Record<string, unknown>;
  }> => {
    return await apiClient.post(`/api/v1/webhook/${id}/test`, data);
  },

  // Get webhook logs
  getLogs: async (id: string, filters?: {
    status?: Webhooks['logs'][0]['status'];
    eventType?: string;
    startDate?: string;
    endDate?: string;
    limit?: number;
    offset?: number;
  }): Promise<Webhooks['logs']> => {
    return await apiClient.get(`/api/v1/webhook/${id}/logs`, {
      params: { ...filters }
    });
  },

  // Get webhook statistics
  getStatistics: async (id: string, filters?: {
    startDate?: string;
    endDate?: string;
    period?: "HOUR" | "DAY" | "WEEK" | "MONTH";
  }): Promise<Webhooks['statistics']> => {
    return await apiClient.get(`/api/v1/webhook/${id}/statistics`, {
      params: { ...filters }
    });
  },

  // Retry failed deliveries
  retryFailed: async (id: string, data?: {
    logIds?: Array<string>;
    all?: boolean;
  }): Promise<{
    success: boolean;
    message: string;
    retriedCount: number;
  }> => {
    return await apiClient.post(`/api/v1/webhook/${id}/retry-failed`, data);
  },

  // Get available events
  getAvailableEvents: async (): Promise<Array<{
    type: string;
    action: string;
    resource: string;
    description?: string;
    payload?: Record<string, unknown>;
    example?: Record<string, unknown>;
  }>> => {
    return await apiClient.get(`/api/v1/webhook/events`);
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
    return await apiClient.post(`/api/v1/webhook/validate-url`, { url });
  },

  // Generate webhook secret
  generateSecret: async (): Promise<{
    secret: string;
    algorithm: string;
    expiresAt?: string;
  }> => {
    return await apiClient.post(`/api/v1/webhook/generate-secret`);
  },

  // Get webhook statistics (organization level)
  getOrganizationStatistics: async (filters?: {
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
    return await apiClient.get(`/api/v1/webhook/statistics`, {
      params: { ...filters }
    });
  },

  // Export webhooks
  export: async (options: {
    status?: Webhooks['status'];
    format: "JSON" | "CSV" | "EXCEL";
    includeConfiguration?: boolean;
    includeLogs?: boolean;
    includeStatistics?: boolean;
    startDate?: string;
    endDate?: string;
  }): Promise<Blob> => {
    return await apiClient.post(`/api/v1/webhook/export`, options, {
      responseType: 'blob'
    });
  },

  // Import webhooks
  import: async (data: {
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
      value: unknown;
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

    return await apiClient.post(`/api/v1/webhook/import`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
  },
};
