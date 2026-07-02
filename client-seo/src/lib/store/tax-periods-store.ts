import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface TaxPeriod {
  id: string;
  name: string;
  type: "monthly" | "quarterly" | "yearly";
  startDate: Date;
  endDate: Date;
  filingDeadline: Date;
  paymentDeadline: Date;
  status: "open" | "closed" | "filed" | "paid";
  totalIncome: number;
  totalExpenses: number;
  taxLiability: number;
  taxPaid: number;
  currency: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface TaxPeriodsState {
  periods: TaxPeriod[];
  loading: boolean;
  error: string | null;
  selectedPeriod: TaxPeriod | null;
  filters: {
    search: string;
    type: string;
    status: string;
    year: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setPeriods: (periods: TaxPeriod[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedPeriod: (period: TaxPeriod | null) => void;
  setFilters: (filters: Partial<TaxPeriodsState["filters"]>) => void;
  setPagination: (pagination: Partial<TaxPeriodsState["pagination"]>) => void;
  addPeriod: (period: TaxPeriod) => void;
  updatePeriod: (id: string, period: Partial<TaxPeriod>) => void;
  removePeriod: (id: string) => void;
  clearFilters: () => void;
}

export const useTaxPeriodsStore = create<TaxPeriodsState>()(
  devtools(
    (set) => ({
      periods: [],
      loading: false,
      error: null,
      selectedPeriod: null,
      filters: {
        search: "",
        type: "all",
        status: "all",
        year: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setPeriods: (periods) => set({ periods }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedPeriod: (selectedPeriod) => set({ selectedPeriod }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addPeriod: (period) =>
        set((state) => ({ periods: [...state.periods, period] })),
      updatePeriod: (id, updatedPeriod) =>
        set((state) => ({
          periods: state.periods.map((p) =>
            p.id === id ? { ...p, ...updatedPeriod } : p
          ),
        })),
      removePeriod: (id) =>
        set((state) => ({
          periods: state.periods.filter((p) => p.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            status: "all",
            year: "all",
          },
        }),
    }),
    { name: "tax-periods-store" }
  )
);
