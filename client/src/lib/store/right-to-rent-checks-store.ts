import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface RightToRentCheck {
  id: string;
  tenantId: string;
  propertyId: string;
  status: "pending" | "in_progress" | "approved" | "rejected" | "expired";
  referenceNumber?: string;
  checkType: "manual" | "automated";
  documents: Array<{
    type: string;
    url: string;
    verifiedAt?: Date;
    notes?: string;
  }>;
  verifiedBy?: string;
  verifiedAt?: Date;
  expiresAt?: Date;
  rejectionReason?: string;
  notes?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface RightToRentChecksState {
  checks: RightToRentCheck[];
  loading: boolean;
  error: string | null;
  selectedCheck: RightToRentCheck | null;
  filters: {
    search: string;
    tenantId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setChecks: (checks: RightToRentCheck[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedCheck: (check: RightToRentCheck | null) => void;
  setFilters: (filters: Partial<RightToRentChecksState["filters"]>) => void;
  setPagination: (
    pagination: Partial<RightToRentChecksState["pagination"]>
  ) => void;
  addCheck: (check: RightToRentCheck) => void;
  updateCheck: (id: string, check: Partial<RightToRentCheck>) => void;
  removeCheck: (id: string) => void;
  clearFilters: () => void;
}

export const useRightToRentChecksStore = create<RightToRentChecksState>()(
  devtools(
    (set) => ({
      checks: [],
      loading: false,
      error: null,
      selectedCheck: null,
      filters: {
        search: "",
        tenantId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setChecks: (checks) => set({ checks }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedCheck: (selectedCheck) => set({ selectedCheck }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addCheck: (check) =>
        set((state) => ({ checks: [...state.checks, check] })),
      updateCheck: (id, updatedCheck) =>
        set((state) => ({
          checks: state.checks.map((c) =>
            c.id === id ? { ...c, ...updatedCheck } : c
          ),
        })),
      removeCheck: (id) =>
        set((state) => ({
          checks: state.checks.filter((c) => c.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            tenantId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "right-to-rent-checks-store" }
  )
);
