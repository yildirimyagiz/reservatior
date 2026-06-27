import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Payout {
  id: string;
  amount: number;
  currency: string;
  recipientId: string;
  recipientType: string;
  status: "pending" | "processing" | "completed" | "failed" | "cancelled";
  method: string;
  reference?: string;
  description?: string;
  fees?: number;
  netAmount?: number;
  processedAt?: Date;
  failedAt?: Date;
  failureReason?: string;
  organizationId: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface PayoutsState {
  payouts: Payout[];
  loading: boolean;
  error: string | null;
  selectedPayout: Payout | null;
  filters: {
    search: string;
    status: string;
    method: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setPayouts: (payouts: Payout[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedPayout: (payout: Payout | null) => void;
  setFilters: (filters: Partial<PayoutsState["filters"]>) => void;
  setPagination: (pagination: Partial<PayoutsState["pagination"]>) => void;
  addPayout: (payout: Payout) => void;
  updatePayout: (id: string, payout: Partial<Payout>) => void;
  removePayout: (id: string) => void;
  clearFilters: () => void;
}

export const usePayoutsStore = create<PayoutsState>()(
  devtools(
    (set) => ({
      payouts: [],
      loading: false,
      error: null,
      selectedPayout: null,
      filters: {
        search: "",
        status: "all",
        method: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setPayouts: (payouts) => set({ payouts }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedPayout: (selectedPayout) => set({ selectedPayout }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addPayout: (payout) =>
        set((state) => ({ payouts: [...state.payouts, payout] })),
      updatePayout: (id, updatedPayout) =>
        set((state) => ({
          payouts: state.payouts.map((p) =>
            p.id === id ? { ...p, ...updatedPayout } : p
          ),
        })),
      removePayout: (id) =>
        set((state) => ({
          payouts: state.payouts.filter((p) => p.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            status: "all",
            method: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "payouts-store" }
  )
);
