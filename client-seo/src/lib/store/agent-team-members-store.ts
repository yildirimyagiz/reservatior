import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AgentTeamMember {
  id: string;
  teamId: string;
  userId: string;
  role: string;
  permissions: string[];
  commissionPercentage: number;
  isActive: boolean;
  joinedAt: Date;
  leftAt?: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AgentTeamMembersState {
  teamMembers: AgentTeamMember[];
  loading: boolean;
  error: string | null;
  selectedTeamMember: AgentTeamMember | null;
  filters: {
    search: string;
    teamId: string;
    userId: string;
    role: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTeamMembers: (teamMembers: AgentTeamMember[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedTeamMember: (teamMember: AgentTeamMember | null) => void;
  setFilters: (filters: Partial<AgentTeamMembersState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AgentTeamMembersState["pagination"]>
  ) => void;
  addTeamMember: (teamMember: AgentTeamMember) => void;
  updateTeamMember: (id: string, teamMember: Partial<AgentTeamMember>) => void;
  removeTeamMember: (id: string) => void;
  clearFilters: () => void;
}

export const useAgentTeamMembersStore = create<AgentTeamMembersState>()(
  devtools(
    (set) => ({
      teamMembers: [],
      loading: false,
      error: null,
      selectedTeamMember: null,
      filters: {
        search: "",
        teamId: "all",
        userId: "all",
        role: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setTeamMembers: (teamMembers) => set({ teamMembers }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedTeamMember: (selectedTeamMember) =>
        set({ selectedTeamMember }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addTeamMember: (teamMember) =>
        set((state) => ({ teamMembers: [...state.teamMembers, teamMember] })),
      updateTeamMember: (id, updatedTeamMember) =>
        set((state) => ({
          teamMembers: state.teamMembers.map((tm) =>
            tm.id === id ? { ...tm, ...updatedTeamMember } : tm
          ),
        })),
      removeTeamMember: (id) =>
        set((state) => ({
          teamMembers: state.teamMembers.filter((tm) => tm.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            teamId: "all",
            userId: "all",
            role: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "agent-team-members-store" }
  )
);
