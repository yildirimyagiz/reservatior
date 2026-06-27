import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ExportType {
  id: string;
  name: string;
  description?: string;
  format: string;
  supportedEntities: string[];
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
}

export interface ExportTypesState {
  types: ExportType[];
  loading: boolean;
  error: string | null;
  selectedType: ExportType | null;
  filters: {
    search: string;
    format: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTypes: (types: ExportType[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedType: (type: ExportType | null) => void;
  setFilters: (filters: Partial<ExportTypesState["filters"]>) => void;
  setPagination: (pagination: Partial<ExportTypesState["pagination"]>) => void;
  addType: (type: ExportType) => void;
  updateType: (id: string, type: Partial<ExportType>) => void;
  removeType: (id: string) => void;
  clearFilters: () => void;
}

export const useExportTypesStore = create<ExportTypesState>()(
  devtools(
    (set) => ({
      types: [],
      loading: false,
      error: null,
      selectedType: null,
      filters: {
        search: "",
        format: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setTypes: (types) => set({ types }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedType: (selectedType) => set({ selectedType }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addType: (type) => set((state) => ({ types: [...state.types, type] })),
      updateType: (id, updatedType) =>
        set((state) => ({
          types: state.types.map((t) =>
            t.id === id ? { ...t, ...updatedType } : t
          ),
        })),
      removeType: (id) =>
        set((state) => ({
          types: state.types.filter((t) => t.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            format: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "export-types-store" }
  )
);
