import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ReportExecution {
  id: string;
  reportId: string;
  name: string;
  parameters: Record<string, any>;
  status: "pending" | "running" | "completed" | "failed" | "cancelled";
  progress: number; // 0-100
  startedAt?: Date;
  completedAt?: Date;
  duration?: number; // milliseconds
  result?: {
    data: any;
    format: string;
    size: number;
  };
  error?: string;
  requestedBy: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ReportExecutionsState {
  executions: ReportExecution[];
  loading: boolean;
  error: string | null;
  selectedExecution: ReportExecution | null;
  filters: {
    search: string;
    reportId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setExecutions: (executions: ReportExecution[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedExecution: (execution: ReportExecution | null) => void;
  setFilters: (filters: Partial<ReportExecutionsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<ReportExecutionsState["pagination"]>
  ) => void;
  addExecution: (execution: ReportExecution) => void;
  updateExecution: (id: string, execution: Partial<ReportExecution>) => void;
  removeExecution: (id: string) => void;
  clearFilters: () => void;
}

export const useReportExecutionsStore = create<ReportExecutionsState>()(
  devtools(
    (set) => ({
      executions: [],
      loading: false,
      error: null,
      selectedExecution: null,
      filters: {
        search: "",
        reportId: "all",
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
            reportId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "report-executions-store" }
  )
);
