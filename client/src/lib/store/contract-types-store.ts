import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ContractType {
  id: string;
  name: string;
  description?: string;
  templateId?: string;
  requiredFields: string[];
  optionalFields: string[];
  requiresSignature: boolean;
  requiresWitness: boolean;
  defaultDuration?: number; // days
  autoRenewal: boolean;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ContractTypesState {
  types: ContractType[];
  loading: boolean;
  error: string | null;
  selectedType: ContractType | null;
  filters: {
    search: string;
    requiresSignature: string;
    requiresWitness: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTypes: (types: ContractType[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedType: (type: ContractType | null) => void;
  setFilters: (filters: Partial<ContractTypesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<ContractTypesState["pagination"]>
  ) => void;
  addType: (type: ContractType) => void;
  updateType: (id: string, type: Partial<ContractType>) => void;
  removeType: (id: string) => void;
  clearFilters: () => void;
}

export const useContractTypesStore = create<ContractTypesState>()(
  devtools(
    (set) => ({
      types: [],
      loading: false,
      error: null,
      selectedType: null,
      filters: {
        search: "",
        requiresSignature: "all",
        requiresWitness: "all",
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
            requiresSignature: "all",
            requiresWitness: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "contract-types-store" }
  )
);
