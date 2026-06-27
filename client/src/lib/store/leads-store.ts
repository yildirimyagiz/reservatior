import { create } from "zustand";
import { devtools } from "zustand/middleware";
import { Lead } from "../api/leads";

export interface LeadsState {
  leads: Lead[];
  loading: boolean;
  error: string | null;
  selectedLead: Lead | null;
  filters: {
    search: string;
    status: string;
    source: string;
    agent: string;
    dateRange: [Date | null, Date | null];
    priority: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setLeads: (leads: Lead[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedLead: (lead: Lead | null) => void;
  setFilters: (filters: Partial<LeadsState["filters"]>) => void;
  setPagination: (pagination: Partial<LeadsState["pagination"]>) => void;
  addLead: (lead: Lead) => void;
  updateLead: (id: string, lead: Partial<Lead>) => void;
  removeLead: (id: string) => void;
  clearFilters: () => void;
}

export const useLeadsStore = create<LeadsState>()(
  devtools(
    (set) => ({
      leads: [],
      loading: false,
      error: null,
      selectedLead: null,
      filters: {
        search: "",
        status: "all",
        source: "all",
        agent: "all",
        dateRange: [null, null],
        priority: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setLeads: (leads) => set({ leads }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedLead: (selectedLead) => set({ selectedLead }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addLead: (lead) => set((state) => ({ leads: [...state.leads, lead] })),
      updateLead: (id, updatedLead) =>
        set((state) => ({
          leads: state.leads.map((l) =>
            l.id === id ? { ...l, ...updatedLead } : l
          ),
        })),
      removeLead: (id) =>
        set((state) => ({
          leads: state.leads.filter((l) => l.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            status: "all",
            source: "all",
            agent: "all",
            dateRange: [null, null],
            priority: "all",
          },
        }),
    }),
    { name: "leads-store" }
  )
);
