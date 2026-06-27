import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AIPropertyDescription {
  id: string;
  propertyId: string;
  description: string;
  tone: string;
  length: "short" | "medium" | "long";
  features: string[];
  highlights: string[];
  modelId: string;
  quality: number; // 0-100
  status: "draft" | "approved" | "rejected";
  generatedAt: Date;
  approvedAt?: Date;
  approvedBy?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AIPropertyDescriptionsState {
  descriptions: AIPropertyDescription[];
  loading: boolean;
  error: string | null;
  selectedDescription: AIPropertyDescription | null;
  filters: {
    search: string;
    propertyId: string;
    status: string;
    quality: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setDescriptions: (descriptions: AIPropertyDescription[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedDescription: (description: AIPropertyDescription | null) => void;
  setFilters: (
    filters: Partial<AIPropertyDescriptionsState["filters"]>
  ) => void;
  setPagination: (
    pagination: Partial<AIPropertyDescriptionsState["pagination"]>
  ) => void;
  addDescription: (description: AIPropertyDescription) => void;
  updateDescription: (
    id: string,
    description: Partial<AIPropertyDescription>
  ) => void;
  removeDescription: (id: string) => void;
  clearFilters: () => void;
}

export const useAIPropertyDescriptionsStore =
  create<AIPropertyDescriptionsState>()(
    devtools(
      (set) => ({
        descriptions: [],
        loading: false,
        error: null,
        selectedDescription: null,
        filters: {
          search: "",
          propertyId: "all",
          status: "all",
          quality: "all",
        },
        pagination: {
          page: 1,
          limit: 20,
          total: 0,
        },
        setDescriptions: (descriptions) => set({ descriptions }),
        setLoading: (loading) => set({ loading }),
        setError: (error) => set({ error }),
        setSelectedDescription: (selectedDescription) =>
          set({ selectedDescription }),
        setFilters: (filters) =>
          set((state) => ({ filters: { ...state.filters, ...filters } })),
        setPagination: (pagination) =>
          set((state) => ({
            pagination: { ...state.pagination, ...pagination },
          })),
        addDescription: (description) =>
          set((state) => ({
            descriptions: [...state.descriptions, description],
          })),
        updateDescription: (id, updatedDescription) =>
          set((state) => ({
            descriptions: state.descriptions.map((d) =>
              d.id === id ? { ...d, ...updatedDescription } : d
            ),
          })),
        removeDescription: (id) =>
          set((state) => ({
            descriptions: state.descriptions.filter((d) => d.id !== id),
          })),
        clearFilters: () =>
          set({
            filters: {
              search: "",
              propertyId: "all",
              status: "all",
              quality: "all",
            },
          }),
      }),
      { name: "ai-property-descriptions-store" }
    )
  );
