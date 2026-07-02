import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface InvestmentStrategy {
  id: string;
  name: string;
  description?: string;
  type: string;
  objectives: string[];
  riskToleranceId: string;
  minInvestment: number;
  currency: string;
  expectedReturn: number; // percentage
  timeHorizon: number; // years
  assetAllocation: Array<{
    assetClass: string;
    percentage: number;
    min: number;
    max: number;
  }>;
  rebalancingFrequency: string;
  constraints: Array<{
    type: string;
    value: any;
    description: string;
  }>;
  performanceMetrics: {
    sharpeRatio?: number;
    sortinoRatio?: number;
    maxDrawdown?: number;
    volatility?: number;
  };
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface InvestmentStrategiesState {
  strategies: InvestmentStrategy[];
  loading: boolean;
  error: string | null;
  selectedStrategy: InvestmentStrategy | null;
  filters: {
    search: string;
    type: string;
    riskToleranceId: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setStrategies: (strategies: InvestmentStrategy[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedStrategy: (strategy: InvestmentStrategy | null) => void;
  setFilters: (filters: Partial<InvestmentStrategiesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<InvestmentStrategiesState["pagination"]>
  ) => void;
  addStrategy: (strategy: InvestmentStrategy) => void;
  updateStrategy: (id: string, strategy: Partial<InvestmentStrategy>) => void;
  removeStrategy: (id: string) => void;
  clearFilters: () => void;
}

export const useInvestmentStrategiesStore = create<InvestmentStrategiesState>()(
  devtools(
    (set) => ({
      strategies: [],
      loading: false,
      error: null,
      selectedStrategy: null,
      filters: {
        search: "",
        type: "all",
        riskToleranceId: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setStrategies: (strategies) => set({ strategies }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedStrategy: (selectedStrategy) => set({ selectedStrategy }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addStrategy: (strategy) =>
        set((state) => ({ strategies: [...state.strategies, strategy] })),
      updateStrategy: (id, updatedStrategy) =>
        set((state) => ({
          strategies: state.strategies.map((s) =>
            s.id === id ? { ...s, ...updatedStrategy } : s
          ),
        })),
      removeStrategy: (id) =>
        set((state) => ({
          strategies: state.strategies.filter((s) => s.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            riskToleranceId: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "investment-strategies-store" }
  )
);
