import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface DashboardWidget {
  widgetType: string;
  title: string;
  id: string;
  name: string;
  type: string;
  description?: string;
  config: Record<string, any>;
  dataSource: string;
  refreshInterval?: number; // minutes
  position: {
    x: number;
    y: number;
    width: number;
    height: number;
  };
  isActive: boolean;
  organizationId: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface DashboardWidgetsState {
  widgets: DashboardWidget[];
  loading: boolean;
  error: string | null;
  selectedWidget: DashboardWidget | null;
  filters: {
    search: string;
    type: string;
    dataSource: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setWidgets: (widgets: DashboardWidget[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedWidget: (widget: DashboardWidget | null) => void;
  setFilters: (filters: Partial<DashboardWidgetsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<DashboardWidgetsState["pagination"]>
  ) => void;
  addWidget: (widget: DashboardWidget) => void;
  updateWidget: (id: string, widget: Partial<DashboardWidget>) => void;
  removeWidget: (id: string) => void;
  clearFilters: () => void;
}

export const useDashboardWidgetsStore = create<DashboardWidgetsState>()(
  devtools(
    (set) => ({
      widgets: [],
      loading: false,
      error: null,
      selectedWidget: null,
      filters: {
        search: "",
        type: "all",
        dataSource: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setWidgets: (widgets) => set({ widgets }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedWidget: (selectedWidget) => set({ selectedWidget }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addWidget: (widget) =>
        set((state) => ({ widgets: [...state.widgets, widget] })),
      updateWidget: (id, updatedWidget) =>
        set((state) => ({
          widgets: state.widgets.map((w) =>
            w.id === id ? { ...w, ...updatedWidget } : w
          ),
        })),
      removeWidget: (id) =>
        set((state) => ({
          widgets: state.widgets.filter((w) => w.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            dataSource: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "dashboard-widgets-store" }
  )
);
