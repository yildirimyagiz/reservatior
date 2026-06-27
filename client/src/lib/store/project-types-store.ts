import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ProjectType {
  id: string;
  name: string;
  description?: string;
  color: string;
  defaultDuration?: number; // days
  requiresApproval: boolean;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ProjectTypesState {
  types: ProjectType[];
  loading: boolean;
  error: string | null;
  selectedType: ProjectType | null;
  filters: {
    search: string;
    requiresApproval: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTypes: (types: ProjectType[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedType: (type: ProjectType | null) => void;
  setFilters: (filters: Partial<ProjectTypesState["filters"]>) => void;
  setPagination: (pagination: Partial<ProjectTypesState["pagination"]>) => void;
  addType: (type: ProjectType) => void;
  updateType: (id: string, type: Partial<ProjectType>) => void;
  removeType: (id: string) => void;
  clearFilters: () => void;
}

export const useProjectTypesStore = create<ProjectTypesState>()(
  devtools(
    (set) => ({
      types: [],
      loading: false,
      error: null,
      selectedType: null,
      filters: {
        search: "",
        requiresApproval: "all",
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
            requiresApproval: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "project-types-store" }
  )
);
