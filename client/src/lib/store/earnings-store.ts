import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Earning {
  id: string;
  amount: number;
  currency: string;
  userId: string;
  type: string;
  source: string;
  description?: string;
  status: "pending" | "approved" | "paid" | "cancelled";
  earnedDate: Date;
  paidDate?: Date;
  period: {
    start: Date;
    end: Date;
  };
  commissionRate?: number;
  bonusAmount?: number;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface EarningsState {
  earnings: Earning[];
  loading: boolean;
  error: string | null;
  selectedEarning: Earning | null;
  filters: {
    search: string;
    userId: string;
    type: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setEarnings: (earnings: Earning[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedEarning: (earning: Earning | null) => void;
  setFilters: (filters: Partial<EarningsState["filters"]>) => void;
  setPagination: (pagination: Partial<EarningsState["pagination"]>) => void;
  addEarning: (earning: Earning) => void;
  updateEarning: (id: string, earning: Partial<Earning>) => void;
  removeEarning: (id: string) => void;
  clearFilters: () => void;
}

export const useEarningsStore = create<EarningsState>()(
  devtools(
    (set) => ({
      earnings: [],
      loading: false,
      error: null,
      selectedEarning: null,
      filters: {
        search: "",
        userId: "all",
        type: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setEarnings: (earnings) => set({ earnings }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedEarning: (selectedEarning) => set({ selectedEarning }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addEarning: (earning) =>
        set((state) => ({ earnings: [...state.earnings, earning] })),
      updateEarning: (id, updatedEarning) =>
        set((state) => ({
          earnings: state.earnings.map((e) =>
            e.id === id ? { ...e, ...updatedEarning } : e
          ),
        })),
      removeEarning: (id) =>
        set((state) => ({
          earnings: state.earnings.filter((e) => e.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            userId: "all",
            type: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "earnings-store" }
  )
);
