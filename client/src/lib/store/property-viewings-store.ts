import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface PropertyViewing {
  id: string;
  propertyId: string;
  viewerId: string;
  agentId?: string;
  scheduledDate: Date;
  duration: number; // minutes
  status: "scheduled" | "completed" | "cancelled" | "no_show";
  type: "in_person" | "virtual" | "open_house";
  notes?: string;
  feedback?: {
    rating: number;
    comments?: string;
    interested: boolean;
  };
  createdAt: Date;
  updatedAt: Date;
}

export interface PropertyViewingsState {
  viewings: PropertyViewing[];
  loading: boolean;
  error: string | null;
  selectedViewing: PropertyViewing | null;
  filters: {
    search: string;
    propertyId: string;
    status: string;
    type: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setViewings: (viewings: PropertyViewing[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedViewing: (viewing: PropertyViewing | null) => void;
  setFilters: (filters: Partial<PropertyViewingsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<PropertyViewingsState["pagination"]>
  ) => void;
  addViewing: (viewing: PropertyViewing) => void;
  updateViewing: (id: string, viewing: Partial<PropertyViewing>) => void;
  removeViewing: (id: string) => void;
  clearFilters: () => void;
}

export const usePropertyViewingsStore = create<PropertyViewingsState>()(
  devtools(
    (set) => ({
      viewings: [],
      loading: false,
      error: null,
      selectedViewing: null,
      filters: {
        search: "",
        propertyId: "all",
        status: "all",
        type: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setViewings: (viewings) => set({ viewings }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedViewing: (selectedViewing) => set({ selectedViewing }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addViewing: (viewing) =>
        set((state) => ({ viewings: [...state.viewings, viewing] })),
      updateViewing: (id, updatedViewing) =>
        set((state) => ({
          viewings: state.viewings.map((v) =>
            v.id === id ? { ...v, ...updatedViewing } : v
          ),
        })),
      removeViewing: (id) =>
        set((state) => ({
          viewings: state.viewings.filter((v) => v.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyId: "all",
            status: "all",
            type: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "property-viewings-store" }
  )
);
