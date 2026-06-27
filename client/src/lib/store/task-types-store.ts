import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface TaskType {
  id: string;
  name: string;
  description?: string;
  color: string;
  defaultPriority: "low" | "medium" | "high" | "urgent";
  defaultDuration?: number; // hours
  requiresApproval: boolean;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface TaskTypesState {
  types: TaskType[];
  loading: boolean;
  error: string | null;
  selectedType: TaskType | null;
  filters: {
    search: string;
    defaultPriority: string;
    requiresApproval: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTypes: (types: TaskType[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedType: (type: TaskType | null) => void;
  setFilters: (filters: Partial<TaskTypesState["filters"]>) => void;
  setPagination: (pagination: Partial<TaskTypesState["pagination"]>) => void;
  addType: (type: TaskType) => void;
  updateType: (id: string, type: Partial<TaskType>) => void;
  removeType: (id: string) => void;
  clearFilters: () => void;
}

export const useTaskTypesStore = create<TaskTypesState>()(
  devtools(
    (set) => ({
      types: [],
      loading: false,
      error: null,
      selectedType: null,
      filters: {
        search: "",
        defaultPriority: "all",
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
            defaultPriority: "all",
            requiresApproval: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "task-types-store" }
  )
);
