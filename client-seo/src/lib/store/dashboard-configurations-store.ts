import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface DashboardConfiguration {
  id: string;
  name: string;
  description?: string;
  layout: string;
  widgets: Array<{
    id: string;
    type: string;
    position: { x: number; y: number; w: number; h: number };
    config: Record<string, any>;
  }>;
  isDefault: boolean;
  isActive: boolean;
  userId?: string;
  organizationId: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface DashboardConfigurationsState {
  configurations: DashboardConfiguration[];
  loading: boolean;
  error: string | null;
  selectedConfiguration: DashboardConfiguration | null;
  filters: {
    search: string;
    userId: string;
    isDefault: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setConfigurations: (configurations: DashboardConfiguration[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedConfiguration: (
    configuration: DashboardConfiguration | null
  ) => void;
  setFilters: (
    filters: Partial<DashboardConfigurationsState["filters"]>
  ) => void;
  setPagination: (
    pagination: Partial<DashboardConfigurationsState["pagination"]>
  ) => void;
  addConfiguration: (configuration: DashboardConfiguration) => void;
  updateConfiguration: (
    id: string,
    configuration: Partial<DashboardConfiguration>
  ) => void;
  removeConfiguration: (id: string) => void;
  clearFilters: () => void;
}

export const useDashboardConfigurationsStore =
  create<DashboardConfigurationsState>()(
    devtools(
      (set) => ({
        configurations: [],
        loading: false,
        error: null,
        selectedConfiguration: null,
        filters: {
          search: "",
          userId: "all",
          isDefault: "all",
          isActive: "all",
        },
        pagination: {
          page: 1,
          limit: 20,
          total: 0,
        },
        setConfigurations: (configurations) => set({ configurations }),
        setLoading: (loading) => set({ loading }),
        setError: (error) => set({ error }),
        setSelectedConfiguration: (selectedConfiguration) =>
          set({ selectedConfiguration }),
        setFilters: (filters) =>
          set((state) => ({ filters: { ...state.filters, ...filters } })),
        setPagination: (pagination) =>
          set((state) => ({
            pagination: { ...state.pagination, ...pagination },
          })),
        addConfiguration: (configuration) =>
          set((state) => ({
            configurations: [...state.configurations, configuration],
          })),
        updateConfiguration: (id, updatedConfiguration) =>
          set((state) => ({
            configurations: state.configurations.map((c) =>
              c.id === id ? { ...c, ...updatedConfiguration } : c
            ),
          })),
        removeConfiguration: (id) =>
          set((state) => ({
            configurations: state.configurations.filter((c) => c.id !== id),
          })),
        clearFilters: () =>
          set({
            filters: {
              search: "",
              userId: "all",
              isDefault: "all",
              isActive: "all",
            },
          }),
      }),
      { name: "dashboard-configurations-store" }
    )
  );
