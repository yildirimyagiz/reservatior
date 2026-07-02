import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ContactType {
  id: string;
  name: string;
  description?: string;
  color: string;
  isClient: boolean;
  isVendor: boolean;
  isLead: boolean;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ContactTypesState {
  types: ContactType[];
  loading: boolean;
  error: string | null;
  selectedType: ContactType | null;
  filters: {
    search: string;
    isClient: string;
    isVendor: string;
    isLead: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTypes: (types: ContactType[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedType: (type: ContactType | null) => void;
  setFilters: (filters: Partial<ContactTypesState["filters"]>) => void;
  setPagination: (pagination: Partial<ContactTypesState["pagination"]>) => void;
  addType: (type: ContactType) => void;
  updateType: (id: string, type: Partial<ContactType>) => void;
  removeType: (id: string) => void;
  clearFilters: () => void;
}

export const useContactTypesStore = create<ContactTypesState>()(
  devtools(
    (set) => ({
      types: [],
      loading: false,
      error: null,
      selectedType: null,
      filters: {
        search: "",
        isClient: "all",
        isVendor: "all",
        isLead: "all",
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
            isClient: "all",
            isVendor: "all",
            isLead: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "contact-types-store" }
  )
);
