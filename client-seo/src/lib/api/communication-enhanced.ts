import apiClient from "./client";

// Types
export interface CommunicationEnhanced {
  id: string;
  orgId: string;
  type: 'EMAIL' | 'SMS' | 'WHATSAPP' | 'PUSH' | 'IN_APP' | 'MAIL' | 'CALL';
  direction: 'INBOUND' | 'OUTBOUND';
  subject?: string;
  content: string;
  recipientId?: string;
  recipientType?: 'USER' | 'CONTACT' | 'LEAD' | 'AGENT' | 'TENANT';
  recipientEmail?: string;
  recipientPhone?: string;
  senderId?: string;
  senderType?: 'USER' | 'SYSTEM' | 'AGENT' | 'AUTOMATION';
  status: 'DRAFT' | 'QUEUED' | 'SENT' | 'DELIVERED' | 'FAILED' | 'BOUNCED' | 'OPENED' | 'CLICKED' | 'REPLIED';
  priority: 'LOW' | 'NORMAL' | 'HIGH' | 'URGENT';
  scheduledAt?: string;
  sentAt?: string;
  deliveredAt?: string;
  openedAt?: string;
  clickedAt?: string;
  failedAt?: string;
  failureReason?: string;
  metadata?: any;
  attachments?: any[];
  templateId?: string;
  campaignId?: string;
  automationId?: string;
  threadId?: string;
  parentId?: string;
  isRead: boolean;
  isArchived: boolean;
  isStarred: boolean;
  tags?: string[];
  externalId?: string;
  provider?: string;
  providerMessageId?: string;
  trackingEnabled: boolean;
  analytics?: {
    opens: number;
    clicks: number;
    forwards: number;
    bounces: number;
    spamReports: number;
    lastActivityAt?: string;
  };
  createdAt: string;
  updatedAt: string;
  deletedAt?: string;
  
  // Relations
  organization?: {
    id: string;
    name: string;
  };
  recipient?: {
    id: string;
    name: string;
    email?: string;
    phone?: string;
  };
  sender?: {
    id: string;
    name: string;
    email?: string;
  };
  template?: {
    id: string;
    name: string;
    type: string;
  };
  campaign?: {
    id: string;
    name: string;
    status: string;
  };
  automation?: {
    id: string;
    name: string;
    type: string;
  };
  thread?: {
    id: string;
    subject: string;
    messageCount: number;
  };
  replies?: CommunicationEnhanced[];
  parent?: CommunicationEnhanced;
}

export interface CommunicationAnalytics {
  total: number;
  sent: number;
  delivered: number;
  opened: number;
  clicked: number;
  failed: number;
  byType: Array<{
    type: string;
    count: number;
    rate: number;
  }>;
  byStatus: Array<{
    status: string;
    count: number;
    percentage: number;
  }>;
  byDate: Array<{
    date: string;
    sent: number;
    delivered: number;
    opened: number;
    clicked: number;
  }>;
  recentCommunications: CommunicationEnhanced[];
}

export interface CommunicationTemplate {
  id: string;
  orgId: string;
  name: string;
  type: 'EMAIL' | 'SMS' | 'WHATSAPP' | 'PUSH' | 'IN_APP';
  category: 'MARKETING' | 'TRANSACTIONAL' | 'NOTIFICATION' | 'REMINDER' | 'ALERT';
  subject?: string;
  content: string;
  htmlContent?: string;
  variables?: any;
  attachments?: any[];
  isActive: boolean;
  isDefault: boolean;
  usageCount: number;
  lastUsedAt?: string;
  createdAt: string;
  updatedAt: string;
  deletedAt?: string;
}

export interface CommunicationCampaign {
  id: string;
  orgId: string;
  name: string;
  type: 'EMAIL' | 'SMS' | 'WHATSAPP' | 'MULTI_CHANNEL';
  status: 'DRAFT' | 'SCHEDULED' | 'RUNNING' | 'COMPLETED' | 'PAUSED' | 'CANCELLED';
  description?: string;
  templateId?: string;
  audienceCriteria?: any;
  scheduledAt?: string;
  startedAt?: string;
  completedAt?: string;
  totalRecipients: number;
  sentCount: number;
  deliveredCount: number;
  openedCount: number;
  clickedCount: number;
  failedCount: number;
  budget?: number;
  cost?: number;
  metadata?: any;
  createdAt: string;
  updatedAt: string;
  deletedAt?: string;
}

// API Client
export const communicationEnhancedApi = {
  // Get all communications
  getCommunications: async (params?: {
    page?: number;
    limit?: number;
    orgId?: string;
    type?: string;
    direction?: string;
    status?: string;
    priority?: string;
    recipientId?: string;
    senderId?: string;
    templateId?: string;
    campaignId?: string;
    threadId?: string;
    startDate?: string;
    endDate?: string;
    search?: string;
    isRead?: boolean;
    isArchived?: boolean;
    isStarred?: boolean;
  }): Promise<{
    communications: CommunicationEnhanced[];
    pagination: {
      page: number;
      limit: number;
      total: number;
      totalPages: number;
    };
  }> => {
    const queryParams = new URLSearchParams();
    if (params) {
      Object.entries(params).forEach(([key, value]) => {
        if (value !== undefined) {
          queryParams.append(key, value.toString());
        }
      });
    }
    
    return await apiClient.get(`/communication-enhanced?${queryParams.toString()}`);
  },

  // Get single communication
  getCommunicationById: async (id: string): Promise<{ data: CommunicationEnhanced }> => {
    return await apiClient.get(`/communication-enhanced/${id}`);
  },

  // Create communication
  createCommunication: async (data: {
    orgId: string;
    type: 'EMAIL' | 'SMS' | 'WHATSAPP' | 'PUSH' | 'IN_APP' | 'MAIL' | 'CALL';
    direction: 'INBOUND' | 'OUTBOUND';
    subject?: string;
    content: string;
    recipientId?: string;
    recipientType?: 'USER' | 'CONTACT' | 'LEAD' | 'AGENT' | 'TENANT';
    recipientEmail?: string;
    recipientPhone?: string;
    senderId?: string;
    senderType?: 'USER' | 'SYSTEM' | 'AGENT' | 'AUTOMATION';
    priority?: 'LOW' | 'NORMAL' | 'HIGH' | 'URGENT';
    scheduledAt?: string;
    templateId?: string;
    campaignId?: string;
    automationId?: string;
    threadId?: string;
    parentId?: string;
    tags?: string[];
    externalId?: string;
    provider?: string;
    trackingEnabled?: boolean;
    attachments?: any[];
  }): Promise<{ data: CommunicationEnhanced }> => {
    return await apiClient.post('/communication-enhanced', data);
  },

  // Update communication
  updateCommunication: async (id: string, data: Partial<CommunicationEnhanced>): Promise<{ data: CommunicationEnhanced }> => {
    return await apiClient.put(`/communication-enhanced/${id}`, data);
  },

  // Delete communication
  deleteCommunication: async (id: string): Promise<void> => {
    return await apiClient.delete(`/communication-enhanced/${id}`);
  },

  // Send communication
  sendCommunication: async (id: string): Promise<{ data: CommunicationEnhanced }> => {
    return await apiClient.post(`/communication-enhanced/${id}/send`);
  },

  // Schedule communication
  scheduleCommunication: async (id: string, scheduledAt: string): Promise<{ data: CommunicationEnhanced }> => {
    return await apiClient.post(`/communication-enhanced/${id}/schedule`, { scheduledAt });
  },

  // Mark as read
  markAsRead: async (id: string): Promise<{ data: CommunicationEnhanced }> => {
    return await apiClient.put(`/communication-enhanced/${id}/read`);
  },

  // Mark as unread
  markAsUnread: async (id: string): Promise<{ data: CommunicationEnhanced }> => {
    return await apiClient.put(`/communication-enhanced/${id}/unread`);
  },

  // Archive communication
  archiveCommunication: async (id: string): Promise<{ data: CommunicationEnhanced }> => {
    return await apiClient.put(`/communication-enhanced/${id}/archive`);
  },

  // Unarchive communication
  unarchiveCommunication: async (id: string): Promise<{ data: CommunicationEnhanced }> => {
    return await apiClient.put(`/communication-enhanced/${id}/unarchive`);
  },

  // Star communication
  starCommunication: async (id: string): Promise<{ data: CommunicationEnhanced }> => {
    return await apiClient.put(`/communication-enhanced/${id}/star`);
  },

  // Unstar communication
  unstarCommunication: async (id: string): Promise<{ data: CommunicationEnhanced }> => {
    return await apiClient.put(`/communication-enhanced/${id}/unstar`);
  },

  // Get communication thread
  getThread: async (threadId: string): Promise<{
    communications: CommunicationEnhanced[];
    thread: {
      id: string;
      subject: string;
      messageCount: number;
      participants: any[];
    };
  }> => {
    return await apiClient.get(`/communication-enhanced/threads/${threadId}`);
  },

  // Get communication replies
  getReplies: async (id: string): Promise<{
    replies: CommunicationEnhanced[];
  }> => {
    return await apiClient.get(`/communication-enhanced/${id}/replies`);
  },

  // Reply to communication
  replyToCommunication: async (id: string, data: {
    content: string;
    type?: 'EMAIL' | 'SMS' | 'WHATSAPP' | 'IN_APP';
    attachments?: any[];
  }): Promise<{ data: CommunicationEnhanced }> => {
    return await apiClient.post(`/communication-enhanced/${id}/reply`, data);
  },

  // Forward communication
  forwardCommunication: async (id: string, data: {
    recipientId?: string;
    recipientEmail?: string;
    recipientPhone?: string;
    recipientType?: 'USER' | 'CONTACT' | 'LEAD' | 'AGENT' | 'TENANT';
    message?: string;
  }): Promise<{ data: CommunicationEnhanced }> => {
    return await apiClient.post(`/communication-enhanced/${id}/forward`, data);
  },

  // Get communication analytics
  getAnalytics: async (params?: {
    orgId?: string;
    type?: string;
    status?: string;
    startDate?: string;
    endDate?: string;
    groupBy?: 'day' | 'week' | 'month';
  }): Promise<CommunicationAnalytics> => {
    const queryParams = new URLSearchParams();
    if (params) {
      Object.entries(params).forEach(([key, value]) => {
        if (value !== undefined) {
          queryParams.append(key, value.toString());
        }
      });
    }
    
    return await apiClient.get(`/communication-enhanced/analytics?${queryParams.toString()}`);
  },

  // Get templates
  getTemplates: async (params?: {
    orgId?: string;
    type?: string;
    category?: string;
    isActive?: boolean;
    search?: string;
  }): Promise<{
    templates: CommunicationTemplate[];
  }> => {
    const queryParams = new URLSearchParams();
    if (params) {
      Object.entries(params).forEach(([key, value]) => {
        if (value !== undefined) {
          queryParams.append(key, value.toString());
        }
      });
    }
    
    return await apiClient.get(`/communication-enhanced/templates?${queryParams.toString()}`);
  },

  // Create template
  createTemplate: async (data: {
    orgId: string;
    name: string;
    type: 'EMAIL' | 'SMS' | 'WHATSAPP' | 'PUSH' | 'IN_APP';
    category: 'MARKETING' | 'TRANSACTIONAL' | 'NOTIFICATION' | 'REMINDER' | 'ALERT';
    subject?: string;
    content: string;
    htmlContent?: string;
    variables?: any;
    attachments?: any[];
    isActive?: boolean;
    isDefault?: boolean;
  }): Promise<{ data: CommunicationTemplate }> => {
    return await apiClient.post('/communication-enhanced/templates', data);
  },

  // Get campaigns
  getCampaigns: async (params?: {
    orgId?: string;
    type?: string;
    status?: string;
    startDate?: string;
    endDate?: string;
    search?: string;
  }): Promise<{
    campaigns: CommunicationCampaign[];
  }> => {
    const queryParams = new URLSearchParams();
    if (params) {
      Object.entries(params).forEach(([key, value]) => {
        if (value !== undefined) {
          queryParams.append(key, value.toString());
        }
      });
    }
    
    return await apiClient.get(`/communication-enhanced/campaigns?${queryParams.toString()}`);
  },

  // Create campaign
  createCampaign: async (data: {
    orgId: string;
    name: string;
    type: 'EMAIL' | 'SMS' | 'WHATSAPP' | 'MULTI_CHANNEL';
    description?: string;
    templateId?: string;
    audienceCriteria?: any;
    scheduledAt?: string;
    budget?: number;
    metadata?: any;
  }): Promise<{ data: CommunicationCampaign }> => {
    return await apiClient.post('/communication-enhanced/campaigns', data);
  },

  // Send test communication
  sendTest: async (data: {
    type: 'EMAIL' | 'SMS' | 'WHATSAPP' | 'PUSH' | 'IN_APP';
    recipientEmail?: string;
    recipientPhone?: string;
    subject?: string;
    content: string;
    templateId?: string;
  }): Promise<{ data: CommunicationEnhanced }> => {
    return await apiClient.post('/communication-enhanced/test', data);
  },

  // Bulk operations
  bulkMarkAsRead: async (communicationIds: string[]): Promise<{
    updated: number;
    failed: string[];
  }> => {
    return await apiClient.post('/communication-enhanced/bulk-mark-read', {
      communicationIds
    });
  },

  bulkArchive: async (communicationIds: string[]): Promise<{
    updated: number;
    failed: string[];
  }> => {
    return await apiClient.post('/communication-enhanced/bulk-archive', {
      communicationIds
    });
  },

  bulkDelete: async (communicationIds: string[]): Promise<{
    deleted: number;
    failed: string[];
  }> => {
    return await apiClient.post('/communication-enhanced/bulk-delete', {
      communicationIds
    });
  },

  // Export communications
  exportCommunications: async (params?: {
    orgId?: string;
    type?: string;
    status?: string;
    startDate?: string;
    endDate?: string;
    format?: 'csv' | 'excel' | 'json';
  }): Promise<{
    downloadUrl: string;
    expiresAt: string;
  }> => {
    const queryParams = new URLSearchParams();
    if (params) {
      Object.entries(params).forEach(([key, value]) => {
        if (value !== undefined) {
          queryParams.append(key, value.toString());
        }
      });
    }
    
    return await apiClient.get(`/communication-enhanced/export?${queryParams.toString()}`);
  }
};

export default communicationEnhancedApi;
