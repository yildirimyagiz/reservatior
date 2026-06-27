import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface FloorPlan {
  id: string;
  title: string;
  propertyId: string;
  imageUrl: string;
  thumbnailUrl?: string;
  bedrooms: number;
  bathrooms: number;
  area: number; // sq ft
  areaUnit: string;
  description?: string;
  order: number;
  createdAt: Date;
  updatedAt: Date;
}

export interface FloorPlansState {
  floorPlans: FloorPlan[];
  loading: boolean;
  error: string | null;
  selectedFloorPlan: FloorPlan | null;
  filters: {
    search: string;
    propertyId: string;
    bedrooms: string;
    bathrooms: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setFloorPlans: (floorPlans: FloorPlan[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedFloorPlan: (floorPlan: FloorPlan | null) => void;
  setFilters: (filters: Partial<FloorPlansState["filters"]>) => void;
  setPagination: (pagination: Partial<FloorPlansState["pagination"]>) => void;
  addFloorPlan: (floorPlan: FloorPlan) => void;
  updateFloorPlan: (id: string, floorPlan: Partial<FloorPlan>) => void;
  removeFloorPlan: (id: string) => void;
  clearFilters: () => void;
}

export const useFloorPlansStore = create<FloorPlansState>()(
  devtools(
    (set) => ({
      floorPlans: [],
      loading: false,
      error: null,
      selectedFloorPlan: null,
      filters: {
        search: "",
        propertyId: "all",
        bedrooms: "all",
        bathrooms: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setFloorPlans: (floorPlans) => set({ floorPlans }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedFloorPlan: (selectedFloorPlan) => set({ selectedFloorPlan }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addFloorPlan: (floorPlan) =>
        set((state) => ({ floorPlans: [...state.floorPlans, floorPlan] })),
      updateFloorPlan: (id, updatedFloorPlan) =>
        set((state) => ({
          floorPlans: state.floorPlans.map((fp) =>
            fp.id === id ? { ...fp, ...updatedFloorPlan } : fp
          ),
        })),
      removeFloorPlan: (id) =>
        set((state) => ({
          floorPlans: state.floorPlans.filter((fp) => fp.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyId: "all",
            bedrooms: "all",
            bathrooms: "all",
          },
        }),
    }),
    { name: "floor-plans-store" }
  )
);
