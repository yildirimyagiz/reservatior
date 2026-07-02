import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AIPriceOptimization {
  id: string;
  propertyId: string;
  modelId: string;
  modelVersion: string;
  currentPrice: number;
  recommendedPrice: number;
  currency: string;
  confidence: number; // 0-1
  priceRange: {
    minimum: number;
    maximum: number;
  };
  factors: Array<{
    name: string;
    impact: number; // percentage change
    weight: number;
    currentValue: any;
    recommendation: string;
  }>;
  marketData: {
    comparableListings: number;
    averagePrice: number;
    pricePerSqFt: number;
    daysOnMarket: number;
  };
  timeline: Array<{
    date: Date;
    price: number;
    reasoning: string;
  }>;
  status: "pending" | "completed" | "failed";
  errorMessage?: string;
  optimizedAt: Date;
  expiresAt: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AIPriceOptimizationState {
  optimizations: AIPriceOptimization[];
  loading: boolean;
  error: string | null;
  selectedOptimization: AIPriceOptimization | null;
  filters: {
    search: string;
    propertyId: string;
    modelId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setOptimizations: (optimizations: AIPriceOptimization[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedOptimization: (optimization: AIPriceOptimization | null) => void;
  setFilters: (filters: Partial<AIPriceOptimizationState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AIPriceOptimizationState["pagination"]>
  ) => void;
  addOptimization: (optimization: AIPriceOptimization) => void;
  updateOptimization: (
    id: string,
    optimization: Partial<AIPriceOptimization>
  ) => void;
  removeOptimization: (id: string) => void;
  clearFilters: () => void;
}

export const useAIPriceOptimizationStore = create<AIPriceOptimizationState>()(
  devtools(
    (set) => ({
      optimizations: [],
      loading: false,
      error: null,
      selectedOptimization: null,
      filters: {
        search: "",
        propertyId: "all",
        modelId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setOptimizations: (optimizations) => set({ optimizations }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedOptimization: (selectedOptimization) =>
        set({ selectedOptimization }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addOptimization: (optimization) =>
        set((state) => ({
          optimizations: [...state.optimizations, optimization],
        })),
      updateOptimization: (id, updatedOptimization) =>
        set((state) => ({
          optimizations: state.optimizations.map((o) =>
            o.id === id ? { ...o, ...updatedOptimization } : o
          ),
        })),
      removeOptimization: (id) =>
        set((state) => ({
          optimizations: state.optimizations.filter((o) => o.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyId: "all",
            modelId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "ai-price-optimization-store" }
  )
);
