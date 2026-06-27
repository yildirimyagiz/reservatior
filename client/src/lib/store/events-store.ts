import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Event {
  id: string;
  title: string;
  description?: string;
  type: string;
  status: "draft" | "published" | "cancelled" | "completed";
  startDate: Date;
  endDate: Date;
  location?: string;
  isVirtual: boolean;
  virtualUrl?: string;
  maxAttendees?: number;
  currentAttendees: number;
  organizerId: string;
  organizationId: string;
  tags: string[];
  createdAt: Date;
  updatedAt: Date;
}

export interface EventsState {
  events: Event[];
  loading: boolean;
  error: string | null;
  selectedEvent: Event | null;
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
  setEvents: (events: Event[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedEvent: (event: Event | null) => void;
  setFilters: (filters: Partial<EventsState["filters"]>) => void;
  setPagination: (pagination: Partial<EventsState["pagination"]>) => void;
  addEvent: (event: Event) => void;
  updateEvent: (id: string, event: Partial<Event>) => void;
  removeEvent: (id: string) => void;
  clearFilters: () => void;
}

export const useEventsStore = create<EventsState>()(
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
    { name: "events-store" }
  )
);
