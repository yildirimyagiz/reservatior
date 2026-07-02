import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Priority {
  id: string;
  name: string;
  description?: string;
  level: number; // 1-5, higher is more important
  color: string;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface PrioritiesState {
  priorities: Priority[];
  loading: boolean;
  error: string | null;
  selectedPriority: Priority | null;
  filters: {
    search: string;
    level: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setPriorities: (priorities: Priority[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedPriority: (priority: Priority | null) => void;
  setFilters: (filters: Partial<PrioritiesState["filters"]>) => void;
  setPagination: (pagination: Partial<PrioritiesState["pagination"]>) => void;
  addPriority: (priority: Priority) => void;
  updatePriority: (id: string, priority: Partial<Priority>) => void;
  removePriority: (id: string) => void;
  clearFilters: () => void;
}

export const usePrioritiesStore = create<PrioritiesState>()(
  devtools(
    (set) => ({
      priorities: [],
      loading: false,
      error: null,
      selectedPriority: null,
      filters: {
        search: "",
        level: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setPriorities: (priorities) => set({ priorities }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedPriority: (selectedPriority) => set({ selectedPriority }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addPriority: (priority) =>
        set((state) => ({ priorities: [...state.priorities, priority] })),
      updatePriority: (id, updatedPriority) =>
        set((state) => ({
          priorities: state.priorities.map((p) =>
            p.id === id ? { ...p, ...updatedPriority } : p
          ),
        })),
      removePriority: (id) =>
        set((state) => ({
          priorities: state.priorities.filter((p) => p.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            level: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "priorities-store" }
  )
);
