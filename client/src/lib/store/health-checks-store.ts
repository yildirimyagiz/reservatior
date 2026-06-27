import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface HealthCheck {
  id: string;
  service: string;
  status: "healthy" | "unhealthy" | "degraded";
  responseTime: number;
  lastChecked: Date;
  uptime: number;
  errorMessage?: string;
  metadata: Record<string, any>;
  organizationId: string;
}

export interface HealthChecksState {
  healthChecks: HealthCheck[];
  loading: boolean;
  error: string | null;
  selectedHealthCheck: HealthCheck | null;
  filters: {
    search: string;
    service: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setHealthChecks: (healthChecks: HealthCheck[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedHealthCheck: (healthCheck: HealthCheck | null) => void;
  setFilters: (filters: Partial<HealthChecksState["filters"]>) => void;
  setPagination: (pagination: Partial<HealthChecksState["pagination"]>) => void;
  addHealthCheck: (healthCheck: HealthCheck) => void;
  updateHealthCheck: (id: string, healthCheck: Partial<HealthCheck>) => void;
  removeHealthCheck: (id: string) => void;
  clearFilters: () => void;
}

export const useHealthChecksStore = create<HealthChecksState>()(
  devtools(
    (set) => ({
      healthChecks: [],
      loading: false,
      error: null,
      selectedHealthCheck: null,
      filters: {
        search: "",
        service: "all",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setHealthChecks: (healthChecks) => set({ healthChecks }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedHealthCheck: (selectedHealthCheck) =>
        set({ selectedHealthCheck }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addHealthCheck: (healthCheck) =>
        set((state) => ({
          healthChecks: [...state.healthChecks, healthCheck],
        })),
      updateHealthCheck: (id, updatedHealthCheck) =>
        set((state) => ({
          healthChecks: state.healthChecks.map((hc) =>
            hc.id === id ? { ...hc, ...updatedHealthCheck } : hc
          ),
        })),
      removeHealthCheck: (id) =>
        set((state) => ({
          healthChecks: state.healthChecks.filter((hc) => hc.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            service: "all",
            status: "all",
          },
        }),
    }),
    { name: "health-checks-store" }
  )
);
