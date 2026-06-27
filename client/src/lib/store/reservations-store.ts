import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Reservation {
  id: string;
  propertyId: string;
  guestId: string;
  checkIn: Date;
  checkOut: Date;
  adults: number;
  children?: number;
  status: "pending" | "confirmed" | "cancelled" | "completed" | "no_show";
  totalAmount: number;
  currency: string;
  depositAmount?: number;
  notes?: string;
  specialRequests?: string[];
  createdAt: Date;
  updatedAt: Date;
}

export interface ReservationsState {
  reservations: Reservation[];
  loading: boolean;
  error: string | null;
  selectedReservation: Reservation | null;
  filters: {
    search: string;
    propertyId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setReservations: (reservations: Reservation[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedReservation: (reservation: Reservation | null) => void;
  setFilters: (filters: Partial<ReservationsState["filters"]>) => void;
  setPagination: (pagination: Partial<ReservationsState["pagination"]>) => void;
  addReservation: (reservation: Reservation) => void;
  updateReservation: (id: string, reservation: Partial<Reservation>) => void;
  removeReservation: (id: string) => void;
  clearFilters: () => void;
}

export const useReservationsStore = create<ReservationsState>()(
  devtools(
    (set) => ({
      reservations: [],
      loading: false,
      error: null,
      selectedReservation: null,
      filters: {
        search: "",
        propertyId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setReservations: (reservations) => set({ reservations }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedReservation: (selectedReservation) =>
        set({ selectedReservation }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addReservation: (reservation) =>
        set((state) => ({
          reservations: [...state.reservations, reservation],
        })),
      updateReservation: (id, updatedReservation) =>
        set((state) => ({
          reservations: state.reservations.map((r) =>
            r.id === id ? { ...r, ...updatedReservation } : r
          ),
        })),
      removeReservation: (id) =>
        set((state) => ({
          reservations: state.reservations.filter((r) => r.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "reservations-store" }
  )
);
