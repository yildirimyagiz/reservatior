import { apiClient } from "./client";

export enum GrowthMetric {
  CHANNEL_QUALITY = "CHANNEL_QUALITY",
  AGENT_PERFORMANCE = "AGENT_PERFORMANCE",
  CITY_GROWTH_POTENTIAL = "CITY_GROWTH_POTENTIAL",
  USER_SEGMENT_TARGETING = "USER_SEGMENT_TARGETING",
  CONVERSION_RATE = "CONVERSION_RATE",
  RETENTION_RATE = "RETENTION_RATE",
  LIFETIME_VALUE = "LIFETIME_VALUE",
  ACQUISITION_COST = "ACQUISITION_COST",
}

export enum GrowthChannel {
  ORGANIC_SEARCH = "ORGANIC_SEARCH",
  PAID_SEARCH = "PAID_SEARCH",
  SOCIAL_MEDIA = "SOCIAL_MEDIA",
  REFERRAL = "REFERRAL",
  DIRECT = "DIRECT",
  EMAIL_MARKETING = "EMAIL_MARKETING",
  PARTNER = "PARTNER",
  AFFILIATE = "AFFILIATE",
}

export interface GrowthInsight {
  id: string;
  metric: GrowthMetric;
  dimension: string;
  value: number;
  trend: "UP" | "DOWN" | "STABLE";
  confidence: number;
  recommendations: string[];
  metadata?: Record<string, unknown>;
  generatedAt: string;
}

export interface ChannelAnalysis {
  channel: GrowthChannel;
  totalUsers: number;
  conversionRate: number;
  retentionRate: number;
  avgLifetimeValue: number;
  acquisitionCost: number;
  roi: number;
  qualityScore: number;
}

export interface GrowthOpportunity {
  type: "CHANNEL" | "CITY" | "SEGMENT" | "AGENT";
  target: string;
  potentialScore: number;
  estimatedImpact: number;
  effort: "LOW" | "MEDIUM" | "HIGH";
  priority: number;
  recommendations: string[];
}

export const growthIntelligenceOSApi = {
  // Analyze channel quality
  analyzeChannelQuality: async (channel: GrowthChannel): Promise<ChannelAnalysis> => {
    const response = await apiClient.get<ChannelAnalysis>(`/api/v1/growth-intelligence-os/channel/${channel}`);
    return response;
  },

  // Analyze agent performance
  analyzeAgentPerformance: async (agentId: string): Promise<GrowthInsight> => {
    const response = await apiClient.get<GrowthInsight>(`/api/v1/growth-intelligence-os/agent/${agentId}`);
    return response;
  },

  // Analyze city growth potential
  analyzeCityGrowthPotential: async (city: string): Promise<GrowthOpportunity> => {
    const response = await apiClient.get<GrowthOpportunity>(`/api/v1/growth-intelligence-os/city/${city}`);
    return response;
  },

  // Analyze user segment targeting
  analyzeUserSegmentTargeting: async (segment: string): Promise<GrowthInsight> => {
    const response = await apiClient.get<GrowthInsight>(`/api/v1/growth-intelligence-os/segment/${segment}`);
    return response;
  },

  // Calculate conversion rate
  calculateConversionRate: async (dimension: string): Promise<GrowthInsight> => {
    const response = await apiClient.get<GrowthInsight>(`/api/v1/growth-intelligence-os/conversion/${dimension}`);
    return response;
  },

  // Calculate retention rate
  calculateRetentionRate: async (dimension: string): Promise<GrowthInsight> => {
    const response = await apiClient.get<GrowthInsight>(`/api/v1/growth-intelligence-os/retention/${dimension}`);
    return response;
  },

  // Calculate lifetime value
  calculateLifetimeValue: async (dimension: string): Promise<GrowthInsight> => {
    const response = await apiClient.get<GrowthInsight>(`/api/v1/growth-intelligence-os/ltv/${dimension}`);
    return response;
  },

  // Calculate acquisition cost
  calculateAcquisitionCost: async (dimension: string): Promise<GrowthInsight> => {
    const response = await apiClient.get<GrowthInsight>(`/api/v1/growth-intelligence-os/cac/${dimension}`);
    return response;
  },

  // Get growth opportunities
  getGrowthOpportunities: async (orgId: string): Promise<GrowthOpportunity[]> => {
    const response = await apiClient.get<GrowthOpportunity[]>(`/api/v1/growth-intelligence-os/opportunities/${orgId}`);
    return response;
  },

  // Get growth dashboard
  getDashboard: async (orgId: string): Promise<any> => {
    const response = await apiClient.get(`/api/v1/growth-intelligence-os/dashboard/${orgId}`);
    return response;
  },
};
