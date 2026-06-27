import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Role {
  id: string;
  name: string;
  description: string;
  permissions: string[];
  organizationId: string;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
}

export interface RoleState {
  roles: Role[];
  loading: boolean;
  error: string | null;
  selectedRole: Role | null;
  filters: {
    search: string;
    organizationId: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setRoles: (roles: Role[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedRole: (role: Role | null) => void;
  setFilters: (filters: Partial<RoleState["filters"]>) => void;
  setPagination: (pagination: Partial<RoleState["pagination"]>) => void;
  addRole: (role: Role) => void;
  updateRole: (id: string, role: Partial<Role>) => void;
  removeRole: (id: string) => void;
  clearFilters: () => void;
}

export const useRolesStore = create<RoleState>()(
  devtools(
    (set) => ({
      roles: [],
      loading: false,
      error: null,
      selectedRole: null,
      filters: {
        search: "",
        organizationId: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setRoles: (roles) => set({ roles }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedRole: (selectedRole) => set({ selectedRole }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addRole: (role) => set((state) => ({ roles: [...state.roles, role] })),
      updateRole: (id, updatedRole) =>
        set((state) => ({
          roles: state.roles.map((r) =>
            r.id === id ? { ...r, ...updatedRole } : r
          ),
        })),
      removeRole: (id) =>
        set((state) => ({
          roles: state.roles.filter((r) => r.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            organizationId: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "roles-store" }
  )
);
