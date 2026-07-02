import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Lease {
  id: string;
  propertyId: string;
  tenantId: string;
  startDate: Date;
  endDate: Date;
  monthlyRent: number;
  currency: string;
  securityDeposit: number;
  status: "active" | "expired" | "terminated" | "pending";
  terms: number; // months
  renewalDate?: Date;
  createdAt: Date;
  updatedAt: Date;
}

export interface LeaseState {
  leases: Lease[];
  loading: boolean;
  error: string | null;
  selectedLease: Lease | null;
  filters: {
    search: string;
    status: string;
    propertyId: string;
    tenantId: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setLeases: (leases: Lease[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedLease: (lease: Lease | null) => void;
  setFilters: (filters: Partial<LeaseState["filters"]>) => void;
  setPagination: (pagination: Partial<LeaseState["pagination"]>) => void;
  addLease: (lease: Lease) => void;
  updateLease: (id: string, lease: Partial<Lease>) => void;
  removeLease: (id: string) => void;
  clearFilters: () => void;
}

export const useLeasesStore = create<LeaseState>()(
  devtools(
    (set) => ({
      leases: [],
      loading: false,
      error: null,
      selectedLease: null,
      filters: {
        search: "",
        status: "all",
        propertyId: "all",
        tenantId: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setLeases: (leases) => set({ leases }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedLease: (selectedLease) => set({ selectedLease }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addLease: (lease) =>
        set((state) => ({ leases: [...state.leases, lease] })),
      updateLease: (id, updatedLease) =>
        set((state) => ({
          leases: state.leases.map((l) =>
            l.id === id ? { ...l, ...updatedLease } : l
          ),
        })),
      removeLease: (id) =>
        set((state) => ({
          leases: state.leases.filter((l) => l.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            status: "all",
            propertyId: "all",
            tenantId: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "leases-store" }
  )
);
