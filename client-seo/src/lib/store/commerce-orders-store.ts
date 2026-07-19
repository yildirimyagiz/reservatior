import { create } from "zustand";
import { devtools } from "zustand/middleware";
import type { CommerceOrder } from "@/lib/api/commerce-orders";

export interface CommerceOrdersState {
  orders: CommerceOrder[];
  loading: boolean;
  error: string | null;
  selectedOrder: CommerceOrder | null;
  filters: {
    search: string;
    status: string;
    paymentStatus: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setOrders: (orders: CommerceOrder[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedOrder: (order: CommerceOrder | null) => void;
  setFilters: (filters: Partial<CommerceOrdersState["filters"]>) => void;
  setPagination: (pagination: Partial<CommerceOrdersState["pagination"]>) => void;
  addOrder: (order: CommerceOrder) => void;
  updateOrder: (id: string, order: Partial<CommerceOrder>) => void;
  removeOrder: (id: string) => void;
  clearFilters: () => void;
}

export const useCommerceOrdersStore = create<CommerceOrdersState>()(
  devtools(
    (set) => ({
      orders: [],
      loading: false,
      error: null,
      selectedOrder: null,
      filters: {
        search: "",
        status: "all",
        paymentStatus: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setOrders: (orders) => set({ orders }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedOrder: (selectedOrder) => set({ selectedOrder }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addOrder: (order) =>
        set((state) => ({ orders: [...state.orders, order] })),
      updateOrder: (id, updatedOrder) =>
        set((state) => ({
          orders: state.orders.map((o) =>
            o.id === id ? { ...o, ...updatedOrder } : o
          ),
        })),
      removeOrder: (id) =>
        set((state) => ({
          orders: state.orders.filter((o) => o.id !== id),
        })),
      clearFilters: () =>
        set({ filters: { search: "", status: "all", paymentStatus: "all" } }),
    }),
    { name: "commerce-orders-store" }
  )
);
