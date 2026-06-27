import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface LoyaltyAccount {
  id: string;
  userId: string;
  accountId: string;
  points: number;
  tier: string;
  status: "active" | "inactive" | "suspended";
  joinDate: Date;
  lastActivity: Date;
  rewards: string[]; // reward IDs
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface LoyaltyAccountsState {
  accounts: LoyaltyAccount[];
  loading: boolean;
  error: string | null;
  selectedAccount: LoyaltyAccount | null;
  filters: {
    search: string;
    userId: string;
    tier: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setAccounts: (accounts: LoyaltyAccount[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedAccount: (account: LoyaltyAccount | null) => void;
  setFilters: (filters: Partial<LoyaltyAccountsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<LoyaltyAccountsState["pagination"]>
  ) => void;
  addAccount: (account: LoyaltyAccount) => void;
  updateAccount: (id: string, account: Partial<LoyaltyAccount>) => void;
  removeAccount: (id: string) => void;
  clearFilters: () => void;
}

export const useLoyaltyAccountsStore = create<LoyaltyAccountsState>()(
  devtools(
    (set) => ({
      accounts: [],
      loading: false,
      error: null,
      selectedAccount: null,
      filters: {
        search: "",
        userId: "all",
        tier: "all",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setAccounts: (accounts) => set({ accounts }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedAccount: (selectedAccount) => set({ selectedAccount }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addAccount: (account) =>
        set((state) => ({ accounts: [...state.accounts, account] })),
      updateAccount: (id, updatedAccount) =>
        set((state) => ({
          accounts: state.accounts.map((a) =>
            a.id === id ? { ...a, ...updatedAccount } : a
          ),
        })),
      removeAccount: (id) =>
        set((state) => ({
          accounts: state.accounts.filter((a) => a.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            userId: "all",
            tier: "all",
            status: "all",
          },
        }),
    }),
    { name: "loyalty-accounts-store" }
  )
);
