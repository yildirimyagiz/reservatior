import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface OrgType {
  id: string;
  name: string;
  description?: string;
  features: string[];
  limits: {
    users: number;
    properties: number;
    storage: number; // MB
  };
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
}

export interface OrgTypesState {
  types: OrgType[];
  loading: boolean;
  error: string | null;
  selectedType: OrgType | null;
  filters: {
    search: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTypes: (types: OrgType[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedType: (type: OrgType | null) => void;
  setFilters: (filters: Partial<OrgTypesState["filters"]>) => void;
  setPagination: (pagination: Partial<OrgTypesState["pagination"]>) => void;
  addType: (type: OrgType) => void;
  updateType: (id: string, type: Partial<OrgType>) => void;
  removeType: (id: string) => void;
  clearFilters: () => void;
}

export const useOrgTypesStore = create<OrgTypesState>()(
  devtools(
    (set) => ({
      types: [],
      loading: false,
      error: null,
      selectedType: null,
      filters: {
        search: "",
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
            isActive: "all",
          },
        }),
    }),
    { name: "org-types-store" }
  )
);
