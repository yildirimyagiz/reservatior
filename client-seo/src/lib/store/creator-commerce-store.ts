import { create } from 'zustand';
import { devtools } from 'zustand/middleware';
import type {
  CreatorProfile,
  CreatorContent,
  AdLiquidityPool,
  ZeroUpfrontCampaign,
  CreatorPayout,
  ClosedLoopSettlement,
} from '@/types/creator-commerce';

interface CreatorCommerceState {
  creators: CreatorProfile[];
  contents: CreatorContent[];
  liquidityPool: AdLiquidityPool | null;
  zeroUpfrontCampaigns: ZeroUpfrontCampaign[];
  settlements: ClosedLoopSettlement[];
  payouts: CreatorPayout[];
  activeCreatorId: string | null;
  loading: boolean;
  error: string | null;

  setCreators: (creators: CreatorProfile[]) => void;
  updateCreator: (id: string, updates: Partial<CreatorProfile>) => void;
  setContents: (contents: CreatorContent[]) => void;
  addContent: (content: CreatorContent) => void;
  setLiquidityPool: (pool: AdLiquidityPool) => void;
  updateLiquidityPool: (updates: Partial<AdLiquidityPool>) => void;
  setZeroUpfrontCampaigns: (campaigns: ZeroUpfrontCampaign[]) => void;
  addZeroUpfrontCampaign: (campaign: ZeroUpfrontCampaign) => void;
  setSettlements: (settlements: ClosedLoopSettlement[]) => void;
  setPayouts: (payouts: CreatorPayout[]) => void;
  setActiveCreator: (id: string | null) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  clearError: () => void;
  reset: () => void;
}

export const useCreatorCommerceStore = create<CreatorCommerceState>()(
  devtools(
    (set) => ({
      creators: [],
      contents: [],
      liquidityPool: null,
      zeroUpfrontCampaigns: [],
      settlements: [],
      payouts: [],
      activeCreatorId: null,
      loading: false,
      error: null,

      setCreators: (creators) => set({ creators }),
      updateCreator: (id, updates) =>
        set((state) => ({
          creators: state.creators.map((c) =>
            c.id === id ? { ...c, ...updates } : c
          ),
        })),
      setContents: (contents) => set({ contents }),
      addContent: (content) =>
        set((state) => ({
          contents: [content, ...state.contents],
        })),
      setLiquidityPool: (liquidityPool) => set({ liquidityPool }),
      updateLiquidityPool: (updates) =>
        set((state) => ({
          liquidityPool: state.liquidityPool
            ? { ...state.liquidityPool, ...updates }
            : null,
        })),
      setZeroUpfrontCampaigns: (zeroUpfrontCampaigns) => set({ zeroUpfrontCampaigns }),
      addZeroUpfrontCampaign: (campaign) =>
        set((state) => ({
          zeroUpfrontCampaigns: [campaign, ...state.zeroUpfrontCampaigns],
        })),
      setSettlements: (settlements) => set({ settlements }),
      setPayouts: (payouts) => set({ payouts }),
      setActiveCreator: (activeCreatorId) => set({ activeCreatorId }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      clearError: () => set({ error: null }),
      reset: () =>
        set({
          creators: [],
          contents: [],
          liquidityPool: null,
          zeroUpfrontCampaigns: [],
          settlements: [],
          payouts: [],
          activeCreatorId: null,
          loading: false,
          error: null,
        }),
    }),
    { name: 'creator-commerce-store' }
  )
);
