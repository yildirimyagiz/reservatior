import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface GovernmentIntegration {
  id: string;
  name: string;
  agency: string;
  type: string;
  description?: string;
  config: {
    baseUrl: string;
    apiKey?: string;
    webhookUrl?: string;
    syncSettings: {
      autoSync: boolean;
      syncInterval: number; // minutes
      syncFields: string[];
    };
  };
  features: string[];
  isActive: boolean;
  lastSyncAt?: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface GovernmentIntegrationsState {
  integrations: GovernmentIntegration[];
  loading: boolean;
  error: string | null;
  selectedIntegration: GovernmentIntegration | null;
  filters: {
    search: string;
    agency: string;
    type: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setIntegrations: (integrations: GovernmentIntegration[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedIntegration: (integration: GovernmentIntegration | null) => void;
  setFilters: (
    filters: Partial<GovernmentIntegrationsState["filters"]>
  ) => void;
  setPagination: (
    pagination: Partial<GovernmentIntegrationsState["pagination"]>
  ) => void;
  addIntegration: (integration: GovernmentIntegration) => void;
  updateIntegration: (
    id: string,
    integration: Partial<GovernmentIntegration>
  ) => void;
  removeIntegration: (id: string) => void;
  clearFilters: () => void;
}

export const useGovernmentIntegrationsStore =
  create<GovernmentIntegrationsState>()(
    devtools(
      (set) => ({
        integrations: [],
        loading: false,
        error: null,
        selectedIntegration: null,
        filters: {
          search: "",
          agency: "all",
          type: "all",
          isActive: "all",
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
              agency: "all",
              type: "all",
              isActive: "all",
            },
          }),
      }),
      { name: "government-integrations-store" }
    )
  );
