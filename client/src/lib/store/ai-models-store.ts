import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AIModel {
  id: string;
  name: string;
  type: string;
  version: string;
  status: "active" | "training" | "deprecated";
  description: string;
  parameters: Record<string, any>;
  performance: {
    accuracy: number;
    latency: number;
    cost: number;
  };
  createdAt: Date;
  updatedAt: Date;
}

export interface AIModelState {
  models: AIModel[];
  loading: boolean;
  error: string | null;
  selectedModel: AIModel | null;
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
  setModels: (models: AIModel[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedModel: (model: AIModel | null) => void;
  setFilters: (filters: Partial<AIModelState["filters"]>) => void;
  setPagination: (pagination: Partial<AIModelState["pagination"]>) => void;
  addModel: (model: AIModel) => void;
  updateModel: (id: string, model: Partial<AIModel>) => void;
  removeModel: (id: string) => void;
  clearFilters: () => void;
}

export const useAIModelsStore = create<AIModelState>()(
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
    { name: "ai-models-store" }
  )
);
