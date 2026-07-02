import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface TaskAssignment {
  id: string;
  taskId: string;
  userId: string;
  role: string;
  assignedAt: Date;
  assignedBy: string;
  status: "active" | "completed" | "cancelled";
  completedAt?: Date;
  notes?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface TaskAssignmentsState {
  assignments: TaskAssignment[];
  loading: boolean;
  error: string | null;
  selectedAssignment: TaskAssignment | null;
  filters: {
    search: string;
    taskId: string;
    userId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setAssignments: (assignments: TaskAssignment[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedAssignment: (assignment: TaskAssignment | null) => void;
  setFilters: (filters: Partial<TaskAssignmentsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<TaskAssignmentsState["pagination"]>
  ) => void;
  addAssignment: (assignment: TaskAssignment) => void;
  updateAssignment: (id: string, assignment: Partial<TaskAssignment>) => void;
  removeAssignment: (id: string) => void;
  clearFilters: () => void;
}

export const useTaskAssignmentsStore = create<TaskAssignmentsState>()(
  devtools(
    (set) => ({
      assignments: [],
      loading: false,
      error: null,
      selectedAssignment: null,
      filters: {
        search: "",
        taskId: "all",
        userId: "all",
        status: "all",
        dateRange: [null, null],
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
            taskId: "all",
            userId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "task-assignments-store" }
  )
);
