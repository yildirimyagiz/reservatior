import { apiClient } from "./client";

export interface CustomReports {
  id: string;
  orgId: string;
  name: string;
  description?: string;
  type: "TABULAR" | "CHART" | "DASHBOARD" | "SUMMARY" | "DETAIL" | "COMPARISON" | "TREND" | "FORECAST" | "CUSTOM";
  category: "SALES" | "MARKETING" | "FINANCIAL" | "OPERATIONAL" | "HR" | "CUSTOMER" | "PROPERTY" | "PERFORMANCE" | "COMPLIANCE" | "CUSTOM";
  status: "DRAFT" | "ACTIVE" | "SCHEDULED" | "ARCHIVED" | "DEPRECATED";
  visibility: "PRIVATE" | "TEAM" | "DEPARTMENT" | "ORGANIZATION" | "PUBLIC";
  configuration: {
    dataSource: {
      type: "DATABASE" | "API" | "FILE" | "STREAM" | "CACHE" | "EXTERNAL";
      connection?: {
        id: string;
        name: string;
        type: string;
      };
      query?: string;
      endpoint?: string;
      parameters?: Record<string, any>;
      filters?: Array<{
        field: string;
        operator: string;
        value: any;
        logic?: "AND" | "OR";
      }>;
      aggregations?: Array<{
        field: string;
        function: "SUM" | "AVG" | "COUNT" | "MIN" | "MAX" | "STDDEV" | "VARIANCE";
        alias?: string;
      }>;
      groupBy?: Array<string>;
      orderBy?: Array<{
        field: string;
        direction: "ASC" | "DESC";
      }>;
      limit?: number;
      offset?: number;
    };
    visualization: {
      type: "TABLE" | "BAR" | "LINE" | "PIE" | "AREA" | "SCATTER" | "HEATMAP" | "TREE_MAP" | "GAUGE" | "FUNNEL" | "RADAR" | "CUSTOM";
      chartType?: string;
      axes?: {
        x: {
          field: string;
          label: string;
          type: "CATEGORY" | "NUMERIC" | "TIME";
        };
        y: {
          field: string;
          label: string;
          type: "CATEGORY" | "NUMERIC" | "TIME";
        };
        y2?: {
          field: string;
          label: string;
          type: "CATEGORY" | "NUMERIC" | "TIME";
        };
      };
      series?: Array<{
        name: string;
        field: string;
        type: "LINE" | "BAR" | "AREA";
        color?: string;
        stack?: boolean;
      }>;
      styling: {
        theme: string;
        colorPalette: Array<string>;
        backgroundColor?: string;
        grid?: {
          enabled: boolean;
          color?: string;
        };
        legend?: {
          enabled: boolean;
          position: "TOP" | "BOTTOM" | "LEFT" | "RIGHT";
        };
        tooltip?: {
          enabled: boolean;
          format?: string;
        };
      };
      interactions: {
        zoom?: boolean;
        pan?: boolean;
        drillDown?: boolean;
        filter?: boolean;
        export?: boolean;
      };
    };
    calculations: Array<{
      id: string;
      name: string;
      type: "METRIC" | "KPI" | "FORMULA" | "AGGREGATION";
      expression: string;
      description?: string;
      format?: {
        type: "NUMBER" | "CURRENCY" | "PERCENTAGE" | "DATE" | "CUSTOM";
        pattern?: string;
        decimals?: number;
      };
      targets?: Array<{
        name: string;
        value: number;
        operator: "GREATER_THAN" | "LESS_THAN" | "EQUALS";
        color?: string;
      }>;
    }>;
    scheduling: {
      enabled: boolean;
      frequency: "MINUTELY" | "HOURLY" | "DAILY" | "WEEKLY" | "MONTHLY" | "QUARTERLY" | "YEARLY" | "CUSTOM";
      interval?: number;
      timezone?: string;
      startDate?: string;
      endDate?: string;
      nextRun?: string;
      recipients: Array<{
        type: "EMAIL" | "WEBHOOK" | "SLACK" | "TEAMS";
        destination: string;
        enabled: boolean;
        format?: "PDF" | "EXCEL" | "CSV" | "JSON";
      }>;
    };
    caching: {
      enabled: boolean;
      ttl?: number;
      strategy?: "LRU" | "LFU" | "TIME_BASED";
      maxSize?: number;
    };
  };
  data: {
    rows?: Array<Record<string, any>>;
    columns?: Array<{
      name: string;
      type: string;
      label?: string;
      format?: string;
      visible: boolean;
    }>;
    metrics?: Array<{
      name: string;
      value: number;
      change?: {
        value: number;
        percentage: number;
        period: string;
      };
      target?: {
        value: number;
        achieved: boolean;
        variance: number;
      };
    }>;
    chartData?: {
      labels: Array<string>;
      datasets: Array<{
        label: string;
        data: Array<number>;
        backgroundColor?: string;
        borderColor?: string;
        borderWidth?: number;
      }>;
    };
    summary?: {
      total: number;
      filtered: number;
      generated: string;
      duration: number;
      cacheHit: boolean;
    };
  };
  performance: {
    executionTime: number;
    dataProcessingTime: number;
    renderTime: number;
    totalRecords: number;
    memoryUsage: number;
    cacheHitRate: number;
    errorRate: number;
    lastExecuted?: string;
    averageExecutionTime: number;
    successRate: number;
  };
  permissions: {
    owner: string;
    viewers: Array<string>;
    editors: Array<string>;
    administrators: Array<string>;
    publicAccess: boolean;
    shareable: boolean;
    exportable: boolean;
  };
  security: {
    encryption: boolean;
    dataMasking: {
      enabled: boolean;
      fields: Array<{
        name: string;
        method: "HASH" | "MASK" | "TOKENIZE";
      }>;
    };
    accessControl: {
      enabled: boolean;
      roles: Array<string>;
      conditions?: Record<string, any>;
    };
    audit: {
      enabled: boolean;
      logLevel: "INFO" | "WARNING" | "ERROR";
      retention: number;
    };
  };
  version: {
    current: string;
    history: Array<{
      version: string;
      changes: Array<string>;
      author: string;
      timestamp: string;
      description?: string;
    }>;
  };
  tags?: Array<{
    id: string;
    name: string;
    color?: string;
  }>;
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

export const customReportsApi = {
  // Get all custom reports
  getAll: async (orgId: string): Promise<CustomReports[]> => {
    return await apiClient.get<CustomReports[]>(`/organizations/${orgId}/custom-reports`);
  },

  // Get custom report by ID
  getById: async (orgId: string, id: string): Promise<CustomReports> => {
    return await apiClient.get<CustomReports>(`/organizations/${orgId}/custom-reports/${id}`);
  },

  // Create new custom report
  create: async (orgId: string, data: Omit<CustomReports, 'id' | 'createdAt' | 'updatedAt' | 'data' | 'performance' | 'version' | 'creator' | 'updater'>): Promise<CustomReports> => {
    return await apiClient.post<CustomReports>(`/organizations/${orgId}/custom-reports`, data);
  },

  // Update custom report
  update: async (orgId: string, id: string, data: Partial<CustomReports>): Promise<CustomReports> => {
    return await apiClient.put<CustomReports>(`/organizations/${orgId}/custom-reports/${id}`, data);
  },

  // Delete custom report
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/custom-reports/${id}`);
  },

  // Get custom reports by type
  getByType: async (orgId: string, type: CustomReports['type']): Promise<CustomReports[]> => {
    return await apiClient.get(`/organizations/${orgId}/custom-reports`, {
      params: { type }
    });
  },

  // Get custom reports by category
  getByCategory: async (orgId: string, category: CustomReports['category']): Promise<CustomReports[]> => {
    return await apiClient.get(`/organizations/${orgId}/custom-reports`, {
      params: { category }
    });
  },

  // Get custom reports by status
  getByStatus: async (orgId: string, status: CustomReports['status']): Promise<CustomReports[]> => {
    return await apiClient.get(`/organizations/${orgId}/custom-reports`, {
      params: { status }
    });
  },

  // Get custom reports by visibility
  getByVisibility: async (orgId: string, visibility: CustomReports['visibility']): Promise<CustomReports[]> => {
    return await apiClient.get(`/organizations/${orgId}/custom-reports`, {
      params: { visibility }
    });
  },

  // Search custom reports
  search: async (orgId: string, query: string, filters?: {
    type?: CustomReports['type'];
    category?: CustomReports['category'];
    status?: CustomReports['status'];
    visibility?: CustomReports['visibility'];
    createdBy?: string;
    tags?: Array<string>;
  }): Promise<CustomReports[]> => {
    return await apiClient.get(`/organizations/${orgId}/custom-reports/search`, {
      params: { query, ...filters }
    });
  },

  // Execute report
  execute: async (orgId: string, id: string, data?: {
    parameters?: Record<string, any>;
    filters?: Array<{
      field: string;
      operator: string;
      value: any;
    }>;
    format?: "JSON" | "CSV" | "EXCEL" | "PDF";
    limit?: number;
    offset?: number;
  }): Promise<{
    success: boolean;
    executionId: string;
    data: CustomReports['data'];
    performance: CustomReports['performance'];
    message?: string;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/custom-reports/${id}/execute`, data);
  },

  // Get execution status
  getExecutionStatus: async (orgId: string, executionId: string): Promise<{
    executionId: string;
    status: "PENDING" | "RUNNING" | "COMPLETED" | "FAILED" | "CANCELLED";
    progress: number;
    startedAt: string;
    completedAt?: string;
    duration?: number;
    recordsProcessed?: number;
    totalRecords?: number;
    error?: string;
    results?: CustomReports['data'];
  }> => {
    return await apiClient.get(`/organizations/${orgId}/custom-reports/execution/${executionId}`);
  },

  // Cancel execution
  cancelExecution: async (orgId: string, executionId: string): Promise<{
    success: boolean;
    message: string;
    cancelledAt: string;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/custom-reports/execution/${executionId}/cancel`);
  },

  // Preview report
  preview: async (orgId: string, data: {
    name: string;
    type: CustomReports['type'];
    configuration: CustomReports['configuration'];
    sampleSize?: number;
  }): Promise<{
    success: boolean;
    data: CustomReports['data'];
    performance: {
      estimatedExecutionTime: number;
      estimatedDataSize: number;
      sampleSize: number;
    };
    warnings?: Array<{
      type: string;
      message: string;
      severity: "LOW" | "MEDIUM" | "HIGH";
    }>;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/custom-reports/preview`, data);
  },

  // Validate report configuration
  validate: async (orgId: string, data: {
    configuration: CustomReports['configuration'];
  }): Promise<{
    valid: boolean;
    errors: Array<{
      field: string;
      message: string;
      severity: "ERROR" | "WARNING";
    }>;
    warnings: Array<{
      field: string;
      message: string;
      severity: "ERROR" | "WARNING";
    }>;
    suggestions?: Array<{
      field: string;
      message: string;
      improvement: string;
    }>;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/custom-reports/validate`, data);
  },

  // Clone report
  clone: async (orgId: string, id: string, data: {
    name: string;
    description?: string;
    copyData?: boolean;
    copyPermissions?: boolean;
    copyScheduling?: boolean;
  }): Promise<CustomReports> => {
    return await apiClient.post(`/organizations/${orgId}/custom-reports/${id}/clone`, data);
  },

  // Update report permissions
  updatePermissions: async (orgId: string, id: string, data: {
    viewers?: Array<string>;
    editors?: Array<string>;
    administrators?: Array<string>;
    publicAccess?: boolean;
    shareable?: boolean;
    exportable?: boolean;
  }): Promise<CustomReports> => {
    return await apiClient.put(`/organizations/${orgId}/custom-reports/${id}/permissions`, data);
  },

  // Share report
  share: async (orgId: string, id: string, data: {
    recipients: Array<{
      type: "USER" | "TEAM" | "DEPARTMENT" | "EMAIL";
      destination: string;
      permissions: Array<"VIEW" | "EDIT" | "SHARE" | "EXPORT">;
      message?: string;
    }>;
    expiresAt?: string;
    password?: string;
  }): Promise<{
    success: boolean;
    shareId: string;
    shareUrl: string;
    expiresAt: string;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/custom-reports/${id}/share`, data);
  },

  // Get shared report
  getShared: async (shareId: string, password?: string): Promise<{
    report: CustomReports;
    data: CustomReports['data'];
    permissions: Array<string>;
    expiresAt: string;
  }> => {
    return await apiClient.get(`/organizations/current/custom-reports/shared/${shareId}`, {
      params: { password }
    });
  },

  // Schedule report
  schedule: async (orgId: string, id: string, data: {
    enabled: boolean;
    frequency: CustomReports['configuration']['scheduling']['frequency'];
    interval?: number;
    timezone?: string;
    startDate?: string;
    endDate?: string;
    recipients: Array<{
      type: "EMAIL" | "WEBHOOK" | "SLACK" | "TEAMS";
      destination: string;
      enabled: boolean;
      format?: "PDF" | "EXCEL" | "CSV" | "JSON";
    }>;
  }): Promise<CustomReports> => {
    return await apiClient.put(`/organizations/${orgId}/custom-reports/${id}/schedule`, data);
  },

  // Get report templates
  getTemplates: async (): Promise<Array<{
    id: string;
    name: string;
    description: string;
    type: CustomReports['type'];
    category: CustomReports['category'];
    configuration: Partial<CustomReports['configuration']>;
    preview?: {
      thumbnail: string;
      description: string;
    };
    usage: number;
    isPublic: boolean;
    createdBy: string;
    createdAt: string;
  }>> => {
    return await apiClient.get(`/organizations/current/custom-reports/templates`);
  },

  // Create report from template
  createFromTemplate: async (orgId: string, data: {
    templateId: string;
    name: string;
    description?: string;
    customConfiguration?: Partial<CustomReports['configuration']>;
  }): Promise<CustomReports> => {
    return await apiClient.post(`/organizations/${orgId}/custom-reports/from-template`, data);
  },

  // Get available data sources
  getDataSources: async (): Promise<Array<{
    id: string;
    name: string;
    type: string;
    description?: string;
    connection?: {
      host?: string;
      database?: string;
      port?: number;
    };
    capabilities: Array<{
      type: string;
      supported: boolean;
      description?: string;
    }>;
  }>> => {
    return await apiClient.get(`/organizations/current/custom-reports/data-sources`);
  },

  // Test data source connection
  testDataSource: async (data: {
    type: string;
    connection: Record<string, any>;
    query?: string;
  }): Promise<{
    success: boolean;
    message: string;
    responseTime?: number;
    sampleData?: Array<Record<string, any>>;
    error?: string;
  }> => {
    return await apiClient.post(`/organizations/current/custom-reports/test-data-source`, data);
  },

  // Get organization report statistics
  getOrganizationStatistics: async (orgId: string, filters?: {
    type?: CustomReports['type'];
    category?: CustomReports['category'];
    status?: CustomReports['status'];
    createdBy?: string;
    startDate?: string;
    endDate?: string;
  }): Promise<{
    total: number;
    byType: Record<string, number>;
    byCategory: Record<string, number>;
    byStatus: Record<string, number>;
    usage: {
      totalExecutions: number;
      successfulExecutions: number;
      failedExecutions: number;
      averageExecutionTime: number;
      totalDataProcessed: number;
    };
    performance: {
      averageExecutionTime: number;
      successRate: number;
      errorRate: number;
      cacheHitRate: number;
    };
    popular: Array<{
      reportId: string;
      reportName: string;
      executions: number;
      averageExecutionTime: number;
      users: number;
    }>;
    trends: Array<{
      date: string;
      created: number;
      executed: number;
      failed: number;
      avgExecutionTime: number;
    }>;
  }> => {
    return await apiClient.get(`/organizations/${orgId}/custom-reports/statistics`, {
      params: { ...filters }
    });
  },

  // Export reports
  export: async (orgId: string, options: {
    type?: CustomReports['type'];
    category?: CustomReports['category'];
    status?: CustomReports['status'];
    format: "JSON" | "CSV" | "EXCEL";
    includeConfiguration?: boolean;
    includeData?: boolean;
    includePermissions?: boolean;
    startDate?: string;
    endDate?: string;
  }): Promise<Blob> => {
    const response = await fetch(`${apiClient['baseURL']}/organizations/${orgId}/custom-reports/export`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${localStorage.getItem("auth_token")}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(options)
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    return await response.blob();
  },

  // Import reports
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

    const response = await fetch(`${apiClient['baseURL']}/organizations/${orgId}/custom-reports/import`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${localStorage.getItem("auth_token")}`,
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
