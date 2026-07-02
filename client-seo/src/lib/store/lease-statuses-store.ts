import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface LeaseStatus {
  id: string;
  name: string;
  description?: string;
  color: string;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface LeaseStatusesState {
  statuses: LeaseStatus[];
  loading: boolean;
  error: string | null;
  selectedStatus: LeaseStatus | null;
  filters: {
    search: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setStatuses: (statuses: LeaseStatus[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedStatus: (status: LeaseStatus | null) => void;
  setFilters: (filters: Partial<LeaseStatusesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<LeaseStatusesState["pagination"]>
  ) => void;
  addStatus: (status: LeaseStatus) => void;
  updateStatus: (id: string, status: Partial<LeaseStatus>) => void;
  removeStatus: (id: string) => void;
  clearFilters: () => void;
}

export const useLeaseStatusesStore = create<LeaseStatusesState>()(
  devtools(
    (set) => ({
      statuses: [],
      loading: false,
      error: null,
      selectedStatus: null,
      filters: {
        search: "",
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
            isActive: "all",
          },
        }),
    }),
    { name: "lease-statuses-store" }
  )
);
