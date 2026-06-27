import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AIImageAnalysis {
  id: string;
  imageUrl: string;
  modelId: string;
  modelVersion: string;
  type: string;
  results: {
    objects: Array<{
      name: string;
      confidence: number;
      bbox: {
        x: number;
        y: number;
        width: number;
        height: number;
      };
    }>;
    features: Array<{
      name: string;
      value: number;
      description: string;
    }>;
    quality: {
      sharpness: number;
      brightness: number;
      contrast: number;
      composition: number;
    };
    tags: string[];
  };
  confidence: number; // 0-1
  processingTime: number; // milliseconds
  status: "pending" | "completed" | "failed";
  errorMessage?: string;
  analyzedAt: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AIImageAnalysisState {
  analyses: AIImageAnalysis[];
  loading: boolean;
  error: string | null;
  selectedAnalysis: AIImageAnalysis | null;
  filters: {
    search: string;
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
  setAnalyses: (analyses: AIImageAnalysis[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedAnalysis: (analysis: AIImageAnalysis | null) => void;
  setFilters: (filters: Partial<AIImageAnalysisState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AIImageAnalysisState["pagination"]>
  ) => void;
  addAnalysis: (analysis: AIImageAnalysis) => void;
  updateAnalysis: (id: string, analysis: Partial<AIImageAnalysis>) => void;
  removeAnalysis: (id: string) => void;
  clearFilters: () => void;
}

export const useAIImageAnalysisStore = create<AIImageAnalysisState>()(
  devtools(
    (set) => ({
      analyses: [],
      loading: false,
      error: null,
      selectedAnalysis: null,
      filters: {
        search: "",
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
            modelId: "all",
            type: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "ai-image-analysis-store" }
  )
);
