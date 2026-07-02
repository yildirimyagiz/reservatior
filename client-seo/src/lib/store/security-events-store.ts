import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface SecurityEvent {
  id: string;
  type: string;
  severity: "low" | "medium" | "high" | "critical";
  description: string;
  userId?: string;
  ipAddress?: string;
  userAgent?: string;
  location?: string;
  resolved: boolean;
  resolvedAt?: Date;
  resolvedBy?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface SecurityEventsState {
  securityEvents: SecurityEvent[];
  loading: boolean;
  error: string | null;
  selectedSecurityEvent: SecurityEvent | null;
  filters: {
    search: string;
    type: string;
    severity: string;
    resolved: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setSecurityEvents: (securityEvents: SecurityEvent[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedSecurityEvent: (securityEvent: SecurityEvent | null) => void;
  setFilters: (filters: Partial<SecurityEventsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<SecurityEventsState["pagination"]>
  ) => void;
  addSecurityEvent: (securityEvent: SecurityEvent) => void;
  updateSecurityEvent: (
    id: string,
    securityEvent: Partial<SecurityEvent>
  ) => void;
  removeSecurityEvent: (id: string) => void;
  clearFilters: () => void;
}

export const useSecurityEventsStore = create<SecurityEventsState>()(
  devtools(
    (set) => ({
      securityEvents: [],
      loading: false,
      error: null,
      selectedSecurityEvent: null,
      filters: {
        search: "",
        type: "all",
        severity: "all",
        resolved: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 50,
        total: 0,
      },
      setSecurityEvents: (securityEvents) => set({ securityEvents }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedSecurityEvent: (selectedSecurityEvent) =>
        set({ selectedSecurityEvent }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addSecurityEvent: (securityEvent) =>
        set((state) => ({
          securityEvents: [...state.securityEvents, securityEvent],
        })),
      updateSecurityEvent: (id, updatedSecurityEvent) =>
        set((state) => ({
          securityEvents: state.securityEvents.map((se) =>
            se.id === id ? { ...se, ...updatedSecurityEvent } : se
          ),
        })),
      removeSecurityEvent: (id) =>
        set((state) => ({
          securityEvents: state.securityEvents.filter((se) => se.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            severity: "all",
            resolved: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "security-events-store" }
  )
);
