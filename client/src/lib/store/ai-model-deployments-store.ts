import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AIModelDeployment {
  id: string;
  modelId: string;
  name: string;
  version: string;
  endpoint: string;
  status: "deploying" | "active" | "inactive" | "failed";
  config: Record<string, any>;
  resources: {
    cpu: number;
    memory: number;
    gpu?: number;
  };
  metrics: {
    requestsPerMinute: number;
    averageLatency: number;
    errorRate: number;
  };
  deployedAt?: Date;
  lastHealthCheck?: Date;
  organizationId: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AIModelDeploymentsState {
  deployments: AIModelDeployment[];
  loading: boolean;
  error: string | null;
  selectedDeployment: AIModelDeployment | null;
  filters: {
    search: string;
    modelId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setDeployments: (deployments: AIModelDeployment[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedDeployment: (deployment: AIModelDeployment | null) => void;
  setFilters: (filters: Partial<AIModelDeploymentsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AIModelDeploymentsState["pagination"]>
  ) => void;
  addDeployment: (deployment: AIModelDeployment) => void;
  updateDeployment: (
    id: string,
    deployment: Partial<AIModelDeployment>
  ) => void;
  removeDeployment: (id: string) => void;
  clearFilters: () => void;
}

export const useAIModelDeploymentsStore = create<AIModelDeploymentsState>()(
  devtools(
    (set) => ({
      deployments: [],
      loading: false,
      error: null,
      selectedDeployment: null,
      filters: {
        search: "",
        modelId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setDeployments: (deployments) => set({ deployments }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedDeployment: (selectedDeployment) =>
        set({ selectedDeployment }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addDeployment: (deployment) =>
        set((state) => ({ deployments: [...state.deployments, deployment] })),
      updateDeployment: (id, updatedDeployment) =>
        set((state) => ({
          deployments: state.deployments.map((d) =>
            d.id === id ? { ...d, ...updatedDeployment } : d
          ),
        })),
      removeDeployment: (id) =>
        set((state) => ({
          deployments: state.deployments.filter((d) => d.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            modelId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "ai-model-deployments-store" }
  )
);
