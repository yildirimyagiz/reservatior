import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Appointment {
  id: string;
  title: string;
  description?: string;
  type: string;
  status: "scheduled" | "completed" | "cancelled" | "no_show";
  startTime: Date;
  endTime: Date;
  attendees: Array<{
    id: string;
    name: string;
    email: string;
    status: "confirmed" | "pending" | "declined";
  }>;
  propertyId?: string;
  contactId?: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AppointmentState {
  appointments: Appointment[];
  loading: boolean;
  error: string | null;
  selectedAppointment: Appointment | null;
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
  setAppointments: (appointments: Appointment[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedAppointment: (appointment: Appointment | null) => void;
  setFilters: (filters: Partial<AppointmentState["filters"]>) => void;
  setPagination: (pagination: Partial<AppointmentState["pagination"]>) => void;
  addAppointment: (appointment: Appointment) => void;
  updateAppointment: (id: string, appointment: Partial<Appointment>) => void;
  removeAppointment: (id: string) => void;
  clearFilters: () => void;
}

export const useAppointmentsStore = create<AppointmentState>()(
  devtools(
    (set) => ({
      appointments: [],
      loading: false,
      error: null,
      selectedAppointment: null,
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
      setAppointments: (appointments) => set({ appointments }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedAppointment: (selectedAppointment) =>
        set({ selectedAppointment }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addAppointment: (appointment) =>
        set((state) => ({
          appointments: [...state.appointments, appointment],
        })),
      updateAppointment: (id, updatedAppointment) =>
        set((state) => ({
          appointments: state.appointments.map((a) =>
            a.id === id ? { ...a, ...updatedAppointment } : a
          ),
        })),
      removeAppointment: (id) =>
        set((state) => ({
          appointments: state.appointments.filter((a) => a.id !== id),
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
    { name: "appointments-store" }
  )
);
