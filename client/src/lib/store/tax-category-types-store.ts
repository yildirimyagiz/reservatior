import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface TaxCategoryType {
  id: string;
  name: string;
  description?: string;
  code: string;
  isDeductible: boolean;
  depreciationYears?: number;
  maxDeductionAmount?: number;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface TaxCategoryTypesState {
  categoryTypes: TaxCategoryType[];
  loading: boolean;
  error: string | null;
  selectedCategoryType: TaxCategoryType | null;
  filters: {
    search: string;
    isDeductible: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setCategoryTypes: (categoryTypes: TaxCategoryType[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedCategoryType: (categoryType: TaxCategoryType | null) => void;
  setFilters: (filters: Partial<TaxCategoryTypesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<TaxCategoryTypesState["pagination"]>
  ) => void;
  addCategoryType: (categoryType: TaxCategoryType) => void;
  updateCategoryType: (
    id: string,
    categoryType: Partial<TaxCategoryType>
  ) => void;
  removeCategoryType: (id: string) => void;
  clearFilters: () => void;
}

export const useTaxCategoryTypesStore = create<TaxCategoryTypesState>()(
  devtools(
    (set) => ({
      categoryTypes: [],
      loading: false,
      error: null,
      selectedCategoryType: null,
      filters: {
        search: "",
        isDeductible: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setCategoryTypes: (categoryTypes) => set({ categoryTypes }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedCategoryType: (selectedCategoryType) =>
        set({ selectedCategoryType }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addCategoryType: (categoryType) =>
        set((state) => ({
          categoryTypes: [...state.categoryTypes, categoryType],
        })),
      updateCategoryType: (id, updatedCategoryType) =>
        set((state) => ({
          categoryTypes: state.categoryTypes.map((ct) =>
            ct.id === id ? { ...ct, ...updatedCategoryType } : ct
          ),
        })),
      removeCategoryType: (id) =>
        set((state) => ({
          categoryTypes: state.categoryTypes.filter((ct) => ct.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            isDeductible: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "tax-category-types-store" }
  )
);
