import { create } from 'zustand';
import { Prediction, PredictionSummary } from '../api/data-intelligence-os';

interface DataIntelligenceOSState {
  predictions: Prediction[];
  summary: PredictionSummary | null;
  loading: boolean;
  error: string | null;
  predictPropertyValuation: (propertyId: string) => Promise<void>;
  predictRentalIncome: (propertyId: string) => Promise<void>;
  predictVacancy: (propertyId: string) => Promise<void>;
  predictTenantLTV: (tenantId: string) => Promise<void>;
  predictMarketTrends: (location: string) => Promise<void>;
  optimizePortfolio: (orgId: string) => Promise<void>;
  getSummary: (orgId?: string) => Promise<void>;
}

export const useDataIntelligenceOSStore = create<DataIntelligenceOSState>((set) => ({
  predictions: [],
  summary: null,
  loading: false,
  error: null,

  predictPropertyValuation: async (propertyId: string) => {
    set({ loading: true, error: null });
    try {
      const { dataIntelligenceOSApi } = await import('../api/data-intelligence-os');
      const prediction = await dataIntelligenceOSApi.predictPropertyValuation(propertyId);
      set(state => ({ predictions: [...state.predictions, prediction], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  predictRentalIncome: async (propertyId: string) => {
    set({ loading: true, error: null });
    try {
      const { dataIntelligenceOSApi } = await import('../api/data-intelligence-os');
      const prediction = await dataIntelligenceOSApi.predictRentalIncome(propertyId);
      set(state => ({ predictions: [...state.predictions, prediction], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  predictVacancy: async (propertyId: string) => {
    set({ loading: true, error: null });
    try {
      const { dataIntelligenceOSApi } = await import('../api/data-intelligence-os');
      const prediction = await dataIntelligenceOSApi.predictVacancy(propertyId);
      set(state => ({ predictions: [...state.predictions, prediction], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  predictTenantLTV: async (tenantId: string) => {
    set({ loading: true, error: null });
    try {
      const { dataIntelligenceOSApi } = await import('../api/data-intelligence-os');
      const prediction = await dataIntelligenceOSApi.predictTenantLTV(tenantId);
      set(state => ({ predictions: [...state.predictions, prediction], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  predictMarketTrends: async (location: string) => {
    set({ loading: true, error: null });
    try {
      const { dataIntelligenceOSApi } = await import('../api/data-intelligence-os');
      const prediction = await dataIntelligenceOSApi.predictMarketTrends(location);
      set(state => ({ predictions: [...state.predictions, prediction], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  optimizePortfolio: async (orgId: string) => {
    set({ loading: true, error: null });
    try {
      const { dataIntelligenceOSApi } = await import('../api/data-intelligence-os');
      const prediction = await dataIntelligenceOSApi.optimizePortfolio(orgId);
      set(state => ({ predictions: [...state.predictions, prediction], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  getSummary: async (orgId?: string) => {
    set({ loading: true, error: null });
    try {
      const { dataIntelligenceOSApi } = await import('../api/data-intelligence-os');
      const summary = await dataIntelligenceOSApi.getSummary(orgId);
      set({ summary, loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },
}));
