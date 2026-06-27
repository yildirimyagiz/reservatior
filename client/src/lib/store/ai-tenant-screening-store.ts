import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AITenantScreening {
  id: string;
  applicantId: string;
  modelId: string;
  modelVersion: string;
  overallScore: number; // 0-100
  riskLevel: "low" | "medium" | "high";
  confidence: number; // 0-1
  categories: {
    credit: {
      score: number;
      weight: number;
      factors: string[];
    };
    income: {
      score: number;
      weight: number;
      factors: string[];
    };
    employment: {
      score: number;
      weight: number;
      factors: string[];
    };
    rental: {
      score: number;
      weight: number;
      factors: string[];
    };
    background: {
      score: number;
      weight: number;
      factors: string[];
    };
  };
  redFlags: Array<{
    type: string;
    severity: "low" | "medium" | "high";
    description: string;
    impact: number;
  }>;
  recommendations: string[];
  status: "pending" | "completed" | "failed";
  errorMessage?: string;
  screenedAt: Date;
  expiresAt: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AITenantScreeningState {
  screenings: AITenantScreening[];
  loading: boolean;
  error: string | null;
  selectedScreening: AITenantScreening | null;
  filters: {
    search: string;
    applicantId: string;
    modelId: string;
    riskLevel: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setScreenings: (screenings: AITenantScreening[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedScreening: (screening: AITenantScreening | null) => void;
  setFilters: (filters: Partial<AITenantScreeningState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AITenantScreeningState["pagination"]>
  ) => void;
  addScreening: (screening: AITenantScreening) => void;
  updateScreening: (id: string, screening: Partial<AITenantScreening>) => void;
  removeScreening: (id: string) => void;
  clearFilters: () => void;
}

export const useAITenantScreeningStore = create<AITenantScreeningState>()(
  devtools(
    (set) => ({
      screenings: [],
      loading: false,
      error: null,
      selectedScreening: null,
      filters: {
        search: "",
        applicantId: "all",
        modelId: "all",
        riskLevel: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setScreenings: (screenings) => set({ screenings }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedScreening: (selectedScreening) => set({ selectedScreening }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addScreening: (screening) =>
        set((state) => ({ screenings: [...state.screenings, screening] })),
      updateScreening: (id, updatedScreening) =>
        set((state) => ({
          screenings: state.screenings.map((s) =>
            s.id === id ? { ...s, ...updatedScreening } : s
          ),
        })),
      removeScreening: (id) =>
        set((state) => ({
          screenings: state.screenings.filter((s) => s.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            applicantId: "all",
            modelId: "all",
            riskLevel: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "ai-tenant-screening-store" }
  )
);
