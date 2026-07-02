import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface MaintenanceBlockType {
  id: string;
  name: string;
  description?: string;
  color: string;
  requiresApproval: boolean;
  defaultDuration: number; // hours
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface MaintenanceBlockTypesState {
  blockTypes: MaintenanceBlockType[];
  loading: boolean;
  error: string | null;
  selectedBlockType: MaintenanceBlockType | null;
  filters: {
    search: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setBlockTypes: (blockTypes: MaintenanceBlockType[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedBlockType: (blockType: MaintenanceBlockType | null) => void;
  setFilters: (filters: Partial<MaintenanceBlockTypesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<MaintenanceBlockTypesState["pagination"]>
  ) => void;
  addBlockType: (blockType: MaintenanceBlockType) => void;
  updateBlockType: (
    id: string,
    blockType: Partial<MaintenanceBlockType>
  ) => void;
  removeBlockType: (id: string) => void;
  clearFilters: () => void;
}

export const useMaintenanceBlockTypesStore =
  create<MaintenanceBlockTypesState>()(
    devtools(
      (set) => ({
        blockTypes: [],
        loading: false,
        error: null,
        selectedBlockType: null,
        filters: {
          search: "",
          isActive: "all",
        },
        pagination: {
          page: 1,
          limit: 20,
          total: 0,
        },
        setBlockTypes: (blockTypes) => set({ blockTypes }),
        setLoading: (loading) => set({ loading }),
        setError: (error) => set({ error }),
        setSelectedBlockType: (selectedBlockType) => set({ selectedBlockType }),
        setFilters: (filters) =>
          set((state) => ({ filters: { ...state.filters, ...filters } })),
        setPagination: (pagination) =>
          set((state) => ({
            pagination: { ...state.pagination, ...pagination },
          })),
        addBlockType: (blockType) =>
          set((state) => ({ blockTypes: [...state.blockTypes, blockType] })),
        updateBlockType: (id, updatedBlockType) =>
          set((state) => ({
            blockTypes: state.blockTypes.map((bt) =>
              bt.id === id ? { ...bt, ...updatedBlockType } : bt
            ),
          })),
        removeBlockType: (id) =>
          set((state) => ({
            blockTypes: state.blockTypes.filter((bt) => bt.id !== id),
          })),
        clearFilters: () =>
          set({
            filters: {
              search: "",
              isActive: "all",
            },
          }),
      }),
      { name: "maintenance-block-types-store" }
    )
  );
