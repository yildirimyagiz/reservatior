import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ApiToken {
  id: string;
  name: string;
  token: string;
  permissions: string[];
  expiresAt?: Date;
  lastUsed?: Date;
  isActive: boolean;
  userId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ApiTokenState {
  tokens: ApiToken[];
  loading: boolean;
  error: string | null;
  selectedToken: ApiToken | null;
  filters: {
    search: string;
    userId: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTokens: (tokens: ApiToken[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedToken: (token: ApiToken | null) => void;
  setFilters: (filters: Partial<ApiTokenState["filters"]>) => void;
  setPagination: (pagination: Partial<ApiTokenState["pagination"]>) => void;
  addToken: (token: ApiToken) => void;
  updateToken: (id: string, token: Partial<ApiToken>) => void;
  removeToken: (id: string) => void;
  clearFilters: () => void;
}

export const useApiTokensStore = create<ApiTokenState>()(
  devtools(
    (set) => ({
      tokens: [],
      loading: false,
      error: null,
      selectedToken: null,
      filters: {
        search: "",
        userId: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setTokens: (tokens) => set({ tokens }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedToken: (selectedToken) => set({ selectedToken }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addToken: (token) =>
        set((state) => ({ tokens: [...state.tokens, token] })),
      updateToken: (id, updatedToken) =>
        set((state) => ({
          tokens: state.tokens.map((t) =>
            t.id === id ? { ...t, ...updatedToken } : t
          ),
        })),
      removeToken: (id) =>
        set((state) => ({
          tokens: state.tokens.filter((t) => t.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            userId: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "api-tokens-store" }
  )
);
