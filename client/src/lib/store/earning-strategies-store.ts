import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface EarningStrategy {
  id: string;
  name: string;
  description?: string;
  type: string;
  calculationMethod: string;
  parameters: Record<string, any>;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface EarningStrategiesState {
  strategies: EarningStrategy[];
  loading: boolean;
  error: string | null;
  selectedStrategy: EarningStrategy | null;
  filters: {
    search: string;
    type: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setStrategies: (strategies: EarningStrategy[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedStrategy: (strategy: EarningStrategy | null) => void;
  setFilters: (filters: Partial<EarningStrategiesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<EarningStrategiesState["pagination"]>
  ) => void;
  addStrategy: (strategy: EarningStrategy) => void;
  updateStrategy: (id: string, strategy: Partial<EarningStrategy>) => void;
  removeStrategy: (id: string) => void;
  clearFilters: () => void;
}

export const useEarningStrategiesStore = create<EarningStrategiesState>()(
  devtools(
    (set) => ({
      strategies: [],
      loading: false,
      error: null,
      selectedStrategy: null,
      filters: {
        search: "",
        type: "all",
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
            isActive: "all",
          },
        }),
    }),
    { name: "earning-strategies-store" }
  )
);
