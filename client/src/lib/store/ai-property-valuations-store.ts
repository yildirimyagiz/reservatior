import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AIPropertyValuation {
  id: string;
  propertyId: string;
  modelId: string;
  modelVersion: string;
  estimatedValue: number;
  currency: string;
  confidence: number; // 0-1
  valueRange: {
    low: number;
    high: number;
  };
  comparableProperties: Array<{
    propertyId: string;
    address: string;
    price: number;
    similarity: number; // 0-1
    distance: number; // meters
  }>;
  factors: Array<{
    name: string;
    impact: number; // positive or negative
    weight: number; // importance in model
  }>;
  status: "pending" | "completed" | "failed";
  errorMessage?: string;
  valuationDate: Date;
  expiresAt: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AIPropertyValuationsState {
  valuations: AIPropertyValuation[];
  loading: boolean;
  error: string | null;
  selectedValuation: AIPropertyValuation | null;
  filters: {
    search: string;
    propertyId: string;
    modelId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setValuations: (valuations: AIPropertyValuation[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedValuation: (valuation: AIPropertyValuation | null) => void;
  setFilters: (filters: Partial<AIPropertyValuationsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AIPropertyValuationsState["pagination"]>
  ) => void;
  addValuation: (valuation: AIPropertyValuation) => void;
  updateValuation: (
    id: string,
    valuation: Partial<AIPropertyValuation>
  ) => void;
  removeValuation: (id: string) => void;
  clearFilters: () => void;
}

export const useAIPropertyValuationsStore = create<AIPropertyValuationsState>()(
  devtools(
    (set) => ({
      valuations: [],
      loading: false,
      error: null,
      selectedValuation: null,
      filters: {
        search: "",
        propertyId: "all",
        modelId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setValuations: (valuations) => set({ valuations }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedValuation: (selectedValuation) => set({ selectedValuation }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addValuation: (valuation) =>
        set((state) => ({ valuations: [...state.valuations, valuation] })),
      updateValuation: (id, updatedValuation) =>
        set((state) => ({
          valuations: state.valuations.map((v) =>
            v.id === id ? { ...v, ...updatedValuation } : v
          ),
        })),
      removeValuation: (id) =>
        set((state) => ({
          valuations: state.valuations.filter((v) => v.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyId: "all",
            modelId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "ai-property-valuations-store" }
  )
);
