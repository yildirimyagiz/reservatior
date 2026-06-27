import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Plan {
  id: string;
  name: string;
  description?: string;
  type: string;
  tier: string;
  price: {
    monthly: number;
    yearly: number;
    currency: string;
  };
  features: Array<{
    name: string;
    included: boolean;
    limit?: number;
  }>;
  limits: {
    users: number;
    properties: number;
    storage: number; // MB
    apiCalls: number;
  };
  isActive: boolean;
  trialDays: number;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface PlansState {
  plans: Plan[];
  loading: boolean;
  error: string | null;
  selectedPlan: Plan | null;
  filters: {
    search: string;
    type: string;
    tier: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setPlans: (plans: Plan[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedPlan: (plan: Plan | null) => void;
  setFilters: (filters: Partial<PlansState["filters"]>) => void;
  setPagination: (pagination: Partial<PlansState["pagination"]>) => void;
  addPlan: (plan: Plan) => void;
  updatePlan: (id: string, plan: Partial<Plan>) => void;
  removePlan: (id: string) => void;
  clearFilters: () => void;
}

export const usePlansStore = create<PlansState>()(
  devtools(
    (set) => ({
      plans: [],
      loading: false,
      error: null,
      selectedPlan: null,
      filters: {
        search: "",
        type: "all",
        tier: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setPlans: (plans) => set({ plans }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedPlan: (selectedPlan) => set({ selectedPlan }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addPlan: (plan) => set((state) => ({ plans: [...state.plans, plan] })),
      updatePlan: (id, updatedPlan) =>
        set((state) => ({
          plans: state.plans.map((p) =>
            p.id === id ? { ...p, ...updatedPlan } : p
          ),
        })),
      removePlan: (id) =>
        set((state) => ({
          plans: state.plans.filter((p) => p.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            tier: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "plans-store" }
  )
);
