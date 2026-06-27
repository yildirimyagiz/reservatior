import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface CalendarEvent {
  id: string;
  title: string;
  description?: string;
  start: Date;
  end: Date;
  isAllDay: boolean;
  location?: string;
  attendees: Array<{
    userId: string;
    email: string;
    status: "pending" | "accepted" | "declined" | "tentative";
  }>;
  type: string;
  status: "confirmed" | "tentative" | "cancelled";
  recurrence?: {
    pattern: string;
    interval: number;
    endDate?: Date;
  };
  reminders: Array<{
    type: string;
    minutesBefore: number;
  }>;
  organizationId: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface CalendarEventsState {
  events: CalendarEvent[];
  loading: boolean;
  error: string | null;
  selectedEvent: CalendarEvent | null;
  filters: {
    search: string;
    type: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setEvents: (events: CalendarEvent[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedEvent: (event: CalendarEvent | null) => void;
  setFilters: (filters: Partial<CalendarEventsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<CalendarEventsState["pagination"]>
  ) => void;
  addEvent: (event: CalendarEvent) => void;
  updateEvent: (id: string, event: Partial<CalendarEvent>) => void;
  removeEvent: (id: string) => void;
  clearFilters: () => void;
}

export const useCalendarEventsStore = create<CalendarEventsState>()(
  devtools(
    (set) => ({
      events: [],
      loading: false,
      error: null,
      selectedEvent: null,
      filters: {
        search: "",
        type: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setEvents: (events) => set({ events }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedEvent: (selectedEvent) => set({ selectedEvent }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addEvent: (event) =>
        set((state) => ({ events: [...state.events, event] })),
      updateEvent: (id, updatedEvent) =>
        set((state) => ({
          events: state.events.map((e) =>
            e.id === id ? { ...e, ...updatedEvent } : e
          ),
        })),
      removeEvent: (id) =>
        set((state) => ({
          events: state.events.filter((e) => e.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "calendar-events-store" }
  )
);
