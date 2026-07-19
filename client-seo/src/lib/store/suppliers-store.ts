import { create } from "zustand";
import { devtools } from "zustand/middleware";
import type { Supplier } from "@/lib/api/suppliers";

export interface SuppliersState {
  suppliers: Supplier[];
  loading: boolean;
  error: string | null;
  selectedSupplier: Supplier | null;
  filters: {
    search: string;
    status: string;
    businessType: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setSuppliers: (suppliers: Supplier[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedSupplier: (supplier: Supplier | null) => void;
  setFilters: (filters: Partial<SuppliersState["filters"]>) => void;
  setPagination: (pagination: Partial<SuppliersState["pagination"]>) => void;
  addSupplier: (supplier: Supplier) => void;
  updateSupplier: (id: string, supplier: Partial<Supplier>) => void;
  removeSupplier: (id: string) => void;
  clearFilters: () => void;
}

export const useSuppliersStore = create<SuppliersState>()(
  devtools(
    (set) => ({
      suppliers: [],
      loading: false,
      error: null,
      selectedSupplier: null,
      filters: {
        search: "",
        status: "all",
        businessType: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setSuppliers: (suppliers) => set({ suppliers }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedSupplier: (selectedSupplier) => set({ selectedSupplier }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addSupplier: (supplier) =>
        set((state) => ({ suppliers: [...state.suppliers, supplier] })),
      updateSupplier: (id, updatedSupplier) =>
        set((state) => ({
          suppliers: state.suppliers.map((s) =>
            s.id === id ? { ...s, ...updatedSupplier } : s
          ),
        })),
      removeSupplier: (id) =>
        set((state) => ({
          suppliers: state.suppliers.filter((s) => s.id !== id),
        })),
      clearFilters: () =>
        set({ filters: { search: "", status: "all", businessType: "all" } }),
    }),
    { name: "suppliers-store" }
  )
);
