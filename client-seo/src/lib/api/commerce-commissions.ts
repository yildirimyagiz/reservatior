import { apiClient } from "./client";

export interface CommerceCommission {
  id: string;
  orgId: string;
  sourceType: string;
  sourceId: string;
  agentId?: string;
  type: string;
  basis: string;
  basisAmount: number;
  rate: number;
  amount: number;
  currency: string;
  platformShare: number;
  agentShare: number;
  supplierShare: number;
  partnerShare: number;
  status: string;
  calculatedAt?: string;
  approvedAt?: string;
  paidAt?: string;
  paymentRef?: string;
  metadata?: any;
  createdAt: string;
  updatedAt: string;
}

export interface CommerceCommissionCreate {
  sourceType: string;
  sourceId: string;
  agentId?: string;
  type: string;
  basis: string;
  basisAmount: number;
  rate: number;
  amount: number;
  currency: string;
}

export const commerceCommissionsApi = {
  getAll: async (params?: any) => {
    return apiClient.get<CommerceCommission[]>("/commerce-commissions", params);
  },
  getById: async (id: string) => {
    return apiClient.get<CommerceCommission>(`/commerce-commissions/${id}`);
  },
  create: async (data: CommerceCommissionCreate) => {
    return apiClient.post<CommerceCommission>("/commerce-commissions", data);
  },
  approve: async (id: string) => {
    return apiClient.patch<CommerceCommission>(`/commerce-commissions/${id}/approve`);
  },
  pay: async (id: string, data: { paymentRef: string }) => {
    return apiClient.patch<CommerceCommission>(`/commerce-commissions/${id}/pay`, data);
  },
  delete: async (id: string) => {
    return apiClient.delete(`/commerce-commissions/${id}`);
  },
};
