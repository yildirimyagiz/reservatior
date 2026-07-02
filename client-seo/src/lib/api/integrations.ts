import { apiClient } from "./client";

export interface Integrations {
  id: string;
  orgId: string;
  name: string;
  type: "CRM" | "EMAIL" | "CALENDAR" | "ACCOUNTING" | "PAYMENT" | "MARKETING" | "ANALYTICS" | "PROJECT_MANAGEMENT" | "COMMUNICATION" | "DOCUMENT_MANAGEMENT" | "PROPERTY_MANAGEMENT" | "CUSTOM";
  provider: string;
  version: string;
  status: "ACTIVE" | "INACTIVE" | "ERROR" | "PENDING" | "EXPIRED" | "SUSPENDED";
  configuration: {
    apiKey?: string;
    apiSecret?: string;
    webhookUrl?: string;
    baseUrl?: string;
    environment?: "SANDBOX" | "PRODUCTION" | "STAGING";
    settings?: Record<string, any>;
    authentication: {
      type: "API_KEY" | "OAUTH2" | "BASIC_AUTH" | "BEARER_TOKEN" | "CUSTOM";
      credentials?: Record<string, any>;
      scopes?: Array<string>;
      expiresAt?: string;
      refreshToken?: string;
    };
    sync: {
      enabled: boolean;
      frequency: "REAL_TIME" | "EVERY_5_MINUTES" | "EVERY_15_MINUTES" | "EVERY_30_MINUTES" | "HOURLY" | "DAILY" | "WEEKLY";
      direction: "BIDIRECTIONAL" | "INBOUND" | "OUTBOUND";
      lastSync?: string;
      nextSync?: string;
      retryCount: number;
      maxRetries: number;
    };
    mapping: {
      fields: Array<{
        sourceField: string;
        targetField: string;
        transformation?: string;
        required: boolean;
        defaultValue?: any;
      }>;
      objects: Array<{
        sourceObject: string;
        targetObject: string;
        fields: Array<string>;
      }>;
    };
    filters?: Array<{
      field: string;
      operator: string;
      value: any;
      logic?: "AND" | "OR";
    }>;
    webhooks?: Array<{
      event: string;
      url: string;
      enabled: boolean;
      secret?: string;
      headers?: Record<string, string>;
    }>;
  };
  capabilities: Array<{
    name: string;
    enabled: boolean;
    supported: boolean;
    configuration?: Record<string, any>;
  }>;
  usage: {
    apiCalls: number;
    dataTransferred: number;
    lastUsed?: string;
    quota?: {
      daily?: number;
      monthly?: number;
      resetDate?: string;
    };
    limits?: {
      maxApiCalls?: number;
      maxDataTransferred?: number;
      maxConnections?: number;
    };
  };
  logs: Array<{
    id: string;
    level: "INFO" | "WARNING" | "ERROR" | "DEBUG";
    message: string;
    timestamp: string;
    details?: Record<string, any>;
    userId?: string;
  }>;
  metrics: {
    syncSuccess: number;
    syncFailures: number;
    averageSyncTime: number;
    lastSyncDuration?: number;
    uptime: number;
    errorRate: number;
    responseTime: number;
    dataQuality: {
      syncedRecords: number;
      failedRecords: number;
      duplicateRecords: number;
      lastValidation?: string;
    };
  };
  security: {
    encryptionEnabled: boolean;
    dataRetention: number;
    accessLogs: Array<{
      timestamp: string;
      userId: string;
      action: string;
      ipAddress?: string;
      userAgent?: string;
    }>;
    compliance: Array<{
      standard: string;
      status: "COMPLIANT" | "NON_COMPLIANT" | "PENDING";
      lastChecked: string;
      issues?: Array<string>;
    }>;
  };
  support: {
    documentation?: string;
    supportEmail?: string;
    supportPhone?: string;
    faq?: Array<{
      question: string;
      answer: string;
      category: string;
    }>;
    troubleshooting?: Array<{
      issue: string;
      solution: string;
      category: string;
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

export const integrationsApi = {
  // Get all integrations
  getAll: async (orgId: string): Promise<Integrations[]> => {
    return await apiClient.get(`/organizations/${orgId}/integrations`);
    
  },

  // Get integration by ID
  getById: async (orgId: string, id: string): Promise<Integrations> => {
    return await apiClient.get(`/organizations/${orgId}/integrations/${id}`);
    
  },

  // Create new integration
  create: async (orgId: string, data: Omit<Integrations, 'id' | 'createdAt' | 'updatedAt' | 'usage' | 'logs' | 'metrics' | 'creator' | 'updater'>): Promise<Integrations> => {
    return await apiClient.post(`/organizations/${orgId}/integrations`, data);
    
  },

  // Update integration
  update: async (orgId: string, id: string, data: Partial<Integrations>): Promise<Integrations> => {
    return await apiClient.put(`/organizations/${orgId}/integrations/${id}`, data);
    
  },

  // Delete integration
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/integrations/${id}`);
  },

  // Get integrations by type
  getByType: async (orgId: string, type: Integrations['type']): Promise<Integrations[]> => {
    return await apiClient.get(`/organizations/${orgId}/integrations`, {
      params: { type }
    });
    
  },

  // Get integrations by status
  getByStatus: async (orgId: string, status: Integrations['status']): Promise<Integrations[]> => {
    return await apiClient.get(`/organizations/${orgId}/integrations`, {
      params: { status }
    });
    
  },

  // Get integrations by provider
  getByProvider: async (orgId: string, provider: string): Promise<Integrations[]> => {
    return await apiClient.get(`/organizations/${orgId}/integrations`, {
      params: { provider }
    });
    
  },

  // Search integrations
  search: async (orgId: string, query: string, filters?: {
    type?: Integrations['type'];
    status?: Integrations['status'];
    provider?: string;
  }): Promise<Integrations[]> => {
    return await apiClient.get(`/organizations/${orgId}/integrations/search`, {
      params: { query, ...filters }
    });
    
  },

  // Test integration connection
  testConnection: async (orgId: string, id: string): Promise<{
    success: boolean;
    message: string;
    responseTime?: number;
    details?: Record<string, any>;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/integrations/${id}/test-connection`);
    
  },

  // Test integration with configuration
  testConfiguration: async (orgId: string, data: {
    type: Integrations['type'];
    provider: string;
    configuration: Integrations['configuration'];
  }): Promise<{
    success: boolean;
    message: string;
    responseTime?: number;
    details?: Record<string, any>;
    validation?: Array<{
      field: string;
      status: "VALID" | "INVALID" | "WARNING";
      message: string;
    }>;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/integrations/test-configuration`, data);
    
  },

  // Update integration status
  updateStatus: async (orgId: string, id: string, data: {
    status: Integrations['status'];
    reason?: string;
  }): Promise<Integrations> => {
    return await apiClient.patch(`/organizations/${orgId}/integrations/${id}/status`, data);
    
  },

  // Sync integration data
  sync: async (orgId: string, id: string, data?: {
    direction?: "INBOUND" | "OUTBOUND" | "BIDIRECTIONAL";
    objects?: Array<string>;
    filters?: Array<{
      field: string;
      operator: string;
      value: any;
    }>;
    force?: boolean;
  }): Promise<{
    success: boolean;
    syncId: string;
    message: string;
    estimatedDuration?: number;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/integrations/${id}/sync`, data);
    
  },

  // Get sync status
  getSyncStatus: async (orgId: string, id: string): Promise<{
    syncId: string;
    status: "PENDING" | "RUNNING" | "COMPLETED" | "FAILED" | "CANCELLED";
    progress: number;
    startedAt: string;
    completedAt?: string;
    recordsProcessed: number;
    totalRecords: number;
    errors?: Array<{
      record: string;
      error: string;
      timestamp: string;
    }>;
  }> => {
    return await apiClient.get(`/organizations/${orgId}/integrations/${id}/sync-status`);
    
  },

  // Get integration logs
  getLogs: async (orgId: string, id: string, filters?: {
    level?: Integrations['logs'][0]['level'];
    startDate?: string;
    endDate?: string;
    limit?: number;
    offset?: number;
  }): Promise<Integrations['logs']> => {
    return await apiClient.get(`/organizations/${orgId}/integrations/${id}/logs`, {
      params: { ...filters }
    });
    
  },

  // Get integration metrics
  getMetrics: async (orgId: string, id: string, filters?: {
    startDate?: string;
    endDate?: string;
    period?: "HOUR" | "DAY" | "WEEK" | "MONTH";
  }): Promise<Integrations['metrics']> => {
    return await apiClient.get(`/organizations/${orgId}/integrations/${id}/metrics`, {
      params: { ...filters }
    });
    
  },

  // Get available integration providers
  getAvailableProviders: async (): Promise<Array<{
    type: Integrations['type'];
    provider: string;
    name: string;
    description: string;
    logo?: string;
    website?: string;
    documentation?: string;
    pricing?: {
      model: string;
      free?: boolean;
      trial?: boolean;
    };
    features: Array<{
      name: string;
      description: string;
      supported: boolean;
    }>;
    authentication: {
      type: Integrations['configuration']['authentication']['type'];
      required: boolean;
      description?: string;
    };
    capabilities: Array<{
      name: string;
      supported: boolean;
      description?: string;
    }>;
  }>> => {
    return await apiClient.get(`/organizations/current/integrations/providers`);
    
  },

  // Get integration statistics
  getStatistics: async (orgId: string, filters?: {
    type?: Integrations['type'];
    status?: Integrations['status'];
    provider?: string;
    startDate?: string;
    endDate?: string;
  }): Promise<{
    total: number;
    byType: Record<string, number>;
    byStatus: Record<string, number>;
    byProvider: Record<string, number>;
    usage: {
      totalApiCalls: number;
      totalDataTransferred: number;
      averageResponseTime: number;
      errorRate: number;
      uptime: number;
    };
    syncMetrics: {
      totalSyncs: number;
      successfulSyncs: number;
      failedSyncs: number;
      averageSyncTime: number;
      recordsSynced: number;
    };
    trends: Array<{
      date: string;
      apiCalls: number;
      dataTransferred: number;
      syncs: number;
      errors: number;
    }>;
  }> => {
    return await apiClient.get(`/organizations/${orgId}/integrations/statistics`, {
      params: { ...filters }
    });
    
  },

  // Export integrations
  export: async (orgId: string, options: {
    type?: Integrations['type'];
    status?: Integrations['status'];
    provider?: string;
    format: "JSON" | "CSV" | "EXCEL";
    includeConfiguration?: boolean;
    includeMetrics?: boolean;
    includeLogs?: boolean;
  }): Promise<Blob> => {
    return await apiClient.post(`/organizations/${orgId}/integrations/export`, options, {
      responseType: 'blob'
    });
    
  },

  // Import integrations
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

    return await apiClient.post(`/organizations/${orgId}/integrations/import`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    
  },
};
