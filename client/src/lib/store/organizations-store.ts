import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Organization {
  id: string;
  name: string;
  type: string;
  description?: string;
  website?: string;
  phone?: string;
  email: string;
  address: string;
  city: string;
  state: string;
  zipCode: string;
  country: string;
  logo?: string;
  subscriptionId?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface OrganizationState {
  organizations: Organization[];
  loading: boolean;
  error: string | null;
  selectedOrganization: Organization | null;
  filters: {
    search: string;
    type: string;
    city: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setOrganizations: (organizations: Organization[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedOrganization: (organization: Organization | null) => void;
  setFilters: (filters: Partial<OrganizationState["filters"]>) => void;
  setPagination: (pagination: Partial<OrganizationState["pagination"]>) => void;
  addOrganization: (organization: Organization) => void;
  updateOrganization: (id: string, organization: Partial<Organization>) => void;
  removeOrganization: (id: string) => void;
  clearFilters: () => void;
}

export const useOrganizationsStore = create<OrganizationState>()(
  devtools(
    (set) => ({
      organizations: [],
      loading: false,
      error: null,
      selectedOrganization: null,
      filters: {
        search: "",
        type: "all",
        city: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setOrganizations: (organizations) => set({ organizations }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedOrganization: (selectedOrganization) =>
        set({ selectedOrganization }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addOrganization: (organization) =>
        set((state) => ({
          organizations: [...state.organizations, organization],
        })),
      updateOrganization: (id, updatedOrganization) =>
        set((state) => ({
          organizations: state.organizations.map((o) =>
            o.id === id ? { ...o, ...updatedOrganization } : o
          ),
        })),
      removeOrganization: (id) =>
        set((state) => ({
          organizations: state.organizations.filter((o) => o.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            city: "all",
          },
        }),
    }),
    { name: "organizations-store" }
  )
);
