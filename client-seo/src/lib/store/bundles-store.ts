import { create } from "zustand";
import { devtools } from "zustand/middleware";
import type { ProductBundle } from "@/lib/api/bundles";

export interface BundlesState {
  bundles: ProductBundle[];
  loading: boolean;
  error: string | null;
  selectedBundle: ProductBundle | null;
  filters: {
    search: string;
    bundleType: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setBundles: (bundles: ProductBundle[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedBundle: (bundle: ProductBundle | null) => void;
  setFilters: (filters: Partial<BundlesState["filters"]>) => void;
  setPagination: (pagination: Partial<BundlesState["pagination"]>) => void;
  addBundle: (bundle: ProductBundle) => void;
  updateBundle: (id: string, bundle: Partial<ProductBundle>) => void;
  removeBundle: (id: string) => void;
  clearFilters: () => void;
}

export const useBundlesStore = create<BundlesState>()(
  devtools(
    (set) => ({
      bundles: [],
      loading: false,
      error: null,
      selectedBundle: null,
      filters: {
        search: "",
        bundleType: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setBundles: (bundles) => set({ bundles }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedBundle: (selectedBundle) => set({ selectedBundle }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addBundle: (bundle) =>
        set((state) => ({ bundles: [...state.bundles, bundle] })),
      updateBundle: (id, updatedBundle) =>
        set((state) => ({
          bundles: state.bundles.map((b) =>
            b.id === id ? { ...b, ...updatedBundle } : b
          ),
        })),
      removeBundle: (id) =>
        set((state) => ({
          bundles: state.bundles.filter((b) => b.id !== id),
        })),
      clearFilters: () =>
        set({ filters: { search: "", bundleType: "all", isActive: "all" } }),
    }),
    { name: "bundles-store" }
  )
);
