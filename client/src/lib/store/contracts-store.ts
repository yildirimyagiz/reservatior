import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Contract {
  id: string;
  title: string;
  type: string;
  status: "draft" | "active" | "completed" | "terminated";
  startDate: Date;
  endDate?: Date;
  parties: Array<{
    id: string;
    name: string;
    type: "landlord" | "tenant" | "agent" | "vendor";
    signedAt?: Date;
  }>;
  terms: string;
  value?: number;
  currency: string;
  documents: string[];
  createdAt: Date;
  updatedAt: Date;
}

export interface ContractState {
  contracts: Contract[];
  loading: boolean;
  error: string | null;
  selectedContract: Contract | null;
  filters: {
    search: string;
    type: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setContracts: (contracts: Contract[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedContract: (contract: Contract | null) => void;
  setFilters: (filters: Partial<ContractState["filters"]>) => void;
  setPagination: (pagination: Partial<ContractState["pagination"]>) => void;
  addContract: (contract: Contract) => void;
  updateContract: (id: string, contract: Partial<Contract>) => void;
  removeContract: (id: string) => void;
  clearFilters: () => void;
}

export const useContractsStore = create<ContractState>()(
  devtools(
    (set) => ({
      contracts: [],
      loading: false,
      error: null,
      selectedContract: null,
      filters: {
        search: "",
        type: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setContracts: (contracts) => set({ contracts }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedContract: (selectedContract) => set({ selectedContract }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addContract: (contract) =>
        set((state) => ({ contracts: [...state.contracts, contract] })),
      updateContract: (id, updatedContract) =>
        set((state) => ({
          contracts: state.contracts.map((c) =>
            c.id === id ? { ...c, ...updatedContract } : c
          ),
        })),
      removeContract: (id) =>
        set((state) => ({
          contracts: state.contracts.filter((c) => c.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "contracts-store" }
  )
);
