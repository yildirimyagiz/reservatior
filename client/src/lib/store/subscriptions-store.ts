import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Subscription {
  id: string;
  name: string;
  plan: string;
  status: "active" | "inactive" | "cancelled" | "expired";
  startDate: Date;
  endDate?: Date;
  amount: number;
  currency: string;
  billingCycle: "monthly" | "yearly";
  features: string[];
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface SubscriptionState {
  subscriptions: Subscription[];
  loading: boolean;
  error: string | null;
  selectedSubscription: Subscription | null;
  filters: {
    search: string;
    status: string;
    plan: string;
    organizationId: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setSubscriptions: (subscriptions: Subscription[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedSubscription: (subscription: Subscription | null) => void;
  setFilters: (filters: Partial<SubscriptionState["filters"]>) => void;
  setPagination: (pagination: Partial<SubscriptionState["pagination"]>) => void;
  addSubscription: (subscription: Subscription) => void;
  updateSubscription: (id: string, subscription: Partial<Subscription>) => void;
  removeSubscription: (id: string) => void;
  clearFilters: () => void;
}

export const useSubscriptionsStore = create<SubscriptionState>()(
  devtools(
    (set) => ({
      subscriptions: [],
      loading: false,
      error: null,
      selectedSubscription: null,
      filters: {
        search: "",
        status: "all",
        plan: "all",
        organizationId: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setSubscriptions: (subscriptions) => set({ subscriptions }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedSubscription: (selectedSubscription) =>
        set({ selectedSubscription }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addSubscription: (subscription) =>
        set((state) => ({
          subscriptions: [...state.subscriptions, subscription],
        })),
      updateSubscription: (id, updatedSubscription) =>
        set((state) => ({
          subscriptions: state.subscriptions.map((s) =>
            s.id === id ? { ...s, ...updatedSubscription } : s
          ),
        })),
      removeSubscription: (id) =>
        set((state) => ({
          subscriptions: state.subscriptions.filter((s) => s.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            status: "all",
            plan: "all",
            organizationId: "all",
          },
        }),
    }),
    { name: "subscriptions-store" }
  )
);
