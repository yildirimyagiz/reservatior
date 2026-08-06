import { apiClient } from "./client";

export interface Commission {
  id: string;
  orgId: string;
  agentId: string;
  propertyId?: string;
  dealId?: string;
  type: "SALE" | "RENTAL" | "REFERRAL" | "BONUS";
  amount: number;
  percentage?: number;
  status: "PENDING" | "APPROVED" | "PAID" | "CANCELLED";
  dueDate?: string;
  paidAt?: string;
  description?: string;
  createdAt: string;
  updatedAt: string;
  agent?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
  property?: {
    id: string;
    title: string;
    address: string;
  };
  deal?: {
    id: string;
    title: string;
    status: string;
  };
}

export const commissionsApi = {
  // Get all commissions
  getAll: async (orgId: string): Promise<Commission[]> => {
    const response = await apiClient.get<Commission[]>(`/organizations/${orgId}/commissions`);
    return response;
  },

  // Get commission by ID
  getById: async (orgId: string, id: string): Promise<Commission> => {
    const response = await apiClient.get<Commission>(`/organizations/${orgId}/commissions/${id}`);
    return response;
  },

  // Create new commission
  create: async (orgId: string, data: Omit<Commission, 'id' | 'createdAt' | 'updatedAt' | 'agent' | 'property' | 'deal'>): Promise<Commission> => {
    const response = await apiClient.post<Commission>(`/organizations/${orgId}/commissions`, data);
    return response;
  },

  // Update commission
  update: async (orgId: string, id: string, data: Partial<Commission>): Promise<Commission> => {
    const response = await apiClient.put<Commission>(`/organizations/${orgId}/commissions/${id}`, data);
    return response;
  },

  // Delete commission
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/commissions/${id}`);
  },

  // Get commissions by agent
  getByAgent: async (orgId: string, agentId: string, filters?: {
    startDate?: string;
    endDate?: string;
    status?: "PENDING" | "APPROVED" | "PAID" | "CANCELLED";
    type?: "SALE" | "RENTAL" | "REFERRAL" | "BONUS";
  }): Promise<Commission[]> => {
    const response = await apiClient.get<Commission[]>(`/organizations/${orgId}/agents/${agentId}/commissions`, {
      params: { ...filters }
    });
    return response;
  },

  // Get commissions by property
  getByProperty: async (orgId: string, propertyId: string): Promise<Commission[]> => {
    const response = await apiClient.get<Commission[]>(`/organizations/${orgId}/properties/${propertyId}/commissions`);
    return response;
  },

  // Get commissions by deal
  getByDeal: async (orgId: string, dealId: string): Promise<Commission[]> => {
    const response = await apiClient.get<Commission[]>(`/organizations/${orgId}/deals/${dealId}/commissions`);
    return response;
  },

  // Update commission status
  updateStatus: async (orgId: string, id: string, status: "PENDING" | "APPROVED" | "PAID" | "CANCELLED"): Promise<Commission> => {
    const response = await apiClient.patch<Commission>(`/organizations/${orgId}/commissions/${id}/status`, { status });
    return response;
  },

  // Approve commission
  approve: async (orgId: string, id: string): Promise<Commission> => {
    const response = await apiClient.patch<Commission>(`/organizations/${orgId}/commissions/${id}/approve`);
    return response;
  },

  // Pay commission
  pay: async (orgId: string, id: string, paymentData: {
    paymentMethod: string;
    transactionId?: string;
    paidAt: string;
  }): Promise<Commission> => {
    const response = await apiClient.patch<Commission>(`/organizations/${orgId}/commissions/${id}/pay`, paymentData);
    return response;
  },

  // Get commission statistics
  getStatistics: async (orgId: string, filters?: {
    startDate?: string;
    endDate?: string;
    agentId?: string;
    type?: "SALE" | "RENTAL" | "REFERRAL" | "BONUS";
  }): Promise<{
    total: number;
    pending: number;
    approved: number;
    paid: number;
    cancelled: number;
    byType: Record<string, number>;
    byAgent: Array<{
      agentId: string;
      agentName: string;
      total: number;
      paid: number;
    }>;
    byMonth: Array<{
      month: string;
      total: number;
      paid: number;
    }>;
  }> => {
    const response = await apiClient.get<{
    total: number;
    pending: number;
    approved: number;
    paid: number;
    cancelled: number;
    byType: Record<string, number>;
    byAgent: Array<{
      agentId: string;
      agentName: string;
      total: number;
      paid: number;
    }>;
    byMonth: Array<{
      month: string;
      total: number;
      paid: number;
    }>;
  }>(`/organizations/${orgId}/commissions/statistics`, {
      params: { ...filters }
    });
    return response;
  },

  // Calculate commission
  calculate: async (orgId: string, data: {
    propertyId?: string;
    dealId?: string;
    agentId: string;
    salePrice?: number;
    rentAmount?: number;
    commissionRate?: number;
    type: "SALE" | "RENTAL" | "REFERRAL" | "BONUS";
  }): Promise<{
    commissionAmount: number;
    commissionPercentage: number;
    netAmount: number;
    taxes: number;
  }> => {
    const response = await apiClient.post<{
    commissionAmount: number;
    commissionPercentage: number;
    netAmount: number;
    taxes: number;
  }>(`/organizations/${orgId}/commissions/calculate`, data);
    return response;
  },

  // Generate commission report
  generateReport: async (orgId: string, options: {
    startDate?: string;
    endDate?: string;
    agentIds?: string[];
    status?: "PENDING" | "APPROVED" | "PAID" | "CANCELLED";
    type?: "SALE" | "RENTAL" | "REFERRAL" | "BONUS";
    format: "PDF" | "EXCEL" | "CSV";
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/commissions/report`, options, {
      responseType: 'blob'
    });
    return response;
  },

  // Bulk approve commissions
  bulkApprove: async (orgId: string, commissionIds: string[]): Promise<Commission[]> => {
    const response = await apiClient.patch<Commission[]>(`/organizations/${orgId}/commissions/bulk-approve`, { commissionIds });
    return response;
  },

  // Bulk pay commissions
  bulkPay: async (orgId: string, data: {
    commissionIds: string[];
    paymentMethod: string;
    transactionId?: string;
    paidAt: string;
  }): Promise<Commission[]> => {
    const response = await apiClient.patch<Commission[]>(`/organizations/${orgId}/commissions/bulk-pay`, data);
    return response;
  },

  // Create installment plan
  createInstallmentPlan: async (orgId: string, id: string, data: {
    installmentCount?: number;
    startDate?: string;
  }): Promise<{ data: any[], success: boolean }> => {
    // In our backend, the route is under /commission/:id/installment-plan
    const response = await apiClient.post<{ data: any[], success: boolean }>(`/commission/${id}/installment-plan`, data);
    return response;
  },
};
