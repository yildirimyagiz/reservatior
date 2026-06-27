import { apiClient } from "./client";

export interface AIServiceStats {
  totalUsage: number;
  totalCost: number;
  revenueLift: number;
  adoptionRate: number;
  services: {
    name: string;
    usage: number;
    revenue: number;
    efficiency: number;
    trend: number;
  }[];
  conversions: {
    date: string;
    aiGroup: number;
    controlGroup: number;
  }[];
  roiData: {
    name: string;
    value: number;
  }[];
}

export interface CommissionSummary {
  totalEarnings: number;
  pendingPayouts: number;
  platformShare: number;
  agencyShare: number;
  agentShare: number;
  distributions: {
    id: string;
    entity: string;
    type: "Platform" | "Agency" | "Agent";
    amount: number;
    status: "Escrow" | "Cleared" | "Pending";
    shares: { label: string; value: number }[];
  }[];
  payoutTrends: {
    month: string;
    amount: number;
  }[];
}

export const adminNeuralApi = {
  getServiceStats: (params?: any) => apiClient.get<AIServiceStats>("/admin/analytics/ai-services", params),
  getCommissionSummary: (params?: any) => apiClient.get<CommissionSummary>("/admin/analytics/commissions", params),
  getEscrowStatus: () => apiClient.get("/admin/financials/escrow-summary"),
};
