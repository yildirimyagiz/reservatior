import { apiClient } from "./client";

export interface CommunicationLogs {
  id: string;
  orgId: string;
  userId?: string;
  agentId?: string;
  type: "EMAIL" | "SMS" | "PUSH" | "IN_APP" | "PHONE_CALL" | "VIDEO_CALL" | "CHAT" | "SOCIAL_MEDIA" | "WEBHOOK" | "SYSTEM" | "CUSTOM";
  direction: "INBOUND" | "OUTBOUND" | "INTERNAL";
  status: "PENDING" | "SENT" | "DELIVERED" | "FAILED" | "BOUNCED" | "COMPLAINED" | "CANCELLED";
  priority: "LOW" | "NORMAL" | "HIGH" | "URGENT";
  subject: string;
  content: string;
  htmlContent?: string;
  attachments?: Array<{
    id: string;
    name: string;
    type: string;
    url: string;
    size: number;
    contentType: string;
  }>;
  metadata?: Record<string, any>;
  recipients?: Array<{
    id: string;
    type: string;
    value: string;
    name?: string;
    email?: string;
    phone?: string;
    deliveredAt?: string;
    openedAt?: string;
    clickedAt?: string;
    bouncedAt?: string;
    complainedAt?: string;
  }>;
  sender?: {
    id: string;
    type: string;
    value: string;
    name?: string;
    email?: string;
    phone?: string;
  };
  campaign?: {
    id: string;
    name: string;
    type: string;
    source?: string;
    medium?: string;
  };
  tracking?: {
    messageId?: string;
    externalId?: string;
    opens: number;
    clicks: number;
    forwards: number;
    bounces: number;
    complaints: number;
    lastEvent?: string;
    lastEventAt?: string;
  };
  errors?: Array<{
    code: string;
    message: string;
    details?: any;
    timestamp?: string;
  }>;
  scheduledAt?: string;
  sentAt?: string;
  deliveredAt?: string;
  openedAt?: string;
  clickedAt?: string;
  bouncedAt?: string;
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

// Define types to avoid array access issues
type CommunicationType = CommunicationLogs['type'];
type CommunicationDirection = CommunicationLogs['direction'];
type CommunicationStatus = CommunicationLogs['status'];
type CommunicationPriority = CommunicationLogs['priority'];

export const communicationLogsApi = {
  // Get all communication logs
  getAll: async (orgId: string): Promise<CommunicationLogs[]> => {
    const response = await apiClient.get<CommunicationLogs[]>(`/organizations/${orgId}/communication-logs`);
    return response;
  },

  // Get communication log by ID
  getById: async (orgId: string, id: string): Promise<CommunicationLogs> => {
    const response = await apiClient.get<CommunicationLogs>(`/organizations/${orgId}/communication-logs/${id}`);
    return response;
  },

  // Create communication log
  create: async (orgId: string, data: Omit<CommunicationLogs, 'id' | 'createdAt' | 'updatedAt' | 'user' | 'agent'>): Promise<CommunicationLogs> => {
    const response = await apiClient.post<CommunicationLogs>(`/organizations/${orgId}/communication-logs`, data);
    return response;
  },

  // Update communication log
  update: async (orgId: string, id: string, data: Partial<CommunicationLogs>): Promise<CommunicationLogs> => {
    const response = await apiClient.put<CommunicationLogs>(`/organizations/${orgId}/communication-logs/${id}`, data);
    return response;
  },

  // Delete communication log
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/communication-logs/${id}`);
  },

  // Get logs by user
  getByUser: async (orgId: string, userId: string): Promise<CommunicationLogs[]> => {
    const response = await apiClient.get<CommunicationLogs[]>(`/organizations/${orgId}/users/${userId}/communication-logs`);
    return response;
  },

  // Get logs by agent
  getByAgent: async (orgId: string, agentId: string): Promise<CommunicationLogs[]> => {
    const response = await apiClient.get<CommunicationLogs[]>(`/organizations/${orgId}/agents/${agentId}/communication-logs`);
    return response;
  },

  // Get logs by type
  getByType: async (orgId: string, type: CommunicationType): Promise<CommunicationLogs[]> => {
    const response = await apiClient.get<CommunicationLogs[]>(`/organizations/${orgId}/communication-logs`, {
      params: { type }
    });
    return response;
  },

  // Get logs by direction
  getByDirection: async (orgId: string, direction: CommunicationDirection): Promise<CommunicationLogs[]> => {
    const response = await apiClient.get<CommunicationLogs[]>(`/organizations/${orgId}/communication-logs`, {
      params: { direction }
    });
    return response;
  },

  // Get logs by status
  getByStatus: async (orgId: string, status: CommunicationStatus): Promise<CommunicationLogs[]> => {
    const response = await apiClient.get<CommunicationLogs[]>(`/organizations/${orgId}/communication-logs`, {
      params: { status }
    });
    return response;
  },

  // Get logs by priority
  getByPriority: async (orgId: string, priority: CommunicationPriority): Promise<CommunicationLogs[]> => {
    const response = await apiClient.get<CommunicationLogs[]>(`/organizations/${orgId}/communication-logs`, {
      params: { priority }
    });
    return response;
  },

  // Get logs by campaign
  getByCampaign: async (orgId: string, campaignId: string): Promise<CommunicationLogs[]> => {
    const response = await apiClient.get<CommunicationLogs[]>(`/organizations/${orgId}/campaigns/${campaignId}/communication-logs`);
    return response;
  },

  // Search communication logs
  search: async (orgId: string, query: string, filters?: {
    userId?: string;
    agentId?: string;
    type?: CommunicationType;
    direction?: CommunicationDirection;
    status?: CommunicationStatus;
    priority?: CommunicationPriority;
    startDate?: string;
    endDate?: string;
    campaignId?: string;
    subject?: string;
    content?: string;
  }): Promise<CommunicationLogs[]> => {
    const response = await apiClient.get<CommunicationLogs[]>(`/organizations/${orgId}/communication-logs/search`, {
      params: { query, ...filters }
    });
    return response;
  },

  // Get communication statistics
  getStatistics: async (orgId: string, filters?: {
    userId?: string;
    agentId?: string;
    type?: CommunicationType;
    direction?: CommunicationDirection;
    status?: CommunicationStatus;
    priority?: CommunicationPriority;
    startDate?: string;
    endDate?: string;
  }): Promise<{
    total: number;
    sent: number;
    delivered: number;
    opened: number;
    clicked: number;
    bounced: number;
    complained: number;
    byType: Record<string, number>;
    byDirection: Record<string, number>;
    byStatus: Record<string, number>;
    byPriority: Record<string, number>;
    byUser: Array<{
      userId?: string;
      agentId?: string;
      name: string;
      total: number;
      sent: number;
      delivered: number;
      opened: number;
      clicked: number;
    }>;
    byCampaign: Array<{
      campaignId: string;
      campaignName: string;
      total: number;
      sent: number;
      delivered: number;
      opened: number;
      clicked: number;
      conversionRate: number;
    }>;
    averageDeliveryTime: number;
    averageOpenRate: number;
    averageClickRate: number;
    trends: Array<{
      date: string;
      sent: number;
      delivered: number;
      opened: number;
      clicked: number;
    }>;
  }> => {
    const response = await apiClient.get<{
    total: number;
    sent: number;
    delivered: number;
    opened: number;
    clicked: number;
    bounced: number;
    complained: number;
    byType: Record<string, number>;
    byDirection: Record<string, number>;
    byStatus: Record<string, number>;
    byPriority: Record<string, number>;
    byUser: Array<{
      userId?: string;
      agentId?: string;
      name: string;
      total: number;
      sent: number;
      delivered: number;
      opened: number;
      clicked: number;
    }>;
    byCampaign: Array<{
      campaignId: string;
      campaignName: string;
      total: number;
      sent: number;
      delivered: number;
      opened: number;
      clicked: number;
      conversionRate: number;
    }>;
    averageDeliveryTime: number;
    averageOpenRate: number;
    averageClickRate: number;
    trends: Array<{
      date: string;
      sent: number;
      delivered: number;
      opened: number;
      clicked: number;
    }>;
  }>(`/organizations/${orgId}/communication-logs/statistics`, {
      params: { ...filters }
    });
    return response;
  },

  // Resend failed communication
  resend: async (orgId: string, id: string): Promise<CommunicationLogs> => {
    const response = await apiClient.post<CommunicationLogs>(`/organizations/${orgId}/communication-logs/${id}/resend`);
    return response;
  },

  // Update communication status
  updateStatus: async (orgId: string, id: string, data: {
    status: CommunicationStatus;
    deliveredAt?: string;
    openedAt?: string;
    clickedAt?: string;
    bouncedAt?: string;
    notes?: string;
  }): Promise<CommunicationLogs> => {
    const response = await apiClient.patch<CommunicationLogs>(`/organizations/${orgId}/communication-logs/${id}/status`, data);
    return response;
  },

  // Mark as opened
  markAsOpened: async (orgId: string, id: string, data: {
    openedAt: string;
    ipAddress?: string;
    userAgent?: string;
  }): Promise<CommunicationLogs> => {
    const response = await apiClient.patch<CommunicationLogs>(`/organizations/${orgId}/communication-logs/${id}/opened`, data);
    return response;
  },

  // Mark as clicked
  markAsClicked: async (orgId: string, id: string, data: {
    clickedAt: string;
    ipAddress?: string;
    userAgent?: string;
    link?: string;
  }): Promise<CommunicationLogs> => {
    const response = await apiClient.patch<CommunicationLogs>(`/organizations/${orgId}/communication-logs/${id}/clicked`, data);
    return response;
  },

  // Get tracking information
  getTracking: async (orgId: string, id: string): Promise<CommunicationLogs['tracking']> => {
    const response = await apiClient.get<CommunicationLogs['tracking']>(`/organizations/${orgId}/communication-logs/${id}/tracking`);
    return response;
  },

  // Update tracking information
  updateTracking: async (orgId: string, id: string, data: Partial<CommunicationLogs['tracking']>): Promise<CommunicationLogs> => {
    const response = await apiClient.patch<CommunicationLogs>(`/organizations/${orgId}/communication-logs/${id}/tracking`, data);
    return response;
  },

  // Export communication logs
  export: async (orgId: string, options: {
    userId?: string;
    agentId?: string;
    type?: CommunicationType;
    direction?: CommunicationDirection;
    status?: CommunicationStatus;
    priority?: CommunicationPriority;
    campaignId?: string;
    startDate?: string;
    endDate?: string;
    format: "CSV" | "EXCEL" | "JSON" | "PDF";
    includeAttachments?: boolean;
    includeTracking?: boolean;
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/communication-logs/export`, options, {
      responseType: 'blob'
    });
    return response;
  },

  // Bulk update communication logs
  bulkUpdate: async (orgId: string, updates: Array<{
    id: string;
    data: Partial<CommunicationLogs>;
  }>): Promise<CommunicationLogs[]> => {
    const response = await apiClient.patch<CommunicationLogs[]>(`/organizations/${orgId}/communication-logs/bulk`, { updates });
    return response;
  },

  // Archive communication logs
  archive: async (orgId: string, data: {
    olderThan: string;
    type?: CommunicationType;
    status?: CommunicationStatus;
    keepActive?: boolean;
  }): Promise<{
    archivedCount: number;
    totalSize: number;
  }> => {
    const response = await apiClient.post<{
    archivedCount: number;
    totalSize: number;
  }>(`/organizations/${orgId}/communication-logs/archive`, data);
    return response;
  },
};
