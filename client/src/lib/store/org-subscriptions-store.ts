import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface OrgSubscription {
  id: string;

  planId: string;
  status: "active" | "inactive" | "cancelled" | "suspended";
  startDate: Date;
  endDate?: Date;
  trialEndDate?: Date;
  billingCycle: "monthly" | "yearly";
  price: number;
  currency: string;
  autoRenew: boolean;
  cancelledAt?: Date;
  cancellationReason?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface OrgSubscriptionsState {
  subscriptions: OrgSubscription[];
  loading: boolean;
  error: string | null;
  selectedSubscription: OrgSubscription | null;
  filters: {
    search: string;
    organizationId: string;
    planId: string;
    status: string;
    billingCycle: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setSubscriptions: (subscriptions: OrgSubscription[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedSubscription: (subscription: OrgSubscription | null) => void;
  setFilters: (filters: Partial<OrgSubscriptionsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<OrgSubscriptionsState["pagination"]>
  ) => void;
  addSubscription: (subscription: OrgSubscription) => void;
  updateSubscription: (
    id: string,
    subscription: Partial<OrgSubscription>
  ) => void;
  removeSubscription: (id: string) => void;
  clearFilters: () => void;
}

export const useOrgSubscriptionsStore = create<OrgSubscriptionsState>()(
  devtools(
    (set) => ({
      subscriptions: [],
      loading: false,
      error: null,
      selectedSubscription: null,
      filters: {
        search: "",
        organizationId: "all",
        planId: "all",
        status: "all",
        billingCycle: "all",
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
            organizationId: "all",
            planId: "all",
            status: "all",
            billingCycle: "all",
          },
        }),
    }),
    { name: "org-subscriptions-store" }
  )
);
