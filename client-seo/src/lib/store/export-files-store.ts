import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ExportFile {
  id: string;
  exportJobId: string;
  filename: string;
  originalFilename: string;
  mimeType: string;
  size: number;
  url: string;
  path: string;
  downloadCount: number;
  expiresAt?: Date;
  createdAt: Date;
  updatedAt: Date;
}

export interface ExportFilesState {
  files: ExportFile[];
  loading: boolean;
  error: string | null;
  selectedFile: ExportFile | null;
  filters: {
    search: string;
    exportJobId: string;
    mimeType: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setFiles: (files: ExportFile[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedFile: (file: ExportFile | null) => void;
  setFilters: (filters: Partial<ExportFilesState["filters"]>) => void;
  setPagination: (pagination: Partial<ExportFilesState["pagination"]>) => void;
  addFile: (file: ExportFile) => void;
  updateFile: (id: string, file: Partial<ExportFile>) => void;
  removeFile: (id: string) => void;
  clearFilters: () => void;
}

export const useExportFilesStore = create<ExportFilesState>()(
  devtools(
    (set) => ({
      files: [],
      loading: false,
      error: null,
      selectedFile: null,
      filters: {
        search: "",
        exportJobId: "all",
        mimeType: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setFiles: (files) => set({ files }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedFile: (selectedFile) => set({ selectedFile }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addFile: (file) => set((state) => ({ files: [...state.files, file] })),
      updateFile: (id, updatedFile) =>
        set((state) => ({
          files: state.files.map((f) =>
            f.id === id ? { ...f, ...updatedFile } : f
          ),
        })),
      removeFile: (id) =>
        set((state) => ({
          files: state.files.filter((f) => f.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            exportJobId: "all",
            mimeType: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "export-files-store" }
  )
);
