import { create } from "zustand";
import { devtools } from "zustand/middleware";
import type { CommerceCampaign } from "@/lib/api/campaigns";

export interface CampaignsState {
  campaigns: CommerceCampaign[];
  loading: boolean;
  error: string | null;
  selectedCampaign: CommerceCampaign | null;
  filters: {
    search: string;
    status: string;
    campaignType: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setCampaigns: (campaigns: CommerceCampaign[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedCampaign: (campaign: CommerceCampaign | null) => void;
  setFilters: (filters: Partial<CampaignsState["filters"]>) => void;
  setPagination: (pagination: Partial<CampaignsState["pagination"]>) => void;
  addCampaign: (campaign: CommerceCampaign) => void;
  updateCampaign: (id: string, campaign: Partial<CommerceCampaign>) => void;
  removeCampaign: (id: string) => void;
  clearFilters: () => void;
}

export const useCampaignsStore = create<CampaignsState>()(
  devtools(
    (set) => ({
      campaigns: [],
      loading: false,
      error: null,
      selectedCampaign: null,
      filters: {
        search: "",
        status: "all",
        campaignType: "all",
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
        set({ filters: { search: "", status: "all", campaignType: "all" } }),
    }),
    { name: "campaigns-store" }
  )
);
