import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ImmigrationStatusCheck {
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
  visaType?: string;
  visaExpiryDate?: Date;
  workPermitExpiryDate?: Date;
  verifiedBy?: string;
  verifiedAt?: Date;
  expiresAt?: Date;
  rejectionReason?: string;
  notes?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ImmigrationStatusChecksState {
  checks: ImmigrationStatusCheck[];
  loading: boolean;
  error: string | null;
  selectedCheck: ImmigrationStatusCheck | null;
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
  setChecks: (checks: ImmigrationStatusCheck[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedCheck: (check: ImmigrationStatusCheck | null) => void;
  setFilters: (
    filters: Partial<ImmigrationStatusChecksState["filters"]>
  ) => void;
  setPagination: (
    pagination: Partial<ImmigrationStatusChecksState["pagination"]>
  ) => void;
  addCheck: (check: ImmigrationStatusCheck) => void;
  updateCheck: (id: string, check: Partial<ImmigrationStatusCheck>) => void;
  removeCheck: (id: string) => void;
  clearFilters: () => void;
}

export const useImmigrationStatusChecksStore =
  create<ImmigrationStatusChecksState>()(
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
      { name: "immigration-status-checks-store" }
    )
  );
