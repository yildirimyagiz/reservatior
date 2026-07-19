import { create } from "zustand";
import { devtools } from "zustand/middleware";
import type { Product } from "@/lib/api/products";

export interface ProductsState {
  products: Product[];
  loading: boolean;
  error: string | null;
  selectedProduct: Product | null;
  filters: {
    search: string;
    category: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setProducts: (products: Product[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedProduct: (product: Product | null) => void;
  setFilters: (filters: Partial<ProductsState["filters"]>) => void;
  setPagination: (pagination: Partial<ProductsState["pagination"]>) => void;
  addProduct: (product: Product) => void;
  updateProduct: (id: string, product: Partial<Product>) => void;
  removeProduct: (id: string) => void;
  clearFilters: () => void;
}

export const useProductsStore = create<ProductsState>()(
  devtools(
    (set) => ({
      products: [],
      loading: false,
      error: null,
      selectedProduct: null,
      filters: {
        search: "",
        category: "all",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setProducts: (products) => set({ products }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedProduct: (selectedProduct) => set({ selectedProduct }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addProduct: (product) =>
        set((state) => ({ products: [...state.products, product] })),
      updateProduct: (id, updatedProduct) =>
        set((state) => ({
          products: state.products.map((p) =>
            p.id === id ? { ...p, ...updatedProduct } : p
          ),
        })),
      removeProduct: (id) =>
        set((state) => ({
          products: state.products.filter((p) => p.id !== id),
        })),
      clearFilters: () =>
        set({ filters: { search: "", category: "all", status: "all" } }),
    }),
    { name: "products-store" }
  )
);
