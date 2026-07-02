import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface MlsDataMapping {
  id: string;
  mlsConnectionId: string;
  sourceField: string;
  targetField: string;
  fieldType: string;
  transformRules?: Array<{
    type: string;
    config: Record<string, any>;
  }>;
  validationRules?: Array<{
    type: string;
    config: Record<string, any>;
  }>;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface MlsDataMappingsState {
  mappings: MlsDataMapping[];
  loading: boolean;
  error: string | null;
  selectedMapping: MlsDataMapping | null;
  filters: {
    search: string;
    mlsConnectionId: string;
    fieldType: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setMappings: (mappings: MlsDataMapping[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedMapping: (mapping: MlsDataMapping | null) => void;
  setFilters: (filters: Partial<MlsDataMappingsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<MlsDataMappingsState["pagination"]>
  ) => void;
  addMapping: (mapping: MlsDataMapping) => void;
  updateMapping: (id: string, mapping: Partial<MlsDataMapping>) => void;
  removeMapping: (id: string) => void;
  clearFilters: () => void;
}

export const useMlsDataMappingsStore = create<MlsDataMappingsState>()(
  devtools(
    (set) => ({
      mappings: [],
      loading: false,
      error: null,
      selectedMapping: null,
      filters: {
        search: "",
        mlsConnectionId: "all",
        fieldType: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setMappings: (mappings) => set({ mappings }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedMapping: (selectedMapping) => set({ selectedMapping }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addMapping: (mapping) =>
        set((state) => ({ mappings: [...state.mappings, mapping] })),
      updateMapping: (id, updatedMapping) =>
        set((state) => ({
          mappings: state.mappings.map((m) =>
            m.id === id ? { ...m, ...updatedMapping } : m
          ),
        })),
      removeMapping: (id) =>
        set((state) => ({
          mappings: state.mappings.filter((m) => m.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            mlsConnectionId: "all",
            fieldType: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "mls-data-mappings-store" }
  )
);
