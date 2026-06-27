import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface RiskTolerance {
  id: string;
  name: string;
  description?: string;
  level: "conservative" | "moderate" | "aggressive";
  score: number; // 1-10
  characteristics: string[];
  recommendedAllocations: Array<{
    assetClass: string;
    percentage: number;
  }>;
  maxVolatility: number; // percentage
  timeHorizon: number; // years
  liquidityNeeds: string;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface RiskTolerancesState {
  tolerances: RiskTolerance[];
  loading: boolean;
  error: string | null;
  selectedTolerance: RiskTolerance | null;
  filters: {
    search: string;
    level: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTolerances: (tolerances: RiskTolerance[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedTolerance: (tolerance: RiskTolerance | null) => void;
  setFilters: (filters: Partial<RiskTolerancesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<RiskTolerancesState["pagination"]>
  ) => void;
  addTolerance: (tolerance: RiskTolerance) => void;
  updateTolerance: (id: string, tolerance: Partial<RiskTolerance>) => void;
  removeTolerance: (id: string) => void;
  clearFilters: () => void;
}

export const useRiskTolerancesStore = create<RiskTolerancesState>()(
  devtools(
    (set) => ({
      tolerances: [],
      loading: false,
      error: null,
      selectedTolerance: null,
      filters: {
        search: "",
        level: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setTolerances: (tolerances) => set({ tolerances }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedTolerance: (selectedTolerance) => set({ selectedTolerance }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addTolerance: (tolerance) =>
        set((state) => ({ tolerances: [...state.tolerances, tolerance] })),
      updateTolerance: (id, updatedTolerance) =>
        set((state) => ({
          tolerances: state.tolerances.map((t) =>
            t.id === id ? { ...t, ...updatedTolerance } : t
          ),
        })),
      removeTolerance: (id) =>
        set((state) => ({
          tolerances: state.tolerances.filter((t) => t.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            level: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "risk-tolerances-store" }
  )
);
