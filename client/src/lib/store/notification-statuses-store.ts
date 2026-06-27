import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface NotificationStatus {
  id: string;
  name: string;
  description?: string;
  color: string;
  isFinal: boolean;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface NotificationStatusesState {
  statuses: NotificationStatus[];
  loading: boolean;
  error: string | null;
  selectedStatus: NotificationStatus | null;
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
  setStatuses: (statuses: NotificationStatus[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedStatus: (status: NotificationStatus | null) => void;
  setFilters: (filters: Partial<NotificationStatusesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<NotificationStatusesState["pagination"]>
  ) => void;
  addStatus: (status: NotificationStatus) => void;
  updateStatus: (id: string, status: Partial<NotificationStatus>) => void;
  removeStatus: (id: string) => void;
  clearFilters: () => void;
}

export const useNotificationStatusesStore = create<NotificationStatusesState>()(
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
    { name: "notification-statuses-store" }
  )
);
