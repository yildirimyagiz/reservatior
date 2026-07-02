import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface MLSConnection {
  id: string;
  name: string;
  provider: string;
  apiKey: string;
  apiSecret: string;
  status: "active" | "inactive" | "error" | "syncing";
  lastSync?: Date;
  syncFrequency: number; // hours
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface MLSConnectionsState {
  connections: MLSConnection[];
  loading: boolean;
  error: string | null;
  selectedConnection: MLSConnection | null;
  filters: {
    search: string;
    provider: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setConnections: (connections: MLSConnection[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedConnection: (connection: MLSConnection | null) => void;
  setFilters: (filters: Partial<MLSConnectionsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<MLSConnectionsState["pagination"]>
  ) => void;
  addConnection: (connection: MLSConnection) => void;
  updateConnection: (id: string, connection: Partial<MLSConnection>) => void;
  removeConnection: (id: string) => void;
  clearFilters: () => void;
}

export const useMLSConnectionsStore = create<MLSConnectionsState>()(
  devtools(
    (set) => ({
      connections: [],
      loading: false,
      error: null,
      selectedConnection: null,
      filters: {
        search: "",
        provider: "all",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setConnections: (connections) => set({ connections }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedConnection: (selectedConnection) =>
        set({ selectedConnection }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addConnection: (connection) =>
        set((state) => ({ connections: [...state.connections, connection] })),
      updateConnection: (id, updatedConnection) =>
        set((state) => ({
          connections: state.connections.map((c) =>
            c.id === id ? { ...c, ...updatedConnection } : c
          ),
        })),
      removeConnection: (id) =>
        set((state) => ({
          connections: state.connections.filter((c) => c.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            provider: "all",
            status: "all",
          },
        }),
    }),
    { name: "mls-connections-store" }
  )
);
