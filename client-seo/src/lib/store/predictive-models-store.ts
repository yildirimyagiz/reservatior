import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface PredictiveModel {
  id: string;
  name: string;
  type: string;
  description: string;
  version: string;
  status: "training" | "active" | "deprecated" | "failed";
  accuracy: number;
  precision: number;
  recall: number;
  f1Score: number;
  trainingData: {
    size: number;
    features: string[];
    lastTrained: Date;
  };
  parameters: Record<string, any>;
  organizationId: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface PredictiveModelsState {
  models: PredictiveModel[];
  loading: boolean;
  error: string | null;
  selectedModel: PredictiveModel | null;
  filters: {
    search: string;
    type: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setModels: (models: PredictiveModel[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedModel: (model: PredictiveModel | null) => void;
  setFilters: (filters: Partial<PredictiveModelsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<PredictiveModelsState["pagination"]>
  ) => void;
  addModel: (model: PredictiveModel) => void;
  updateModel: (id: string, model: Partial<PredictiveModel>) => void;
  removeModel: (id: string) => void;
  clearFilters: () => void;
}

export const usePredictiveModelsStore = create<PredictiveModelsState>()(
  devtools(
    (set) => ({
      models: [],
      loading: false,
      error: null,
      selectedModel: null,
      filters: {
        search: "",
        type: "all",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setModels: (models) => set({ models }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedModel: (selectedModel) => set({ selectedModel }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addModel: (model) =>
        set((state) => ({ models: [...state.models, model] })),
      updateModel: (id, updatedModel) =>
        set((state) => ({
          models: state.models.map((m) =>
            m.id === id ? { ...m, ...updatedModel } : m
          ),
        })),
      removeModel: (id) =>
        set((state) => ({
          models: state.models.filter((m) => m.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            status: "all",
          },
        }),
    }),
    { name: "predictive-models-store" }
  )
);
