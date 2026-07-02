import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ActivityLog {
  id: string;
  userId: string;
  action: string;
  entityType: string;
  entityId: string;
  entityName?: string;
  description?: string;
  metadata: Record<string, any>;
  ipAddress?: string;
  userAgent?: string;
  organizationId: string;
  createdAt: Date;
}

export interface ActivityLogsState {
  logs: ActivityLog[];
  loading: boolean;
  error: string | null;
  selectedLog: ActivityLog | null;
  filters: {
    search: string;
    userId: string;
    action: string;
    entityType: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setLogs: (logs: ActivityLog[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedLog: (log: ActivityLog | null) => void;
  setFilters: (filters: Partial<ActivityLogsState["filters"]>) => void;
  setPagination: (pagination: Partial<ActivityLogsState["pagination"]>) => void;
  addLog: (log: ActivityLog) => void;
  updateLog: (id: string, log: Partial<ActivityLog>) => void;
  removeLog: (id: string) => void;
  clearFilters: () => void;
}

export const useActivityLogsStore = create<ActivityLogsState>()(
  devtools(
    (set) => ({
      logs: [],
      loading: false,
      error: null,
      selectedLog: null,
      filters: {
        search: "",
        userId: "all",
        action: "all",
        entityType: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
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
            userId: "all",
            action: "all",
            entityType: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "activity-logs-store" }
  )
);
