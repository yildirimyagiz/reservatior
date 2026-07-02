import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface TaskStatus {
  id: string;
  name: string;
  description?: string;
  color: string;
  isFinal: boolean;
  order: number;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface TaskStatusesState {
  statuses: TaskStatus[];
  loading: boolean;
  error: string | null;
  selectedStatus: TaskStatus | null;
  filters: {
    search: string;
    isFinal: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setStatuses: (statuses: TaskStatus[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedStatus: (status: TaskStatus | null) => void;
  setFilters: (filters: Partial<TaskStatusesState["filters"]>) => void;
  setPagination: (pagination: Partial<TaskStatusesState["pagination"]>) => void;
  addStatus: (status: TaskStatus) => void;
  updateStatus: (id: string, status: Partial<TaskStatus>) => void;
  removeStatus: (id: string) => void;
  clearFilters: () => void;
}

export const useTaskStatusesStore = create<TaskStatusesState>()(
  devtools(
    (set) => ({
      statuses: [],
      loading: false,
      error: null,
      selectedStatus: null,
      filters: {
        search: "",
        isFinal: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setStatuses: (statuses) => set({ statuses }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedStatus: (selectedStatus) => set({ selectedStatus }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addStatus: (status) =>
        set((state) => ({ statuses: [...state.statuses, status] })),
      updateStatus: (id, updatedStatus) =>
        set((state) => ({
          statuses: state.statuses.map((s) =>
            s.id === id ? { ...s, ...updatedStatus } : s
          ),
        })),
      removeStatus: (id) =>
        set((state) => ({
          statuses: state.statuses.filter((s) => s.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            isFinal: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "task-statuses-store" }
  )
);
