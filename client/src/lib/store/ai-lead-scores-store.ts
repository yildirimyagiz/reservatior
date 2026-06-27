import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AILeadScore {
  id: string;
  leadId: string;
  score: number;
  maxScore: number;
  factors: Array<{
    factor: string;
    weight: number;
    value: number;
  }>;
  modelId: string;
  confidence: number;
  recommendation: string;
  calculatedAt: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AILeadScoresState {
  leadScores: AILeadScore[];
  loading: boolean;
  error: string | null;
  selectedLeadScore: AILeadScore | null;
  filters: {
    search: string;
    leadId: string;
    scoreRange: [number, number];
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setLeadScores: (leadScores: AILeadScore[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedLeadScore: (leadScore: AILeadScore | null) => void;
  setFilters: (filters: Partial<AILeadScoresState["filters"]>) => void;
  setPagination: (pagination: Partial<AILeadScoresState["pagination"]>) => void;
  addLeadScore: (leadScore: AILeadScore) => void;
  updateLeadScore: (id: string, leadScore: Partial<AILeadScore>) => void;
  removeLeadScore: (id: string) => void;
  clearFilters: () => void;
}

export const useAILeadScoresStore = create<AILeadScoresState>()(
  devtools(
    (set) => ({
      leadScores: [],
      loading: false,
      error: null,
      selectedLeadScore: null,
      filters: {
        search: "",
        leadId: "all",
        scoreRange: [0, 100],
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setLeadScores: (leadScores) => set({ leadScores }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedLeadScore: (selectedLeadScore) => set({ selectedLeadScore }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addLeadScore: (leadScore) =>
        set((state) => ({ leadScores: [...state.leadScores, leadScore] })),
      updateLeadScore: (id, updatedLeadScore) =>
        set((state) => ({
          leadScores: state.leadScores.map((ls) =>
            ls.id === id ? { ...ls, ...updatedLeadScore } : ls
          ),
        })),
      removeLeadScore: (id) =>
        set((state) => ({
          leadScores: state.leadScores.filter((ls) => ls.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            leadId: "all",
            scoreRange: [0, 100],
            dateRange: [null, null],
          },
        }),
    }),
    { name: "ai-lead-scores-store" }
  )
);
