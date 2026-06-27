import { create } from "zustand";
import { devtools } from "zustand/middleware";
import { Deal } from "../api/deals";

export interface DealsState {
  deals: Deal[];
  loading: boolean;
  error: string | null;
  selectedDeal: Deal | null;
  filters: {
    search: string;
    dealType: string;
    status: string;
    agent: string;
    dateRange: [Date | null, Date | null];
    priceRange: [number, number];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setDeals: (deals: Deal[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedDeal: (deal: Deal | null) => void;
  setFilters: (filters: Partial<DealsState["filters"]>) => void;
  setPagination: (pagination: Partial<DealsState["pagination"]>) => void;
  addDeal: (deal: Deal) => void;
  updateDeal: (id: string, deal: Partial<Deal>) => void;
  removeDeal: (id: string) => void;
  clearFilters: () => void;
}

export const useDealsStore = create<DealsState>()(
  devtools(
    (set) => ({
      deals: [],
      loading: false,
      error: null,
      selectedDeal: null,
      filters: {
        search: "",
        dealType: "all",
        status: "all",
        agent: "all",
        dateRange: [null, null],
        priceRange: [0, 1000000],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setDeals: (deals) => set({ deals }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedDeal: (selectedDeal) => set({ selectedDeal }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addDeal: (deal) => set((state) => ({ deals: [...state.deals, deal] })),
      updateDeal: (id, updatedDeal) =>
        set((state) => ({
          deals: state.deals.map((d) =>
            d.id === id ? { ...d, ...updatedDeal } : d
          ),
        })),
      removeDeal: (id) =>
        set((state) => ({
          deals: state.deals.filter((d) => d.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            dealType: "all",
            status: "all",
            agent: "all",
            dateRange: [null, null],
            priceRange: [0, 1000000],
          },
        }),
    }),
    { name: "deals-store" }
  )
);
