import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Amenity {
  id: string;
  name: string;
  type: string;
  description?: string;
  icon?: string;
  propertyId?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AmenitiesState {
  amenities: Amenity[];
  loading: boolean;
  error: string | null;
  selectedAmenity: Amenity | null;
  filters: {
    search: string;
    type: string;
    propertyId: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setAmenities: (amenities: Amenity[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedAmenity: (amenity: Amenity | null) => void;
  setFilters: (filters: Partial<AmenitiesState["filters"]>) => void;
  setPagination: (pagination: Partial<AmenitiesState["pagination"]>) => void;
  addAmenity: (amenity: Amenity) => void;
  updateAmenity: (id: string, amenity: Partial<Amenity>) => void;
  removeAmenity: (id: string) => void;
  clearFilters: () => void;
}

export const useAmenitiesStore = create<AmenitiesState>()(
  devtools(
    (set) => ({
      amenities: [],
      loading: false,
      error: null,
      selectedAmenity: null,
      filters: {
        search: "",
        type: "all",
        propertyId: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setAmenities: (amenities) => set({ amenities }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedAmenity: (selectedAmenity) => set({ selectedAmenity }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addAmenity: (amenity) =>
        set((state) => ({ amenities: [...state.amenities, amenity] })),
      updateAmenity: (id, updatedAmenity) =>
        set((state) => ({
          amenities: state.amenities.map((a) =>
            a.id === id ? { ...a, ...updatedAmenity } : a
          ),
        })),
      removeAmenity: (id) =>
        set((state) => ({
          amenities: state.amenities.filter((a) => a.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            propertyId: "all",
          },
        }),
    }),
    { name: "amenities-store" }
  )
);
