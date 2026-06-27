import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface DepositProtection {
  id: string;
  leaseId: string;
  tenantId: string;
  propertyId: string;
  amount: number;
  currency: string;
  scheme: string;
  referenceNumber?: string;
  status: "pending" | "registered" | "disputed" | "released" | "cancelled";
  registrationDate?: Date;
  releaseDate?: Date;
  releaseAmount?: number;
  releaseReason?: string;
  disputes: Array<{
    id: string;
    reason: string;
    amount: number;
    status: string;
    createdAt: Date;
  }>;
  documents: string[];
  notes?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface DepositProtectionsState {
  protections: DepositProtection[];
  loading: boolean;
  error: string | null;
  selectedProtection: DepositProtection | null;
  filters: {
    search: string;
    leaseId: string;
    status: string;
    scheme: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setProtections: (protections: DepositProtection[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedProtection: (protection: DepositProtection | null) => void;
  setFilters: (filters: Partial<DepositProtectionsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<DepositProtectionsState["pagination"]>
  ) => void;
  addProtection: (protection: DepositProtection) => void;
  updateProtection: (
    id: string,
    protection: Partial<DepositProtection>
  ) => void;
  removeProtection: (id: string) => void;
  clearFilters: () => void;
}

export const useDepositProtectionsStore = create<DepositProtectionsState>()(
  devtools(
    (set) => ({
      protections: [],
      loading: false,
      error: null,
      selectedProtection: null,
      filters: {
        search: "",
        leaseId: "all",
        status: "all",
        scheme: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setProtections: (protections) => set({ protections }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedProtection: (selectedProtection) =>
        set({ selectedProtection }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addProtection: (protection) =>
        set((state) => ({ protections: [...state.protections, protection] })),
      updateProtection: (id, updatedProtection) =>
        set((state) => ({
          protections: state.protections.map((p) =>
            p.id === id ? { ...p, ...updatedProtection } : p
          ),
        })),
      removeProtection: (id) =>
        set((state) => ({
          protections: state.protections.filter((p) => p.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            leaseId: "all",
            status: "all",
            scheme: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "deposit-protections-store" }
  )
);
