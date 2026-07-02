import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface PermissionKey {
  id: string;
  key: string;
  name: string;
  description?: string;
  category: string;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
}

export interface PermissionKeysState {
  permissionKeys: PermissionKey[];
  loading: boolean;
  error: string | null;
  selectedPermissionKey: PermissionKey | null;
  filters: {
    search: string;
    category: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setPermissionKeys: (permissionKeys: PermissionKey[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedPermissionKey: (permissionKey: PermissionKey | null) => void;
  setFilters: (filters: Partial<PermissionKeysState["filters"]>) => void;
  setPagination: (
    pagination: Partial<PermissionKeysState["pagination"]>
  ) => void;
  addPermissionKey: (permissionKey: PermissionKey) => void;
  updatePermissionKey: (
    id: string,
    permissionKey: Partial<PermissionKey>
  ) => void;
  removePermissionKey: (id: string) => void;
  clearFilters: () => void;
}

export const usePermissionKeysStore = create<PermissionKeysState>()(
  devtools(
    (set) => ({
      permissionKeys: [],
      loading: false,
      error: null,
      selectedPermissionKey: null,
      filters: {
        search: "",
        category: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setPermissionKeys: (permissionKeys) => set({ permissionKeys }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedPermissionKey: (selectedPermissionKey) =>
        set({ selectedPermissionKey }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addPermissionKey: (permissionKey) =>
        set((state) => ({
          permissionKeys: [...state.permissionKeys, permissionKey],
        })),
      updatePermissionKey: (id, updatedPermissionKey) =>
        set((state) => ({
          permissionKeys: state.permissionKeys.map((pk) =>
            pk.id === id ? { ...pk, ...updatedPermissionKey } : pk
          ),
        })),
      removePermissionKey: (id) =>
        set((state) => ({
          permissionKeys: state.permissionKeys.filter((pk) => pk.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            category: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "permission-keys-store" }
  )
);
