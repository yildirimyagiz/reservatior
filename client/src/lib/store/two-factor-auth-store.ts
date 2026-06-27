import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface TwoFactorAuth {
  id: string;
  userId: string;
  method: string;
  secret?: string;
  phoneNumber?: string;
  email?: string;
  backupCodes: string[];
  isEnabled: boolean;
  lastUsedAt?: Date;
  verifiedAt?: Date;
  attempts: number;
  lockedUntil?: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface TwoFactorAuthState {
  twoFactorAuths: TwoFactorAuth[];
  loading: boolean;
  error: string | null;
  selectedTwoFactorAuth: TwoFactorAuth | null;
  filters: {
    search: string;
    userId: string;
    method: string;
    isEnabled: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTwoFactorAuths: (twoFactorAuths: TwoFactorAuth[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedTwoFactorAuth: (twoFactorAuth: TwoFactorAuth | null) => void;
  setFilters: (filters: Partial<TwoFactorAuthState["filters"]>) => void;
  setPagination: (
    pagination: Partial<TwoFactorAuthState["pagination"]>
  ) => void;
  addTwoFactorAuth: (twoFactorAuth: TwoFactorAuth) => void;
  updateTwoFactorAuth: (
    id: string,
    twoFactorAuth: Partial<TwoFactorAuth>
  ) => void;
  removeTwoFactorAuth: (id: string) => void;
  clearFilters: () => void;
}

export const useTwoFactorAuthStore = create<TwoFactorAuthState>()(
  devtools(
    (set) => ({
      twoFactorAuths: [],
      loading: false,
      error: null,
      selectedTwoFactorAuth: null,
      filters: {
        search: "",
        userId: "all",
        method: "all",
        isEnabled: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setTwoFactorAuths: (twoFactorAuths) => set({ twoFactorAuths }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedTwoFactorAuth: (selectedTwoFactorAuth) =>
        set({ selectedTwoFactorAuth }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addTwoFactorAuth: (twoFactorAuth) =>
        set((state) => ({
          twoFactorAuths: [...state.twoFactorAuths, twoFactorAuth],
        })),
      updateTwoFactorAuth: (id, updatedTwoFactorAuth) =>
        set((state) => ({
          twoFactorAuths: state.twoFactorAuths.map((tfa) =>
            tfa.id === id ? { ...tfa, ...updatedTwoFactorAuth } : tfa
          ),
        })),
      removeTwoFactorAuth: (id) =>
        set((state) => ({
          twoFactorAuths: state.twoFactorAuths.filter((tfa) => tfa.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            userId: "all",
            method: "all",
            isEnabled: "all",
          },
        }),
    }),
    { name: "two-factor-auth-store" }
  )
);
