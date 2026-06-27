import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface PropertyValuation {
  id: string;
  propertyId: string;
  value: number;
  currency: string;
  valuationType: string;
  valuationDate: Date;
  valuatorId: string;
  methodology: string;
  notes?: string;
  documents: string[];
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface PropertyValuationsState {
  valuations: PropertyValuation[];
  loading: boolean;
  error: string | null;
  selectedValuation: PropertyValuation | null;
  filters: {
    search: string;
    propertyId: string;
    valuationType: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setValuations: (valuations: PropertyValuation[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedValuation: (valuation: PropertyValuation | null) => void;
  setFilters: (filters: Partial<PropertyValuationsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<PropertyValuationsState["pagination"]>
  ) => void;
  addValuation: (valuation: PropertyValuation) => void;
  updateValuation: (id: string, valuation: Partial<PropertyValuation>) => void;
  removeValuation: (id: string) => void;
  clearFilters: () => void;
}

export const usePropertyValuationsStore = create<PropertyValuationsState>()(
  devtools(
    (set) => ({
      valuations: [],
      loading: false,
      error: null,
      selectedValuation: null,
      filters: {
        search: "",
        propertyId: "all",
        valuationType: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setValuations: (valuations) => set({ valuations }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedValuation: (selectedValuation) => set({ selectedValuation }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addValuation: (valuation) =>
        set((state) => ({ valuations: [...state.valuations, valuation] })),
      updateValuation: (id, updatedValuation) =>
        set((state) => ({
          valuations: state.valuations.map((v) =>
            v.id === id ? { ...v, ...updatedValuation } : v
          ),
        })),
      removeValuation: (id) =>
        set((state) => ({
          valuations: state.valuations.filter((v) => v.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyId: "all",
            valuationType: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "property-valuations-store" }
  )
);
