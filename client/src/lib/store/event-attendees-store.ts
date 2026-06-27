import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface EventAttendee {
  id: string;
  eventId: string;
  userId: string;
  email: string;
  name: string;
  status: "registered" | "confirmed" | "cancelled" | "attended" | "no_show";
  registrationDate: Date;
  notes?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface EventAttendeesState {
  attendees: EventAttendee[];
  loading: boolean;
  error: string | null;
  selectedAttendee: EventAttendee | null;
  filters: {
    search: string;
    eventId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setAttendees: (attendees: EventAttendee[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedAttendee: (attendee: EventAttendee | null) => void;
  setFilters: (filters: Partial<EventAttendeesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<EventAttendeesState["pagination"]>
  ) => void;
  addAttendee: (attendee: EventAttendee) => void;
  updateAttendee: (id: string, attendee: Partial<EventAttendee>) => void;
  removeAttendee: (id: string) => void;
  clearFilters: () => void;
}

export const useEventAttendeesStore = create<EventAttendeesState>()(
  devtools(
    (set) => ({
      attendees: [],
      loading: false,
      error: null,
      selectedAttendee: null,
      filters: {
        search: "",
        eventId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setAttendees: (attendees) => set({ attendees }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedAttendee: (selectedAttendee) => set({ selectedAttendee }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addAttendee: (attendee) =>
        set((state) => ({ attendees: [...state.attendees, attendee] })),
      updateAttendee: (id, updatedAttendee) =>
        set((state) => ({
          attendees: state.attendees.map((a) =>
            a.id === id ? { ...a, ...updatedAttendee } : a
          ),
        })),
      removeAttendee: (id) =>
        set((state) => ({
          attendees: state.attendees.filter((a) => a.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            eventId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "event-attendees-store" }
  )
);
