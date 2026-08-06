import { create } from 'zustand';
import { Match, DemandSignal, SupplySignal, MatchStatus } from '../api/marketplace-os';

interface MarketplaceOSState {
  matches: Match[];
  demandSignals: DemandSignal[];
  supplySignals: SupplySignal[];
  loading: boolean;
  error: string | null;
  analyzeDemand: (location: string, propertyType?: string) => Promise<void>;
  analyzeSupply: (location: string, propertyType?: string) => Promise<void>;
  matchTenantToProperty: (tenantId: string, propertyId: string) => Promise<void>;
  getRecommendations: (entityType: string, entityId: string, limit?: number) => Promise<void>;
  createMatch: (data: Omit<Match, 'id' | 'createdAt'>) => Promise<void>;
  updateMatchStatus: (matchId: string, status: MatchStatus) => Promise<void>;
  getMatchHistory: (entityId: string, limit?: number) => Promise<void>;
}

export const useMarketplaceOSStore = create<MarketplaceOSState>((set) => ({
  matches: [],
  demandSignals: [],
  supplySignals: [],
  loading: false,
  error: null,

  analyzeDemand: async (location: string, propertyType?: string) => {
    set({ loading: true, error: null });
    try {
      const { marketplaceOSApi } = await import('../api/marketplace-os');
      const signals = await marketplaceOSApi.analyzeDemand(location, propertyType);
      set({ demandSignals: signals, loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  analyzeSupply: async (location: string, propertyType?: string) => {
    set({ loading: true, error: null });
    try {
      const { marketplaceOSApi } = await import('../api/marketplace-os');
      const signals = await marketplaceOSApi.analyzeSupply(location, propertyType);
      set({ supplySignals: signals, loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  matchTenantToProperty: async (tenantId: string, propertyId: string) => {
    set({ loading: true, error: null });
    try {
      const { marketplaceOSApi } = await import('../api/marketplace-os');
      const match = await marketplaceOSApi.matchTenantToProperty(tenantId, propertyId);
      set(state => ({ matches: [...state.matches, match], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  getRecommendations: async (entityType: string, entityId: string, limit?: number) => {
    set({ loading: true, error: null });
    try {
      const { marketplaceOSApi } = await import('../api/marketplace-os');
      const recommendations = await marketplaceOSApi.getRecommendations(entityType, entityId, limit);
      set({ matches: recommendations, loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  createMatch: async (data) => {
    set({ loading: true, error: null });
    try {
      const { marketplaceOSApi } = await import('../api/marketplace-os');
      const match = await marketplaceOSApi.createMatch(data);
      set(state => ({ matches: [...state.matches, match], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  updateMatchStatus: async (matchId: string, status: MatchStatus) => {
    set({ loading: true, error: null });
    try {
      const { marketplaceOSApi } = await import('../api/marketplace-os');
      const match = await marketplaceOSApi.updateMatchStatus(matchId, status);
      set(state => ({
        matches: state.matches.map(m => m.id === matchId ? match : m),
        loading: false,
      }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  getMatchHistory: async (entityId: string, limit?: number) => {
    set({ loading: true, error: null });
    try {
      const { marketplaceOSApi } = await import('../api/marketplace-os');
      const history = await marketplaceOSApi.getMatchHistory(entityId, limit);
      set({ matches: history, loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },
}));
