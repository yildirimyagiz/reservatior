import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface MLSSyncJob {
  id: string;
  mlsConnectionId: string;
  type: string;
  status: "pending" | "running" | "completed" | "failed" | "cancelled";
  progress: number; // 0-100
  totalRecords: number;
  processedRecords: number;
  errors: Array<{
    recordId: string;
    error: string;
    timestamp: Date;
  }>;
  startedAt?: Date;
  completedAt?: Date;
  duration?: number; // milliseconds
  triggeredBy: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface MLSSyncJobsState {
  syncJobs: MLSSyncJob[];
  loading: boolean;
  error: string | null;
  selectedSyncJob: MLSSyncJob | null;
  filters: {
    search: string;
    mlsConnectionId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setSyncJobs: (syncJobs: MLSSyncJob[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedSyncJob: (syncJob: MLSSyncJob | null) => void;
  setFilters: (filters: Partial<MLSSyncJobsState["filters"]>) => void;
  setPagination: (pagination: Partial<MLSSyncJobsState["pagination"]>) => void;
  addSyncJob: (syncJob: MLSSyncJob) => void;
  updateSyncJob: (id: string, syncJob: Partial<MLSSyncJob>) => void;
  removeSyncJob: (id: string) => void;
  clearFilters: () => void;
}

export const useMLSSyncJobsStore = create<MLSSyncJobsState>()(
  devtools(
    (set) => ({
      syncJobs: [],
      loading: false,
      error: null,
      selectedSyncJob: null,
      filters: {
        search: "",
        mlsConnectionId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setSyncJobs: (syncJobs) => set({ syncJobs }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedSyncJob: (selectedSyncJob) => set({ selectedSyncJob }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addSyncJob: (syncJob) =>
        set((state) => ({ syncJobs: [...state.syncJobs, syncJob] })),
      updateSyncJob: (id, updatedSyncJob) =>
        set((state) => ({
          syncJobs: state.syncJobs.map((j) =>
            j.id === id ? { ...j, ...updatedSyncJob } : j
          ),
        })),
      removeSyncJob: (id) =>
        set((state) => ({
          syncJobs: state.syncJobs.filter((j) => j.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            mlsConnectionId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "mls-sync-jobs-store" }
  )
);
