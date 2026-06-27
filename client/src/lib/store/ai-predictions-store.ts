import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AIPrediction {
  id: string;
  modelId: string;
  modelVersion: string;
  type: string;
  input: Record<string, any>;
  output: Record<string, any>;
  confidence: number; // 0-1
  status: "pending" | "completed" | "failed";
  errorMessage?: string;
  processingTime: number; // milliseconds
  cost?: number;
  currency?: string;
  userId?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AIPredictionsState {
  predictions: AIPrediction[];
  loading: boolean;
  error: string | null;
  selectedPrediction: AIPrediction | null;
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
  setPredictions: (predictions: AIPrediction[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedPrediction: (prediction: AIPrediction | null) => void;
  setFilters: (filters: Partial<AIPredictionsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AIPredictionsState["pagination"]>
  ) => void;
  addPrediction: (prediction: AIPrediction) => void;
  updatePrediction: (id: string, prediction: Partial<AIPrediction>) => void;
  removePrediction: (id: string) => void;
  clearFilters: () => void;
}

export const useAIPredictionsStore = create<AIPredictionsState>()(
  devtools(
    (set) => ({
      predictions: [],
      loading: false,
      error: null,
      selectedPrediction: null,
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
      setPredictions: (predictions) => set({ predictions }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedPrediction: (selectedPrediction) =>
        set({ selectedPrediction }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addPrediction: (prediction) =>
        set((state) => ({ predictions: [...state.predictions, prediction] })),
      updatePrediction: (id, updatedPrediction) =>
        set((state) => ({
          predictions: state.predictions.map((p) =>
            p.id === id ? { ...p, ...updatedPrediction } : p
          ),
        })),
      removePrediction: (id) =>
        set((state) => ({
          predictions: state.predictions.filter((p) => p.id !== id),
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
    { name: "ai-predictions-store" }
  )
);
