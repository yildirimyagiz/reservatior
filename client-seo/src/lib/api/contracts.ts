import { apiClient } from "./client";

export interface Contracts {
  id: string;
  orgId: string;
  title: string;
  type: "LEASE" | "SALE" | "PURCHASE" | "MANAGEMENT" | "SERVICE" | "COMMISSION" | "PARTNERSHIP" | "EMPLOYMENT" | "CUSTOM";
  status: "DRAFT" | "PENDING" | "ACTIVE" | "EXPIRED" | "TERMINATED" | "SUSPENDED" | "ARCHIVED";
  description?: string;
  parties: Array<{
    id: string;
    type: "LANDLORD" | "TENANT" | "BUYER" | "SELLER" | "AGENT" | "MANAGER" | "THIRD_PARTY" | "WITNESS" | "GUARANTOR";
    name: string;
    email?: string;
    phone?: string;
    address?: string;
    role?: string;
    signedAt?: string;
    signature?: {
      url: string;
      hash: string;
      ipAddress?: string;
      userAgent?: string;
    };
    isPrimary: boolean;
  }>;
  terms: {
    startDate: string;
    endDate?: string;
    duration?: number;
    durationUnit?: "DAYS" | "MONTHS" | "YEARS";
    renewalTerms?: {
      autoRenew: boolean;
      renewalPeriod: number;
      renewalUnit: "DAYS" | "MONTHS" | "YEARS";
      renewalNotice: number;
      renewalNoticeUnit: "DAYS" | "MONTHS";
    };
    termination?: {
      noticePeriod: number;
      noticeUnit: "DAYS" | "MONTHS";
      terminationFee?: number;
      terminationFeeType?: "FIXED" | "PERCENTAGE";
    };
  };
  financials: {
    amount?: number;
    currency: string;
    paymentFrequency?: "WEEKLY" | "BIWEEKLY" | "MONTHLY" | "QUARTERLY" | "YEARLY" | "ONETIME";
    paymentMethod?: string;
    deposit?: number;
    depositType?: "FIXED" | "PERCENTAGE";
    lateFees?: {
      enabled: boolean;
      feeAmount?: number;
      feeType?: "FIXED" | "PERCENTAGE";
      gracePeriod?: number;
    };
    escalation?: {
      enabled: boolean;
      rate: number;
      frequency: "ANNUAL" | "BIANNUAL";
      maxRate?: number;
    };
  };
  property?: {
    id: string;
    address: string;
    type: string;
    size?: number;
    bedrooms?: number;
    bathrooms?: number;
    parking?: number;
    amenities?: string[];
  };
  clauses: Array<{
    id: string;
    title: string;
    content: string;
    type: "STANDARD" | "CUSTOM" | "LEGAL" | "FINANCIAL" | "MAINTENANCE" | "UTILITIES" | "INSURANCE" | "LIABILITY";
    required: boolean;
    order: number;
    variables?: Record<string, any>;
  }>;
  attachments: Array<{
    id: string;
    name: string;
    type: string;
    url: string;
    size: number;
    category: "CONTRACT" | "SIGNATURE" | "IDENTITY" | "PROPERTY" | "FINANCIAL" | "OTHER";
    required: boolean;
    uploadedAt: string;
    uploadedBy: string;
  }>;
  signatures: Array<{
    id: string;
    partyId: string;
    partyName: string;
    partyType: "LANDLORD" | "TENANT" | "BUYER" | "SELLER" | "AGENT" | "MANAGER" | "THIRD_PARTY" | "WITNESS" | "GUARANTOR";
    status: "PENDING" | "SIGNED" | "DECLINED" | "EXPIRED";
    signatureUrl?: string;
    signatureHash?: string;
    ipAddress?: string;
    userAgent?: string;
    signedAt?: string;
    declinedAt?: string;
    declineReason?: string;
    isElectronic: boolean;
    witness?: {
      name: string;
      email?: string;
      signatureUrl?: string;
      signedAt?: string;
    };
  }>;
  compliance: {
    legalRequirements: Array<{
      requirement: string;
      status: "COMPLIANT" | "NON_COMPLIANT" | "PENDING";
      details?: string;
      lastChecked?: string;
    }>;
    disclosures: Array<{
      type: string;
      content: string;
      acknowledged: boolean;
      acknowledgedAt?: string;
      acknowledgedBy?: string;
    }>;
    regulations: Array<{
      name: string;
      jurisdiction: string;
      applicable: boolean;
      complianceStatus: "COMPLIANT" | "NON_COMPLIANT" | "EXEMPT";
      notes?: string;
    }>;
  };
  workflow: {
    currentStage: string;
    stages: Array<{
      name: string;
      status: "PENDING" | "IN_PROGRESS" | "COMPLETED" | "SKIPPED";
      assignedTo?: string;
      completedAt?: string;
      notes?: string;
    }>;
    nextAction?: {
      action: string;
      assignedTo?: string;
      dueDate?: string;
      priority: "LOW" | "MEDIUM" | "HIGH" | "URGENT";
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

// Define types to avoid array access issues
type ContractType = Contracts['type'];
type ContractStatus = Contracts['status'];
type PartyType = Contracts['parties'][0]['type'];
type ClauseType = Contracts['clauses'][0]['type'];
type AttachmentCategory = Contracts['attachments'][0]['category'];

export interface ContractGenerationRequest {
  country_code: string;
  contract_type: string;
  property: {
    id: string;
    address: string;
    city: string;
    country: string;
    price: number;
    currency: string;
    property_type: string;
  };
  owner: {
    full_name: string;
    identification_number: string;
    address: string;
    phone: string;
    email: string;
  };
  buyer_or_tenant: {
    full_name: string;
    identification_number: string;
    address: string;
    phone: string;
    email: string;
  };
  additional_terms?: string;
}

export interface ContractGenerationResponse {
  contract_id: string;
  content_markdown: string;
  country_applied: string;
  generated_at: string;
}


export const contractsApi = {
  // Generate Contract via ML-Services
  generate: async (data: ContractGenerationRequest): Promise<ContractGenerationResponse> => {
    const response = await apiClient.post<ContractGenerationResponse>("/api/v1/contracts/generate", data);
    return response as any;
  },

  // Get all contracts
  getAll: async (orgId: string): Promise<Contracts[]> => {
    const response = await apiClient.get<Contracts[]>(`/organizations/${orgId}/contracts`);
    return response;
  },

  // Get contract by ID
  getById: async (orgId: string, id: string): Promise<Contracts> => {
    const response = await apiClient.get<Contracts>(`/organizations/${orgId}/contracts/${id}`);
    return response;
  },

  // Create new contract
  create: async (orgId: string, data: Omit<Contracts, 'id' | 'createdAt' | 'updatedAt' | 'creator' | 'updater'>): Promise<Contracts> => {
    const response = await apiClient.post<Contracts>(`/organizations/${orgId}/contracts`, data);
    return response;
  },

  // Update contract
  update: async (orgId: string, id: string, data: Partial<Contracts>): Promise<Contracts> => {
    const response = await apiClient.put<Contracts>(`/organizations/${orgId}/contracts/${id}`, data);
    return response;
  },

  // Delete contract
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/contracts/${id}`);
  },

  // Get contracts by type
  getByType: async (orgId: string, type: ContractType): Promise<Contracts[]> => {
    const response = await apiClient.get<Contracts[]>(`/organizations/${orgId}/contracts`, {
      params: { type }
    });
    return response;
  },

  // Get contracts by status
  getByStatus: async (orgId: string, status: ContractStatus): Promise<Contracts[]> => {
    const response = await apiClient.get<Contracts[]>(`/organizations/${orgId}/contracts`, {
      params: { status }
    });
    return response;
  },

  // Get contracts by property
  getByProperty: async (orgId: string, propertyId: string): Promise<Contracts[]> => {
    const response = await apiClient.get<Contracts[]>(`/organizations/${orgId}/properties/${propertyId}/contracts`);
    return response;
  },

  // Get contracts by party
  getByParty: async (orgId: string, partyId: string): Promise<Contracts[]> => {
    const response = await apiClient.get<Contracts[]>(`/organizations/${orgId}/parties/${partyId}/contracts`);
    return response;
  },

  // Update contract status
  updateStatus: async (orgId: string, id: string, data: {
    status: ContractStatus;
    notes?: string;
    effectiveDate?: string;
  }): Promise<Contracts> => {
    const response = await apiClient.patch<Contracts>(`/organizations/${orgId}/contracts/${id}/status`, data);
    return response;
  },

  // Add party to contract
  addParty: async (orgId: string, id: string, data: {
    type: PartyType;
    name: string;
    email?: string;
    phone?: string;
    address?: string;
    role?: string;
    isPrimary?: boolean;
  }): Promise<Contracts> => {
    const response = await apiClient.post<Contracts>(`/organizations/${orgId}/contracts/${id}/parties`, data);
    return response;
  },

  // Update party
  updateParty: async (orgId: string, id: string, partyId: string, data: Partial<Contracts['parties'][0]>): Promise<Contracts> => {
    const response = await apiClient.put<Contracts>(`/organizations/${orgId}/contracts/${id}/parties/${partyId}`, data);
    return response;
  },

  // Remove party from contract
  removeParty: async (orgId: string, id: string, partyId: string): Promise<Contracts> => {
    const response = await apiClient.delete<Contracts>(`/organizations/${orgId}/contracts/${id}/parties/${partyId}`);
    return response;
  },

  // Sign contract
  sign: async (orgId: string, id: string, data: {
    partyId: string;
    signature?: string;
    ipAddress?: string;
    userAgent?: string;
    witness?: {
      name: string;
      email?: string;
      signature?: string;
    };
  }): Promise<Contracts> => {
    const response = await apiClient.post<Contracts>(`/organizations/${orgId}/contracts/${id}/sign`, data);
    return response;
  },

  // Request signature
  requestSignature: async (orgId: string, id: string, data: {
    partyId: string;
    message?: string;
    dueDate?: string;
    reminderSettings?: {
      enabled: boolean;
      frequency: number;
      unit: "HOURS" | "DAYS";
      maxReminders: number;
    };
  }): Promise<{
    success: boolean;
    requestId: string;
    expiresAt: string;
  }> => {
    const response = await apiClient.post<{
    success: boolean;
    requestId: string;
    expiresAt: string;
  }>(`/organizations/${orgId}/contracts/${id}/request-signature`, data);
    return response;
  },

  // Add clause to contract
  addClause: async (orgId: string, id: string, data: {
    title: string;
    content: string;
    type: ClauseType;
    required?: boolean;
    order?: number;
    variables?: Record<string, any>;
  }): Promise<Contracts> => {
    const response = await apiClient.post<Contracts>(`/organizations/${orgId}/contracts/${id}/clauses`, data);
    return response;
  },

  // Update clause
  updateClause: async (orgId: string, id: string, clauseId: string, data: Partial<Contracts['clauses'][0]>): Promise<Contracts> => {
    const response = await apiClient.put<Contracts>(`/organizations/${orgId}/contracts/${id}/clauses/${clauseId}`, data);
    return response;
  },

  // Remove clause from contract
  removeClause: async (orgId: string, id: string, clauseId: string): Promise<Contracts> => {
    const response = await apiClient.delete<Contracts>(`/organizations/${orgId}/contracts/${id}/clauses/${clauseId}`);
    return response;
  },

  // Add attachment to contract
  addAttachment: async (orgId: string, id: string, data: {
    name: string;
    file: File;
    category: AttachmentCategory;
    required?: boolean;
  }): Promise<Contracts> => {
    const formData = new FormData();
    formData.append('name', data.name);
    formData.append('file', data.file);
    formData.append('category', data.category);
    formData.append('required', String(data.required || false));

    const response = await apiClient.post<Contracts>(`/organizations/${orgId}/contracts/${id}/attachments`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    return response;
  },

  // Remove attachment from contract
  removeAttachment: async (orgId: string, id: string, attachmentId: string): Promise<Contracts> => {
    const response = await apiClient.delete<Contracts>(`/organizations/${orgId}/contracts/${id}/attachments/${attachmentId}`);
    return response;
  },

  // Get contract statistics
  getStatistics: async (orgId: string, filters?: {
    type?: ContractType;
    status?: ContractStatus;
    propertyId?: string;
    partyId?: string;
    startDate?: string;
    endDate?: string;
  }): Promise<{
    total: number;
    byType: Record<string, number>;
    byStatus: Record<string, number>;
    byProperty: Array<{
      propertyId: string;
      propertyAddress: string;
      contractCount: number;
      activeContracts: number;
      totalValue: number;
    }>;
    byParty: Array<{
      partyId: string;
      partyName: string;
      contractCount: number;
      activeContracts: number;
      totalValue: number;
    }>;
    averageValue: number;
    totalValue: number;
    expiringSoon: number;
    pendingSignatures: number;
    monthlyRevenue: number;
    annualRevenue: number;
  }> => {
    const response = await apiClient.get<{
    total: number;
    byType: Record<string, number>;
    byStatus: Record<string, number>;
    byProperty: Array<{
      propertyId: string;
      propertyAddress: string;
      contractCount: number;
      activeContracts: number;
      totalValue: number;
    }>;
    byParty: Array<{
      partyId: string;
      partyName: string;
      contractCount: number;
      activeContracts: number;
      totalValue: number;
    }>;
    averageValue: number;
    totalValue: number;
    expiringSoon: number;
    pendingSignatures: number;
    monthlyRevenue: number;
    annualRevenue: number;
  }>(`/organizations/${orgId}/contracts/statistics`, {
      params: { ...filters }
    });
    return response;
  },

  // Export contract
  export: async (orgId: string, id: string, options: {
    format: "PDF" | "DOC" | "HTML";
    includeSignatures?: boolean;
    includeAttachments?: boolean;
    includeClauses?: boolean;
    watermark?: boolean;
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/contracts/${id}/export`, options, {
      responseType: 'blob'
    });
    return response;
  },

  // Clone contract
  clone: async (orgId: string, id: string, data: {
    title: string;
    copyParties?: boolean;
    copyClauses?: boolean;
    copyAttachments?: boolean;
    copyFinancials?: boolean;
    startDate?: string;
    endDate?: string;
  }): Promise<Contracts> => {
    const response = await apiClient.post<Contracts>(`/organizations/${orgId}/contracts/${id}/clone`, data);
    return response;
  },

  // Get contract templates
  getTemplates: async (orgId: string): Promise<Array<{
    id: string;
    name: string;
    description?: string;
    type: ContractType;
    template: {
      clauses: Array<{
        title: string;
        content: string;
        type: ClauseType;
        required: boolean;
        order: number;
      }>;
      defaultTerms: Partial<Contracts['terms']>;
      defaultFinancials: Partial<Contracts['financials']>;
    };
    usageCount: number;
    isPublic: boolean;
    createdBy: string;
    createdAt: string;
  }>> => {
    const response = await apiClient.get<Array<{
    id: string;
    name: string;
    description?: string;
    type: ContractType;
    template: {
      clauses: Array<{
        title: string;
        content: string;
        type: ClauseType;
        required: boolean;
        order: number;
      }>;
      defaultTerms: Partial<Contracts['terms']>;
      defaultFinancials: Partial<Contracts['financials']>;
    };
    usageCount: number;
    isPublic: boolean;
    createdBy: string;
    createdAt: string;
  }>>(`/organizations/${orgId}/contracts/templates`);
    return response;
  },

  // Create contract from template
  createFromTemplate: async (orgId: string, data: {
    templateId: string;
    title: string;
    parties?: Array<{
      type: PartyType;
      name: string;
      email?: string;
      phone?: string;
      address?: string;
      role?: string;
    }>;
    propertyId?: string;
    customTerms?: Partial<Contracts['terms']>;
    customFinancials?: Partial<Contracts['financials']>;
    customClauses?: Array<{
      title: string;
      content: string;
      type: ClauseType;
      required?: boolean;
    }>;
  }): Promise<Contracts> => {
    const response = await apiClient.post<Contracts>(`/organizations/${orgId}/contracts/from-template`, data);
    return response;
  },
};
