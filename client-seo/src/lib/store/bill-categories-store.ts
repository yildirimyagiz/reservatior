import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface BillCategory {
  id: string;
  name: string;
  description?: string;
  parentCategoryId?: string;
  color: string;
  budgetAlert?: number; // percentage
  isTaxDeductible: boolean;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface BillCategoriesState {
  categories: BillCategory[];
  loading: boolean;
  error: string | null;
  selectedCategory: BillCategory | null;
  filters: {
    search: string;
    parentCategoryId: string;
    isTaxDeductible: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setCategories: (categories: BillCategory[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedCategory: (category: BillCategory | null) => void;
  setFilters: (filters: Partial<BillCategoriesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<BillCategoriesState["pagination"]>
  ) => void;
  addCategory: (category: BillCategory) => void;
  updateCategory: (id: string, category: Partial<BillCategory>) => void;
  removeCategory: (id: string) => void;
  clearFilters: () => void;
}

export const useBillCategoriesStore = create<BillCategoriesState>()(
  devtools(
    (set) => ({
      categories: [],
      loading: false,
      error: null,
      selectedCategory: null,
      filters: {
        search: "",
        parentCategoryId: "all",
        isTaxDeductible: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setCategories: (categories) => set({ categories }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedCategory: (selectedCategory) => set({ selectedCategory }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addCategory: (category) =>
        set((state) => ({ categories: [...state.categories, category] })),
      updateCategory: (id, updatedCategory) =>
        set((state) => ({
          categories: state.categories.map((c) =>
            c.id === id ? { ...c, ...updatedCategory } : c
          ),
        })),
      removeCategory: (id) =>
        set((state) => ({
          categories: state.categories.filter((c) => c.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            parentCategoryId: "all",
            isTaxDeductible: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "bill-categories-store" }
  )
);
