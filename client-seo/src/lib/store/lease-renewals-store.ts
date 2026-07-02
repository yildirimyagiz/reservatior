import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface LeaseRenewal {
  id: string;
  leaseId: string;
  tenantId: string;
  propertyId: string;
  type: "renewal" | "extension" | "termination";
  status: "pending" | "approved" | "rejected" | "cancelled";
  currentEndDate: Date;
  proposedEndDate: Date;
  newRentAmount?: number;
  rentChange?: {
    amount: number;
    percentage: number;
    reason: string;
  };
  terms: {
    noticePeriod: number; // days
    renewalOption: boolean;
    rentIncrease: number; // percentage
  };
  documents: string[];
  notes?: string;
  requestedBy: string;
  approvedBy?: string;
  approvedAt?: Date;
  rejectionReason?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface LeaseRenewalsState {
  renewals: LeaseRenewal[];
  loading: boolean;
  error: string | null;
  selectedRenewal: LeaseRenewal | null;
  filters: {
    search: string;
    leaseId: string;
    status: string;
    type: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setRenewals: (renewals: LeaseRenewal[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedRenewal: (renewal: LeaseRenewal | null) => void;
  setFilters: (filters: Partial<LeaseRenewalsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<LeaseRenewalsState["pagination"]>
  ) => void;
  addRenewal: (renewal: LeaseRenewal) => void;
  updateRenewal: (id: string, renewal: Partial<LeaseRenewal>) => void;
  removeRenewal: (id: string) => void;
  clearFilters: () => void;
}

export const useLeaseRenewalsStore = create<LeaseRenewalsState>()(
  devtools(
    (set) => ({
      renewals: [],
      loading: false,
      error: null,
      selectedRenewal: null,
      filters: {
        search: "",
        leaseId: "all",
        status: "all",
        type: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setRenewals: (renewals) => set({ renewals }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedRenewal: (selectedRenewal) => set({ selectedRenewal }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addRenewal: (renewal) =>
        set((state) => ({ renewals: [...state.renewals, renewal] })),
      updateRenewal: (id, updatedRenewal) =>
        set((state) => ({
          renewals: state.renewals.map((r) =>
            r.id === id ? { ...r, ...updatedRenewal } : r
          ),
        })),
      removeRenewal: (id) =>
        set((state) => ({
          renewals: state.renewals.filter((r) => r.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            leaseId: "all",
            status: "all",
            type: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "lease-renewals-store" }
  )
);
