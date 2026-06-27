import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface WebhookDelivery {
  id: string;
  webhookId: string;
  url: string;
  method: string;
  headers: Record<string, string>;
  payload: any;
  responseStatus?: number;
  responseBody?: string;
  attemptCount: number;
  maxAttempts: number;
  status: "pending" | "delivered" | "failed" | "retrying";
  deliveredAt?: Date;
  nextRetryAt?: Date;
  errorMessage?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface WebhookDeliveriesState {
  deliveries: WebhookDelivery[];
  loading: boolean;
  error: string | null;
  selectedDelivery: WebhookDelivery | null;
  filters: {
    search: string;
    webhookId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setDeliveries: (deliveries: WebhookDelivery[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedDelivery: (delivery: WebhookDelivery | null) => void;
  setFilters: (filters: Partial<WebhookDeliveriesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<WebhookDeliveriesState["pagination"]>
  ) => void;
  addDelivery: (delivery: WebhookDelivery) => void;
  updateDelivery: (id: string, delivery: Partial<WebhookDelivery>) => void;
  removeDelivery: (id: string) => void;
  clearFilters: () => void;
}

export const useWebhookDeliveriesStore = create<WebhookDeliveriesState>()(
  devtools(
    (set) => ({
      deliveries: [],
      loading: false,
      error: null,
      selectedDelivery: null,
      filters: {
        search: "",
        webhookId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setDeliveries: (deliveries) => set({ deliveries }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedDelivery: (selectedDelivery) => set({ selectedDelivery }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addDelivery: (delivery) =>
        set((state) => ({ deliveries: [...state.deliveries, delivery] })),
      updateDelivery: (id, updatedDelivery) =>
        set((state) => ({
          deliveries: state.deliveries.map((d) =>
            d.id === id ? { ...d, ...updatedDelivery } : d
          ),
        })),
      removeDelivery: (id) =>
        set((state) => ({
          deliveries: state.deliveries.filter((d) => d.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            webhookId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "webhook-deliveries-store" }
  )
);
