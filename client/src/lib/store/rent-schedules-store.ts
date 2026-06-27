import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface RentSchedule {
  id: string;
  leaseId: string;
  tenantId: string;
  propertyId: string;
  amount: number;
  currency: string;
  frequency: "weekly" | "biweekly" | "monthly" | "quarterly" | "yearly";
  dayOfMonth?: number; // for monthly payments
  dayOfWeek?: number; // for weekly payments
  startDate: Date;
  endDate?: Date;
  gracePeriod: number; // days
  lateFee: {
    type: "fixed" | "percentage";
    amount: number;
    appliesAfter: number; // days
  };
  autoCharge: boolean;
  paymentMethod?: string;
  status: "active" | "paused" | "completed";
  nextDueDate: Date;
  lastPaidDate?: Date;
  balance: number;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface RentSchedulesState {
  schedules: RentSchedule[];
  loading: boolean;
  error: string | null;
  selectedSchedule: RentSchedule | null;
  filters: {
    search: string;
    leaseId: string;
    tenantId: string;
    status: string;
    frequency: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setSchedules: (schedules: RentSchedule[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedSchedule: (schedule: RentSchedule | null) => void;
  setFilters: (filters: Partial<RentSchedulesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<RentSchedulesState["pagination"]>
  ) => void;
  addSchedule: (schedule: RentSchedule) => void;
  updateSchedule: (id: string, schedule: Partial<RentSchedule>) => void;
  removeSchedule: (id: string) => void;
  clearFilters: () => void;
}

export const useRentSchedulesStore = create<RentSchedulesState>()(
  devtools(
    (set) => ({
      schedules: [],
      loading: false,
      error: null,
      selectedSchedule: null,
      filters: {
        search: "",
        leaseId: "all",
        tenantId: "all",
        status: "all",
        frequency: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setSchedules: (schedules) => set({ schedules }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedSchedule: (selectedSchedule) => set({ selectedSchedule }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addSchedule: (schedule) =>
        set((state) => ({ schedules: [...state.schedules, schedule] })),
      updateSchedule: (id, updatedSchedule) =>
        set((state) => ({
          schedules: state.schedules.map((s) =>
            s.id === id ? { ...s, ...updatedSchedule } : s
          ),
        })),
      removeSchedule: (id) =>
        set((state) => ({
          schedules: state.schedules.filter((s) => s.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            leaseId: "all",
            tenantId: "all",
            status: "all",
            frequency: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "rent-schedules-store" }
  )
);
