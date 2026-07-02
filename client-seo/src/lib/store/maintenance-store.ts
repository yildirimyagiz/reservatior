import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface MaintenanceBlock {
  id: string;
  propertyId: string;
  type: string;
  startDate: Date;
  endDate: Date;
  reason: string;
  status: "scheduled" | "in_progress" | "completed" | "cancelled";
  assignedTo?: string;
  cost?: number;
  currency: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface MaintenanceState {
  blocks: MaintenanceBlock[];
  loading: boolean;
  error: string | null;
  selectedBlock: MaintenanceBlock | null;
  filters: {
    search: string;
    status: string;
    propertyId: string;
    type: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setBlocks: (blocks: MaintenanceBlock[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedBlock: (block: MaintenanceBlock | null) => void;
  setFilters: (filters: Partial<MaintenanceState["filters"]>) => void;
  setPagination: (pagination: Partial<MaintenanceState["pagination"]>) => void;
  addBlock: (block: MaintenanceBlock) => void;
  updateBlock: (id: string, block: Partial<MaintenanceBlock>) => void;
  removeBlock: (id: string) => void;
  clearFilters: () => void;
}

export const useMaintenanceStore = create<MaintenanceState>()(
  devtools(
    (set) => ({
      blocks: [],
      loading: false,
      error: null,
      selectedBlock: null,
      filters: {
        search: "",
        status: "all",
        propertyId: "all",
        type: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setBlocks: (blocks) => set({ blocks }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedBlock: (selectedBlock) => set({ selectedBlock }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addBlock: (block) =>
        set((state) => ({ blocks: [...state.blocks, block] })),
      updateBlock: (id, updatedBlock) =>
        set((state) => ({
          blocks: state.blocks.map((b) =>
            b.id === id ? { ...b, ...updatedBlock } : b
          ),
        })),
      removeBlock: (id) =>
        set((state) => ({
          blocks: state.blocks.filter((b) => b.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            status: "all",
            propertyId: "all",
            type: "all",
          },
        }),
    }),
    { name: "maintenance-store" }
  )
);
