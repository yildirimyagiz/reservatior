import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Permission {
  id: string;
  key: string;
  name: string;
  description: string;
  category: string;
  resource: string;
  action: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface PermissionState {
  permissions: Permission[];
  loading: boolean;
  error: string | null;
  selectedPermission: Permission | null;
  filters: {
    search: string;
    category: string;
    resource: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setPermissions: (permissions: Permission[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedPermission: (permission: Permission | null) => void;
  setFilters: (filters: Partial<PermissionState["filters"]>) => void;
  setPagination: (pagination: Partial<PermissionState["pagination"]>) => void;
  addPermission: (permission: Permission) => void;
  updatePermission: (id: string, permission: Partial<Permission>) => void;
  removePermission: (id: string) => void;
  clearFilters: () => void;
}

export const usePermissionsStore = create<PermissionState>()(
  devtools(
    (set) => ({
      permissions: [],
      loading: false,
      error: null,
      selectedPermission: null,
      filters: {
        search: "",
        category: "all",
        resource: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setPermissions: (permissions) => set({ permissions }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedPermission: (selectedPermission) =>
        set({ selectedPermission }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addPermission: (permission) =>
        set((state) => ({ permissions: [...state.permissions, permission] })),
      updatePermission: (id, updatedPermission) =>
        set((state) => ({
          permissions: state.permissions.map((p) =>
            p.id === id ? { ...p, ...updatedPermission } : p
          ),
        })),
      removePermission: (id) =>
        set((state) => ({
          permissions: state.permissions.filter((p) => p.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            category: "all",
            resource: "all",
          },
        }),
    }),
    { name: "permissions-store" }
  )
);
