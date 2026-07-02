import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ExportJob {
  id: string;
  name: string;
  type: string;
  format: string;
  status: "pending" | "running" | "completed" | "failed" | "cancelled";
  progress: number; // 0-100
  parameters: Record<string, any>;
  filePath?: string;
  fileSize?: number;
  downloadUrl?: string;
  expiresAt?: Date;
  requestedBy: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ExportJobsState {
  exportJobs: ExportJob[];
  loading: boolean;
  error: string | null;
  selectedExportJob: ExportJob | null;
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
  setExportJobs: (exportJobs: ExportJob[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedExportJob: (exportJob: ExportJob | null) => void;
  setFilters: (filters: Partial<ExportJobsState["filters"]>) => void;
  setPagination: (pagination: Partial<ExportJobsState["pagination"]>) => void;
  addExportJob: (exportJob: ExportJob) => void;
  updateExportJob: (id: string, exportJob: Partial<ExportJob>) => void;
  removeExportJob: (id: string) => void;
  clearFilters: () => void;
}

export const useExportJobsStore = create<ExportJobsState>()(
  devtools(
    (set) => ({
      exportJobs: [],
      loading: false,
      error: null,
      selectedExportJob: null,
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
      setExportJobs: (exportJobs) => set({ exportJobs }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedExportJob: (selectedExportJob) => set({ selectedExportJob }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addExportJob: (exportJob) =>
        set((state) => ({ exportJobs: [...state.exportJobs, exportJob] })),
      updateExportJob: (id, updatedExportJob) =>
        set((state) => ({
          exportJobs: state.exportJobs.map((ej) =>
            ej.id === id ? { ...ej, ...updatedExportJob } : ej
          ),
        })),
      removeExportJob: (id) =>
        set((state) => ({
          exportJobs: state.exportJobs.filter((ej) => ej.id !== id),
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
    { name: "export-jobs-store" }
  )
);
