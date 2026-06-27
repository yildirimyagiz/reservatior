import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface TransactionType {
  id: string;
  name: string;
  description?: string;
  category: string;
  affectsBalance: "debit" | "credit" | "neutral";
  isRecurring: boolean;
  requiresApproval: boolean;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface TransactionTypesState {
  types: TransactionType[];
  loading: boolean;
  error: string | null;
  selectedType: TransactionType | null;
  filters: {
    search: string;
    category: string;
    affectsBalance: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTypes: (types: TransactionType[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedType: (type: TransactionType | null) => void;
  setFilters: (filters: Partial<TransactionTypesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<TransactionTypesState["pagination"]>
  ) => void;
  addType: (type: TransactionType) => void;
  updateType: (id: string, type: Partial<TransactionType>) => void;
  removeType: (id: string) => void;
  clearFilters: () => void;
}

export const useTransactionTypesStore = create<TransactionTypesState>()(
  devtools(
    (set) => ({
      types: [],
      loading: false,
      error: null,
      selectedType: null,
      filters: {
        search: "",
        category: "all",
        affectsBalance: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setTypes: (types) => set({ types }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedType: (selectedType) => set({ selectedType }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addType: (type) => set((state) => ({ types: [...state.types, type] })),
      updateType: (id, updatedType) =>
        set((state) => ({
          types: state.types.map((t) =>
            t.id === id ? { ...t, ...updatedType } : t
          ),
        })),
      removeType: (id) =>
        set((state) => ({
          types: state.types.filter((t) => t.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            category: "all",
            affectsBalance: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "transaction-types-store" }
  )
);
