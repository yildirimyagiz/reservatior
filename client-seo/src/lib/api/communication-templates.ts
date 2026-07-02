import { apiClient } from "./client";

export interface CommunicationTemplates {
  id: string;
  orgId: string;
  name: string;
  type: "EMAIL" | "SMS" | "PUSH" | "IN_APP" | "LETTER" | "SOCIAL_MEDIA" | "CUSTOM";
  category: "MARKETING" | "TRANSACTIONAL" | "NOTIFICATION" | "REMINDER" | "SURVEY" | "FEEDBACK" | "LEGAL" | "CUSTOM";
  subject: string;
  content: string;
  htmlContent?: string;
  variables?: Array<{
    name: string;
    type: string;
    description?: string;
    defaultValue?: any;
    required: boolean;
  }>;
  attachments?: Array<{
    id: string;
    name: string;
    type: string;
    url: string;
    isVariable: boolean;
    content?: string;
  }>;
  settings: {
    fromEmail?: string;
    fromName?: string;
    replyTo?: string;
    cc?: string;
    bcc?: string;
    priority?: "LOW" | "NORMAL" | "HIGH" | "URGENT";
    trackOpens?: boolean;
    trackClicks?: boolean;
    trackDeliveries?: boolean;
    schedule?: {
      enabled: boolean;
      timezone?: string;
      sendTime?: string;
      recurring?: {
        enabled: boolean;
        frequency: "DAILY" | "WEEKLY" | "MONTHLY" | "YEARLY";
        dayOfWeek?: number;
        dayOfMonth?: number;
        endDate?: string;
      };
    };
    unsubscribeLink?: boolean;
    footer?: string;
    header?: string;
  };
  design: {
    template?: string;
    theme?: string;
    colors?: {
      primary?: string;
      secondary?: string;
      text?: string;
      background?: string;
    };
    fonts?: {
      heading?: string;
      body?: string;
    };
    logo?: {
      url?: string;
      width?: number;
      height?: number;
      alignment?: "LEFT" | "CENTER" | "RIGHT";
    };
  };
  usage: {
    totalSent: number;
    totalDelivered: number;
    totalOpened: number;
    totalClicked: number;
    totalUnsubscribed: number;
    averageOpenRate: number;
    averageClickRate: number;
    lastUsedAt?: string;
  };
  isActive: boolean;
  isDefault: boolean;
  approvalStatus: "PENDING" | "APPROVED" | "REJECTED" | "ARCHIVED";
  approvedBy?: string;
  approvedAt?: string;
  createdAt: string;
  updatedAt: string;
  createdBy?: string;
}

export const communicationTemplatesApi = {
  // Get all communication templates
  getAll: async (orgId: string): Promise<CommunicationTemplates[]> => {
    const response = await apiClient.get<CommunicationTemplates[]>(`/organizations/${orgId}/communication-templates`);
    return response;
  },

  // Get communication template by ID
  getById: async (orgId: string, id: string): Promise<CommunicationTemplates> => {
    const response = await apiClient.get<CommunicationTemplates>(`/organizations/${orgId}/communication-templates/${id}`);
    return response;
  },

  // Create new communication template
  create: async (orgId: string, data: Omit<CommunicationTemplates, 'id' | 'createdAt' | 'updatedAt' | 'usage' | 'createdBy'>): Promise<CommunicationTemplates> => {
    const response = await apiClient.post<CommunicationTemplates>(`/organizations/${orgId}/communication-templates`, data);
    return response;
  },

  // Update communication template
  update: async (orgId: string, id: string, data: Partial<CommunicationTemplates>): Promise<CommunicationTemplates> => {
    const response = await apiClient.put<CommunicationTemplates>(`/organizations/${orgId}/communication-templates/${id}`, data);
    return response;
  },

  // Delete communication template
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/communication-templates/${id}`);
  },

  // Get templates by type
  getByType: async (orgId: string, type: "EMAIL" | "SMS" | "PUSH" | "IN_APP" | "LETTER" | "SOCIAL_MEDIA" | "CUSTOM"): Promise<CommunicationTemplates[]> => {
    const response = await apiClient.get<CommunicationTemplates[]>(`/organizations/${orgId}/communication-templates`, {
      params: { type }
    });
    return response;
  },

  // Get templates by category
  getByCategory: async (orgId: string, category: "MARKETING" | "TRANSACTIONAL" | "NOTIFICATION" | "REMINDER" | "SURVEY" | "FEEDBACK" | "LEGAL" | "CUSTOM"): Promise<CommunicationTemplates[]> => {
    const response = await apiClient.get<CommunicationTemplates[]>(`/organizations/${orgId}/communication-templates`, {
      params: { category }
    });
    return response;
  },

  // Search templates
  search: async (orgId: string, query: string, filters?: {
    type?: "EMAIL" | "SMS" | "PUSH" | "IN_APP" | "LETTER" | "SOCIAL_MEDIA" | "CUSTOM";
    category?: "MARKETING" | "TRANSACTIONAL" | "NOTIFICATION" | "REMINDER" | "SURVEY" | "FEEDBACK" | "LEGAL" | "CUSTOM";
    isActive?: boolean;
    isDefault?: boolean;
    approvalStatus?: "PENDING" | "APPROVED" | "REJECTED" | "ARCHIVED";
  }): Promise<CommunicationTemplates[]> => {
    const response = await apiClient.get<CommunicationTemplates[]>(`/organizations/${orgId}/communication-templates/search`, {
      params: { query, ...filters }
    });
    return response;
  },

  // Preview template
  preview: async (orgId: string, id: string, data?: {
    variables?: Record<string, any>;
    locale?: string;
    testMode?: boolean;
    testData?: Record<string, any>;
  }): Promise<{
    subject: string;
    content: string;
    htmlContent?: string;
    renderedContent?: string;
    variables?: Record<string, any>;
  }> => {
    const response = await apiClient.post<{
      subject: string;
      content: string;
      htmlContent?: string;
      renderedContent?: string;
      variables?: Record<string, any>;
    }>(`/organizations/${orgId}/communication-templates/${id}/preview`, data);
    return response;
  },

  // Send test email
  sendTestEmail: async (orgId: string, id: string, data: {
    to: string;
    variables?: Record<string, any>;
    locale?: string;
  attachments?: Array<{
      name: string;
      file: File;
    }>;
  }): Promise<{
    success: boolean;
    messageId?: string;
    error?: string;
    deliveryTime?: number;
  }> => {
    const formData = new FormData();
    formData.append('to', data.to);
    if (data.variables) formData.append('variables', JSON.stringify(data.variables));
    if (data.locale) formData.append('locale', data.locale);
    
    if (data.attachments) {
      data.attachments.forEach((attachment, index) => {
        formData.append(`attachments[${index}].name`, attachment.name);
        formData.append(`attachments[${index}].file`, attachment.file);
      });
    }

    const response = await apiClient.post<{
    success: boolean;
    messageId?: string;
    error?: string;
    deliveryTime?: number;
  }>(`/organizations/${orgId}/communication-templates/${id}/send-test`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    return response;
  },

  // Clone template
  clone: async (orgId: string, id: string, data: {
    name: string;
    description?: string;
  }): Promise<CommunicationTemplates> => {
    const response = await apiClient.post<CommunicationTemplates>(`/organizations/${orgId}/communication-templates/${id}/clone`, data);
    return response;
  },

  // Update template status
  updateStatus: async (orgId: string, id: string, data: {
    isActive: boolean;
  isDefault?: boolean;
  }): Promise<CommunicationTemplates> => {
    const response = await apiClient.patch<CommunicationTemplates>(`/organizations/${orgId}/communication-templates/${id}/status`, data);
    return response;
  },

  // Submit for approval
  submitForApproval: async (orgId: string, id: string, data?: {
    notes?: string;
    priority?: "LOW" | "NORMAL" | "HIGH";
  }): Promise<CommunicationTemplates> => {
    const response = await apiClient.post<CommunicationTemplates>(`/organizations/${orgId}/communication-templates/${id}/submit-approval`, data);
    return response;
  },

  // Approve template
  approve: async (orgId: string, id: string, data?: {
    notes?: string;
    approvedBy?: string;
  }): Promise<CommunicationTemplates> => {
    const response = await apiClient.post<CommunicationTemplates>(`/organizations/${orgId}/communication-templates/${id}/approve`, data);
    return response;
  },

  // Reject template
  reject: async (orgId: string, id: string, data: {
    reason: string;
    notes?: string;
    rejectedBy?: string;
  }): Promise<CommunicationTemplates> => {
    const response = await apiClient.post<CommunicationTemplates>(`/organizations/${orgId}/communication-templates/${id}/reject`, data);
    return response;
  },

  // Get template usage statistics
  getUsageStatistics: async (orgId: string, id: string, filters?: {
    startDate?: string;
    endDate?: string;
    channel?: string;
  campaign?: string;
  }): Promise<{
    totalSent: number;
    totalDelivered: number;
    totalOpened: number;
    totalClicked: number;
    totalUnsubscribed: number;
    averageOpenRate: number;
    averageClickRate: number;
    averageDeliveryTime: number;
    byDate: Array<{
      date: string;
      sent: number;
      delivered: number;
      opened: number;
      clicked: number;
    }>;
    byChannel: Record<string, number>;
    topPerformingVariants: Array<{
      variantId: string;
      variantName: string;
      sent: number;
      opened: number;
      clicked: number;
      conversionRate: number;
    }>;
    geolocation: Array<{
      country: string;
      city: string;
      sent: number;
      opened: number;
      clicked: number;
    }>;
  }> => {
    const response = await apiClient.get<{
    totalSent: number;
    totalDelivered: number;
    totalOpened: number;
    totalClicked: number;
    totalUnsubscribed: number;
    averageOpenRate: number;
    averageClickRate: number;
    averageDeliveryTime: number;
    byDate: Array<{
      date: string;
      sent: number;
      delivered: number;
      opened: number;
      clicked: number;
    }>;
    byChannel: Record<string, number>;
    topPerformingVariants: Array<{
      variantId: string;
      variantName: string;
      sent: number;
      opened: number;
      clicked: number;
      conversionRate: number;
    }>;
    geolocation: Array<{
      country: string;
      city: string;
      sent: number;
      opened: number;
      clicked: number;
    }>;
  }>(`/organizations/${orgId}/communication-templates/${id}/usage-statistics`, {
      params: { ...filters }
    });
    return response;
  },

  // Get template versions
  getVersions: async (orgId: string, id: string): Promise<Array<{
    id: string;
    version: string;
    changes: string;
    createdBy: string;
    createdAt: string;
    isActive: boolean;
  }>> => {
    const response = await apiClient.get<Array<{
    id: string;
    version: string;
    changes: string;
    createdBy: string;
    createdAt: string;
    isActive: boolean;
  }>>(`/organizations/${orgId}/communication-templates/${id}/versions`);
    return response;
  },

  // Create template version
  createVersion: async (orgId: string, id: string, data: {
    version: string;
    changes: string;
    notes?: string;
    makeActive?: boolean;
  }): Promise<void> => {
    await apiClient.post(`/organizations/${orgId}/communication-templates/${id}/versions`, data);
  },

  // Restore template version
  restoreVersion: async (orgId: string, id: string, versionId: string): Promise<CommunicationTemplates> => {
    const response = await apiClient.post<CommunicationTemplates>(`/organizations/${orgId}/communication-templates/${id}/versions/${versionId}/restore`);
    return response;
  },

  // Export templates
  export: async (orgId: string, options: {
    type?: "EMAIL" | "SMS" | "PUSH" | "IN_APP" | "LETTER" | "SOCIAL_MEDIA" | "CUSTOM";
    category?: "MARKETING" | "TRANSACTIONAL" | "NOTIFICATION" | "REMINDER" | "SURVEY" | "FEEDBACK" | "LEGAL" | "CUSTOM";
    isActive?: boolean;
    approvalStatus?: "PENDING" | "APPROVED" | "REJECTED" | "ARCHIVED";
    format: "CSV" | "EXCEL" | "JSON";
    includeUsage?: boolean;
    includeVersions?: boolean;
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/communication-templates/export`, options, {
      responseType: 'blob'
    });
    return response;
  },

  // Import templates
  import: async (orgId: string, data: {
    format: "CSV" | "EXCEL" | "JSON";
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

    const response = await apiClient.post<{
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
  }>(`/organizations/${orgId}/communication-templates/import`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    return response;
  },
};
