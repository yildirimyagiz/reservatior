import { apiClient } from "./client";

export interface CrmExtended {
  id: string;
  orgId: string;
  name: string;
  type: "LEAD" | "CONTACT" | "ACCOUNT" | "OPPORTUNITY" | "DEAL" | "ACTIVITY" | "TASK" | "NOTE" | "CUSTOM";
  category: string;
  status: "NEW" | "CONTACTED" | "QUALIFIED" | "PROPOSAL" | "NEGOTIATION" | "WON" | "LOST" | "INACTIVE" | "ARCHIVED";
  priority: "LOW" | "MEDIUM" | "HIGH" | "URGENT";
  value?: number;
  currency?: string;
  probability?: number;
  expectedCloseDate?: string;
  actualCloseDate?: string;
  source?: string;
  campaign?: string;
  assignedTo?: string;
  assignedTeam?: string;
  parentCrmId?: string;
  tags?: Array<{
    id: string;
    name: string;
    color?: string;
  }>;
  customFields?: Record<string, any>;
  contactInfo: {
    firstName?: string;
    lastName?: string;
    email?: string;
    phone?: string;
    mobile?: string;
    fax?: string;
    website?: string;
    linkedIn?: string;
    facebook?: string;
    twitter?: string;
    address?: {
      street?: string;
      city?: string;
      state?: string;
      zipCode?: string;
      country?: string;
      latitude?: number;
      longitude?: number;
    };
    company?: {
      name?: string;
      industry?: string;
      size?: string;
      revenue?: number;
      website?: string;
      address?: {
        street?: string;
        city?: string;
        state?: string;
        zipCode?: string;
        country?: string;
      };
    };
    preferences?: {
      contactMethod?: "EMAIL" | "PHONE" | "SMS" | "MAIL" | "IN_PERSON";
      contactTime?: string;
      timezone?: string;
      language?: string;
      doNotCall?: boolean;
      doNotEmail?: boolean;
      doNotSms?: boolean;
    };
  };
  activities: Array<{
    id: string;
    type: "CALL" | "EMAIL" | "MEETING" | "TASK" | "NOTE" | "DEMO" | "PRESENTATION" | "SITE_VISIT" | "CUSTOM";
    subject?: string;
    description: string;
    direction?: "INBOUND" | "OUTBOUND";
    status: "PLANNED" | "COMPLETED" | "CANCELLED";
    priority: "LOW" | "MEDIUM" | "HIGH" | "URGENT";
    duration?: number;
    location?: string;
    attendees?: Array<{
      id: string;
      name: string;
      email?: string;
      role: string;
      status: "ACCEPTED" | "DECLINED" | "TENTATIVE" | "NEEDS_ACTION";
    }>;
    attachments?: Array<{
      id: string;
      name: string;
      type: string;
      url: string;
      size: number;
    }>;
    createdBy: string;
    assignedTo?: string;
    scheduledAt?: string;
    completedAt?: string;
    createdAt: string;
    updatedAt: string;
  }>;
  opportunities?: Array<{
    id: string;
    name: string;
    description?: string;
    value: number;
    currency: string;
    probability: number;
    stage: string;
    expectedCloseDate: string;
    source?: string;
    assignedTo?: string;
    products?: Array<{
      id: string;
      name: string;
      quantity: number;
      unitPrice: number;
      totalPrice: number;
    }>;
    competitors?: Array<{
      name: string;
      strengths?: string[];
      weaknesses?: string[];
      status: string;
    }>;
    createdAt: string;
    updatedAt: string;
  }>;
  deals?: Array<{
    id: string;
    name: string;
    description?: string;
    value: number;
    currency: string;
    probability: number;
    stage: string;
    expectedCloseDate: string;
    actualCloseDate?: string;
    status: "ACTIVE" | "WON" | "LOST" | "PAUSED";
    source?: string;
    assignedTo?: string;
    lostReason?: string;
    wonAmount?: number;
    commission?: number;
    commissionRate?: number;
    products?: Array<{
      id: string;
      name: string;
      quantity: number;
      unitPrice: number;
      totalPrice: number;
    }>;
    timeline?: Array<{
      date: string;
      action: string;
      description: string;
      createdBy: string;
    }>;
    createdAt: string;
    updatedAt: string;
  }>;
  documents?: Array<{
    id: string;
    name: string;
    type: string;
    url: string;
    size: number;
    category: string;
    description?: string;
    uploadedAt: string;
    uploadedBy: string;
  }>;
  interactions: Array<{
    id: string;
    type: "PHONE_CALL" | "EMAIL" | "MEETING" | "SOCIAL_MEDIA" | "WEBSITE_VISIT" | "FORM_SUBMISSION" | "EVENT_ATTENDANCE" | "REFERRAL" | "CUSTOM";
    direction: "INBOUND" | "OUTBOUND";
    subject?: string;
    content: string;
    outcome?: string;
    nextAction?: string;
    nextActionDate?: string;
    ipAddress?: string;
    userAgent?: string;
    source?: string;
    campaign?: string;
    createdBy: string;
    createdAt: string;
  }>;
  analytics: {
    totalActivities: number;
    totalInteractions: number;
    totalOpportunities: number;
    totalDeals: number;
    wonDeals: number;
    lostDeals: number;
    totalValue: number;
    wonValue: number;
    lostValue: number;
    conversionRate: number;
    averageDealSize: number;
    averageSalesCycle: number;
    lastActivityAt?: string;
    nextFollowUpAt?: string;
    engagementScore: number;
    riskScore: number;
    trends: Array<{
      period: string;
      activities: number;
      interactions: number;
      opportunities: number;
      deals: number;
      value: number;
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

export const crmExtendedApi = {
  // Get all CRM records
  getAll: async (orgId: string): Promise<CrmExtended[]> => {
    return await apiClient.get(`/organizations/${orgId}/crm-extended`);
  },

  // Get CRM record by ID
  getById: async (orgId: string, id: string): Promise<CrmExtended> => {
    return await apiClient.get(`/organizations/${orgId}/crm-extended/${id}`);
  },

  // Create new CRM record
  create: async (orgId: string, data: Omit<CrmExtended, 'id' | 'createdAt' | 'updatedAt' | 'creator' | 'updater' | 'analytics'>): Promise<CrmExtended> => {
    return await apiClient.post(`/organizations/${orgId}/crm-extended`, data);
  },

  // Update CRM record
  update: async (orgId: string, id: string, data: Partial<CrmExtended>): Promise<CrmExtended> => {
    return await apiClient.put(`/organizations/${orgId}/crm-extended/${id}`, data);
  },

  // Delete CRM record
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/crm-extended/${id}`);
  },

  // Get CRM records by type
  getByType: async (orgId: string, type: CrmExtended['type']): Promise<CrmExtended[]> => {
    return await apiClient.get(`/organizations/${orgId}/crm-extended`, {
      params: { type }
    });
  },

  // Get CRM records by status
  getByStatus: async (orgId: string, status: CrmExtended['status']): Promise<CrmExtended[]> => {
    return await apiClient.get(`/organizations/${orgId}/crm-extended`, {
      params: { status }
    });
  },

  // Get CRM records by assigned user
  getByAssignedUser: async (orgId: string, userId: string): Promise<CrmExtended[]> => {
    return await apiClient.get(`/organizations/${orgId}/users/${userId}/crm-extended`);
  },

  // Get CRM records by assigned team
  getByAssignedTeam: async (orgId: string, teamId: string): Promise<CrmExtended[]> => {
    return await apiClient.get(`/organizations/${orgId}/teams/${teamId}/crm-extended`);
  },

  // Search CRM records
  search: async (orgId: string, query: string, filters?: {
    type?: CrmExtended['type'];
    status?: CrmExtended['status'];
    priority?: CrmExtended['priority'];
    assignedTo?: string;
    assignedTeam?: string;
    source?: string;
    campaign?: string;
    startDate?: string;
    endDate?: string;
    minValue?: number;
    maxValue?: number;
    tags?: string[];
  }): Promise<CrmExtended[]> => {
    return await apiClient.get(`/organizations/${orgId}/crm-extended/search`, {
      params: { query, ...filters }
    });
  },

  // Update CRM record status
  updateStatus: async (orgId: string, id: string, data: {
    status: CrmExtended['status'];
    notes?: string;
    actualCloseDate?: string;
    lostReason?: string;
    wonAmount?: number;
  }): Promise<CrmExtended> => {
    return await apiClient.patch(`/organizations/${orgId}/crm-extended/${id}/status`, data);
  },

  // Assign CRM record
  assign: async (orgId: string, id: string, data: {
    assignedTo?: string;
    assignedTeam?: string;
    priority?: CrmExtended['priority'];
    notes?: string;
  }): Promise<CrmExtended> => {
    return await apiClient.patch(`/organizations/${orgId}/crm-extended/${id}/assign`, data);
  },

  // Add activity to CRM record
  addActivity: async (orgId: string, id: string, data: {
    type: CrmExtended['activities'][0]['type'];
    subject?: string;
    description: string;
    direction?: CrmExtended['activities'][0]['direction'];
    status: CrmExtended['activities'][0]['status'];
    priority: CrmExtended['activities'][0]['priority'];
    duration?: number;
    location?: string;
    scheduledAt?: string;
    assignedTo?: string;
    attachments?: Array<{
      name: string;
      file: File;
    }>;
  }): Promise<CrmExtended> => {
    const formData = new FormData();
    formData.append('type', data.type);
    if (data.subject) formData.append('subject', data.subject);
    formData.append('description', data.description);
    if (data.direction) formData.append('direction', data.direction);
    formData.append('status', data.status);
    formData.append('priority', data.priority);
    if (data.duration) formData.append('duration', String(data.duration));
    if (data.location) formData.append('location', data.location);
    if (data.scheduledAt) formData.append('scheduledAt', data.scheduledAt);
    if (data.assignedTo) formData.append('assignedTo', data.assignedTo);

    if (data.attachments) {
      data.attachments.forEach((attachment, index) => {
        formData.append(`attachments[${index}].name`, attachment.name);
        formData.append(`attachments[${index}].file`, attachment.file);
      });
    }

    const response = await fetch(`${apiClient['baseURL']}/organizations/${orgId}/crm-extended/${id}/activities`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${localStorage.getItem("auth_token")}`,
      },
      body: formData
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    return await response.json() as CrmExtended;
  },

  // Get CRM record activities
  getActivities: async (orgId: string, id: string, filters?: {
    type?: CrmExtended['activities'][0]['type'];
    status?: CrmExtended['activities'][0]['status'];
    startDate?: string;
    endDate?: string;
    assignedTo?: string;
  }): Promise<CrmExtended['activities']> => {
    return await apiClient.get(`/organizations/${orgId}/crm-extended/${id}/activities`, {
      params: { ...filters }
    });
  },

  // Add opportunity to CRM record
  addOpportunity: async (orgId: string, id: string, data: {
    name: string;
    description?: string;
    value: number;
    currency: string;
    probability: number;
    stage: string;
    expectedCloseDate: string;
    source?: string;
    assignedTo?: string;
    products?: Array<{
      id: string;
      name: string;
      quantity: number;
      unitPrice: number;
    }>;
    competitors?: Array<{
      name: string;
      strengths?: string[];
      weaknesses?: string[];
      status: string;
    }>;
  }): Promise<CrmExtended> => {
    return await apiClient.post(`/organizations/${orgId}/crm-extended/${id}/opportunities`, data);
  },

  // Get CRM record opportunities
  getOpportunities: async (orgId: string, id: string): Promise<CrmExtended['opportunities']> => {
    return await apiClient.get(`/organizations/${orgId}/crm-extended/${id}/opportunities`);
  },

  // Add deal to CRM record
  addDeal: async (orgId: string, id: string, data: {
    name: string;
    description?: string;
    value: number;
    currency: string;
    probability: number;
    stage: string;
    expectedCloseDate: string;
    source?: string;
    assignedTo?: string;
    products?: Array<{
      id: string;
      name: string;
      quantity: number;
      unitPrice: number;
    }>;
    commissionRate?: number;
  }): Promise<CrmExtended> => {
    return await apiClient.post(`/organizations/${orgId}/crm-extended/${id}/deals`, data);
  },

  // Get CRM record deals
  getDeals: async (orgId: string, id: string): Promise<CrmExtended['deals']> => {
    return await apiClient.get(`/organizations/${orgId}/crm-extended/${id}/deals`);
  },

  // Get CRM analytics
  getAnalytics: async (orgId: string, filters?: {
    type?: CrmExtended['type'];
    status?: CrmExtended['status'];
    assignedTo?: string;
    assignedTeam?: string;
    startDate?: string;
    endDate?: string;
  }): Promise<{
    totalRecords: number;
    byType: Record<string, number>;
    byStatus: Record<string, number>;
    byPriority: Record<string, number>;
    byAssignedUser: Array<{
      userId: string;
      userName: string;
      recordCount: number;
      activities: number;
      interactions: number;
      opportunities: number;
      deals: number;
      totalValue: number;
    }>;
    byAssignedTeam: Array<{
      teamId: string;
      teamName: string;
      recordCount: number;
      activities: number;
      interactions: number;
      opportunities: number;
      deals: number;
      totalValue: number;
    }>;
    conversionMetrics: {
      leadToOpportunity: number;
      opportunityToDeal: number;
      dealToWin: number;
      overall: number;
    };
    performanceMetrics: {
      averageDealSize: number;
      averageSalesCycle: number;
      winRate: number;
      totalRevenue: number;
      averageActivitiesPerRecord: number;
    };
    trends: Array<{
      date: string;
      newRecords: number;
      activities: number;
      interactions: number;
      opportunities: number;
      deals: number;
      revenue: number;
    }>;
  }> => {
    return await apiClient.get(`/organizations/${orgId}/crm-extended/analytics`, {
      params: { ...filters }
    });
  },

  // Export CRM records
  export: async (orgId: string, options: {
    type?: CrmExtended['type'];
    status?: CrmExtended['status'];
    assignedTo?: string;
    assignedTeam?: string;
    startDate?: string;
    endDate?: string;
    format: "CSV" | "EXCEL" | "JSON" | "PDF";
    includeActivities?: boolean;
    includeOpportunities?: boolean;
    includeDeals?: boolean;
    includeDocuments?: boolean;
  }): Promise<Blob> => {
    const response = await fetch(`${apiClient['baseURL']}/organizations/${orgId}/crm-extended/export`, {
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

  // Import CRM records
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

    const response = await fetch(`${apiClient['baseURL']}/organizations/${orgId}/crm-extended/import`, {
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
