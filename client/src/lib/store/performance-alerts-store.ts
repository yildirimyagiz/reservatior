import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface PerformanceAlert {
  id: string;
  type: string;
  severity: "low" | "medium" | "high" | "critical";
  title: string;
  description: string;
  metric: string;
  threshold: number;
  currentValue: number;
  status: "active" | "resolved" | "acknowledged";
  triggeredAt: Date;
  resolvedAt?: Date;
  acknowledgedBy?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface PerformanceAlertsState {
  alerts: PerformanceAlert[];
  loading: boolean;
  error: string | null;
  selectedAlert: PerformanceAlert | null;
  filters: {
    search: string;
    type: string;
    severity: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setAlerts: (alerts: PerformanceAlert[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedAlert: (alert: PerformanceAlert | null) => void;
  setFilters: (filters: Partial<PerformanceAlertsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<PerformanceAlertsState["pagination"]>
  ) => void;
  addAlert: (alert: PerformanceAlert) => void;
  updateAlert: (id: string, alert: Partial<PerformanceAlert>) => void;
  removeAlert: (id: string) => void;
  clearFilters: () => void;
}

export const usePerformanceAlertsStore = create<PerformanceAlertsState>()(
  devtools(
    (set) => ({
      alerts: [],
      loading: false,
      error: null,
      selectedAlert: null,
      filters: {
        search: "",
        type: "all",
        severity: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setAlerts: (alerts) => set({ alerts }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedAlert: (selectedAlert) => set({ selectedAlert }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addAlert: (alert) =>
        set((state) => ({ alerts: [...state.alerts, alert] })),
      updateAlert: (id, updatedAlert) =>
        set((state) => ({
          alerts: state.alerts.map((a) =>
            a.id === id ? { ...a, ...updatedAlert } : a
          ),
        })),
      removeAlert: (id) =>
        set((state) => ({
          alerts: state.alerts.filter((a) => a.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            severity: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "performance-alerts-store" }
  )
);
