import { apiClient } from "./client";

export interface PropertyScan {
  propertyId: string;
  address: string;
  city: string;
  bedrooms: number;
  squareMeters: number;
  estimatedValue: number;
  estimatedRent: number;
  occupancyRate: number;
  certificateTier?: string;
  trustScore?: number;
}

export interface AgentOffer {
  id: string;
  agentId: string;
  propertyId: string;
  offerType: string;
  bundleId?: string;
  amount: number;
  commission: number;
  commissionRate: number;
  status: string;
  validUntil: string;
  notes?: string;
  createdAt: string;
}

export interface AgentDashboardSummary {
  totalOrders: number;
  totalRevenue: number;
  totalCommissions: number;
  pendingCommissions: number;
  activeOffers: number;
  propertiesScanned: number;
  recentOrders: any[];
  topProperties: any[];
}

export const agentMobileApi = {
  scanProperty: async (params: { address?: string; city?: string; minBedrooms?: number; maxPrice?: number }) => {
    return apiClient.get<PropertyScan[]>("/agent-mobile/scan", params);
  },
  getDashboard: async (agentId: string) => {
    return apiClient.get<AgentDashboardSummary>(`/agent-mobile/dashboard/${agentId}`);
  },
  generateOffer: async (data: { agentId: string; propertyId: string; offerType: string; bundleId?: string; amount: number; notes?: string }) => {
    return apiClient.post<AgentOffer>("/agent-mobile/offers", data);
  },
  getOffers: async (agentId: string) => {
    return apiClient.get<AgentOffer[]>(`/agent-mobile/offers/${agentId}`);
  },
  getCommissionSummary: async (agentId: string) => {
    return apiClient.get<any>(`/agent-mobile/commissions/${agentId}`);
  },
};
