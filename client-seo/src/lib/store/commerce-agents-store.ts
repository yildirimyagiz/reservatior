import { create } from "zustand";
import { devtools } from "zustand/middleware";
import type { CommerceAgent } from "@/lib/api/commerce-agents";

export interface CommerceAgentsState {
  agents: CommerceAgent[];
  loading: boolean;
  error: string | null;
  selectedAgent: CommerceAgent | null;
  filters: {
    search: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setAgents: (agents: CommerceAgent[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedAgent: (agent: CommerceAgent | null) => void;
  setFilters: (filters: Partial<CommerceAgentsState["filters"]>) => void;
  setPagination: (pagination: Partial<CommerceAgentsState["pagination"]>) => void;
  addAgent: (agent: CommerceAgent) => void;
  updateAgent: (id: string, agent: Partial<CommerceAgent>) => void;
  removeAgent: (id: string) => void;
  clearFilters: () => void;
}

export const useCommerceAgentsStore = create<CommerceAgentsState>()(
  devtools(
    (set) => ({
      agents: [],
      loading: false,
      error: null,
      selectedAgent: null,
      filters: {
        search: "",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setAgents: (agents) => set({ agents }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedAgent: (selectedAgent) => set({ selectedAgent }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addAgent: (agent) =>
        set((state) => ({ agents: [...state.agents, agent] })),
      updateAgent: (id, updatedAgent) =>
        set((state) => ({
          agents: state.agents.map((a) =>
            a.id === id ? { ...a, ...updatedAgent } : a
          ),
        })),
      removeAgent: (id) =>
        set((state) => ({
          agents: state.agents.filter((a) => a.id !== id),
        })),
      clearFilters: () =>
        set({ filters: { search: "", status: "all" } }),
    }),
    { name: "commerce-agents-store" }
  )
);
