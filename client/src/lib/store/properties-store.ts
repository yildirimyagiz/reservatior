import { create } from "zustand";
import { devtools } from "zustand/middleware";
import { Property } from "../api/properties";

export interface PropertiesState {
  properties: Property[];
  loading: boolean;
  error: string | null;
  selectedProperty: Property | null;
  filters: {
    search: string;
    propertyType: string;
    status: string;
    city: string;
    priceRange: [number, number];
    bedrooms: string;
    bathrooms: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setProperties: (properties: Property[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedProperty: (property: Property | null) => void;
  setFilters: (filters: Partial<PropertiesState["filters"]>) => void;
  setPagination: (pagination: Partial<PropertiesState["pagination"]>) => void;
  addProperty: (property: Property) => void;
  updateProperty: (id: string, property: Partial<Property>) => void;
  removeProperty: (id: string) => void;
  clearFilters: () => void;
}

export const usePropertiesStore = create<PropertiesState>()(
  devtools(
    (set) => ({
      properties: [],
      loading: false,
      error: null,
      selectedProperty: null,
      filters: {
        search: "",
        propertyType: "all",
        status: "all",
        city: "all",
        priceRange: [0, 1000000],
        bedrooms: "all",
        bathrooms: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setProperties: (properties) => set({ properties }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedProperty: (selectedProperty) => set({ selectedProperty }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addProperty: (property) =>
        set((state) => ({ properties: [...state.properties, property] })),
      updateProperty: (id, updatedProperty) =>
        set((state) => ({
          properties: state.properties.map((p) =>
            p.id === id ? { ...p, ...updatedProperty } : p
          ),
        })),
      removeProperty: (id) =>
        set((state) => ({
          properties: state.properties.filter((p) => p.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyType: "all",
            status: "all",
            city: "all",
            priceRange: [0, 1000000],
            bedrooms: "all",
            bathrooms: "all",
          },
        }),
    }),
    { name: "properties-store" }
  )
);
