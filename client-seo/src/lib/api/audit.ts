import { apiClient } from "./client";

export interface Audit {
  id: string;
  orgId: string;
  userId?: string;
  agentId?: string;
  type: "USER_LOGIN" | "USER_LOGOUT" | "DATA_ACCESS" | "DATA_MODIFICATION" | "DATA_DELETION" | "SYSTEM_CHANGE" | "SECURITY_BREACH" | "PERMISSION_CHANGE" | "CONFIG_UPDATE" | "API_CALL" | "ERROR_OCCURRED" | "CUSTOM";
  category: string;
  action: string;
  resource: string;
  resourceId?: string;
  details?: Record<string, any>;
  ipAddress?: string;
  userAgent?: string;
  sessionId?: string;
  severity: "LOW" | "MEDIUM" | "HIGH" | "CRITICAL";
  status: "ACTIVE" | "RESOLVED" | "IGNORED";
  timestamp: string;
  resolvedAt?: string;
  resolvedBy?: string;
  resolution?: string;
  metadata?: {
    oldValue?: any;
    newValue?: any;
    changes?: Array<{
      field: string;
      oldValue: any;
      newValue: any;
    }>;
    stackTrace?: string;
    requestId?: string;
  };
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

export const auditApi = {
  // Get all audit logs
  getAll: async (orgId: string): Promise<Audit[]> => {
    const response = await apiClient.get<Audit[]>(`/organizations/${orgId}/audit`);
    return response;
  },

  // Get audit log by ID
  getById: async (orgId: string, id: string): Promise<Audit> => {
    const response = await apiClient.get<Audit>(`/organizations/${orgId}/audit/${id}`);
    return response;
  },

  // Create audit log entry
  create: async (orgId: string, data: Omit<Audit, 'id' | 'timestamp' | 'resolvedAt' | 'resolvedBy' | 'resolution' | 'user' | 'agent'>): Promise<Audit> => {
    const response = await apiClient.post<Audit>(`/organizations/${orgId}/audit`, data);
    return response;
  },

  // Get audit logs by user
  getByUser: async (orgId: string, userId: string): Promise<Audit[]> => {
    const response = await apiClient.get<Audit[]>(`/organizations/${orgId}/users/${userId}/audit`);
    return response;
  },

  // Get audit logs by agent
  getByAgent: async (orgId: string, agentId: string): Promise<Audit[]> => {
    const response = await apiClient.get<Audit[]>(`/organizations/${orgId}/agents/${agentId}/audit`);
    return response;
  },

  // Get audit logs by type
  getByType: async (orgId: string, type: Audit['type']): Promise<Audit[]> => {
    const response = await apiClient.get<Audit[]>(`/organizations/${orgId}/audit`, {
      params: { type }
    });
    return response;
  },

  // Get audit logs by severity
  getBySeverity: async (orgId: string, severity: Audit['severity']): Promise<Audit[]> => {
    const response = await apiClient.get<Audit[]>(`/organizations/${orgId}/audit`, {
      params: { severity }
    });
    return response;
  },

  // Get audit logs by resource
  getByResource: async (orgId: string, resource: string): Promise<Audit[]> => {
    const response = await apiClient.get<Audit[]>(`/organizations/${orgId}/audit`, {
      params: { resource }
    });
    return response;
  },

  // Search audit logs
  search: async (orgId: string, query: string, filters?: {
    userId?: string;
    agentId?: string;
    type?: Audit['type'];
    severity?: Audit['severity'];
    category?: string;
    action?: string;
    startDate?: string;
    endDate?: string;
    resourceId?: string;
    ipAddress?: string;
  }): Promise<Audit[]> => {
    const response = await apiClient.get<Audit[]>(`/organizations/${orgId}/audit/search`, {
      params: { query, ...filters }
    });
    return response;
  },

  // Update audit log status
  updateStatus: async (orgId: string, id: string, data: {
    status: Audit['status'];
    resolution?: string;
    resolvedBy?: string;
  }): Promise<Audit> => {
    const response = await apiClient.patch<Audit>(`/organizations/${orgId}/audit/${id}/status`, data);
    return response;
  },

  // Get audit statistics
  getStatistics: async (orgId: string, filters?: {
    userId?: string;
    agentId?: string;
    type?: Audit['type'];
    severity?: Audit['severity'];
    category?: string;
    startDate?: string;
    endDate?: string;
  }): Promise<{
    total: number;
    byType: Record<string, number>;
    bySeverity: Record<string, number>;
    byCategory: Record<string, number>;
    byUser: Array<{
      userId?: string;
      agentId?: string;
      name: string;
      count: number;
      lastActivity: string;
    }>;
    byResource: Record<string, number>;
    criticalIssues: number;
    unresolvedIssues: number;
    averageResolutionTime: number;
    trends: Array<{
      date: string;
      count: number;
      severity: string;
    }>;
  }> => {
    const response = await apiClient.get<{
    total: number;
    byType: Record<string, number>;
    bySeverity: Record<string, number>;
    byCategory: Record<string, number>;
    byUser: Array<{
      userId?: string;
      agentId?: string;
      name: string;
      count: number;
      lastActivity: string;
    }>;
    byResource: Record<string, number>;
    criticalIssues: number;
    unresolvedIssues: number;
    averageResolutionTime: number;
    trends: Array<{
      date: string;
      count: number;
      severity: string;
    }>;
  }>(`/organizations/${orgId}/audit/statistics`, {
      params: { ...filters }
    });
    return response;
  },

  // Export audit logs
  export: async (orgId: string, options: {
    type?: Audit['type'];
    severity?: Audit['severity'];
    category?: string;
    userId?: string;
    agentId?: string;
    startDate?: string;
    endDate?: string;
    format: "PDF" | "EXCEL" | "CSV" | "JSON";
    includeDetails?: boolean;
    includeMetadata?: boolean;
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/audit/export`, options, {
      responseType: 'blob'
    });
    return response;
  },

  // Get audit retention settings
  getRetentionSettings: async (orgId: string): Promise<{
    retentionPeriod: number;
    retentionUnit: "DAYS" | "MONTHS" | "YEARS";
    autoDelete: boolean;
    criticalRetentionPeriod: number;
    criticalRetentionUnit: "DAYS" | "MONTHS" | "YEARS";
  }> => {
    const response = await apiClient.get<{
    retentionPeriod: number;
    retentionUnit: "DAYS" | "MONTHS" | "YEARS";
    autoDelete: boolean;
    criticalRetentionPeriod: number;
    criticalRetentionUnit: "DAYS" | "MONTHS" | "YEARS";
  }>(`/organizations/${orgId}/audit/retention`);
    return response;
  },

  // Update audit retention settings
  updateRetentionSettings: async (orgId: string, data: {
    retentionPeriod: number;
    retentionUnit: "DAYS" | "MONTHS" | "YEARS";
    autoDelete: boolean;
    criticalRetentionPeriod: number;
    criticalRetentionUnit: "DAYS" | "MONTHS" | "YEARS";
  }): Promise<void> => {
    await apiClient.put(`/organizations/${orgId}/audit/retention`, data);
  },

  // Get audit alerts
  getAlerts: async (orgId: string): Promise<Array<{
    id: string;
    type: Audit['type'];
    severity: Audit['severity'];
    condition: string;
    threshold: number;
    timeWindow: number;
    timeUnit: "MINUTES" | "HOURS" | "DAYS";
    isActive: boolean;
    notificationChannels: Array<string>;
    createdAt: string;
  }>> => {
    const response = await apiClient.get<Array<{
    id: string;
    type: Audit['type'];
    severity: Audit['severity'];
    condition: string;
    threshold: number;
    timeWindow: number;
    timeUnit: "MINUTES" | "HOURS" | "DAYS";
    isActive: boolean;
    notificationChannels: Array<string>;
    createdAt: string;
  }>>(`/organizations/${orgId}/audit/alerts`);
    return response;
  },

  // Create audit alert
  createAlert: async (orgId: string, data: {
    type: Audit['type'];
    severity: Audit['severity'];
    condition: string;
    threshold: number;
    timeWindow: number;
    timeUnit: "MINUTES" | "HOURS" | "DAYS";
    notificationChannels: Array<string>;
  }): Promise<void> => {
    await apiClient.post(`/organizations/${orgId}/audit/alerts`, data);
  },

  // Update audit alert
  updateAlert: async (orgId: string, alertId: string, data: {
    type?: Audit['type'];
    severity?: Audit['severity'];
    condition?: string;
    threshold?: number;
    timeWindow?: number;
    timeUnit?: "MINUTES" | "HOURS" | "DAYS";
    notificationChannels?: Array<string>;
    isActive?: boolean;
  }): Promise<void> => {
    await apiClient.put(`/organizations/${orgId}/audit/alerts/${alertId}`, data);
  },

  // Delete audit alert
  deleteAlert: async (orgId: string, alertId: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/audit/alerts/${alertId}`);
  },

  // Purge old audit logs
  purge: async (orgId: string, data: {
    olderThan: string;
    severity?: Audit['severity'];
    type?: Audit['type'];
    keepCritical?: boolean;
  }): Promise<{
    deletedCount: number;
    totalSize: number;
  }> => {
    const response = await apiClient.post<{
    deletedCount: number;
    totalSize: number;
  }>(`/organizations/${orgId}/audit/purge`, data);
    return response;
  },
};
