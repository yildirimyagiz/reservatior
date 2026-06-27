import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Budget {
  id: string;
  name: string;
  description?: string;
  amount: number;
  currency: string;
  period: string;
  startDate: Date;
  endDate: Date;
  category: string;
  status: "active" | "completed" | "exceeded";
  organizationId: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface BudgetsState {
  budgets: Budget[];
  loading: boolean;
  error: string | null;
  selectedBudget: Budget | null;
  filters: {
    search: string;
    category: string;
    status: string;
    organizationId: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setBudgets: (budgets: Budget[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedBudget: (budget: Budget | null) => void;
  setFilters: (filters: Partial<BudgetsState["filters"]>) => void;
  setPagination: (pagination: Partial<BudgetsState["pagination"]>) => void;
  addBudget: (budget: Budget) => void;
  updateBudget: (id: string, budget: Partial<Budget>) => void;
  removeBudget: (id: string) => void;
  clearFilters: () => void;
}

export const useBudgetsStore = create<BudgetsState>()(
  devtools(
    (set) => ({
      budgets: [],
      loading: false,
      error: null,
      selectedBudget: null,
      filters: {
        search: "",
        category: "all",
        status: "all",
        organizationId: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setBudgets: (budgets) => set({ budgets }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedBudget: (selectedBudget) => set({ selectedBudget }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addBudget: (budget) =>
        set((state) => ({ budgets: [...state.budgets, budget] })),
      updateBudget: (id, updatedBudget) =>
        set((state) => ({
          budgets: state.budgets.map((b) =>
            b.id === id ? { ...b, ...updatedBudget } : b
          ),
        })),
      removeBudget: (id) =>
        set((state) => ({
          budgets: state.budgets.filter((b) => b.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            category: "all",
            status: "all",
            organizationId: "all",
          },
        }),
    }),
    { name: "budgets-store" }
  )
);
