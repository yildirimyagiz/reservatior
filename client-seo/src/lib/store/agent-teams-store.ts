import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AgentTeam {
  id: string;
  name: string;
  description?: string;
  leaderId: string;
  members: Array<{
    userId: string;
    role: string;
    joinedAt: Date;
  }>;
  commissionStructure: {
    type: string;
    split: Array<{
      userId: string;
      percentage: number;
    }>;
  };
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AgentTeamsState {
  teams: AgentTeam[];
  loading: boolean;
  error: string | null;
  selectedTeam: AgentTeam | null;
  filters: {
    search: string;
    leaderId: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTeams: (teams: AgentTeam[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedTeam: (team: AgentTeam | null) => void;
  setFilters: (filters: Partial<AgentTeamsState["filters"]>) => void;
  setPagination: (pagination: Partial<AgentTeamsState["pagination"]>) => void;
  addTeam: (team: AgentTeam) => void;
  updateTeam: (id: string, team: Partial<AgentTeam>) => void;
  removeTeam: (id: string) => void;
  clearFilters: () => void;
}

export const useAgentTeamsStore = create<AgentTeamsState>()(
  devtools(
    (set) => ({
      teams: [],
      loading: false,
      error: null,
      selectedTeam: null,
      filters: {
        search: "",
        leaderId: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setTeams: (teams) => set({ teams }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedTeam: (selectedTeam) => set({ selectedTeam }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addTeam: (team) => set((state) => ({ teams: [...state.teams, team] })),
      updateTeam: (id, updatedTeam) =>
        set((state) => ({
          teams: state.teams.map((t) =>
            t.id === id ? { ...t, ...updatedTeam } : t
          ),
        })),
      removeTeam: (id) =>
        set((state) => ({
          teams: state.teams.filter((t) => t.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            leaderId: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "agent-teams-store" }
  )
);
