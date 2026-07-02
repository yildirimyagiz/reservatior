import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Booking {
  id: string;
  propertyId: string;
  guestId: string;
  startDate: Date;
  endDate: Date;
  status: "pending" | "confirmed" | "cancelled" | "completed";
  totalPrice: number;
  currency: string;
  specialRequests?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface BookingState {
  bookings: Booking[];
  loading: boolean;
  error: string | null;
  selectedBooking: Booking | null;
  filters: {
    search: string;
    status: string;
    dateRange: [Date | null, Date | null];
    propertyId: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setBookings: (bookings: Booking[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedBooking: (booking: Booking | null) => void;
  setFilters: (filters: Partial<BookingState["filters"]>) => void;
  setPagination: (pagination: Partial<BookingState["pagination"]>) => void;
  addBooking: (booking: Booking) => void;
  updateBooking: (id: string, booking: Partial<Booking>) => void;
  removeBooking: (id: string) => void;
  clearFilters: () => void;
}

export const useBookingsStore = create<BookingState>()(
  devtools(
    (set) => ({
      bookings: [],
      loading: false,
      error: null,
      selectedBooking: null,
      filters: {
        search: "",
        status: "all",
        dateRange: [null, null],
        propertyId: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setBookings: (bookings) => set({ bookings }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedBooking: (selectedBooking) => set({ selectedBooking }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addBooking: (booking) =>
        set((state) => ({ bookings: [...state.bookings, booking] })),
      updateBooking: (id, updatedBooking) =>
        set((state) => ({
          bookings: state.bookings.map((b) =>
            b.id === id ? { ...b, ...updatedBooking } : b
          ),
        })),
      removeBooking: (id) =>
        set((state) => ({
          bookings: state.bookings.filter((b) => b.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            status: "all",
            dateRange: [null, null],
            propertyId: "all",
          },
        }),
    }),
    { name: "bookings-store" }
  )
);
