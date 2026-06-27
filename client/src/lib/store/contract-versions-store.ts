import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ContractVersion {
  id: string;
  contractId: string;
  version: number;
  title: string;
  content: string;
  changes?: string;
  status: "draft" | "active" | "archived";
  effectiveDate?: Date;
  createdBy: string;
  approvedBy?: string;
  approvedAt?: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ContractVersionsState {
  versions: ContractVersion[];
  loading: boolean;
  error: string | null;
  selectedVersion: ContractVersion | null;
  filters: {
    search: string;
    contractId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setVersions: (versions: ContractVersion[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedVersion: (version: ContractVersion | null) => void;
  setFilters: (filters: Partial<ContractVersionsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<ContractVersionsState["pagination"]>
  ) => void;
  addVersion: (version: ContractVersion) => void;
  updateVersion: (id: string, version: Partial<ContractVersion>) => void;
  removeVersion: (id: string) => void;
  clearFilters: () => void;
}

export const useContractVersionsStore = create<ContractVersionsState>()(
  devtools(
    (set) => ({
      versions: [],
      loading: false,
      error: null,
      selectedVersion: null,
      filters: {
        search: "",
        contractId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setVersions: (versions) => set({ versions }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedVersion: (selectedVersion) => set({ selectedVersion }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addVersion: (version) =>
        set((state) => ({ versions: [...state.versions, version] })),
      updateVersion: (id, updatedVersion) =>
        set((state) => ({
          versions: state.versions.map((v) =>
            v.id === id ? { ...v, ...updatedVersion } : v
          ),
        })),
      removeVersion: (id) =>
        set((state) => ({
          versions: state.versions.filter((v) => v.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            contractId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "contract-versions-store" }
  )
);
