import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ListingStatusHistory {
  id: string;
  listingId: string;
  fromStatus: string;
  toStatus: string;
  reason?: string;
  changedBy: string;
  changedAt: Date;
  metadata: Record<string, any>;
}

export interface ListingStatusHistoryState {
  statusHistory: ListingStatusHistory[];
  loading: boolean;
  error: string | null;
  selectedStatusHistory: ListingStatusHistory | null;
  filters: {
    search: string;
    listingId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setStatusHistory: (statusHistory: ListingStatusHistory[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedStatusHistory: (
    statusHistory: ListingStatusHistory | null
  ) => void;
  setFilters: (filters: Partial<ListingStatusHistoryState["filters"]>) => void;
  setPagination: (
    pagination: Partial<ListingStatusHistoryState["pagination"]>
  ) => void;
  addStatusHistory: (statusHistory: ListingStatusHistory) => void;
  updateStatusHistory: (
    id: string,
    statusHistory: Partial<ListingStatusHistory>
  ) => void;
  removeStatusHistory: (id: string) => void;
  clearFilters: () => void;
}

export const useListingStatusHistoryStore = create<ListingStatusHistoryState>()(
  devtools(
    (set) => ({
      statusHistory: [],
      loading: false,
      error: null,
      selectedStatusHistory: null,
      filters: {
        search: "",
        listingId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setStatusHistory: (statusHistory) => set({ statusHistory }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedStatusHistory: (selectedStatusHistory) =>
        set({ selectedStatusHistory }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addStatusHistory: (statusHistory) =>
        set((state) => ({
          statusHistory: [...state.statusHistory, statusHistory],
        })),
      updateStatusHistory: (id, updatedStatusHistory) =>
        set((state) => ({
          statusHistory: state.statusHistory.map((sh) =>
            sh.id === id ? { ...sh, ...updatedStatusHistory } : sh
          ),
        })),
      removeStatusHistory: (id) =>
        set((state) => ({
          statusHistory: state.statusHistory.filter((sh) => sh.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            listingId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "listing-status-history-store" }
  )
);
