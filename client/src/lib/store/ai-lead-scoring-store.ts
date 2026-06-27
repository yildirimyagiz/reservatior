import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AILeadScoring {
  id: string;
  leadId: string;
  modelId: string;
  modelVersion: string;
  score: number; // 0-100
  confidence: number; // 0-1
  tier: "hot" | "warm" | "cold";
  factors: Array<{
    name: string;
    value: number;
    weight: number;
    impact: "positive" | "negative" | "neutral";
  }>;
  recommendations: string[];
  status: "pending" | "completed" | "failed";
  errorMessage?: string;
  scoredAt: Date;
  expiresAt: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AILeadScoringState {
  scorings: AILeadScoring[];
  loading: boolean;
  error: string | null;
  selectedScoring: AILeadScoring | null;
  filters: {
    search: string;
    leadId: string;
    modelId: string;
    tier: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setScorings: (scorings: AILeadScoring[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedScoring: (scoring: AILeadScoring | null) => void;
  setFilters: (filters: Partial<AILeadScoringState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AILeadScoringState["pagination"]>
  ) => void;
  addScoring: (scoring: AILeadScoring) => void;
  updateScoring: (id: string, scoring: Partial<AILeadScoring>) => void;
  removeScoring: (id: string) => void;
  clearFilters: () => void;
}

export const useAILeadScoringStore = create<AILeadScoringState>()(
  devtools(
    (set) => ({
      scorings: [],
      loading: false,
      error: null,
      selectedScoring: null,
      filters: {
        search: "",
        leadId: "all",
        modelId: "all",
        tier: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setScorings: (scorings) => set({ scorings }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedScoring: (selectedScoring) => set({ selectedScoring }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addScoring: (scoring) =>
        set((state) => ({ scorings: [...state.scorings, scoring] })),
      updateScoring: (id, updatedScoring) =>
        set((state) => ({
          scorings: state.scorings.map((s) =>
            s.id === id ? { ...s, ...updatedScoring } : s
          ),
        })),
      removeScoring: (id) =>
        set((state) => ({
          scorings: state.scorings.filter((s) => s.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            leadId: "all",
            modelId: "all",
            tier: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "ai-lead-scoring-store" }
  )
);
