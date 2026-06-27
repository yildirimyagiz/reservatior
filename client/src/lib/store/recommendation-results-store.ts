import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface RecommendationResult {
  id: string;
  recommendationId: string;
  userId?: string;
  propertyId?: string;
  leadId?: string;
  score: number;
  confidence: number;
  factors: Array<{
    factor: string;
    weight: number;
    value: number;
  }>;
  explanation: string;
  status: "pending" | "viewed" | "accepted" | "dismissed";
  createdAt: Date;
  updatedAt: Date;
}

export interface RecommendationResultsState {
  results: RecommendationResult[];
  loading: boolean;
  error: string | null;
  selectedResult: RecommendationResult | null;
  filters: {
    search: string;
    recommendationId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setResults: (results: RecommendationResult[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedResult: (result: RecommendationResult | null) => void;
  setFilters: (filters: Partial<RecommendationResultsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<RecommendationResultsState["pagination"]>
  ) => void;
  addResult: (result: RecommendationResult) => void;
  updateResult: (id: string, result: Partial<RecommendationResult>) => void;
  removeResult: (id: string) => void;
  clearFilters: () => void;
}

export const useRecommendationResultsStore =
  create<RecommendationResultsState>()(
    devtools(
      (set) => ({
        results: [],
        loading: false,
        error: null,
        selectedResult: null,
        filters: {
          search: "",
          recommendationId: "all",
          status: "all",
          dateRange: [null, null],
        },
        pagination: {
          page: 1,
          limit: 20,
          total: 0,
        },
        setResults: (results) => set({ results }),
        setLoading: (loading) => set({ loading }),
        setError: (error) => set({ error }),
        setSelectedResult: (selectedResult) => set({ selectedResult }),
        setFilters: (filters) =>
          set((state) => ({ filters: { ...state.filters, ...filters } })),
        setPagination: (pagination) =>
          set((state) => ({
            pagination: { ...state.pagination, ...pagination },
          })),
        addResult: (result) =>
          set((state) => ({ results: [...state.results, result] })),
        updateResult: (id, updatedResult) =>
          set((state) => ({
            results: state.results.map((r) =>
              r.id === id ? { ...r, ...updatedResult } : r
            ),
          })),
        removeResult: (id) =>
          set((state) => ({
            results: state.results.filter((r) => r.id !== id),
          })),
        clearFilters: () =>
          set({
            filters: {
              search: "",
              recommendationId: "all",
              status: "all",
              dateRange: [null, null],
            },
          }),
      }),
      { name: "recommendation-results-store" }
    )
  );
