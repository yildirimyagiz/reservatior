import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface MarketingCampaign {
  id: string;
  name: string;
  description?: string;
  type: string;
  status: "draft" | "active" | "paused" | "completed" | "cancelled";
  startDate: Date;
  endDate?: Date;
  budget: {
    total: number;
    spent: number;
    currency: string;
  };
  targetAudience: {
    criteria: Record<string, any>;
    estimatedReach: number;
  };
  channels: Array<{
    type: string;
    config: Record<string, any>;
  }>;
  metrics: {
    impressions: number;
    clicks: number;
    conversions: number;
    cost: number;
    roi: number;
  };
  organizationId: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface MarketingCampaignsState {
  campaigns: MarketingCampaign[];
  loading: boolean;
  error: string | null;
  selectedCampaign: MarketingCampaign | null;
  filters: {
    search: string;
    type: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setCampaigns: (campaigns: MarketingCampaign[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedCampaign: (campaign: MarketingCampaign | null) => void;
  setFilters: (filters: Partial<MarketingCampaignsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<MarketingCampaignsState["pagination"]>
  ) => void;
  addCampaign: (campaign: MarketingCampaign) => void;
  updateCampaign: (id: string, campaign: Partial<MarketingCampaign>) => void;
  removeCampaign: (id: string) => void;
  clearFilters: () => void;
}

export const useMarketingCampaignsStore = create<MarketingCampaignsState>()(
  devtools(
    (set) => ({
      campaigns: [],
      loading: false,
      error: null,
      selectedCampaign: null,
      filters: {
        search: "",
        type: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setCampaigns: (campaigns) => set({ campaigns }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedCampaign: (selectedCampaign) => set({ selectedCampaign }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addCampaign: (campaign) =>
        set((state) => ({ campaigns: [...state.campaigns, campaign] })),
      updateCampaign: (id, updatedCampaign) =>
        set((state) => ({
          campaigns: state.campaigns.map((c) =>
            c.id === id ? { ...c, ...updatedCampaign } : c
          ),
        })),
      removeCampaign: (id) =>
        set((state) => ({
          campaigns: state.campaigns.filter((c) => c.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "marketing-campaigns-store" }
  )
);
