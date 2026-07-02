import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface QueueMessage {
  id: string;
  queueId: string;
  type: string;
  payload: any;
  priority: number;
  attempts: number;
  maxAttempts: number;
  status: "pending" | "processing" | "completed" | "failed" | "cancelled";
  error?: string;
  createdAt: Date;
  processedAt?: Date;
  nextRetryAt?: Date;
  organizationId: string;
}

export interface QueueMessagesState {
  messages: QueueMessage[];
  loading: boolean;
  error: string | null;
  selectedMessage: QueueMessage | null;
  filters: {
    search: string;
    queueId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setMessages: (messages: QueueMessage[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedMessage: (message: QueueMessage | null) => void;
  setFilters: (filters: Partial<QueueMessagesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<QueueMessagesState["pagination"]>
  ) => void;
  addMessage: (message: QueueMessage) => void;
  updateMessage: (id: string, message: Partial<QueueMessage>) => void;
  removeMessage: (id: string) => void;
  clearFilters: () => void;
}

export const useQueueMessagesStore = create<QueueMessagesState>()(
  devtools(
    (set) => ({
      messages: [],
      loading: false,
      error: null,
      selectedMessage: null,
      filters: {
        search: "",
        queueId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setMessages: (messages) => set({ messages }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedMessage: (selectedMessage) => set({ selectedMessage }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addMessage: (message) =>
        set((state) => ({ messages: [...state.messages, message] })),
      updateMessage: (id, updatedMessage) =>
        set((state) => ({
          messages: state.messages.map((m) =>
            m.id === id ? { ...m, ...updatedMessage } : m
          ),
        })),
      removeMessage: (id) =>
        set((state) => ({
          messages: state.messages.filter((m) => m.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            queueId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "queue-messages-store" }
  )
);
