import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface InvestorPortfolio {
  id: string;
  investorId: string;
  name: string;
  description?: string;
  totalValue: number;
  currency: string;
  expectedReturn: number;
  riskLevel: "low" | "medium" | "high";
  properties: string[]; // property IDs
  investments: string[]; // investment IDs
  status: "active" | "inactive" | "liquidated";
  createdAt: Date;
  updatedAt: Date;
}

export interface InvestorPortfoliosState {
  portfolios: InvestorPortfolio[];
  loading: boolean;
  error: string | null;
  selectedPortfolio: InvestorPortfolio | null;
  filters: {
    search: string;
    investorId: string;
    riskLevel: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setPortfolios: (portfolios: InvestorPortfolio[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedPortfolio: (portfolio: InvestorPortfolio | null) => void;
  setFilters: (filters: Partial<InvestorPortfoliosState["filters"]>) => void;
  setPagination: (
    pagination: Partial<InvestorPortfoliosState["pagination"]>
  ) => void;
  addPortfolio: (portfolio: InvestorPortfolio) => void;
  updatePortfolio: (id: string, portfolio: Partial<InvestorPortfolio>) => void;
  removePortfolio: (id: string) => void;
  clearFilters: () => void;
}

export const useInvestorPortfoliosStore = create<InvestorPortfoliosState>()(
  devtools(
    (set) => ({
      portfolios: [],
      loading: false,
      error: null,
      selectedPortfolio: null,
      filters: {
        search: "",
        investorId: "all",
        riskLevel: "all",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setPortfolios: (portfolios) => set({ portfolios }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedPortfolio: (selectedPortfolio) => set({ selectedPortfolio }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addPortfolio: (portfolio) =>
        set((state) => ({ portfolios: [...state.portfolios, portfolio] })),
      updatePortfolio: (id, updatedPortfolio) =>
        set((state) => ({
          portfolios: state.portfolios.map((p) =>
            p.id === id ? { ...p, ...updatedPortfolio } : p
          ),
        })),
      removePortfolio: (id) =>
        set((state) => ({
          portfolios: state.portfolios.filter((p) => p.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            investorId: "all",
            riskLevel: "all",
            status: "all",
          },
        }),
    }),
    { name: "investor-portfolios-store" }
  )
);
