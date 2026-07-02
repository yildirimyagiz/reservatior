import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface LeadSource {
  id: string;
  name: string;
  type: string;
  description?: string;
  isActive: boolean;
  organizationId: string;
  leadCount: number;
  conversionRate: number;
  createdAt: Date;
  updatedAt: Date;
}

export interface LeadSourcesState {
  leadSources: LeadSource[];
  loading: boolean;
  error: string | null;
  selectedLeadSource: LeadSource | null;
  filters: {
    search: string;
    type: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setLeadSources: (leadSources: LeadSource[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedLeadSource: (leadSource: LeadSource | null) => void;
  setFilters: (filters: Partial<LeadSourcesState["filters"]>) => void;
  setPagination: (pagination: Partial<LeadSourcesState["pagination"]>) => void;
  addLeadSource: (leadSource: LeadSource) => void;
  updateLeadSource: (id: string, leadSource: Partial<LeadSource>) => void;
  removeLeadSource: (id: string) => void;
  clearFilters: () => void;
}

export const useLeadSourcesStore = create<LeadSourcesState>()(
  devtools(
    (set) => ({
      leadSources: [],
      loading: false,
      error: null,
      selectedLeadSource: null,
      filters: {
        search: "",
        type: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setLeadSources: (leadSources) => set({ leadSources }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedLeadSource: (selectedLeadSource) =>
        set({ selectedLeadSource }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addLeadSource: (leadSource) =>
        set((state) => ({ leadSources: [...state.leadSources, leadSource] })),
      updateLeadSource: (id, updatedLeadSource) =>
        set((state) => ({
          leadSources: state.leadSources.map((ls) =>
            ls.id === id ? { ...ls, ...updatedLeadSource } : ls
          ),
        })),
      removeLeadSource: (id) =>
        set((state) => ({
          leadSources: state.leadSources.filter((ls) => ls.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "lead-sources-store" }
  )
);
