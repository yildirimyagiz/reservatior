import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Commission {
  id: string;
  agentId: string;
  dealId: string;
  amount: number;
  currency: string;
  percentage: number;
  status: "pending" | "paid" | "cancelled";
  dueDate?: Date;
  paidAt?: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface CommissionsState {
  commissions: Commission[];
  loading: boolean;
  error: string | null;
  selectedCommission: Commission | null;
  filters: {
    search: string;
    agentId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setCommissions: (commissions: Commission[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedCommission: (commission: Commission | null) => void;
  setFilters: (filters: Partial<CommissionsState["filters"]>) => void;
  setPagination: (pagination: Partial<CommissionsState["pagination"]>) => void;
  addCommission: (commission: Commission) => void;
  updateCommission: (id: string, commission: Partial<Commission>) => void;
  removeCommission: (id: string) => void;
  clearFilters: () => void;
}

export const useCommissionsStore = create<CommissionsState>()(
  devtools(
    (set) => ({
      commissions: [],
      loading: false,
      error: null,
      selectedCommission: null,
      filters: {
        search: "",
        agentId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setCommissions: (commissions) => set({ commissions }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedCommission: (selectedCommission) =>
        set({ selectedCommission }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addCommission: (commission) =>
        set((state) => ({ commissions: [...state.commissions, commission] })),
      updateCommission: (id, updatedCommission) =>
        set((state) => ({
          commissions: state.commissions.map((c) =>
            c.id === id ? { ...c, ...updatedCommission } : c
          ),
        })),
      removeCommission: (id) =>
        set((state) => ({
          commissions: state.commissions.filter((c) => c.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            agentId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "commissions-store" }
  )
);
