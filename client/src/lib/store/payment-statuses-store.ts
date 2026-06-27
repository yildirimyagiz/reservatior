import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface PaymentStatus {
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

export interface PaymentStatusesState {
  statuses: PaymentStatus[];
  loading: boolean;
  error: string | null;
  selectedStatus: PaymentStatus | null;
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
  setStatuses: (statuses: PaymentStatus[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedStatus: (status: PaymentStatus | null) => void;
  setFilters: (filters: Partial<PaymentStatusesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<PaymentStatusesState["pagination"]>
  ) => void;
  addStatus: (status: PaymentStatus) => void;
  updateStatus: (id: string, status: Partial<PaymentStatus>) => void;
  removeStatus: (id: string) => void;
  clearFilters: () => void;
}

export const usePaymentStatusesStore = create<PaymentStatusesState>()(
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
    { name: "payment-statuses-store" }
  )
);
