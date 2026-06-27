import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface VacationRental {
  id: string;
  propertyId: string;
  name: string;
  description?: string;
  type: string;
  capacity: number;
  bedrooms: number;
  bathrooms: number;
  amenities: string[];
  houseRules: string[];
  photos: string[];
  videos: string[];
  virtualTours: string[];
  floorPlans: string[];
  pricing: {
    nightly: number;
    weekly?: number;
    monthly?: number;
    currency: string;
    weekendRate?: number;
    holidayRate?: number;
    cleaningFee?: number;
    serviceFee?: number;
    taxes: Array<{
      name: string;
      rate: number;
    }>;
  };
  availability: {
    calendar: Array<{
      date: Date;
      available: boolean;
      price?: number;
      minimumStay?: number;
    }>;
    minimumStay: number;
    maximumStay?: number;
    checkInTime: string;
    checkOutTime: string;
    advanceNotice: number;
  };
  policies: {
    cancellation: string;
    paymentSchedule: string;
    securityDeposit?: number;
    petPolicy: string;
    smokingPolicy: string;
  };
  platforms: Array<{
    platformId: string;
    externalId: string;
    isActive: boolean;
    lastSyncedAt?: Date;
  }>;
  isActive: boolean;
  organizationId: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface VacationRentalsState {
  rentals: VacationRental[];
  loading: boolean;
  error: string | null;
  selectedRental: VacationRental | null;
  filters: {
    search: string;
    propertyId: string;
    type: string;
    capacity: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setRentals: (rentals: VacationRental[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedRental: (rental: VacationRental | null) => void;
  setFilters: (filters: Partial<VacationRentalsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<VacationRentalsState["pagination"]>
  ) => void;
  addRental: (rental: VacationRental) => void;
  updateRental: (id: string, rental: Partial<VacationRental>) => void;
  removeRental: (id: string) => void;
  clearFilters: () => void;
}

export const useVacationRentalsStore = create<VacationRentalsState>()(
  devtools(
    (set) => ({
      rentals: [],
      loading: false,
      error: null,
      selectedRental: null,
      filters: {
        search: "",
        propertyId: "all",
        type: "all",
        capacity: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setRentals: (rentals) => set({ rentals }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedRental: (selectedRental) => set({ selectedRental }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addRental: (rental) =>
        set((state) => ({ rentals: [...state.rentals, rental] })),
      updateRental: (id, updatedRental) =>
        set((state) => ({
          rentals: state.rentals.map((r) =>
            r.id === id ? { ...r, ...updatedRental } : r
          ),
        })),
      removeRental: (id) =>
        set((state) => ({
          rentals: state.rentals.filter((r) => r.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyId: "all",
            type: "all",
            capacity: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "vacation-rentals-store" }
  )
);
