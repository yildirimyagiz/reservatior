import { apiClient } from "./client";

// Lead Conversion Types
export type ConversionType = "INQUIRY" | "VIEWING" | "OFFER" | "SALE";
export type ConversionStatus = "NEW" | "CONTACTED" | "QUALIFIED" | "CONVERTED" | "LOST";
export type LeadSource = "VALUATION" | "VIDEO" | "LISTING" | "WEBSITE" | "REFERRAL" | "ADVERTISEMENT" | "SOCIAL_MEDIA" | "OTHER";

export interface LeadConversion {
  id: string;
  valuationId?: string;
  agentId?: string;
  userId?: string;
  propertyId?: string;
  orgId: string;
  conversionType: ConversionType;
  status: ConversionStatus;
  source: LeadSource;
  priority: "LOW" | "NORMAL" | "HIGH" | "URGENT";
  value: number;
  commissionAmount?: number;
  commissionRate?: number;
  conversionDate?: string;
  expectedClosingDate?: string;
  actualClosingDate?: string;
  notes?: string;
  tags: string[];
  metadata?: Record<string, any>;
  
  // Lead Information
  leadInfo: {
    firstName: string;
    lastName: string;
    email: string;
    phone?: string;
    preferredContact: "EMAIL" | "PHONE" | "TEXT";
    budget?: number;
    timeline?: string;
    propertyCriteria?: {
      propertyTypes: string[];
      locations: string[];
      priceRange: {
        min: number;
        max: number;
      };
      bedrooms?: number;
      bathrooms?: number;
      features?: string[];
    };
  };
  
  // Tracking
  tracking: {
    firstContactDate: string;
    lastContactDate: string;
    contactCount: number;
    responseTime: number; // minutes
    engagementScore: number; // 0-100
    conversionProbability: number; // 0-100
  };
  
  // Follow-up Management
  followUp: {
    nextAction?: string;
    nextActionDate?: string;
    reminders: Array<{
      id: string;
      type: "CALL" | "EMAIL" | "TEXT" | "MEETING" | "TASK";
      scheduledFor: string;
      completed: boolean;
      completedAt?: string;
      notes?: string;
    }>;
    activities: Array<{
      id: string;
      type: "CALL" | "EMAIL" | "TEXT" | "MEETING" | "VIEWING" | "OFFER" | "NOTE";
      description: string;
      createdAt: string;
      createdBy: string;
      outcome?: string;
    }>;
  };
  
  // Financial
  financial: {
    offerPrice?: number;
    acceptedPrice?: number;
    depositAmount?: number;
    financingType?: "CASH" | "CONVENTIONAL" | "FHA" | "VA" | "OTHER";
    preApproved?: boolean;
    preApprovalAmount?: number;
  };
  
  // Closing Details
  closing: {
    attorney?: string;
    titleCompany?: string;
    inspectionDate?: string;
    appraisalDate?: string;
    financingContingency?: string;
    homeSaleContingency?: string;
    closingDate?: string;
    possessionDate?: string;
  };
  
  createdAt: string;
  updatedAt: string;
  
  // Relations
  valuation?: {
    id: string;
    value: number;
    confidence?: number;
    valuationDate: string;
    property?: {
      id: string;
      name: string;
      addressLine1: string;
      city: string;
      state: string;
      zip: string;
      areaSqm: number;
      bedrooms: number;
      bathrooms: number;
    };
  };
  agent?: {
    id: string;
    name: string;
    email: string;
    phoneNumber?: string;
    licenseNumber?: string;
    experienceLevel?: string;
    commission?: {
      rate: number;
      structure: "PERCENTAGE" | "FLAT" | "HYBRID";
    };
  };
  user?: {
    id: string;
    name: string;
    email: string;
    phone?: string;
  };
  property?: {
    id: string;
    name: string;
    addressLine1: string;
    city: string;
    state: string;
    zip: string;
    type: string;
    status: string;
    price: number;
    areaSqm: number;
    bedrooms: number;
    bathrooms: number;
  };
  organization?: {
    id: string;
    name: string;
    type: string;
  };
}

export const leadConversionsApi = {
  // Basic CRUD
  getAll: async (params?: { 
    page?: number; 
    limit?: number; 
    valuationId?: string; 
    agentId?: string; 
    userId?: string; 
    propertyId?: string; 
    conversionType?: ConversionType; 
    status?: ConversionStatus;
    source?: LeadSource;
    priority?: string;
    startDate?: string;
    endDate?: string;
    orgId?: string;
    search?: string;
  }) => {
    return await apiClient.get("/lead-conversions", { params });
  },
  
  getById: async (id: string): Promise<LeadConversion> => {
    return await apiClient.get(`/lead-conversions/${id}`);
  },
  
  create: async (data: Partial<LeadConversion>): Promise<LeadConversion> => {
    return await apiClient.post("/lead-conversions", data);
  },
  
  update: async (id: string, data: Partial<LeadConversion>): Promise<LeadConversion> => {
    return await apiClient.put(`/lead-conversions/${id}`, data);
  },
  
  delete: async (id: string): Promise<void> => {
    await apiClient.delete(`/lead-conversions/${id}`);
  },

  // Status Management
  updateStatus: async (id: string, status: ConversionStatus, notes?: string): Promise<LeadConversion> => {
    return await apiClient.patch(`/lead-conversions/${id}/status`, { status, notes });
  },
  
  convertToSale: async (id: string, data: {
    salePrice: number;
    commissionRate?: number;
    closingDate?: string;
    possessionDate?: string;
    notes?: string;
  }): Promise<LeadConversion> => {
    return await apiClient.post(`/lead-conversions/${id}/convert`, data);
  },
  
  markAsLost: async (id: string, reason: string, notes?: string): Promise<LeadConversion> => {
    return await apiClient.post(`/lead-conversions/${id}/lost`, { reason, notes });
  },

  // Follow-up Management
  addFollowUp: async (id: string, data: {
    type: "CALL" | "EMAIL" | "TEXT" | "MEETING" | "TASK";
    scheduledFor: string;
    notes?: string;
    priority?: "LOW" | "NORMAL" | "HIGH";
  }): Promise<any> => {
    return await apiClient.post(`/lead-conversions/${id}/follow-up`, data);
  },
  
  completeFollowUp: async (id: string, followUpId: string, outcome?: string, notes?: string): Promise<any> => {
    return await apiClient.patch(`/lead-conversions/${id}/follow-up/${followUpId}`, { outcome, notes });
  },
  
  getFollowUpHistory: async (id: string): Promise<any[]> => {
    return await apiClient.get(`/lead-conversions/${id}/follow-up-history`);
  },
  
  scheduleFollowUp: async (id: string, data: {
    action: string;
    scheduledDate: string;
    reminder?: boolean;
    notes?: string;
  }): Promise<any> => {
    return await apiClient.post(`/lead-conversions/${id}/schedule-follow-up`, data);
  },

  // Activities & Notes
  addActivity: async (id: string, data: {
    type: "CALL" | "EMAIL" | "TEXT" | "MEETING" | "VIEWING" | "OFFER" | "NOTE";
    description: string;
    outcome?: string;
    nextAction?: string;
  }): Promise<any> => {
    return await apiClient.post(`/lead-conversions/${id}/activities`, data);
  },
  
  getActivities: async (id: string, params?: {
    type?: string;
    startDate?: string;
    endDate?: string;
    page?: number;
    limit?: number;
  }): Promise<any[]> => {
    return await apiClient.get(`/lead-conversions/${id}/activities`, { params });
  },

  // Analytics & Statistics
  getStats: async (params?: { 
    agentId?: string; 
    startDate?: string; 
    endDate?: string;
    orgId?: string;
    conversionType?: ConversionType;
  }): Promise<{
    totalLeads: number;
    convertedLeads: number;
    conversionRate: number;
    averageConversionTime: number;
    totalValue: number;
    totalCommission: number;
    leadsByStatus: Record<ConversionStatus, number>;
    leadsByType: Record<ConversionType, number>;
    leadsBySource: Record<LeadSource, number>;
    conversionFunnel: Array<{
      stage: string;
      count: number;
      conversionRate: number;
    }>;
    topPerformers: Array<{
      agentId: string;
      agentName: string;
      conversionCount: number;
      conversionRate: number;
      totalValue: number;
    }>;
    monthlyTrends: Array<{
      month: string;
      leads: number;
      conversions: number;
      value: number;
    }>;
  }> => {
    return await apiClient.get("/lead-conversions/stats", { params });
  },
  
  getAnalytics: async (id: string): Promise<{
    engagementScore: number;
    conversionProbability: number;
    responseTime: number;
    contactFrequency: number;
    bestContactTime: string;
    riskFactors: Array<{
      factor: string;
      level: "LOW" | "MEDIUM" | "HIGH";
      description: string;
    }>;
    recommendations: Array<{
      action: string;
      priority: "LOW" | "NORMAL" | "HIGH";
      reasoning: string;
    }>;
  }> => {
    return await apiClient.get(`/lead-conversions/${id}/analytics`);
  },

  // Bulk Operations
  bulkUpdate: async (data: {
    ids: string[];
    updates: Partial<LeadConversion>;
  }): Promise<{
    updated: number;
    failed: Array<{
      id: string;
      error: string;
    }>;
  }> => {
    return await apiClient.post("/lead-conversions/bulk-update", data);
  },
  
  bulkAssign: async (data: {
    ids: string[];
    agentId: string;
    reason?: string;
  }): Promise<{
    assigned: number;
    failed: Array<{
      id: string;
      error: string;
    }>;
  }> => {
    return await apiClient.post("/lead-conversions/bulk-assign", data);
  },

  // Communication
  sendEmail: async (id: string, data: {
    templateId?: string;
    subject: string;
    content: string;
    attachments?: File[];
  }): Promise<any> => {
    const formData = new FormData();
    formData.append("subject", data.subject);
    formData.append("content", data.content);
    if (data.templateId) formData.append("templateId", data.templateId);
    if (data.attachments) {
      data.attachments.forEach((file, index) => {
        formData.append(`attachment_${index}`, file);
      });
    }

    return await apiClient.post(`/lead-conversions/${id}/email`, formData);
  },
  
  sendText: async (id: string, data: {
    message: string;
    templateId?: string;
  }): Promise<any> => {
    return await apiClient.post(`/lead-conversions/${id}/text`, data);
  },
  
  logCall: async (id: string, data: {
    duration: number;
    outcome: string;
    notes?: string;
    nextAction?: string;
  }): Promise<any> => {
    return await apiClient.post(`/lead-conversions/${id}/call`, data);
  },

  // Search & Filtering
  search: async (query: string, filters?: {
    conversionType?: ConversionType;
    status?: ConversionStatus;
    source?: LeadSource;
    agentId?: string;
    dateRange?: {
      start: string;
      end: string;
    };
    valueRange?: {
      min: number;
      max: number;
    };
  }): Promise<{
    leads: LeadConversion[];
    total: number;
    suggestions?: string[];
  }> => {
    return await apiClient.get("/lead-conversions/search", { 
      params: { query, ...filters } 
    });
  },

  // Export
  export: async (params: {
    format: "CSV" | "EXCEL" | "PDF";
    filters?: {
      agentId?: string;
      conversionType?: ConversionType;
      status?: ConversionStatus;
      startDate?: string;
      endDate?: string;
    };
    fields?: string[];
  }): Promise<Blob> => {
    const response = await fetch(`${apiClient['baseURL']}/lead-conversions/export`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${typeof window !== "undefined" ? localStorage.getItem("auth_token") : ""}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(params)
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    return await response.blob();
  },

  // Automation & Workflows
  triggerWorkflow: async (id: string, workflowId: string, data?: any): Promise<any> => {
    return await apiClient.post(`/lead-conversions/${id}/workflows/${workflowId}/trigger`, data);
  },
  
  getWorkflows: async (params?: { status?: string }): Promise<any[]> => {
    return await apiClient.get("/lead-conversions/workflows", { params });
  },

  // Integration with Valuations
  createFromValuation: async (valuationId: string, data: {
    conversionType: ConversionType;
    priority?: string;
    notes?: string;
    assignToAgent?: string;
  }): Promise<LeadConversion> => {
    return await apiClient.post(`/valuations/${valuationId}/create-lead`, data);
  },
  
  getRelatedValuations: async (id: string): Promise<any[]> => {
    return await apiClient.get(`/lead-conversions/${id}/related-valuations`);
  },
};
