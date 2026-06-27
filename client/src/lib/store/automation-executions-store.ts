import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AutomationExecution {
  id: string;
  ruleId: string;
  triggerData: Record<string, any>;
  status: "pending" | "running" | "completed" | "failed" | "cancelled";
  startedAt: Date;
  completedAt?: Date;
  duration?: number; // milliseconds
  results: Array<{
    actionType: string;
    status: "success" | "failed" | "skipped";
    result?: any;
    error?: string;
  }>;
  error?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AutomationExecutionsState {
  executions: AutomationExecution[];
  loading: boolean;
  error: string | null;
  selectedExecution: AutomationExecution | null;
  filters: {
    search: string;
    ruleId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setExecutions: (executions: AutomationExecution[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedExecution: (execution: AutomationExecution | null) => void;
  setFilters: (filters: Partial<AutomationExecutionsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AutomationExecutionsState["pagination"]>
  ) => void;
  addExecution: (execution: AutomationExecution) => void;
  updateExecution: (
    id: string,
    execution: Partial<AutomationExecution>
  ) => void;
  removeExecution: (id: string) => void;
  clearFilters: () => void;
}

export const useAutomationExecutionsStore = create<AutomationExecutionsState>()(
  devtools(
    (set) => ({
      executions: [],
      loading: false,
      error: null,
      selectedExecution: null,
      filters: {
        search: "",
        ruleId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setExecutions: (executions) => set({ executions }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedExecution: (selectedExecution) => set({ selectedExecution }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addExecution: (execution) =>
        set((state) => ({ executions: [...state.executions, execution] })),
      updateExecution: (id, updatedExecution) =>
        set((state) => ({
          executions: state.executions.map((e) =>
            e.id === id ? { ...e, ...updatedExecution } : e
          ),
        })),
      removeExecution: (id) =>
        set((state) => ({
          executions: state.executions.filter((e) => e.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            ruleId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "automation-executions-store" }
  )
);
