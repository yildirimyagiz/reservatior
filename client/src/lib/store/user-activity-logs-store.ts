import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface UserActivityLog {
  id: string;
  userId: string;
  action: string;
  entityType: string;
  entityId: string;
  details: Record<string, any>;
  ipAddress?: string;
  userAgent?: string;
  timestamp: Date;
  organizationId: string;
}

export interface UserActivityLogsState {
  activityLogs: UserActivityLog[];
  loading: boolean;
  error: string | null;
  selectedActivityLog: UserActivityLog | null;
  filters: {
    search: string;
    userId: string;
    action: string;
    entityType: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setActivityLogs: (activityLogs: UserActivityLog[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedActivityLog: (activityLog: UserActivityLog | null) => void;
  setFilters: (filters: Partial<UserActivityLogsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<UserActivityLogsState["pagination"]>
  ) => void;
  clearFilters: () => void;
}

export const useUserActivityLogsStore = create<UserActivityLogsState>()(
  devtools(
    (set) => ({
      activityLogs: [],
      loading: false,
      error: null,
      selectedActivityLog: null,
      filters: {
        search: "",
        userId: "all",
        action: "all",
        entityType: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 50,
        total: 0,
      },
      setActivityLogs: (activityLogs) => set({ activityLogs }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedActivityLog: (selectedActivityLog) =>
        set({ selectedActivityLog }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            userId: "all",
            action: "all",
            entityType: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "user-activity-logs-store" }
  )
);
