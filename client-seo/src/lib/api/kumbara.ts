import { apiClient } from "./client";

export interface KumbaraDeposit {
  id: string;
  orgId: string;
  leaseId: string;
  propertyId: string;
  tenantId: string;
  status: string;
  totalTarget: number;
  totalContributed: number;
  remainingBalance: number;
  currency: string;
  ruleType: string;
  contributionRate: number;
  fixedAmount: number;
  contributionDay: number;
  escrowAccountId: string;
  ownerProtectionEnabled: boolean;
  maxMissedPayments: number;
  currentMissedPayments: number;
  autoDefaultOnMiss: boolean;
  startedAt: string;
  completedAt: string;
  nextDueDate: string;
  metadata: Record<string, any>;
  createdAt: string;
  updatedAt: string;
}

export interface KumbaraContribution {
  id: string;
  depositId: string;
  amount: number;
  currency: string;
  status: string;
  paymentMethod: string;
  transactionId: string;
  contributedAt: string;
  metadata: Record<string, any>;
  createdAt: string;
  updatedAt: string;
}

export interface KumbaraRule {
  id: string;
  orgId: string;
  name: string;
  ruleType: string;
  contributionRate: number;
  fixedAmount: number;
  contributionDay: number;
  maxMissedPayments: number;
  autoDefaultOnMiss: boolean;
  ownerProtectionEnabled: boolean;
  metadata: Record<string, any>;
  createdAt: string;
  updatedAt: string;
}

export const kumbaraApi = {
  getAll: (params?: { orgId?: string; status?: string; page?: number; limit?: number }) =>
    apiClient.get<{ data: KumbaraDeposit[]; total: number }>("/kumbara-deposits", params),

  getById: (id: string) =>
    apiClient.get<{ data: KumbaraDeposit }>(`/kumbara-deposits/${id}`),

  create: (data: {
    orgId: string;
    leaseId: string;
    propertyId: string;
    tenantId: string;
    totalTarget: number;
    currency: string;
    ruleType: string;
    contributionRate?: number;
    fixedAmount?: number;
    contributionDay?: number;
    ownerProtectionEnabled?: boolean;
    maxMissedPayments?: number;
    autoDefaultOnMiss?: boolean;
  }) =>
    apiClient.post<{ data: KumbaraDeposit }>("/kumbara-deposits", data),

  contribute: (id: string, data: {
    amount: number;
    currency?: string;
    paymentMethod: string;
    transactionId?: string;
    metadata?: Record<string, any>;
  }) =>
    apiClient.post<{ data: KumbaraContribution }>(`/kumbara-deposits/${id}/contributions`, data),

  getSummary: (params?: { orgId?: string }) =>
    apiClient.get<{ data: Record<string, any> }>("/kumbara-deposits/summary", params),

  checkMissedPayments: (params?: { orgId?: string }) =>
    apiClient.post<{ data: { checked: number; flagged: number } }>("/kumbara-deposits/check-missed", params),
};
