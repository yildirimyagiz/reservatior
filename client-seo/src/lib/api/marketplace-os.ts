import { apiClient } from "./client";

export enum MatchType {
  TENANT_PROPERTY = "TENANT_PROPERTY",
  LANDLORD_AGENT = "LANDLORD_AGENT",
  BUYER_PROPERTY = "BUYER_PROPERTY",
  INVESTOR_PROPERTY = "INVESTOR_PROPERTY",
}

export enum MatchStatus {
  PENDING = "PENDING",
  ACCEPTED = "ACCEPTED",
  REJECTED = "REJECTED",
  EXPIRED = "EXPIRED",
}

export interface Match {
  id: string;
  matchType: MatchType;
  fromEntityId: string;
  toEntityId: string;
  matchScore: number;
  compatibilityScore: number;
  status: MatchStatus;
  factors: Array<{ factor: string; impact: number }>;
  metadata?: Record<string, unknown>;
  createdAt: string;
  expiresAt?: string;
}

export interface DemandSignal {
  entityType: string;
  entityId: string;
  criteria: Record<string, unknown>;
  urgency: number;
  budget: number;
  location: string;
  timestamp: string;
}

export interface SupplySignal {
  entityType: string;
  entityId: string;
  attributes: Record<string, unknown>;
  availability: boolean;
  price: number;
  location: string;
  timestamp: string;
}

export const marketplaceOSApi = {
  // Analyze demand
  analyzeDemand: async (location: string, propertyType?: string): Promise<DemandSignal[]> => {
    const response = await apiClient.get<DemandSignal[]>(`/api/v1/marketplace-os/demand/${location}`, {
      params: { propertyType },
    });
    return response;
  },

  // Analyze supply
  analyzeSupply: async (location: string, propertyType?: string): Promise<SupplySignal[]> => {
    const response = await apiClient.get<SupplySignal[]>(`/api/v1/marketplace-os/supply/${location}`, {
      params: { propertyType },
    });
    return response;
  },

  // Match tenant to property
  matchTenantToProperty: async (tenantId: string, propertyId: string): Promise<Match> => {
    const response = await apiClient.get<Match>(
      `/api/v1/marketplace-os/match/tenant/${tenantId}/property/${propertyId}`
    );
    return response;
  },

  // Get recommendations
  getRecommendations: async (
    entityType: string,
    entityId: string,
    limit?: number
  ): Promise<Match[]> => {
    const response = await apiClient.get<Match[]>(
      `/api/v1/marketplace-os/recommendations/${entityType}/${entityId}`,
      { params: { limit } }
    );
    return response;
  },

  // Get marketplace statistics
  getStats: async (location: string): Promise<any> => {
    const response = await apiClient.get(`/api/v1/marketplace-os/stats/${location}`);
    return response;
  },

  // Create match
  createMatch: async (data: Omit<Match, 'id' | 'createdAt'>): Promise<Match> => {
    const response = await apiClient.post<Match>(`/api/v1/marketplace-os/match`, data);
    return response;
  },

  // Update match status
  updateMatchStatus: async (matchId: string, status: MatchStatus): Promise<Match> => {
    const response = await apiClient.put<Match>(`/api/v1/marketplace-os/match/${matchId}/status`, { status });
    return response;
  },

  // Get match history
  getMatchHistory: async (entityId: string, limit?: number): Promise<Match[]> => {
    const response = await apiClient.get<Match[]>(`/api/v1/marketplace-os/match/history/${entityId}`, {
      params: { limit },
    });
    return response;
  },

  // Get dashboard
  getDashboard: async (orgId?: string): Promise<any> => {
    const response = await apiClient.get(`/api/v1/marketplace-os/dashboard`, {
      params: { orgId },
    });
    return response;
  },
};
