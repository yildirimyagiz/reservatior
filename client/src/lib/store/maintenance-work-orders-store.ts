import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface MaintenanceWorkOrder {
  id: string;
  title: string;
  description?: string;
  priority: "low" | "medium" | "high" | "urgent";
  status: "pending" | "assigned" | "in_progress" | "completed" | "cancelled";
  category: string;
  propertyId: string;
  unitId?: string;
  requestedBy: string;
  assignedTo?: string;
  vendorId?: string;
  estimatedCost?: number;
  actualCost?: number;
  currency: string;
  scheduledDate?: Date;
  startedAt?: Date;
  completedAt?: Date;
  estimatedDuration?: number; // hours
  actualDuration?: number; // hours
  materials: Array<{
    name: string;
    quantity: number;
    cost: number;
  }>;
  photos: string[];
  documents: string[];
  notes: Array<{
    content: string;
    author: string;
    timestamp: Date;
  }>;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface MaintenanceWorkOrdersState {
  workOrders: MaintenanceWorkOrder[];
  loading: boolean;
  error: string | null;
  selectedWorkOrder: MaintenanceWorkOrder | null;
  filters: {
    search: string;
    propertyId: string;
    status: string;
    priority: string;
    category: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setWorkOrders: (workOrders: MaintenanceWorkOrder[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedWorkOrder: (workOrder: MaintenanceWorkOrder | null) => void;
  setFilters: (filters: Partial<MaintenanceWorkOrdersState["filters"]>) => void;
  setPagination: (
    pagination: Partial<MaintenanceWorkOrdersState["pagination"]>
  ) => void;
  addWorkOrder: (workOrder: MaintenanceWorkOrder) => void;
  updateWorkOrder: (
    id: string,
    workOrder: Partial<MaintenanceWorkOrder>
  ) => void;
  removeWorkOrder: (id: string) => void;
  clearFilters: () => void;
}

export const useMaintenanceWorkOrdersStore =
  create<MaintenanceWorkOrdersState>()(
    devtools(
      (set) => ({
        workOrders: [],
        loading: false,
        error: null,
        selectedWorkOrder: null,
        filters: {
          search: "",
          propertyId: "all",
          status: "all",
          priority: "all",
          category: "all",
          dateRange: [null, null],
        },
        pagination: {
          page: 1,
          limit: 20,
          total: 0,
        },
        setWorkOrders: (workOrders) => set({ workOrders }),
        setLoading: (loading) => set({ loading }),
        setError: (error) => set({ error }),
        setSelectedWorkOrder: (selectedWorkOrder) => set({ selectedWorkOrder }),
        setFilters: (filters) =>
          set((state) => ({ filters: { ...state.filters, ...filters } })),
        setPagination: (pagination) =>
          set((state) => ({
            pagination: { ...state.pagination, ...pagination },
          })),
        addWorkOrder: (workOrder) =>
          set((state) => ({ workOrders: [...state.workOrders, workOrder] })),
        updateWorkOrder: (id, updatedWorkOrder) =>
          set((state) => ({
            workOrders: state.workOrders.map((wo) =>
              wo.id === id ? { ...wo, ...updatedWorkOrder } : wo
            ),
          })),
        removeWorkOrder: (id) =>
          set((state) => ({
            workOrders: state.workOrders.filter((wo) => wo.id !== id),
          })),
        clearFilters: () =>
          set({
            filters: {
              search: "",
              propertyId: "all",
              status: "all",
              priority: "all",
              category: "all",
              dateRange: [null, null],
            },
          }),
      }),
      { name: "maintenance-work-orders-store" }
    )
  );
