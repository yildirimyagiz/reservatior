import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface VirtualTour {
  id: string;
  title: string;
  description?: string;
  propertyId: string;
  tourUrl: string;
  thumbnailUrl?: string;
  duration?: number; // seconds
  status: "active" | "processing" | "failed";
  views: number;
  createdAt: Date;
  updatedAt: Date;
}

export interface VirtualToursState {
  tours: VirtualTour[];
  loading: boolean;
  error: string | null;
  selectedTour: VirtualTour | null;
  filters: {
    search: string;
    propertyId: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTours: (tours: VirtualTour[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedTour: (tour: VirtualTour | null) => void;
  setFilters: (filters: Partial<VirtualToursState["filters"]>) => void;
  setPagination: (pagination: Partial<VirtualToursState["pagination"]>) => void;
  addTour: (tour: VirtualTour) => void;
  updateTour: (id: string, tour: Partial<VirtualTour>) => void;
  removeTour: (id: string) => void;
  clearFilters: () => void;
}

export const useVirtualToursStore = create<VirtualToursState>()(
  devtools(
    (set) => ({
      tours: [],
      loading: false,
      error: null,
      selectedTour: null,
      filters: {
        search: "",
        propertyId: "all",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setTours: (tours) => set({ tours }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedTour: (selectedTour) => set({ selectedTour }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addTour: (tour) => set((state) => ({ tours: [...state.tours, tour] })),
      updateTour: (id, updatedTour) =>
        set((state) => ({
          tours: state.tours.map((t) =>
            t.id === id ? { ...t, ...updatedTour } : t
          ),
        })),
      removeTour: (id) =>
        set((state) => ({
          tours: state.tours.filter((t) => t.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyId: "all",
            status: "all",
          },
        }),
    }),
    { name: "virtual-tours-store" }
  )
);
