import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AgentAssignment {
  id: string;
  agentId: string;
  propertyId?: string;
  contactId?: string;
  leadId?: string;
  dealId?: string;
  type: string;
  status: "active" | "completed" | "transferred";
  assignedAt: Date;
  assignedBy: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AgentAssignmentState {
  assignments: AgentAssignment[];
  loading: boolean;
  error: string | null;
  selectedAssignment: AgentAssignment | null;
  filters: {
    search: string;
    agentId: string;
    type: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setAssignments: (assignments: AgentAssignment[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedAssignment: (assignment: AgentAssignment | null) => void;
  setFilters: (filters: Partial<AgentAssignmentState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AgentAssignmentState["pagination"]>
  ) => void;
  addAssignment: (assignment: AgentAssignment) => void;
  updateAssignment: (id: string, assignment: Partial<AgentAssignment>) => void;
  removeAssignment: (id: string) => void;
  clearFilters: () => void;
}

export const useAgentAssignmentsStore = create<AgentAssignmentState>()(
  devtools(
    (set) => ({
      assignments: [],
      loading: false,
      error: null,
      selectedAssignment: null,
      filters: {
        search: "",
        agentId: "all",
        type: "all",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setAssignments: (assignments) => set({ assignments }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedAssignment: (selectedAssignment) =>
        set({ selectedAssignment }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addAssignment: (assignment) =>
        set((state) => ({ assignments: [...state.assignments, assignment] })),
      updateAssignment: (id, updatedAssignment) =>
        set((state) => ({
          assignments: state.assignments.map((a) =>
            a.id === id ? { ...a, ...updatedAssignment } : a
          ),
        })),
      removeAssignment: (id) =>
        set((state) => ({
          assignments: state.assignments.filter((a) => a.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            agentId: "all",
            type: "all",
            status: "all",
          },
        }),
    }),
    { name: "agent-assignments-store" }
  )
);
