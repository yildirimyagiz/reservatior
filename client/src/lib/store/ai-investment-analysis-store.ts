import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AIInvestmentAnalysis {
  id: string;
  propertyId: string;
  investorId: string;
  modelId: string;
  modelVersion: string;
  overallScore: number; // 0-100
  recommendation: "buy" | "hold" | "sell";
  confidence: number; // 0-1
  metrics: {
    capRate: number;
    cashOnCash: number;
    noi: number;
    grossYield: number;
    netYield: number;
    irr: number;
    npv: number;
  };
  projections: {
    year1: number;
    year3: number;
    year5: number;
    year10: number;
  };
  risks: Array<{
    type: string;
    level: "low" | "medium" | "high";
    description: string;
    impact: number;
  }>;
  opportunities: Array<{
    type: string;
    potential: number;
    description: string;
  }>;
  marketFactors: Array<{
    name: string;
    trend: "positive" | "negative" | "neutral";
    impact: number;
  }>;
  status: "pending" | "completed" | "failed";
  errorMessage?: string;
  analyzedAt: Date;
  expiresAt: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AIInvestmentAnalysisState {
  analyses: AIInvestmentAnalysis[];
  loading: boolean;
  error: string | null;
  selectedAnalysis: AIInvestmentAnalysis | null;
  filters: {
    search: string;
    propertyId: string;
    investorId: string;
    modelId: string;
    recommendation: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setAnalyses: (analyses: AIInvestmentAnalysis[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedAnalysis: (analysis: AIInvestmentAnalysis | null) => void;
  setFilters: (filters: Partial<AIInvestmentAnalysisState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AIInvestmentAnalysisState["pagination"]>
  ) => void;
  addAnalysis: (analysis: AIInvestmentAnalysis) => void;
  updateAnalysis: (id: string, analysis: Partial<AIInvestmentAnalysis>) => void;
  removeAnalysis: (id: string) => void;
  clearFilters: () => void;
}

export const useAIInvestmentAnalysisStore = create<AIInvestmentAnalysisState>()(
  devtools(
    (set) => ({
      analyses: [],
      loading: false,
      error: null,
      selectedAnalysis: null,
      filters: {
        search: "",
        propertyId: "all",
        investorId: "all",
        modelId: "all",
        recommendation: "all",
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
            propertyId: "all",
            investorId: "all",
            modelId: "all",
            recommendation: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "ai-investment-analysis-store" }
  )
);
