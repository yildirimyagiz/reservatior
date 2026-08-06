import { create } from 'zustand';
import { devtools } from 'zustand/middleware';
import type { AdCampaign, AdNetworkConfig, AdBudgetShiftEvent, AdArbitrageReport } from '@/types/ad-router';

export interface AdRouterState {
  campaigns: AdCampaign[];
  networkConfigs: AdNetworkConfig[];
  budgetShifts: AdBudgetShiftEvent[];
  arbitrageReport: AdArbitrageReport | null;
  activeCampaignId: string | null;
  autoArbitrageEnabled: boolean;
  arbitrageIntervalMs: number;
  loading: boolean;
  error: string | null;

  setCampaigns: (campaigns: AdCampaign[]) => void;
  updateCampaign: (id: string, updates: Partial<AdCampaign>) => void;
  setNetworkConfigs: (configs: AdNetworkConfig[]) => void;
  updateNetworkConfig: (network: string, updates: Partial<AdNetworkConfig>) => void;
  setBudgetShifts: (shifts: AdBudgetShiftEvent[]) => void;
  addBudgetShift: (shift: AdBudgetShiftEvent) => void;
  setArbitrageReport: (report: AdArbitrageReport) => void;
  setActiveCampaign: (id: string | null) => void;
  setAutoArbitrage: (enabled: boolean) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  clearError: () => void;
  reset: () => void;
}

export const useAdRouterStore = create<AdRouterState>()(
  devtools(
    (set) => ({
      campaigns: [],
      networkConfigs: [],
      budgetShifts: [],
      arbitrageReport: null,
      activeCampaignId: null,
      autoArbitrageEnabled: true,
      arbitrageIntervalMs: 300000,
      loading: false,
      error: null,

      setCampaigns: (campaigns) => set({ campaigns }),
      updateCampaign: (id, updates) =>
        set((state) => ({
          campaigns: state.campaigns.map((c) =>
            c.id === id ? { ...c, ...updates } : c
          ),
        })),
      setNetworkConfigs: (networkConfigs) => set({ networkConfigs }),
      updateNetworkConfig: (network, updates) =>
        set((state) => ({
          networkConfigs: state.networkConfigs.map((n) =>
            n.network === network ? { ...n, ...updates } : n
          ),
        })),
      setBudgetShifts: (budgetShifts) => set({ budgetShifts }),
      addBudgetShift: (shift) =>
        set((state) => ({
          budgetShifts: [shift, ...state.budgetShifts].slice(0, 100),
        })),
      setArbitrageReport: (arbitrageReport) => set({ arbitrageReport }),
      setActiveCampaign: (activeCampaignId) => set({ activeCampaignId }),
      setAutoArbitrage: (autoArbitrageEnabled) => set({ autoArbitrageEnabled }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      clearError: () => set({ error: null }),
      reset: () =>
        set({
          campaigns: [],
          networkConfigs: [],
          budgetShifts: [],
          arbitrageReport: null,
          activeCampaignId: null,
          autoArbitrageEnabled: true,
          arbitrageIntervalMs: 300000,
          loading: false,
          error: null,
        }),
    }),
    { name: 'ad-router-store' }
  )
);
