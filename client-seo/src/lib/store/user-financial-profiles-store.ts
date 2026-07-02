import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface UserFinancialProfile {
  id: string;
  userId: string;
  income: {
    monthly: number;
    yearly: number;
    currency: string;
    source: string;
  };
  expenses: {
    monthly: number;
    categories: Array<{
      name: string;
      amount: number;
    }>;
  };
  assets: Array<{
    type: string;
    value: number;
    description?: string;
  }>;
  liabilities: Array<{
    type: string;
    amount: number;
    description?: string;
  }>;
  creditScore?: number;
  netWorth: number;
  riskTolerance: "conservative" | "moderate" | "aggressive";
  investmentGoals: string[];
  lastUpdated: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface UserFinancialProfilesState {
  profiles: UserFinancialProfile[];
  loading: boolean;
  error: string | null;
  selectedProfile: UserFinancialProfile | null;
  filters: {
    search: string;
    userId: string;
    riskTolerance: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setProfiles: (profiles: UserFinancialProfile[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedProfile: (profile: UserFinancialProfile | null) => void;
  setFilters: (filters: Partial<UserFinancialProfilesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<UserFinancialProfilesState["pagination"]>
  ) => void;
  addProfile: (profile: UserFinancialProfile) => void;
  updateProfile: (id: string, profile: Partial<UserFinancialProfile>) => void;
  removeProfile: (id: string) => void;
  clearFilters: () => void;
}

export const useUserFinancialProfilesStore =
  create<UserFinancialProfilesState>()(
    devtools(
      (set) => ({
        profiles: [],
        loading: false,
        error: null,
        selectedProfile: null,
        filters: {
          search: "",
          userId: "all",
          riskTolerance: "all",
        },
        pagination: {
          page: 1,
          limit: 20,
          total: 0,
        },
        setProfiles: (profiles) => set({ profiles }),
        setLoading: (loading) => set({ loading }),
        setError: (error) => set({ error }),
        setSelectedProfile: (selectedProfile) => set({ selectedProfile }),
        setFilters: (filters) =>
          set((state) => ({ filters: { ...state.filters, ...filters } })),
        setPagination: (pagination) =>
          set((state) => ({
            pagination: { ...state.pagination, ...pagination },
          })),
        addProfile: (profile) =>
          set((state) => ({ profiles: [...state.profiles, profile] })),
        updateProfile: (id, updatedProfile) =>
          set((state) => ({
            profiles: state.profiles.map((p) =>
              p.id === id ? { ...p, ...updatedProfile } : p
            ),
          })),
        removeProfile: (id) =>
          set((state) => ({
            profiles: state.profiles.filter((p) => p.id !== id),
          })),
        clearFilters: () =>
          set({
            filters: {
              search: "",
              userId: "all",
              riskTolerance: "all",
            },
          }),
      }),
      { name: "user-financial-profiles-store" }
    )
  );
