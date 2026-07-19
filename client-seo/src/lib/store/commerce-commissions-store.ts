import { create } from "zustand";
import { devtools } from "zustand/middleware";
import type { CommerceCommission } from "@/lib/api/commerce-commissions";

export interface CommerceCommissionsState {
  commissions: CommerceCommission[];
  loading: boolean;
  error: string | null;
  selectedCommission: CommerceCommission | null;
  filters: {
    search: string;
    status: string;
    agentId: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setCommissions: (commissions: CommerceCommission[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedCommission: (commission: CommerceCommission | null) => void;
  setFilters: (filters: Partial<CommerceCommissionsState["filters"]>) => void;
  setPagination: (pagination: Partial<CommerceCommissionsState["pagination"]>) => void;
  addCommission: (commission: CommerceCommission) => void;
  updateCommission: (id: string, commission: Partial<CommerceCommission>) => void;
  removeCommission: (id: string) => void;
  clearFilters: () => void;
}

export const useCommerceCommissionsStore = create<CommerceCommissionsState>()(
  devtools(
    (set) => ({
      commissions: [],
      loading: false,
      error: null,
      selectedCommission: null,
      filters: {
        search: "",
        status: "all",
        agentId: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setCommissions: (commissions) => set({ commissions }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedCommission: (selectedCommission) => set({ selectedCommission }),
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
        set({ filters: { search: "", status: "all", agentId: "all" } }),
    }),
    { name: "commerce-commissions-store" }
  )
);
