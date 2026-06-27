import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AISentimentAnalysis {
  id: string;
  text: string;
  modelId: string;
  modelVersion: string;
  sentiment: "positive" | "negative" | "neutral";
  score: number; // -1 to 1
  confidence: number; // 0-1
  emotions: {
    joy: number;
    sadness: number;
    anger: number;
    fear: number;
    surprise: number;
    disgust: number;
  };
  keywords: Array<{
    word: string;
    sentiment: string;
    score: number;
  }>;
  entities: Array<{
    text: string;
    type: string;
    sentiment: string;
  }>;
  processingTime: number; // milliseconds
  status: "pending" | "completed" | "failed";
  errorMessage?: string;
  analyzedAt: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AISentimentAnalysisState {
  analyses: AISentimentAnalysis[];
  loading: boolean;
  error: string | null;
  selectedAnalysis: AISentimentAnalysis | null;
  filters: {
    search: string;
    modelId: string;
    sentiment: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setAnalyses: (analyses: AISentimentAnalysis[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedAnalysis: (analysis: AISentimentAnalysis | null) => void;
  setFilters: (filters: Partial<AISentimentAnalysisState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AISentimentAnalysisState["pagination"]>
  ) => void;
  addAnalysis: (analysis: AISentimentAnalysis) => void;
  updateAnalysis: (id: string, analysis: Partial<AISentimentAnalysis>) => void;
  removeAnalysis: (id: string) => void;
  clearFilters: () => void;
}

export const useAISentimentAnalysisStore = create<AISentimentAnalysisState>()(
  devtools(
    (set) => ({
      analyses: [],
      loading: false,
      error: null,
      selectedAnalysis: null,
      filters: {
        search: "",
        modelId: "all",
        sentiment: "all",
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
            modelId: "all",
            sentiment: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "ai-sentiment-analysis-store" }
  )
);
