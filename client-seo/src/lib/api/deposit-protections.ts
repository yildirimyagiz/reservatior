import { apiClient } from "./client";

export interface DepositProtections {
  id: string;
  orgId: string;
  propertyId?: string;
  tenantId?: string;
  landlordId?: string;
  type: "SECURITY_DEPOSIT" | "RENTAL_DEPOSIT" | "PET_DEPOSIT" | "UTILITY_DEPOSIT" | "MAINTENANCE_DEPOSIT" | "CUSTOM";
  status: "PENDING" | "HELD" | "PARTIAL_RELEASE" | "FULL_RELEASE" | "FORFEITED" | "DISPUTED" | "REFUNDED";
  amount: number;
  currency: string;
  paymentMethod?: string;
  paymentDate?: string;
  paymentReference?: string;
  terms: {
    depositAmount: number;
    depositType: string;
    conditions: Array<{
      condition: string;
      description: string;
      met: boolean;
      evidence?: Array<{
        id: string;
        type: string;
        url: string;
        description?: string;
        uploadedAt: string;
        uploadedBy: string;
      }>;
      metAt?: string;
    }>;
    releaseConditions: Array<{
      condition: string;
      description: string;
      required: boolean;
      timeframe?: number;
      timeframeUnit?: "DAYS" | "WEEKS" | "MONTHS" | "YEARS";
    }>;
    interestRate?: number;
    interestCalculation?: "SIMPLE" | "COMPOUND";
    interestPaymentSchedule?: "MONTHLY" | "QUARTERLY" | "YEARLY" | "AT_RELEASE";
  };
  timeline: Array<{
    id: string;
    action: "COLLECTED" | "HELD" | "PARTIAL_RELEASE" | "FULL_RELEASE" | "FORFEITED" | "DISPUTE_OPENED" | "DISPUTE_RESOLVED" | "INTEREST_ACCRUED" | "INTEREST_PAID";
    amount?: number;
    description: string;
    performedBy: string;
    performedAt: string;
    evidence?: Array<{
      id: string;
      type: string;
      url: string;
      description?: string;
      uploadedAt: string;
      uploadedBy: string;
    }>;
    nextAction?: string;
    nextActionDue?: string;
  }>;
  disputes: Array<{
    id: string;
    type: "DAMAGE" | "UNPAID_RENT" | "CLEANING" | "EARLY_TERMINATION" | "OTHER";
    status: "OPEN" | "INVESTIGATION" | "MEDIATION" | "RESOLVED" | "CLOSED";
    description: string;
    claimAmount?: number;
    evidence: Array<{
      id: string;
      type: string;
      url: string;
      description?: string;
      uploadedAt: string;
      uploadedBy: string;
    }>;
    raisedBy: string;
    raisedAt: string;
    resolvedBy?: string;
    resolvedAt?: string;
    resolution?: string;
    actualAmount?: number;
  }>;
  releases: Array<{
    id: string;
    amount: number;
    reason: string;
    description?: string;
    releasedBy: string;
    releasedAt: string;
    paymentMethod?: string;
    paymentReference?: string;
    bankAccount?: {
      accountHolder: string;
      accountNumber: string;
      sortCode?: string;
      routingNumber?: string;
      bankName?: string;
      iban?: string;
      swift?: string;
    };
    evidence?: Array<{
      id: string;
      type: string;
      url: string;
      description?: string;
      uploadedAt: string;
      uploadedBy: string;
    }>;
  }>;
  interest: {
    accrued: number;
    paid: number;
    outstanding: number;
    rate: number;
    calculation: "SIMPLE" | "COMPOUND";
    lastCalculated: string;
    paymentHistory: Array<{
      id: string;
      amount: number;
      paidAt: string;
      period: string;
      paymentMethod?: string;
      paymentReference?: string;
    }>;
  };
  notifications: {
    reminders: Array<{
      id: string;
      type: "DUE_DATE" | "INSPECTION_REMINDER" | "RELEASE_REMINDER" | "PAYMENT_REMINDER";
      scheduledAt: string;
      sentAt?: string;
      status: "PENDING" | "SENT" | "DELIVERED" | "FAILED";
      recipient: string;
      method: "EMAIL" | "SMS" | "PUSH" | "MAIL";
    }>;
    alerts: Array<{
      id: string;
      type: "DISPUTE_RAISED" | "RELEASE_REQUEST" | "PAYMENT_RECEIVED" | "INTEREST_ACCRUED" | "DOCUMENT_MISSING";
      message: string;
      severity: "INFO" | "WARNING" | "ERROR";
      triggeredAt: string;
      acknowledgedBy?: string;
      acknowledgedAt?: string;
    }>;
  };
  documents: Array<{
    id: string;
    name: string;
    type: "DEPOSIT_AGREEMENT" | "PAYMENT_RECEIPT" | "INSPECTION_REPORT" | "RELEASE_FORM" | "DISPUTE_EVIDENCE" | "BANK_STATEMENT" | "OTHER";
    url: string;
    size: number;
    uploadedAt: string;
    uploadedBy: string;
    category: string;
    required: boolean;
    expiresAt?: string;
  }>;
  createdAt: string;
  updatedAt: string;
  createdBy: string;
  updatedBy?: string;
  property?: {
    id: string;
    title: string;
    address: string;
    type: string;
  };
  tenant?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
    phone?: string;
  };
  landlord?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
    phone?: string;
  };
}

export const depositProtectionsApi = {
  // Get all deposit protections
  getAll: async (orgId: string): Promise<DepositProtections[]> => {
    return await apiClient.get(`/organizations/${orgId}/deposit-protections`);
    
  },

  // Get deposit protection by ID
  getById: async (orgId: string, id: string): Promise<DepositProtections> => {
    return await apiClient.get(`/organizations/${orgId}/deposit-protections/${id}`);
    
  },

  // Create new deposit protection
  create: async (orgId: string, data: Omit<DepositProtections, 'id' | 'createdAt' | 'updatedAt' | 'createdBy' | 'updatedBy' | 'property' | 'tenant' | 'landlord'>): Promise<DepositProtections> => {
    return await apiClient.post(`/organizations/${orgId}/deposit-protections`, data);
    
  },

  // Update deposit protection
  update: async (orgId: string, id: string, data: Partial<DepositProtections>): Promise<DepositProtections> => {
    return await apiClient.put(`/organizations/${orgId}/deposit-protections/${id}`, data);
    
  },

  // Delete deposit protection
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/deposit-protections/${id}`);
  },

  // Get deposit protections by property
  getByProperty: async (orgId: string, propertyId: string): Promise<DepositProtections[]> => {
    return await apiClient.get(`/organizations/${orgId}/properties/${propertyId}/deposit-protections`);
    
  },

  // Get deposit protections by tenant
  getByTenant: async (orgId: string, tenantId: string): Promise<DepositProtections[]> => {
    return await apiClient.get(`/organizations/${orgId}/tenants/${tenantId}/deposit-protections`);
    
  },

  // Get deposit protections by landlord
  getByLandlord: async (orgId: string, landlordId: string): Promise<DepositProtections[]> => {
    return await apiClient.get(`/organizations/${orgId}/landlords/${landlordId}/deposit-protections`);
    
  },

  // Get deposit protections by type
  getByType: async (orgId: string, type: DepositProtections['type']): Promise<DepositProtections[]> => {
    return await apiClient.get(`/organizations/${orgId}/deposit-protections`, {
      params: { type }
    });
    
  },

  // Get deposit protections by status
  getByStatus: async (orgId: string, status: DepositProtections['status']): Promise<DepositProtections[]> => {
    return await apiClient.get(`/organizations/${orgId}/deposit-protections`, {
      params: { status }
    });
    
  },

  // Update deposit protection status
  updateStatus: async (orgId: string, id: string, data: {
    status: DepositProtections['status'];
    notes?: string;
    effectiveDate?: string;
  }): Promise<DepositProtections> => {
    return await apiClient.patch(`/organizations/${orgId}/deposit-protections/${id}/status`, data);
    
  },

  // Add timeline event
  addTimelineEvent: async (orgId: string, id: string, data: {
    action: DepositProtections['timeline'][0]['action'];
    amount?: number;
    description: string;
    evidence?: Array<{
      name: string;
      file: File;
    }>;
    nextAction?: string;
    nextActionDue?: string;
  }): Promise<DepositProtections> => {
    const formData = new FormData();
    formData.append('action', data.action);
    if (data.amount) formData.append('amount', String(data.amount));
    formData.append('description', data.description);
    if (data.nextAction) formData.append('nextAction', data.nextAction);
    if (data.nextActionDue) formData.append('nextActionDue', data.nextActionDue);

    if (data.evidence) {
      data.evidence.forEach((evidence, index) => {
        formData.append(`evidence[${index}].name`, evidence.name);
        formData.append(`evidence[${index}].file`, evidence.file);
      });
    }

    return await apiClient.post(`/organizations/${orgId}/deposit-protections/${id}/timeline`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    
  },

  // Get timeline events
  getTimeline: async (orgId: string, id: string): Promise<DepositProtections['timeline']> => {
    return await apiClient.get(`/organizations/${orgId}/deposit-protections/${id}/timeline`);
    
  },

  // Raise dispute
  raiseDispute: async (orgId: string, id: string, data: {
    type: DepositProtections['disputes'][0]['type'];
    description: string;
    claimAmount?: number;
    evidence?: Array<{
      name: string;
      file: File;
    }>;
  }): Promise<DepositProtections> => {
    const formData = new FormData();
    formData.append('type', data.type);
    formData.append('description', data.description);
    if (data.claimAmount) formData.append('claimAmount', String(data.claimAmount));

    if (data.evidence) {
      data.evidence.forEach((evidence, index) => {
        formData.append(`evidence[${index}].name`, evidence.name);
        formData.append(`evidence[${index}].file`, evidence.file);
      });
    }

    return await apiClient.post(`/organizations/${orgId}/deposit-protections/${id}/disputes`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    
  },

  // Get disputes
  getDisputes: async (orgId: string, id: string): Promise<DepositProtections['disputes']> => {
    return await apiClient.get(`/organizations/${orgId}/deposit-protections/${id}/disputes`);
    
  },

  // Resolve dispute
  resolveDispute: async (orgId: string, id: string, disputeId: string, data: {
    resolution: string;
    actualAmount?: number;
    notes?: string;
  }): Promise<DepositProtections> => {
    return await apiClient.post(`/organizations/${orgId}/deposit-protections/${id}/disputes/${disputeId}/resolve`, data);
    
  },

  // Request release
  requestRelease: async (orgId: string, id: string, data: {
    amount?: number;
    reason: string;
    description?: string;
    releaseTo?: {
      accountHolder: string;
      accountNumber: string;
      sortCode?: string;
      routingNumber?: string;
      bankName?: string;
      iban?: string;
      swift?: string;
    };
    evidence?: Array<{
      name: string;
      file: File;
    }>;
  }): Promise<DepositProtections> => {
    const formData = new FormData();
    if (data.amount) formData.append('amount', String(data.amount));
    formData.append('reason', data.reason);
    if (data.description) formData.append('description', data.description);
    if (data.releaseTo) {
      Object.entries(data.releaseTo).forEach(([key, value]) => {
        formData.append(`releaseTo.${key}`, value);
      });
    }

    if (data.evidence) {
      data.evidence.forEach((evidence, index) => {
        formData.append(`evidence[${index}].name`, evidence.name);
        formData.append(`evidence[${index}].file`, evidence.file);
      });
    }

    return await apiClient.post(`/organizations/${orgId}/deposit-protections/${id}/release-request`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    
  },

  // Process release
  processRelease: async (orgId: string, id: string, data: {
    amount: number;
    reason: string;
    description?: string;
    paymentMethod?: string;
    paymentReference?: string;
    bankAccount?: {
      accountHolder: string;
      accountNumber: string;
      sortCode?: string;
      routingNumber?: string;
      bankName?: string;
      iban?: string;
      swift?: string;
    };
  }): Promise<DepositProtections> => {
    return await apiClient.post(`/organizations/${orgId}/deposit-protections/${id}/process-release`, data);
    
  },

  // Calculate interest
  calculateInterest: async (orgId: string, id: string, data: {
    toDate?: string;
    includePaid?: boolean;
  }): Promise<{
    accrued: number;
    outstanding: number;
    rate: number;
    calculation: DepositProtections['interest']['calculation'];
    period: {
      startDate: string;
      endDate: string;
      days: number;
    };
    breakdown: Array<{
      period: string;
      principal: number;
      rate: number;
      interest: number;
      cumulative: number;
    }>;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/deposit-protections/${id}/calculate-interest`, data);
    
  },

  // Add document
  addDocument: async (orgId: string, id: string, data: {
    name: string;
    type: DepositProtections['documents'][0]['type'];
    category: string;
    required?: boolean;
    expiresAt?: string;
    file: File;
  }): Promise<DepositProtections> => {
    const formData = new FormData();
    formData.append('name', data.name);
    formData.append('type', data.type);
    formData.append('category', data.category);
    formData.append('required', String(data.required || false));
    if (data.expiresAt) formData.append('expiresAt', data.expiresAt);
    formData.append('file', data.file);

    return await apiClient.post(`/organizations/${orgId}/deposit-protections/${id}/documents`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    
  },

  // Get documents
  getDocuments: async (orgId: string, id: string): Promise<DepositProtections['documents']> => {
    return await apiClient.get(`/organizations/${orgId}/deposit-protections/${id}/documents`);
    
  },

  // Get deposit protection statistics
  getStatistics: async (orgId: string, filters?: {
    propertyId?: string;
    tenantId?: string;
    landlordId?: string;
    type?: DepositProtections['type'];
    status?: DepositProtections['status'];
    startDate?: string;
    endDate?: string;
  }): Promise<{
    total: number;
    totalAmount: number;
    byType: Record<string, number>;
    byStatus: Record<string, number>;
    byProperty: Array<{
      propertyId: string;
      propertyAddress: string;
      depositCount: number;
      totalAmount: number;
    }>;
    byTenant: Array<{
      tenantId: string;
      tenantName: string;
      depositCount: number;
      totalAmount: number;
    }>;
    disputes: {
      total: number;
      open: number;
      resolved: number;
      averageResolutionTime: number;
      totalClaimAmount: number;
      totalPaidAmount: number;
    };
    releases: {
      total: number;
      totalAmount: number;
      averageProcessingTime: number;
      partial: number;
      full: number;
    };
    interest: {
      totalAccrued: number;
      totalPaid: number;
      outstanding: number;
      averageRate: number;
    };
  }> => {
    return await apiClient.get(`/organizations/${orgId}/deposit-protections/statistics`, {
      params: { ...filters }
    });
    
  },

  // Export deposit protections
  export: async (orgId: string, options: object): Promise<Blob> => {
    const response = await fetch(`${apiClient['baseURL']}/organizations/${orgId}/deposit-protections/export`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${typeof window !== "undefined" ? localStorage.getItem("auth_token") : ""}`,
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
