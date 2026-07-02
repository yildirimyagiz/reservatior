import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ApiKey {
  id: string;
  name: string;
  key: string;
  permissions: string[];
  expiresAt?: Date;
  lastUsed?: Date;
  isActive: boolean;
  usageCount: number;
  rateLimit?: number;
  organizationId: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ApiKeysState {
  apiKeys: ApiKey[];
  loading: boolean;
  error: string | null;
  selectedApiKey: ApiKey | null;
  filters: {
    search: string;
    isActive: string;
    organizationId: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setApiKeys: (apiKeys: ApiKey[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedApiKey: (apiKey: ApiKey | null) => void;
  setFilters: (filters: Partial<ApiKeysState["filters"]>) => void;
  setPagination: (pagination: Partial<ApiKeysState["pagination"]>) => void;
  addApiKey: (apiKey: ApiKey) => void;
  updateApiKey: (id: string, apiKey: Partial<ApiKey>) => void;
  removeApiKey: (id: string) => void;
  clearFilters: () => void;
}

export const useApiKeysStore = create<ApiKeysState>()(
  devtools(
    (set) => ({
      apiKeys: [],
      loading: false,
      error: null,
      selectedApiKey: null,
      filters: {
        search: "",
        isActive: "all",
        organizationId: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setApiKeys: (apiKeys) => set({ apiKeys }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedApiKey: (selectedApiKey) => set({ selectedApiKey }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addApiKey: (apiKey) =>
        set((state) => ({ apiKeys: [...state.apiKeys, apiKey] })),
      updateApiKey: (id, updatedApiKey) =>
        set((state) => ({
          apiKeys: state.apiKeys.map((ak) =>
            ak.id === id ? { ...ak, ...updatedApiKey } : ak
          ),
        })),
      removeApiKey: (id) =>
        set((state) => ({
          apiKeys: state.apiKeys.filter((ak) => ak.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            isActive: "all",
            organizationId: "all",
          },
        }),
    }),
    { name: "api-keys-store" }
  )
);
