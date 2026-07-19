import { create } from "zustand";
import { devtools } from "zustand/middleware";
import type { BankAccount } from "../api/bank-account";

export interface BankAccountState {
  items: BankAccount[];
  loading: boolean;
  error: string | null;
  selectedItem: BankAccount | null;
  filters: { search: string; status: string };
  pagination: { page: number; limit: number; total: number };
  setItems: (items: BankAccount[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedItem: (item: BankAccount | null) => void;
  setFilters: (filters: Partial<BankAccountState["filters"]>) => void;
  setPagination: (pagination: Partial<BankAccountState["pagination"]>) => void;
  addItem: (item: BankAccount) => void;
  updateItem: (id: string, item: Partial<BankAccount>) => void;
  removeItem: (id: string) => void;
  clearFilters: () => void;
}

export const useBankAccountStore = create<BankAccountState>()(
  devtools(
    (set) => ({
      items: [],
      loading: false,
      error: null,
      selectedItem: null,
      filters: { search: "", status: "" },
      pagination: { page: 1, limit: 20, total: 0 },
      setItems: (items) => set({ items }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedItem: (selectedItem) => set({ selectedItem }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addItem: (item) =>
        set((state) => ({ items: [...state.items, item] })),
      updateItem: (id, updatedItem) =>
        set((state) => ({
          items: state.items.map((i) =>
            i.id === id ? { ...i, ...updatedItem } : i
          ),
        })),
      removeItem: (id) =>
        set((state) => ({
          items: state.items.filter((i) => i.id !== id),
        })),
      clearFilters: () =>
        set({ filters: { search: "", status: "" } }),
    }),
    { name: "bank-account-store" }
  )
);
