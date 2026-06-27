import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AIValuationModel {
  id: string;
  name: string;
  description?: string;
  type: string;
  algorithm: string;
  features: string[];
  accuracy: number; // 0-1
  lastTrainedAt?: Date;
  trainingData: {
    samples: number;
    features: string[];
    targetVariable: string;
  };
  performance: {
    mae: number; // mean absolute error
    rmse: number; // root mean square error
    r2: number; // r-squared
  };
  isActive: boolean;
  organizationId: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AIValuationModelsState {
  models: AIValuationModel[];
  loading: boolean;
  error: string | null;
  selectedModel: AIValuationModel | null;
  filters: {
    search: string;
    type: string;
    algorithm: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setModels: (models: AIValuationModel[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedModel: (model: AIValuationModel | null) => void;
  setFilters: (filters: Partial<AIValuationModelsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AIValuationModelsState["pagination"]>
  ) => void;
  addModel: (model: AIValuationModel) => void;
  updateModel: (id: string, model: Partial<AIValuationModel>) => void;
  removeModel: (id: string) => void;
  clearFilters: () => void;
}

export const useAIValuationModelsStore = create<AIValuationModelsState>()(
  devtools(
    (set) => ({
      models: [],
      loading: false,
      error: null,
      selectedModel: null,
      filters: {
        search: "",
        type: "all",
        algorithm: "all",
        isActive: "all",
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
            algorithm: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "ai-valuation-models-store" }
  )
);
