import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface SystemMetrics {
  id: string;
  timestamp: Date;
  cpu: number; // percentage
  memory: number; // percentage
  disk: number; // percentage
  responseTime: number; // milliseconds
  activeUsers: number;
  requestsPerSecond: number;
  errorRate: number; // percentage
  uptime: number; // seconds
  organizationId: string;
}

export interface SystemMetricsState {
  metrics: SystemMetrics[];
  loading: boolean;
  error: string | null;
  selectedMetrics: SystemMetrics | null;
  filters: {
    dateRange: [Date | null, Date | null];
    organizationId: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setMetrics: (metrics: SystemMetrics[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedMetrics: (metrics: SystemMetrics | null) => void;
  setFilters: (filters: Partial<SystemMetricsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<SystemMetricsState["pagination"]>
  ) => void;
  addMetrics: (metrics: SystemMetrics) => void;
  updateMetrics: (id: string, metrics: Partial<SystemMetrics>) => void;
  removeMetrics: (id: string) => void;
  clearFilters: () => void;
}

export const useSystemMetricsStore = create<SystemMetricsState>()(
  devtools(
    (set) => ({
      metrics: [],
      loading: false,
      error: null,
      selectedMetrics: null,
      filters: {
        dateRange: [null, null],
        organizationId: "all",
      },
      pagination: {
        page: 1,
        limit: 50,
        total: 0,
      },
      setMetrics: (metrics) => set({ metrics }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedMetrics: (selectedMetrics) => set({ selectedMetrics }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addMetrics: (metrics) =>
        set((state) => ({ metrics: [...state.metrics, metrics] })),
      updateMetrics: (id, updatedMetrics) =>
        set((state) => ({
          metrics: state.metrics.map((m) =>
            m.id === id ? { ...m, ...updatedMetrics } : m
          ),
        })),
      removeMetrics: (id) =>
        set((state) => ({
          metrics: state.metrics.filter((m) => m.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            dateRange: [null, null],
            organizationId: "all",
          },
        }),
    }),
    { name: "system-metrics-store" }
  )
);
