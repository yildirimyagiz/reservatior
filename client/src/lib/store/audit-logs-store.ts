import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AuditLog {
  id: string;
  action: string;
  entityType: string;
  entityId: string;
  userId: string;
  details: Record<string, any>;
  ipAddress?: string;
  userAgent?: string;
  timestamp: Date;
  organizationId: string;
}

export interface AuditLogState {
  logs: AuditLog[];
  loading: boolean;
  error: string | null;
  selectedLog: AuditLog | null;
  filters: {
    search: string;
    action: string;
    entityType: string;
    userId: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setLogs: (logs: AuditLog[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedLog: (log: AuditLog | null) => void;
  setFilters: (filters: Partial<AuditLogState["filters"]>) => void;
  setPagination: (pagination: Partial<AuditLogState["pagination"]>) => void;
  clearFilters: () => void;
}

export const useAuditLogsStore = create<AuditLogState>()(
  devtools(
    (set) => ({
      logs: [],
      loading: false,
      error: null,
      selectedLog: null,
      filters: {
        search: "",
        action: "all",
        entityType: "all",
        userId: "all",
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
      clearFilters: () =>
        set({
          filters: {
            search: "",
            action: "all",
            entityType: "all",
            userId: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "audit-logs-store" }
  )
);
