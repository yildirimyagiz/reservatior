import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface IntegrationLog {
  id: string;
  integrationId: string;
  type: string;
  level: "info" | "warn" | "error" | "debug";
  message: string;
  details?: Record<string, any>;
  request?: any;
  response?: any;
  duration?: number;
  status: "success" | "failure" | "pending";
  timestamp: Date;
  organizationId: string;
}

export interface IntegrationLogsState {
  logs: IntegrationLog[];
  loading: boolean;
  error: string | null;
  selectedLog: IntegrationLog | null;
  filters: {
    search: string;
    integrationId: string;
    level: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setLogs: (logs: IntegrationLog[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedLog: (log: IntegrationLog | null) => void;
  setFilters: (filters: Partial<IntegrationLogsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<IntegrationLogsState["pagination"]>
  ) => void;
  addLog: (log: IntegrationLog) => void;
  updateLog: (id: string, log: Partial<IntegrationLog>) => void;
  removeLog: (id: string) => void;
  clearFilters: () => void;
}

export const useIntegrationLogsStore = create<IntegrationLogsState>()(
  devtools(
    (set) => ({
      logs: [],
      loading: false,
      error: null,
      selectedLog: null,
      filters: {
        search: "",
        integrationId: "all",
        level: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 50,
        total: 0,
      },
      setLogs: (logs) => set({ logs }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedLog: (selectedLog) => set({ selectedLog }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addLog: (log) => set((state) => ({ logs: [...state.logs, log] })),
      updateLog: (id, updatedLog) =>
        set((state) => ({
          logs: state.logs.map((l) =>
            l.id === id ? { ...l, ...updatedLog } : l
          ),
        })),
      removeLog: (id) =>
        set((state) => ({
          logs: state.logs.filter((l) => l.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            integrationId: "all",
            level: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "integration-logs-store" }
  )
);
