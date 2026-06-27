import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface RolePermission {
  id: string;
  roleId: string;
  permissionId: string;
  granted: boolean;
  grantedBy?: string;
  grantedAt?: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface RolePermissionsState {
  rolePermissions: RolePermission[];
  loading: boolean;
  error: string | null;
  selectedRolePermission: RolePermission | null;
  filters: {
    search: string;
    roleId: string;
    permissionId: string;
    granted: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setRolePermissions: (rolePermissions: RolePermission[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedRolePermission: (rolePermission: RolePermission | null) => void;
  setFilters: (filters: Partial<RolePermissionsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<RolePermissionsState["pagination"]>
  ) => void;
  addRolePermission: (rolePermission: RolePermission) => void;
  updateRolePermission: (
    id: string,
    rolePermission: Partial<RolePermission>
  ) => void;
  removeRolePermission: (id: string) => void;
  clearFilters: () => void;
}

export const useRolePermissionsStore = create<RolePermissionsState>()(
  devtools(
    (set) => ({
      rolePermissions: [],
      loading: false,
      error: null,
      selectedRolePermission: null,
      filters: {
        search: "",
        roleId: "all",
        permissionId: "all",
        granted: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setRolePermissions: (rolePermissions) => set({ rolePermissions }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedRolePermission: (selectedRolePermission) =>
        set({ selectedRolePermission }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addRolePermission: (rolePermission) =>
        set((state) => ({
          rolePermissions: [...state.rolePermissions, rolePermission],
        })),
      updateRolePermission: (id, updatedRolePermission) =>
        set((state) => ({
          rolePermissions: state.rolePermissions.map((rp) =>
            rp.id === id ? { ...rp, ...updatedRolePermission } : rp
          ),
        })),
      removeRolePermission: (id) =>
        set((state) => ({
          rolePermissions: state.rolePermissions.filter((rp) => rp.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            roleId: "all",
            permissionId: "all",
            granted: "all",
          },
        }),
    }),
    { name: "role-permissions-store" }
  )
);
