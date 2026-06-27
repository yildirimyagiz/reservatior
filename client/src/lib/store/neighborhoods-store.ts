import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Neighborhood {
  id: string;
  name: string;
  description?: string;
  city: string;
  state?: string;
  country: string;
  coordinates: {
    lat: number;
    lng: number;
  };
  boundaries?: Array<{
    lat: number;
    lng: number;
  }>;
  medianPrice: number;
  pricePerSqft: number;
  population: number;
  schools: Array<{
    name: string;
    rating: number;
    distance: number;
  }>;
  amenities: string[];
  crimeRate: number;
  walkScore?: number;
  transitScore?: number;
  photos: string[];
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface NeighborhoodsState {
  neighborhoods: Neighborhood[];
  loading: boolean;
  error: string | null;
  selectedNeighborhood: Neighborhood | null;
  filters: {
    search: string;
    city: string;
    priceRange: [number, number];
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setNeighborhoods: (neighborhoods: Neighborhood[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedNeighborhood: (neighborhood: Neighborhood | null) => void;
  setFilters: (filters: Partial<NeighborhoodsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<NeighborhoodsState["pagination"]>
  ) => void;
  addNeighborhood: (neighborhood: Neighborhood) => void;
  updateNeighborhood: (id: string, neighborhood: Partial<Neighborhood>) => void;
  removeNeighborhood: (id: string) => void;
  clearFilters: () => void;
}

export const useNeighborhoodsStore = create<NeighborhoodsState>()(
  devtools(
    (set) => ({
      neighborhoods: [],
      loading: false,
      error: null,
      selectedNeighborhood: null,
      filters: {
        search: "",
        city: "all",
        priceRange: [0, 10000000],
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setNeighborhoods: (neighborhoods) => set({ neighborhoods }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedNeighborhood: (selectedNeighborhood) =>
        set({ selectedNeighborhood }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addNeighborhood: (neighborhood) =>
        set((state) => ({
          neighborhoods: [...state.neighborhoods, neighborhood],
        })),
      updateNeighborhood: (id, updatedNeighborhood) =>
        set((state) => ({
          neighborhoods: state.neighborhoods.map((n) =>
            n.id === id ? { ...n, ...updatedNeighborhood } : n
          ),
        })),
      removeNeighborhood: (id) =>
        set((state) => ({
          neighborhoods: state.neighborhoods.filter((n) => n.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            city: "all",
            priceRange: [0, 10000000],
            isActive: "all",
          },
        }),
    }),
    { name: "neighborhoods-store" }
  )
);
