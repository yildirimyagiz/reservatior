import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface TenantApplication {
  id: string;
  firstName: string;
  lastName: string;
  email: string;
  phone?: string;
  propertyId: string;
  status: "pending" | "approved" | "rejected" | "withdrawn";
  employmentStatus: string;
  annualIncome: number;
  currency: string;
  references: Array<{
    name: string;
    email: string;
    phone: string;
    relationship: string;
  }>;
  documentUrls: string[];
  submittedAt: Date;
  reviewedAt?: Date;
  reviewedBy?: string;
  notes?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface TenantApplicationState {
  applications: TenantApplication[];
  loading: boolean;
  error: string | null;
  selectedApplication: TenantApplication | null;
  filters: {
    search: string;
    status: string;
    propertyId: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setApplications: (applications: TenantApplication[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedApplication: (application: TenantApplication | null) => void;
  setFilters: (filters: Partial<TenantApplicationState["filters"]>) => void;
  setPagination: (
    pagination: Partial<TenantApplicationState["pagination"]>
  ) => void;
  addApplication: (application: TenantApplication) => void;
  updateApplication: (
    id: string,
    application: Partial<TenantApplication>
  ) => void;
  removeApplication: (id: string) => void;
  clearFilters: () => void;
}

export const useTenantApplicationsStore = create<TenantApplicationState>()(
  devtools(
    (set) => ({
      applications: [],
      loading: false,
      error: null,
      selectedApplication: null,
      filters: {
        search: "",
        status: "all",
        propertyId: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setApplications: (applications) => set({ applications }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedApplication: (selectedApplication) =>
        set({ selectedApplication }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addApplication: (application) =>
        set((state) => ({
          applications: [...state.applications, application],
        })),
      updateApplication: (id, updatedApplication) =>
        set((state) => ({
          applications: state.applications.map((a) =>
            a.id === id ? { ...a, ...updatedApplication } : a
          ),
        })),
      removeApplication: (id) =>
        set((state) => ({
          applications: state.applications.filter((a) => a.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            status: "all",
            propertyId: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "tenant-applications-store" }
  )
);
