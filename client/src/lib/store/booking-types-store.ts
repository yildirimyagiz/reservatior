import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface BookingType {
  id: string;
  name: string;
  description?: string;
  duration: number; // hours
  requiresApproval: boolean;
  maxAdvanceBooking: number; // days
  cancellationPolicy: string;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface BookingTypesState {
  types: BookingType[];
  loading: boolean;
  error: string | null;
  selectedType: BookingType | null;
  filters: {
    search: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTypes: (types: BookingType[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedType: (type: BookingType | null) => void;
  setFilters: (filters: Partial<BookingTypesState["filters"]>) => void;
  setPagination: (pagination: Partial<BookingTypesState["pagination"]>) => void;
  addType: (type: BookingType) => void;
  updateType: (id: string, type: Partial<BookingType>) => void;
  removeType: (id: string) => void;
  clearFilters: () => void;
}

export const useBookingTypesStore = create<BookingTypesState>()(
  devtools(
    (set) => ({
      types: [],
      loading: false,
      error: null,
      selectedType: null,
      filters: {
        search: "",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setTypes: (types) => set({ types }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedType: (selectedType) => set({ selectedType }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addType: (type) => set((state) => ({ types: [...state.types, type] })),
      updateType: (id, updatedType) =>
        set((state) => ({
          types: state.types.map((t) =>
            t.id === id ? { ...t, ...updatedType } : t
          ),
        })),
      removeType: (id) =>
        set((state) => ({
          types: state.types.filter((t) => t.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            isActive: "all",
          },
        }),
    }),
    { name: "booking-types-store" }
  )
);
