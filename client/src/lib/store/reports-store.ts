import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Report {
  id: string;
  name: string;
  type: string;
  description: string;
  status: "generating" | "completed" | "failed";
  parameters: Record<string, any>;
  fileUrl?: string;
  generatedBy: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ReportState {
  reports: Report[];
  loading: boolean;
  error: string | null;
  selectedReport: Report | null;
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
  setReports: (reports: Report[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedReport: (report: Report | null) => void;
  setFilters: (filters: Partial<ReportState["filters"]>) => void;
  setPagination: (pagination: Partial<ReportState["pagination"]>) => void;
  addReport: (report: Report) => void;
  updateReport: (id: string, report: Partial<Report>) => void;
  removeReport: (id: string) => void;
  clearFilters: () => void;
}

export const useReportsStore = create<ReportState>()(
  devtools(
    (set) => ({
      reports: [],
      loading: false,
      error: null,
      selectedReport: null,
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
      setReports: (reports) => set({ reports }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedReport: (selectedReport) => set({ selectedReport }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addReport: (report) =>
        set((state) => ({ reports: [...state.reports, report] })),
      updateReport: (id, updatedReport) =>
        set((state) => ({
          reports: state.reports.map((r) =>
            r.id === id ? { ...r, ...updatedReport } : r
          ),
        })),
      removeReport: (id) =>
        set((state) => ({
          reports: state.reports.filter((r) => r.id !== id),
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
    { name: "reports-store" }
  )
);
