import { apiClient } from "./client";

export type CommissionType = "LEASING_COMMISSION" | "SUBSCRIPTION_COMMISSION" | "CO_BROKERAGE" | "REFERRAL" | "MANAGEMENT";
export type CommissionStatus = "PENDING" | "CALCULATED" | "PAID" | "DISPUTED" | "CANCELLED";
export type CommissionFrequency = "MONTHLY" | "QUARTERLY" | "YEARLY" | "ONE_TIME";
export type CommissionPartyType = "PLATFORM" | "AGENCY" | "AGENT" | "CO_AGENCY" | "CO_AGENT" | "PROPERTY_OWNER";

export interface CommissionSplit {
  id: string;
  commissionId: string;
  partyType: CommissionPartyType;
  partyId?: string;
  partyName?: string;
  rate: number;
  amount: number;
  currency: string;
  status: CommissionStatus;
  paidAt?: string;
  paidAmount?: number;
}

export interface Commission {
  id: string;
  orgId: string;
  listingId?: string;
  leaseId?: string;
  agentId?: string;
  agencyId?: string;
  amountBase: number;
  commissionRate?: number;
  platformRate?: number;
  agencyRate?: number;
  agentRate?: number;
  coAgencyId?: string;
  coAgentId?: string;
  coAgencyRate?: number;
  coAgentRate?: number;
  isCoBrokerage?: boolean;
  taxAmount: number;
  commissionAmount: number;
  currency: string;
  status: CommissionStatus;
  type: CommissionType;
  frequency: CommissionFrequency;
  totalInstallments?: number;
  completedInstallments?: number;
  nextBillingDate?: string;
  lastBilledDate?: string;
  partnerRate?: number;
  platformFee?: number;
  partnerFee?: number;
  createdAt: string;
  updatedAt: string;
  splits?: CommissionSplit[];
  agent?: { id: string; firstName: string; lastName: string; email: string };
}

export interface CreateSubscriptionCommissionInput {
  orgId: string;
  leaseId?: string;
  listingId?: string;
  agentId?: string;
  agencyId?: string;
  monthlyRent: number;
  currency?: string;
  frequency?: CommissionFrequency;
  totalInstallments?: number;
  splits: { partyType: CommissionPartyType; partyId?: string; partyName?: string; rate: number }[];
}

export const commissionsApi = {
  getAll: (params?: { orgId?: string; status?: string; type?: string; page?: number; limit?: number }) =>
    apiClient.get<{ data: Commission[]; total: number; page: number; limit: number }>("/commission", params as any),

  getById: (id: string) =>
    apiClient.get<{ data: Commission }>(`/commission/${id}`),

  create: (data: any) =>
    apiClient.post<{ data: Commission }>("/commission", data),

  update: (id: string, data: any) =>
    apiClient.patch<{ data: Commission }>(`/commission/${id}`, data),

  delete: (id: string) =>
    apiClient.delete(`/commission/${id}`),

  createSubscription: (data: CreateSubscriptionCommissionInput) =>
    apiClient.post<{ data: Commission }>("/commission/subscription", data),

  billRecurring: (id: string) =>
    apiClient.post<{ data: any }>(`/commission/${id}/bill`),
};
