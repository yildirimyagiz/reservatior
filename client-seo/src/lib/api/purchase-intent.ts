import { apiClient } from "./client";

export interface PurchaseIntent {
  id: string;
  orgId: string;
  leaseId: string;
  propertyId: string;
  tenantId: string;
  status: string;
  readinessTier: string;
  targetPrice: number;
  estimatedDownPmt: number;
  monthlySavings: number;
  savingsGoal: number;
  currentSavings: number;
  mortgagePreApproved: boolean;
  mortgagePreApprovalId: string;
  maxMortgageAmount: number;
  preferredLender: string;
  trustScoreAtIntent: number;
  buyerReadinessScore: number;
  targetPurchaseDate: string;
  leaseEndSynchronizes: boolean;
  declaredAt: string;
  lastActivityAt: string;
  expiresAt: string;
  metadata: Record<string, any>;
  createdAt: string;
  updatedAt: string;
}

export interface EquityAccumulation {
  id: string;
  purchaseIntentId: string;
  leaseId: string;
  monthNumber: number;
  equityAmount: number;
  cumulativeEquity: number;
  rentPaid: number;
  equityPortion: number;
  interestPortion: number;
  status: string;
  recordedAt: string;
  createdAt: string;
  updatedAt: string;
}

export interface OwnershipConversion {
  id: string;
  purchaseIntentId: string;
  orgId: string;
  status: string;
  conversionType: string;
  finalPrice: number;
  downPayment: number;
  mortgageAmount: number;
  equityApplied: number;
  startedAt: string;
  completedAt: string;
  metadata: Record<string, any>;
  createdAt: string;
  updatedAt: string;
}

export const purchaseIntentApi = {
  getAll: (params?: { orgId?: string; status?: string; readinessTier?: string; page?: number; limit?: number }) =>
    apiClient.get<{ data: PurchaseIntent[]; total: number }>("/purchase-intents", params),

  getById: (id: string) =>
    apiClient.get<{ data: PurchaseIntent }>(`/purchase-intents/${id}`),

  create: (data: {
    orgId: string;
    leaseId: string;
    propertyId: string;
    tenantId: string;
    targetPrice: number;
    savingsGoal: number;
    monthlySavings: number;
    targetPurchaseDate?: string;
    metadata?: Record<string, any>;
  }) =>
    apiClient.post<{ data: PurchaseIntent }>("/purchase-intents", data),

  update: (id: string, data: Partial<PurchaseIntent>) =>
    apiClient.patch<{ data: PurchaseIntent }>(`/purchase-intents/${id}`, data),

  getEquityAccumulations: (intentId: string) =>
    apiClient.get<{ data: EquityAccumulation[] }>(`/purchase-intents/${intentId}/equity`),

  getJourneySummary: (intentId: string) =>
    apiClient.get<{ data: Record<string, any> }>(`/purchase-intents/${intentId}/journey`),

  startConversion: (intentId: string, data: {
    conversionType: string;
    finalPrice: number;
    downPayment: number;
    mortgageAmount?: number;
    metadata?: Record<string, any>;
  }) =>
    apiClient.post<{ data: OwnershipConversion }>(`/purchase-intents/${intentId}/conversion`, data),

  getConversion: (intentId: string) =>
    apiClient.get<{ data: OwnershipConversion }>(`/purchase-intents/${intentId}/conversion`),
};
