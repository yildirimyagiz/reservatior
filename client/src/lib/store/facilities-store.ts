import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Facility {
  id: string;
  name: string;
  type: string;
  description?: string;
  capacity?: number;
  location?: string;
  amenities: string[];
  photos: string[];
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface FacilitiesState {
  facilities: Facility[];
  loading: boolean;
  error: string | null;
  selectedFacility: Facility | null;
  filters: {
    search: string;
    type: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setFacilities: (facilities: Facility[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedFacility: (facility: Facility | null) => void;
  setFilters: (filters: Partial<FacilitiesState["filters"]>) => void;
  setPagination: (pagination: Partial<FacilitiesState["pagination"]>) => void;
  addFacility: (facility: Facility) => void;
  updateFacility: (id: string, facility: Partial<Facility>) => void;
  removeFacility: (id: string) => void;
  clearFilters: () => void;
}

export const useFacilitiesStore = create<FacilitiesState>()(
  devtools(
    (set) => ({
      facilities: [],
      loading: false,
      error: null,
      selectedFacility: null,
      filters: {
        search: "",
        type: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setFacilities: (facilities) => set({ facilities }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedFacility: (selectedFacility) => set({ selectedFacility }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addFacility: (facility) =>
        set((state) => ({ facilities: [...state.facilities, facility] })),
      updateFacility: (id, updatedFacility) =>
        set((state) => ({
          facilities: state.facilities.map((f) =>
            f.id === id ? { ...f, ...updatedFacility } : f
          ),
        })),
      removeFacility: (id) =>
        set((state) => ({
          facilities: state.facilities.filter((f) => f.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "facilities-store" }
  )
);
