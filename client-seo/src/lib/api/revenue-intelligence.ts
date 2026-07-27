import { getLocalizationHeaders } from './localization-helper';

export interface RevenueIntelligenceStats {
  totalRevenue: number;
  netOperatingIncome: number;
  yieldArbitrage: number;
  revenueAttribution: number;
  avgOccupancy: number;
  revenueGrowth: number;
  predictedRevenue: number;
  optimizationPotential: number;
}

export interface RevenueStream {
  name: string;
  value: number;
  trend: string;
  color: string;
}

export interface OptimizationOpportunity {
  name: string;
  potential: string;
  impact: string;
  effort: string;
}

export interface PredictiveInsight {
  metric: string;
  predicted: string;
  confidence: number;
  trend: string;
}

export const revenueIntelligenceApi = {
  getStats: async (orgId: string, timeRange: string): Promise<RevenueIntelligenceStats> => {
    const res = await fetch(`/api/v1/revenue-intelligence/dashboard?orgId=${orgId}&timeRange=${timeRange}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch revenue intelligence stats');
    return res.json();
  },

  getRevenueStreams: async (orgId: string): Promise<RevenueStream[]> => {
    const res = await fetch(`/api/v1/revenue-intelligence/streams?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch revenue streams');
    return res.json();
  },

  getOptimizationOpportunities: async (orgId: string): Promise<OptimizationOpportunity[]> => {
    const res = await fetch(`/api/v1/revenue-intelligence/opportunities?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch optimization opportunities');
    return res.json();
  },

  getPredictiveInsights: async (orgId: string): Promise<PredictiveInsight[]> => {
    const res = await fetch(`/api/v1/revenue-intelligence/predictions?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch predictive insights');
    return res.json();
  },
};
