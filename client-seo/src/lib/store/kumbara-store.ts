import { create } from "zustand";
import { devtools } from "zustand/middleware";
import type { KumbaraDeposit } from "../api/kumbara";

export interface KumbaraState {
  items: KumbaraDeposit[];
  loading: boolean;
  error: string | null;
  selectedItem: KumbaraDeposit | null;
  filters: { search: string; status: string };
  pagination: { page: number; limit: number; total: number };
  setItems: (items: KumbaraDeposit[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedItem: (item: KumbaraDeposit | null) => void;
  setFilters: (filters: Partial<KumbaraState["filters"]>) => void;
  setPagination: (pagination: Partial<KumbaraState["pagination"]>) => void;
  addItem: (item: KumbaraDeposit) => void;
  updateItem: (id: string, item: Partial<KumbaraDeposit>) => void;
  removeItem: (id: string) => void;
  clearFilters: () => void;
}

export const useKumbaraStore = create<KumbaraState>()(
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
    { name: "kumbara-store" }
  )
);
