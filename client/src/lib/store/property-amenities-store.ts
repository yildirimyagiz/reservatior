import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface PropertyAmenity {
  id: string;
  propertyId: string;
  amenityId: string;
  value?: string;
  quantity?: number;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
}

export interface PropertyAmenitiesState {
  propertyAmenities: PropertyAmenity[];
  loading: boolean;
  error: string | null;
  selectedPropertyAmenity: PropertyAmenity | null;
  filters: {
    search: string;
    propertyId: string;
    amenityId: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setPropertyAmenities: (propertyAmenities: PropertyAmenity[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedPropertyAmenity: (propertyAmenity: PropertyAmenity | null) => void;
  setFilters: (filters: Partial<PropertyAmenitiesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<PropertyAmenitiesState["pagination"]>
  ) => void;
  addPropertyAmenity: (propertyAmenity: PropertyAmenity) => void;
  updatePropertyAmenity: (
    id: string,
    propertyAmenity: Partial<PropertyAmenity>
  ) => void;
  removePropertyAmenity: (id: string) => void;
  clearFilters: () => void;
}

export const usePropertyAmenitiesStore = create<PropertyAmenitiesState>()(
  devtools(
    (set) => ({
      propertyAmenities: [],
      loading: false,
      error: null,
      selectedPropertyAmenity: null,
      filters: {
        search: "",
        propertyId: "all",
        amenityId: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setPropertyAmenities: (propertyAmenities) => set({ propertyAmenities }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedPropertyAmenity: (selectedPropertyAmenity) =>
        set({ selectedPropertyAmenity }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addPropertyAmenity: (propertyAmenity) =>
        set((state) => ({
          propertyAmenities: [...state.propertyAmenities, propertyAmenity],
        })),
      updatePropertyAmenity: (id, updatedPropertyAmenity) =>
        set((state) => ({
          propertyAmenities: state.propertyAmenities.map((pa) =>
            pa.id === id ? { ...pa, ...updatedPropertyAmenity } : pa
          ),
        })),
      removePropertyAmenity: (id) =>
        set((state) => ({
          propertyAmenities: state.propertyAmenities.filter(
            (pa) => pa.id !== id
          ),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyId: "all",
            amenityId: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "property-amenities-store" }
  )
);
