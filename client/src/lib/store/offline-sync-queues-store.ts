import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface OfflineSyncQueue {
  id: string;
  userId: string;
  deviceId: string;
  entityType: string;
  entityId: string;
  operation: "create" | "update" | "delete";
  data: any;
  status: "pending" | "syncing" | "completed" | "failed";
  attempts: number;
  maxAttempts: number;
  error?: string;
  createdAt: Date;
  syncedAt?: Date;
  nextRetryAt?: Date;
}

export interface OfflineSyncQueuesState {
  queues: OfflineSyncQueue[];
  loading: boolean;
  error: string | null;
  selectedQueue: OfflineSyncQueue | null;
  filters: {
    search: string;
    userId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setQueues: (queues: OfflineSyncQueue[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedQueue: (queue: OfflineSyncQueue | null) => void;
  setFilters: (filters: Partial<OfflineSyncQueuesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<OfflineSyncQueuesState["pagination"]>
  ) => void;
  addQueue: (queue: OfflineSyncQueue) => void;
  updateQueue: (id: string, queue: Partial<OfflineSyncQueue>) => void;
  removeQueue: (id: string) => void;
  clearFilters: () => void;
}

export const useOfflineSyncQueuesStore = create<OfflineSyncQueuesState>()(
  devtools(
    (set) => ({
      queues: [],
      loading: false,
      error: null,
      selectedQueue: null,
      filters: {
        search: "",
        userId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setQueues: (queues) => set({ queues }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedQueue: (selectedQueue) => set({ selectedQueue }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addQueue: (queue) =>
        set((state) => ({ queues: [...state.queues, queue] })),
      updateQueue: (id, updatedQueue) =>
        set((state) => ({
          queues: state.queues.map((q) =>
            q.id === id ? { ...q, ...updatedQueue } : q
          ),
        })),
      removeQueue: (id) =>
        set((state) => ({
          queues: state.queues.filter((q) => q.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            userId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "offline-sync-queues-store" }
  )
);
