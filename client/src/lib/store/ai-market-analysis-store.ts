import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AIMarketAnalysis {
  id: string;
  regionId: string;
  modelId: string;
  modelVersion: string;
  type: string;
  timeframe: string;
  metrics: {
    averagePrice: number;
    pricePerSqFt: number;
    daysOnMarket: number;
    inventory: number;
    absorptionRate: number;
    priceTrend: "increasing" | "decreasing" | "stable";
    marketCondition: "buyers" | "sellers" | "balanced";
  };
  predictions: {
    priceChange: number; // percentage in next 6 months
    demandTrend: "increasing" | "decreasing" | "stable";
    supplyTrend: "increasing" | "decreasing" | "stable";
  };
  factors: Array<{
    name: string;
    impact: number;
    description: string;
  }>;
  confidence: number; // 0-1
  status: "pending" | "completed" | "failed";
  errorMessage?: string;
  analysisDate: Date;
  expiresAt: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AIMarketAnalysisState {
  analyses: AIMarketAnalysis[];
  loading: boolean;
  error: string | null;
  selectedAnalysis: AIMarketAnalysis | null;
  filters: {
    search: string;
    regionId: string;
    modelId: string;
    type: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setAnalyses: (analyses: AIMarketAnalysis[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedAnalysis: (analysis: AIMarketAnalysis | null) => void;
  setFilters: (filters: Partial<AIMarketAnalysisState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AIMarketAnalysisState["pagination"]>
  ) => void;
  addAnalysis: (analysis: AIMarketAnalysis) => void;
  updateAnalysis: (id: string, analysis: Partial<AIMarketAnalysis>) => void;
  removeAnalysis: (id: string) => void;
  clearFilters: () => void;
}

export const useAIMarketAnalysisStore = create<AIMarketAnalysisState>()(
  devtools(
    (set) => ({
      analyses: [],
      loading: false,
      error: null,
      selectedAnalysis: null,
      filters: {
        search: "",
        regionId: "all",
        modelId: "all",
        type: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setAnalyses: (analyses) => set({ analyses }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedAnalysis: (selectedAnalysis) => set({ selectedAnalysis }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addAnalysis: (analysis) =>
        set((state) => ({ analyses: [...state.analyses, analysis] })),
      updateAnalysis: (id, updatedAnalysis) =>
        set((state) => ({
          analyses: state.analyses.map((a) =>
            a.id === id ? { ...a, ...updatedAnalysis } : a
          ),
        })),
      removeAnalysis: (id) =>
        set((state) => ({
          analyses: state.analyses.filter((a) => a.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            regionId: "all",
            modelId: "all",
            type: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "ai-market-analysis-store" }
  )
);
