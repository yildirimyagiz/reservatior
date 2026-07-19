import { create } from "zustand";
import { devtools } from "zustand/middleware";
import type {
  AssetListing,
  MarketplaceFilters,
  MarketplaceSummary,
  InvestmentOpportunity,
  PropertyMarketData,
} from "@/lib/api/asset-marketplace";

export interface AssetMarketplaceState {
  listings: AssetListing[];
  summary: MarketplaceSummary | null;
  opportunities: InvestmentOpportunity[];
  selectedProperty: PropertyMarketData | null;
  loading: boolean;
  error: string | null;
  filters: MarketplaceFilters;
  pagination: {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
  };
  setListings: (listings: AssetListing[]) => void;
  setSummary: (summary: MarketplaceSummary) => void;
  setOpportunities: (opportunities: InvestmentOpportunity[]) => void;
  setSelectedProperty: (property: PropertyMarketData | null) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setFilters: (filters: Partial<MarketplaceFilters>) => void;
  setPagination: (pagination: Partial<AssetMarketplaceState["pagination"]>) => void;
  clearFilters: () => void;
}

const defaultFilters: MarketplaceFilters = {
  sortBy: "price_desc",
  page: 1,
  limit: 20,
};

export const useAssetMarketplaceStore = create<AssetMarketplaceState>()(
  devtools(
    (set) => ({
      listings: [],
      summary: null,
      opportunities: [],
      selectedProperty: null,
      loading: false,
      error: null,
      filters: { ...defaultFilters },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
        totalPages: 0,
      },
      setListings: (listings) => set({ listings }),
      setSummary: (summary) => set({ summary }),
      setOpportunities: (opportunities) => set({ opportunities }),
      setSelectedProperty: (selectedProperty) => set({ selectedProperty }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setFilters: (filters) =>
        set((state) => ({
          filters: { ...state.filters, ...filters },
          pagination: { ...state.pagination, page: 1 },
        })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      clearFilters: () =>
        set({ filters: { ...defaultFilters }, pagination: { page: 1, limit: 20, total: 0, totalPages: 0 } }),
    }),
    { name: "asset-marketplace-store" }
  )
);
