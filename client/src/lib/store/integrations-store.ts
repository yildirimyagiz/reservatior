import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Integration {
  id: string;
  name: string;
  type: string;
  status: "active" | "inactive" | "error" | "pending";
  configuration: Record<string, any>;
  apiKey?: string;
  webhookUrl?: string;
  lastSync?: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface IntegrationState {
  integrations: Integration[];
  loading: boolean;
  error: string | null;
  selectedIntegration: Integration | null;
  filters: {
    search: string;
    type: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setIntegrations: (integrations: Integration[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedIntegration: (integration: Integration | null) => void;
  setFilters: (filters: Partial<IntegrationState["filters"]>) => void;
  setPagination: (pagination: Partial<IntegrationState["pagination"]>) => void;
  addIntegration: (integration: Integration) => void;
  updateIntegration: (id: string, integration: Partial<Integration>) => void;
  removeIntegration: (id: string) => void;
  clearFilters: () => void;
}

export const useIntegrationsStore = create<IntegrationState>()(
  devtools(
    (set) => ({
      integrations: [],
      loading: false,
      error: null,
      selectedIntegration: null,
      filters: {
        search: "",
        type: "all",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setIntegrations: (integrations) => set({ integrations }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedIntegration: (selectedIntegration) =>
        set({ selectedIntegration }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addIntegration: (integration) =>
        set((state) => ({
          integrations: [...state.integrations, integration],
        })),
      updateIntegration: (id, updatedIntegration) =>
        set((state) => ({
          integrations: state.integrations.map((i) =>
            i.id === id ? { ...i, ...updatedIntegration } : i
          ),
        })),
      removeIntegration: (id) =>
        set((state) => ({
          integrations: state.integrations.filter((i) => i.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            status: "all",
          },
        }),
    }),
    { name: "integrations-store" }
  )
);
