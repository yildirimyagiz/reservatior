import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AutomationRule {
  id: string;
  name: string;
  description?: string;
  trigger: {
    type: string;
    conditions: Record<string, any>;
  };
  actions: Array<{
    type: string;
    parameters: Record<string, any>;
    order: number;
  }>;
  isActive: boolean;
  priority: number;
  executionCount: number;
  lastExecuted?: Date;
  organizationId: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AutomationRulesState {
  rules: AutomationRule[];
  loading: boolean;
  error: string | null;
  selectedRule: AutomationRule | null;
  filters: {
    search: string;
    triggerType: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setRules: (rules: AutomationRule[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedRule: (rule: AutomationRule | null) => void;
  setFilters: (filters: Partial<AutomationRulesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AutomationRulesState["pagination"]>
  ) => void;
  addRule: (rule: AutomationRule) => void;
  updateRule: (id: string, rule: Partial<AutomationRule>) => void;
  removeRule: (id: string) => void;
  clearFilters: () => void;
}

export const useAutomationRulesStore = create<AutomationRulesState>()(
  devtools(
    (set) => ({
      rules: [],
      loading: false,
      error: null,
      selectedRule: null,
      filters: {
        search: "",
        triggerType: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setRules: (rules) => set({ rules }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedRule: (selectedRule) => set({ selectedRule }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addRule: (rule) => set((state) => ({ rules: [...state.rules, rule] })),
      updateRule: (id, updatedRule) =>
        set((state) => ({
          rules: state.rules.map((r) =>
            r.id === id ? { ...r, ...updatedRule } : r
          ),
        })),
      removeRule: (id) =>
        set((state) => ({
          rules: state.rules.filter((r) => r.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            triggerType: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "automation-rules-store" }
  )
);
