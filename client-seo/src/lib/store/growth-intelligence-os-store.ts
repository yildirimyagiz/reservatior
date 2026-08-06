import { create } from 'zustand';
import { GrowthInsight, ChannelAnalysis, GrowthOpportunity, GrowthChannel } from '../api/growth-intelligence-os';

interface GrowthIntelligenceOSState {
  insights: GrowthInsight[];
  channelAnalyses: ChannelAnalysis[];
  opportunities: GrowthOpportunity[];
  loading: boolean;
  error: string | null;
  analyzeChannelQuality: (channel: GrowthChannel) => Promise<void>;
  analyzeAgentPerformance: (agentId: string) => Promise<void>;
  analyzeCityGrowthPotential: (city: string) => Promise<void>;
  analyzeUserSegmentTargeting: (segment: string) => Promise<void>;
  calculateConversionRate: (dimension: string) => Promise<void>;
  calculateRetentionRate: (dimension: string) => Promise<void>;
  calculateLifetimeValue: (dimension: string) => Promise<void>;
  calculateAcquisitionCost: (dimension: string) => Promise<void>;
  getGrowthOpportunities: (orgId: string) => Promise<void>;
}

export const useGrowthIntelligenceOSStore = create<GrowthIntelligenceOSState>((set) => ({
  insights: [],
  channelAnalyses: [],
  opportunities: [],
  loading: false,
  error: null,

  analyzeChannelQuality: async (channel: GrowthChannel) => {
    set({ loading: true, error: null });
    try {
      const { growthIntelligenceOSApi } = await import('../api/growth-intelligence-os');
      const analysis = await growthIntelligenceOSApi.analyzeChannelQuality(channel);
      set(state => ({ channelAnalyses: [...state.channelAnalyses, analysis], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  analyzeAgentPerformance: async (agentId: string) => {
    set({ loading: true, error: null });
    try {
      const { growthIntelligenceOSApi } = await import('../api/growth-intelligence-os');
      const insight = await growthIntelligenceOSApi.analyzeAgentPerformance(agentId);
      set(state => ({ insights: [...state.insights, insight], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  analyzeCityGrowthPotential: async (city: string) => {
    set({ loading: true, error: null });
    try {
      const { growthIntelligenceOSApi } = await import('../api/growth-intelligence-os');
      const opportunity = await growthIntelligenceOSApi.analyzeCityGrowthPotential(city);
      set(state => ({ opportunities: [...state.opportunities, opportunity], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  analyzeUserSegmentTargeting: async (segment: string) => {
    set({ loading: true, error: null });
    try {
      const { growthIntelligenceOSApi } = await import('../api/growth-intelligence-os');
      const insight = await growthIntelligenceOSApi.analyzeUserSegmentTargeting(segment);
      set(state => ({ insights: [...state.insights, insight], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  calculateConversionRate: async (dimension: string) => {
    set({ loading: true, error: null });
    try {
      const { growthIntelligenceOSApi } = await import('../api/growth-intelligence-os');
      const insight = await growthIntelligenceOSApi.calculateConversionRate(dimension);
      set(state => ({ insights: [...state.insights, insight], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  calculateRetentionRate: async (dimension: string) => {
    set({ loading: true, error: null });
    try {
      const { growthIntelligenceOSApi } = await import('../api/growth-intelligence-os');
      const insight = await growthIntelligenceOSApi.calculateRetentionRate(dimension);
      set(state => ({ insights: [...state.insights, insight], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  calculateLifetimeValue: async (dimension: string) => {
    set({ loading: true, error: null });
    try {
      const { growthIntelligenceOSApi } = await import('../api/growth-intelligence-os');
      const insight = await growthIntelligenceOSApi.calculateLifetimeValue(dimension);
      set(state => ({ insights: [...state.insights, insight], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  calculateAcquisitionCost: async (dimension: string) => {
    set({ loading: true, error: null });
    try {
      const { growthIntelligenceOSApi } = await import('../api/growth-intelligence-os');
      const insight = await growthIntelligenceOSApi.calculateAcquisitionCost(dimension);
      set(state => ({ insights: [...state.insights, insight], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  getGrowthOpportunities: async (orgId: string) => {
    set({ loading: true, error: null });
    try {
      const { growthIntelligenceOSApi } = await import('../api/growth-intelligence-os');
      const opportunities = await growthIntelligenceOSApi.getGrowthOpportunities(orgId);
      set({ opportunities, loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },
}));
