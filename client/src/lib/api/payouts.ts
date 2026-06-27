import { apiClient } from "./client";

export interface Payout {
  id: string;
  orgId: string;
  agentId?: string;
  vendorId?: string;
  type: "COMMISSION" | "SALARY" | "BONUS" | "REFUND" | "EXPENSE";
  amount: number;
  status: "PENDING" | "PROCESSING" | "COMPLETED" | "FAILED" | "CANCELLED";
  currency: string;
  description?: string;
  dueDate?: string;
  processedAt?: string;
  failureReason?: string;
  transactionId?: string;
  bankAccount?: {
    bankName: string;
    accountNumber: string;
    routingNumber?: string;
  };
  createdAt: string;
  updatedAt: string;
  agent?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
  vendor?: {
    id: string;
    name: string;
    email: string;
  };
}

export const payoutsApi = {
  // Get all payouts
  getAll: async (orgId: string): Promise<Payout[]> => {
    return await apiClient.get(`/organizations/${orgId}/payouts`);
    
  },

  // Get payout by ID
  getById: async (orgId: string, id: string): Promise<Payout> => {
    return await apiClient.get(`/organizations/${orgId}/payouts/${id}`);
    
  },

  // Create new payout
  create: async (orgId: string, data: Omit<Payout, 'id' | 'createdAt' | 'updatedAt' | 'agent' | 'vendor'>): Promise<Payout> => {
    return await apiClient.post(`/organizations/${orgId}/payouts`, data);
    
  },

  // Update payout
  update: async (orgId: string, id: string, data: Partial<Payout>): Promise<Payout> => {
    return await apiClient.put(`/organizations/${orgId}/payouts/${id}`, data);
    
  },

  // Delete payout
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/payouts/${id}`);
  },

  // Get payouts by agent
  getByAgent: async (orgId: string, agentId: string, filters?: {
    startDate?: string;
    endDate?: string;
    status?: Payout['status'];
    type?: Payout['type'];
  }): Promise<Payout[]> => {
    return await apiClient.get(`/organizations/${orgId}/agents/${agentId}/payouts`, {
      params: { ...filters }
    });
    
  },

  // Get payouts by vendor
  getByVendor: async (orgId: string, vendorId: string): Promise<Payout[]> => {
    return await apiClient.get(`/organizations/${orgId}/vendors/${vendorId}/payouts`);
    
  },

  // Update payout status
  updateStatus: async (orgId: string, id: string, status: Payout['status']): Promise<Payout> => {
    return await apiClient.patch(`/organizations/${orgId}/payouts/${id}/status`, { status });
    
  },

  // Process payout
  process: async (orgId: string, id: string): Promise<Payout> => {
    return await apiClient.patch(`/organizations/${orgId}/payouts/${id}/process`);
    
  },

  // Complete payout
  complete: async (orgId: string, id: string, data: {
    transactionId?: string;
    processedAt: string;
    notes?: string;
  }): Promise<Payout> => {
    return await apiClient.patch(`/organizations/${orgId}/payouts/${id}/complete`, data);
    
  },

  // Fail payout
  fail: async (orgId: string, id: string, data: {
    failureReason: string;
    notes?: string;
  }): Promise<Payout> => {
    return await apiClient.patch(`/organizations/${orgId}/payouts/${id}/fail`, data);
    
  },

  // Get payout statistics
  getStatistics: async (orgId: string, filters?: {
    startDate?: string;
    endDate?: string;
    agentId?: string;
    vendorId?: string;
    status?: Payout['status'];
    type?: Payout['type'];
  }): Promise<{
    total: number;
    pending: number;
    processing: number;
    completed: number;
    failed: number;
    cancelled: number;
    totalAmount: number;
    byType: Record<string, number>;
    byAgent: Array<{
      agentId: string;
      agentName: string;
      total: number;
      completed: number;
    }>;
    byMonth: Array<{
      month: string;
      total: number;
      completed: number;
    }>;
  }> => {
    return await apiClient.get(`/organizations/${orgId}/payouts/statistics`, {
      params: { ...filters }
    });
    
  },

  // Generate payout report
  generateReport: async (orgId: string, options: {
    startDate?: string;
    endDate?: string;
    agentIds?: string[];
    vendorIds?: string[];
    status?: Payout['status'];
    type?: Payout['type'];
    format: "PDF" | "EXCEL" | "CSV";
  }): Promise<Blob> => {
    return await apiClient.post(`/organizations/${orgId}/payouts/report`, options, {
      responseType: 'blob'
    });
    
  },

  // Bulk process payouts
  bulkProcess: async (orgId: string, payoutIds: string[]): Promise<Payout[]> => {
    return await apiClient.patch(`/organizations/${orgId}/payouts/bulk-process`, { payoutIds });
    
  },

  // Calculate payout fees
  calculateFees: async (orgId: string, data: {
    amount: number;
    method: string;
    currency: string;
    destination: string;
  }): Promise<{
    processingFee: number;
    transactionFee: number;
    totalFee: number;
    netAmount: number;
    estimatedDeliveryTime: string;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/payouts/calculate-fees`, data);
    
  },

  // Get payout methods
  getMethods: async (orgId: string): Promise<Array<{
    id: string;
    name: string;
    type: string;
    currencies: string[];
    minAmount: number;
    maxAmount: number;
    processingTime: string;
    fees: {
      fixed: number;
      percentage: number;
    };
  }>> => {
    return await apiClient.get(`/organizations/${orgId}/payouts/methods`);
    
  },
};
