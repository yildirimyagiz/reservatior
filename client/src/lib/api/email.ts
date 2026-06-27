import { apiClient } from "./client";

export interface Email {
  id: string;
  orgId: string;
  from: {
    email: string;
    name?: string;
    userId?: string;
  };
  to: Array<{
    email: string;
    name?: string;
    userId?: string;
    type: "TO" | "CC" | "BCC";
  }>;
  subject: string;
  body: {
    text: string;
    html?: string;
    attachments?: Array<{
      id: string;
      name: string;
      type: string;
      size: number;
      url: string;
      inline?: boolean;
      contentId?: string;
    }>;
  };
  replyTo?: {
    email: string;
    name?: string;
  };
  cc?: Array<{
    email: string;
    name?: string;
    userId?: string;
  }>;
  bcc?: Array<{
    email: string;
    name?: string;
    userId?: string;
  }>;
  priority: "LOW" | "NORMAL" | "HIGH" | "URGENT";
  status: "DRAFT" | "QUEUED" | "SENDING" | "SENT" | "DELIVERED" | "FAILED" | "BOUNCED" | "COMPLAINED" | "CANCELLED";
  delivery: {
    attempts: number;
    lastAttempt?: string;
    nextRetry?: string;
    maxRetries?: number;
    bounceType?: "HARD" | "SOFT" | "TRANSIENT";
    bounceReason?: string;
    complaintReason?: string;
    deliveredAt?: string;
    openedAt?: string;
    clickedAt?: string;
    unsubscribedAt?: string;
  };
  tracking: {
    opens: Array<{
      timestamp: string;
      ipAddress?: string;
      userAgent?: string;
      location?: {
        country?: string;
        city?: string;
      };
    }>;
    clicks: Array<{
      timestamp: string;
      url: string;
      ipAddress?: string;
      userAgent?: string;
      location?: {
        country?: string;
        city?: string;
      };
    }>;
    bounces: Array<{
      timestamp: string;
      type: "HARD" | "SOFT" | "TRANSIENT";
      reason: string;
      details?: string;
    }>;
    complaints: Array<{
      timestamp: string;
      reason: string;
      feedback?: string;
    }>;
  };
  campaign?: {
    id: string;
    name: string;
    type: string;
    source?: string;
    medium?: string;
  };
  template?: {
    id: string;
    name: string;
    variables?: Record<string, any>;
  };
  scheduling?: {
    scheduledAt?: string;
    timezone?: string;
    recurring?: {
      enabled: boolean;
      frequency: "DAILY" | "WEEKLY" | "MONTHLY" | "YEARLY";
      dayOfWeek?: number;
      dayOfMonth?: number;
      endDate?: string;
    };
  };
  security: {
    dkim: {
      enabled: boolean;
      verified: boolean;
      domain?: string;
    };
    spf: {
      enabled: boolean;
      verified: boolean;
      result?: "PASS" | "FAIL" | "NEUTRAL";
    };
    dmarc: {
      enabled: boolean;
      verified: boolean;
      result?: "PASS" | "FAIL" | "NEUTRAL";
    };
    encryption: {
      enabled: boolean;
      type?: "TLS" | "SSL" | "STARTTLS";
    };
  };
  metadata?: Record<string, any>;
  tags?: Array<{
    id: string;
    name: string;
    color?: string;
  }>;
  createdAt: string;
  updatedAt: string;
  sentAt?: string;
  createdBy: string;
  updatedBy?: string;
  parentEmailId?: string;
  threadId?: string;
  inReplyTo?: string;
  references?: string[];
  archivedAt?: string;
  deletedAt?: string;
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

export const emailApi = {
  // Get all emails
  getAll: async (orgId: string): Promise<Email[]> => {
    return await apiClient.get(`/organizations/${orgId}/email`);
  },

  // Get email by ID
  getById: async (orgId: string, id: string): Promise<Email> => {
    return await apiClient.get(`/organizations/${orgId}/email/${id}`);
  },

  // Send email
  send: async (orgId: string, data: {
    from?: {
      email: string;
      name?: string;
    };
    to: Array<{
      email: string;
      name?: string;
      type?: "TO" | "CC" | "BCC";
    }>;
    cc?: Array<{
      email: string;
      name?: string;
    }>;
    bcc?: Array<{
      email: string;
      name?: string;
    }>;
    subject: string;
    body: {
      text: string;
      html?: string;
    };
    attachments?: Array<{
      name: string;
      file: File;
      inline?: boolean;
      contentId?: string;
    }>;
    replyTo?: {
      email: string;
      name?: string;
    };
    priority?: Email['priority'];
    template?: {
      id: string;
      variables?: Record<string, any>;
    };
    campaign?: {
      id: string;
      name?: string;
      type?: string;
      source?: string;
      medium?: string;
    };
    metadata?: Record<string, any>;
    tags?: Array<{
      name: string;
      color?: string;
    }>;
    scheduling?: {
      scheduledAt?: string;
      timezone?: string;
      recurring?: {
        enabled: boolean;
        frequency: "DAILY" | "WEEKLY" | "MONTHLY" | "YEARLY";
        dayOfWeek?: number;
        dayOfMonth?: number;
        endDate?: string;
      };
    };
  }): Promise<Email> => {
    const formData = new FormData();
    
    if (data.from) {
      formData.append('from.email', data.from.email);
      if (data.from.name) formData.append('from.name', data.from.name);
    }
    
    data.to.forEach((recipient, index) => {
      formData.append(`to[${index}].email`, recipient.email);
      if (recipient.name) formData.append(`to[${index}].name`, recipient.name);
      formData.append(`to[${index}].type`, recipient.type || 'TO');
    });
    
    if (data.cc) {
      data.cc.forEach((recipient, index) => {
        formData.append(`cc[${index}].email`, recipient.email);
        if (recipient.name) formData.append(`cc[${index}].name`, recipient.name);
      });
    }
    
    if (data.bcc) {
      data.bcc.forEach((recipient, index) => {
        formData.append(`bcc[${index}].email`, recipient.email);
        if (recipient.name) formData.append(`bcc[${index}].name`, recipient.name);
      });
    }
    
    formData.append('subject', data.subject);
    formData.append('body.text', data.body.text);
    if (data.body.html) formData.append('body.html', data.body.html);
    
    if (data.attachments) {
      data.attachments.forEach((attachment, index) => {
        formData.append(`attachments[${index}].name`, attachment.name);
        formData.append(`attachments[${index}].file`, attachment.file);
        if (attachment.inline) formData.append(`attachments[${index}].inline`, String(attachment.inline));
        if (attachment.contentId) formData.append(`attachments[${index}].contentId`, attachment.contentId);
      });
    }
    
    if (data.replyTo) {
      formData.append('replyTo.email', data.replyTo.email);
      if (data.replyTo.name) formData.append('replyTo.name', data.replyTo.name);
    }
    
    if (data.priority) formData.append('priority', data.priority);
    
    if (data.template) {
      formData.append('template.id', data.template.id);
      if (data.template.variables) formData.append('template.variables', JSON.stringify(data.template.variables));
    }
    
    if (data.campaign) {
      formData.append('campaign.id', data.campaign.id);
      if (data.campaign.name) formData.append('campaign.name', data.campaign.name);
      if (data.campaign.type) formData.append('campaign.type', data.campaign.type);
      if (data.campaign.source) formData.append('campaign.source', data.campaign.source);
      if (data.campaign.medium) formData.append('campaign.medium', data.campaign.medium);
    }
    
    if (data.metadata) formData.append('metadata', JSON.stringify(data.metadata));
    
    if (data.tags) {
      data.tags.forEach((tag, index) => {
        formData.append(`tags[${index}].name`, tag.name);
        if (tag.color) formData.append(`tags[${index}].color`, tag.color);
      });
    }
    
    if (data.scheduling) {
      if (data.scheduling.scheduledAt) formData.append('scheduling.scheduledAt', data.scheduling.scheduledAt);
      if (data.scheduling.timezone) formData.append('scheduling.timezone', data.scheduling.timezone);
      if (data.scheduling.recurring) {
        formData.append('scheduling.recurring.enabled', String(data.scheduling.recurring.enabled));
        formData.append('scheduling.recurring.frequency', data.scheduling.recurring.frequency);
        if (data.scheduling.recurring.dayOfWeek) formData.append('scheduling.recurring.dayOfWeek', String(data.scheduling.recurring.dayOfWeek));
        if (data.scheduling.recurring.dayOfMonth) formData.append('scheduling.recurring.dayOfMonth', String(data.scheduling.recurring.dayOfMonth));
        if (data.scheduling.recurring.endDate) formData.append('scheduling.recurring.endDate', data.scheduling.recurring.endDate);
      }
    }

    return await apiClient.post(`/organizations/${orgId}/email`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
  },

  // Update email
  update: async (orgId: string, id: string, data: Partial<Email>): Promise<Email> => {
    return await apiClient.put(`/organizations/${orgId}/email/${id}`, data);
  },

  // Delete email
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/email/${id}`);
  },

  // Get emails by status
  getByStatus: async (orgId: string, status: Email['status']): Promise<Email[]> => {
    return await apiClient.get(`/organizations/${orgId}/email`, {
      params: { status }
    });
  },

  // Get emails by campaign
  getByCampaign: async (orgId: string, campaignId: string): Promise<Email[]> => {
    return await apiClient.get(`/organizations/${orgId}/campaigns/${campaignId}/email`);
  },

  // Get emails by thread
  getByThread: async (orgId: string, threadId: string): Promise<Email[]> => {
    return await apiClient.get(`/organizations/${orgId}/email/threads/${threadId}`);
  },

  // Get sent emails
  getSent: async (orgId: string, filters?: {
    startDate?: string;
    endDate?: string;
    from?: string;
    to?: string;
    subject?: string;
    campaignId?: string;
  }): Promise<Email[]> => {
    return await apiClient.get(`/organizations/${orgId}/email/sent`, {
      params: { ...filters }
    });
  },

  // Get received emails
  getReceived: async (orgId: string, filters?: {
    startDate?: string;
    endDate?: string;
    from?: string;
    to?: string;
    subject?: string;
    campaignId?: string;
  }): Promise<Email[]> => {
    return await apiClient.get(`/organizations/${orgId}/email/received`, {
      params: { ...filters }
    });
  },

  // Search emails
  search: async (orgId: string, query: string, filters?: {
    status?: Email['status'];
    priority?: Email['priority'];
    from?: string;
    to?: string;
    subject?: string;
    body?: string;
    campaignId?: string;
    startDate?: string;
    endDate?: string;
    hasAttachments?: boolean;
  }): Promise<Email[]> => {
    return await apiClient.get(`/organizations/${orgId}/email/search`, {
      params: { query, ...filters }
    });
  },

  // Reply to email
  reply: async (orgId: string, id: string, data: {
    to: Array<{
      email: string;
      name?: string;
      type?: "TO" | "CC" | "BCC";
    }>;
    cc?: Array<{
      email: string;
      name?: string;
    }>;
    bcc?: Array<{
      email: string;
      name?: string;
    }>;
    subject: string;
    body: {
      text: string;
      html?: string;
    };
    attachments?: Array<{
      name: string;
      file: File;
      inline?: boolean;
      contentId?: string;
    }>;
    priority?: Email['priority'];
  }): Promise<Email> => {
    const formData = new FormData();
    
    data.to.forEach((recipient, index) => {
      formData.append(`to[${index}].email`, recipient.email);
      if (recipient.name) formData.append(`to[${index}].name`, recipient.name);
      formData.append(`to[${index}].type`, recipient.type || 'TO');
    });
    
    if (data.cc) {
      data.cc.forEach((recipient, index) => {
        formData.append(`cc[${index}].email`, recipient.email);
        if (recipient.name) formData.append(`cc[${index}].name`, recipient.name);
      });
    }
    
    if (data.bcc) {
      data.bcc.forEach((recipient, index) => {
        formData.append(`bcc[${index}].email`, recipient.email);
        if (recipient.name) formData.append(`bcc[${index}].name`, recipient.name);
      });
    }
    
    formData.append('subject', data.subject);
    formData.append('body.text', data.body.text);
    if (data.body.html) formData.append('body.html', data.body.html);
    
    if (data.attachments) {
      data.attachments.forEach((attachment, index) => {
        formData.append(`attachments[${index}].name`, attachment.name);
        formData.append(`attachments[${index}].file`, attachment.file);
        if (attachment.inline) formData.append(`attachments[${index}].inline`, String(attachment.inline));
        if (attachment.contentId) formData.append(`attachments[${index}].contentId`, attachment.contentId);
      });
    }
    
    if (data.priority) formData.append('priority', data.priority);

    return await apiClient.post(`/organizations/${orgId}/email/${id}/reply`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
  },

  // Forward email
  forward: async (orgId: string, id: string, data: {
    to: Array<{
      email: string;
      name?: string;
      type?: "TO" | "CC" | "BCC";
    }>;
    cc?: Array<{
      email: string;
      name?: string;
    }>;
    bcc?: Array<{
      email: string;
      name?: string;
    }>;
    subject: string;
    body: {
      text: string;
      html?: string;
    };
    attachments?: Array<{
      name: string;
      file: File;
      inline?: boolean;
      contentId?: string;
    }>;
    priority?: Email['priority'];
    includeOriginal?: boolean;
  }): Promise<Email> => {
    const formData = new FormData();
    
    data.to.forEach((recipient, index) => {
      formData.append(`to[${index}].email`, recipient.email);
      if (recipient.name) formData.append(`to[${index}].name`, recipient.name);
      formData.append(`to[${index}].type`, recipient.type || 'TO');
    });
    
    if (data.cc) {
      data.cc.forEach((recipient, index) => {
        formData.append(`cc[${index}].email`, recipient.email);
        if (recipient.name) formData.append(`cc[${index}].name`, recipient.name);
      });
    }
    
    if (data.bcc) {
      data.bcc.forEach((recipient, index) => {
        formData.append(`bcc[${index}].email`, recipient.email);
        if (recipient.name) formData.append(`bcc[${index}].name`, recipient.name);
      });
    }
    
    formData.append('subject', data.subject);
    formData.append('body.text', data.body.text);
    if (data.body.html) formData.append('body.html', data.body.html);
    
    if (data.attachments) {
      data.attachments.forEach((attachment, index) => {
        formData.append(`attachments[${index}].name`, attachment.name);
        formData.append(`attachments[${index}].file`, attachment.file);
        if (attachment.inline) formData.append(`attachments[${index}].inline`, String(attachment.inline));
        if (attachment.contentId) formData.append(`attachments[${index}].contentId`, attachment.contentId);
      });
    }
    
    if (data.priority) formData.append('priority', data.priority);
    formData.append('includeOriginal', String(data.includeOriginal || false));

    return await apiClient.post(`/organizations/${orgId}/email/${id}/forward`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
  },

  // Resend email
  resend: async (orgId: string, id: string, data: {
    to?: Array<{
      email: string;
      name?: string;
    }>;
    subject?: string;
    body?: string;
  }): Promise<Email> => {
    return await apiClient.post(`/organizations/${orgId}/email/${id}/resend`, data);
  },

  // Cancel email
  cancel: async (orgId: string, id: string): Promise<Email> => {
    return await apiClient.post(`/organizations/${orgId}/email/${id}/cancel`);
  },

  // Get email statistics
  getStatistics: async (orgId: string, filters?: {
    status?: Email['status'];
    priority?: Email['priority'];
    campaignId?: string;
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
    byStatus: Record<string, number>;
    byPriority: Record<string, number>;
    byCampaign: Array<{
      campaignId: string;
      campaignName: string;
      sent: number;
      delivered: number;
      opened: number;
      clicked: number;
      bounced: number;
      complained: number;
    }>;
    byDate: Array<{
      date: string;
      sent: number;
      delivered: number;
      opened: number;
      clicked: number;
      bounced: number;
      complained: number;
    }>;
    averageDeliveryTime: number;
    averageOpenRate: number;
    averageClickRate: number;
    bounceRate: number;
    complaintRate: number;
  }> => {
    return await apiClient.get(`/organizations/${orgId}/email/statistics`, {
      params: { ...filters }
    });
  },

  // Export emails
  exportEmails: async (orgId: string, options: {
    format: "CSV" | "EXCEL" | "JSON";
    filters?: {
      status?: Email['status'];
      priority?: Email['priority'];
      from?: string;
      to?: string;
      subject?: string;
      campaignId?: string;
      startDate?: string;
      endDate?: string;
      hasAttachments?: boolean;
    };
  }): Promise<Blob> => {
    const response = await fetch(`${apiClient['baseURL']}/organizations/${orgId}/email/export`, {
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
};
