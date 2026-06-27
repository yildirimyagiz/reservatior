import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Reference {
  id: string;
  name: string;
  email: string;
  phone?: string;
  relationship: string;
  company?: string;
  position?: string;
  contactId?: string;
  leadId?: string;
  status: "pending" | "contacted" | "completed" | "failed";
  notes?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ReferencesState {
  references: Reference[];
  loading: boolean;
  error: string | null;
  selectedReference: Reference | null;
  filters: {
    search: string;
    status: string;
    relationship: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setReferences: (references: Reference[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedReference: (reference: Reference | null) => void;
  setFilters: (filters: Partial<ReferencesState["filters"]>) => void;
  setPagination: (pagination: Partial<ReferencesState["pagination"]>) => void;
  addReference: (reference: Reference) => void;
  updateReference: (id: string, reference: Partial<Reference>) => void;
  removeReference: (id: string) => void;
  clearFilters: () => void;
}

export const useReferencesStore = create<ReferencesState>()(
  devtools(
    (set) => ({
      references: [],
      loading: false,
      error: null,
      selectedReference: null,
      filters: {
        search: "",
        status: "all",
        relationship: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setReferences: (references) => set({ references }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedReference: (selectedReference) => set({ selectedReference }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addReference: (reference) =>
        set((state) => ({ references: [...state.references, reference] })),
      updateReference: (id, updatedReference) =>
        set((state) => ({
          references: state.references.map((r) =>
            r.id === id ? { ...r, ...updatedReference } : r
          ),
        })),
      removeReference: (id) =>
        set((state) => ({
          references: state.references.filter((r) => r.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            status: "all",
            relationship: "all",
          },
        }),
    }),
    { name: "references-store" }
  )
);
