import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface BookingStatus {
  id: string;
  name: string;
  description?: string;
  color: string;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface BookingStatusesState {
  statuses: BookingStatus[];
  loading: boolean;
  error: string | null;
  selectedStatus: BookingStatus | null;
  filters: {
    search: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setStatuses: (statuses: BookingStatus[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedStatus: (status: BookingStatus | null) => void;
  setFilters: (filters: Partial<BookingStatusesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<BookingStatusesState["pagination"]>
  ) => void;
  addStatus: (status: BookingStatus) => void;
  updateStatus: (id: string, status: Partial<BookingStatus>) => void;
  removeStatus: (id: string) => void;
  clearFilters: () => void;
}

export const useBookingStatusesStore = create<BookingStatusesState>()(
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
    { name: "booking-statuses-store" }
  )
);
