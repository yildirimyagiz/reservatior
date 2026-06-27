import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AIRecommendation {
  id: string;
  type: string;
  title: string;
  description: string;
  userId?: string;
  propertyId?: string;
  leadId?: string;
  confidence: number;
  priority: "low" | "medium" | "high";
  status: "pending" | "viewed" | "accepted" | "dismissed";
  actionUrl?: string;
  metadata: Record<string, any>;
  modelId: string;
  generatedAt: Date;
  expiresAt?: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AIRecommendationsState {
  recommendations: AIRecommendation[];
  loading: boolean;
  error: string | null;
  selectedRecommendation: AIRecommendation | null;
  filters: {
    search: string;
    type: string;
    status: string;
    priority: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setRecommendations: (recommendations: AIRecommendation[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedRecommendation: (recommendation: AIRecommendation | null) => void;
  setFilters: (filters: Partial<AIRecommendationsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AIRecommendationsState["pagination"]>
  ) => void;
  addRecommendation: (recommendation: AIRecommendation) => void;
  updateRecommendation: (
    id: string,
    recommendation: Partial<AIRecommendation>
  ) => void;
  removeRecommendation: (id: string) => void;
  clearFilters: () => void;
}

export const useAIRecommendationsStore = create<AIRecommendationsState>()(
  devtools(
    (set) => ({
      recommendations: [],
      loading: false,
      error: null,
      selectedRecommendation: null,
      filters: {
        search: "",
        type: "all",
        status: "all",
        priority: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setRecommendations: (recommendations) => set({ recommendations }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedRecommendation: (selectedRecommendation) =>
        set({ selectedRecommendation }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addRecommendation: (recommendation) =>
        set((state) => ({
          recommendations: [...state.recommendations, recommendation],
        })),
      updateRecommendation: (id, updatedRecommendation) =>
        set((state) => ({
          recommendations: state.recommendations.map((r) =>
            r.id === id ? { ...r, ...updatedRecommendation } : r
          ),
        })),
      removeRecommendation: (id) =>
        set((state) => ({
          recommendations: state.recommendations.filter((r) => r.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            status: "all",
            priority: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "ai-recommendations-store" }
  )
);
