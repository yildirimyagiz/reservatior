import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Investment {
  id: string;
  name: string;
  type: string;
  amount: number;
  currency: string;
  status: "active" | "completed" | "cancelled";
  expectedReturn: number;
  actualReturn?: number;
  startDate: Date;
  endDate?: Date;
  investorId: string;
  propertyId?: string;
  description?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface InvestmentState {
  investments: Investment[];
  loading: boolean;
  error: string | null;
  selectedInvestment: Investment | null;
  filters: {
    search: string;
    type: string;
    status: string;
    investorId: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setInvestments: (investments: Investment[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedInvestment: (investment: Investment | null) => void;
  setFilters: (filters: Partial<InvestmentState["filters"]>) => void;
  setPagination: (pagination: Partial<InvestmentState["pagination"]>) => void;
  addInvestment: (investment: Investment) => void;
  updateInvestment: (id: string, investment: Partial<Investment>) => void;
  removeInvestment: (id: string) => void;
  clearFilters: () => void;
}

export const useInvestmentsStore = create<InvestmentState>()(
  devtools(
    (set) => ({
      investments: [],
      loading: false,
      error: null,
      selectedInvestment: null,
      filters: {
        search: "",
        type: "all",
        status: "all",
        investorId: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setInvestments: (investments) => set({ investments }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedInvestment: (selectedInvestment) =>
        set({ selectedInvestment }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addInvestment: (investment) =>
        set((state) => ({ investments: [...state.investments, investment] })),
      updateInvestment: (id, updatedInvestment) =>
        set((state) => ({
          investments: state.investments.map((i) =>
            i.id === id ? { ...i, ...updatedInvestment } : i
          ),
        })),
      removeInvestment: (id) =>
        set((state) => ({
          investments: state.investments.filter((i) => i.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            status: "all",
            investorId: "all",
          },
        }),
    }),
    { name: "investments-store" }
  )
);
