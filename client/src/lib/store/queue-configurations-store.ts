import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface QueueConfiguration {
  id: string;
  name: string;
  type: string;
  description?: string;
  settings: {
    maxRetries: number;
    retryDelay: number; // seconds
    timeout: number; // seconds
    priority: number;
    concurrency: number;
  };
  isActive: boolean;
  messageCount: number;
  lastProcessed?: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface QueueConfigurationsState {
  configurations: QueueConfiguration[];
  loading: boolean;
  error: string | null;
  selectedConfiguration: QueueConfiguration | null;
  filters: {
    search: string;
    type: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setConfigurations: (configurations: QueueConfiguration[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedConfiguration: (configuration: QueueConfiguration | null) => void;
  setFilters: (filters: Partial<QueueConfigurationsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<QueueConfigurationsState["pagination"]>
  ) => void;
  addConfiguration: (configuration: QueueConfiguration) => void;
  updateConfiguration: (
    id: string,
    configuration: Partial<QueueConfiguration>
  ) => void;
  removeConfiguration: (id: string) => void;
  clearFilters: () => void;
}

export const useQueueConfigurationsStore = create<QueueConfigurationsState>()(
  devtools(
    (set) => ({
      configurations: [],
      loading: false,
      error: null,
      selectedConfiguration: null,
      filters: {
        search: "",
        type: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setConfigurations: (configurations) => set({ configurations }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedConfiguration: (selectedConfiguration) =>
        set({ selectedConfiguration }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addConfiguration: (configuration) =>
        set((state) => ({
          configurations: [...state.configurations, configuration],
        })),
      updateConfiguration: (id, updatedConfiguration) =>
        set((state) => ({
          configurations: state.configurations.map((c) =>
            c.id === id ? { ...c, ...updatedConfiguration } : c
          ),
        })),
      removeConfiguration: (id) =>
        set((state) => ({
          configurations: state.configurations.filter((c) => c.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "queue-configurations-store" }
  )
);
