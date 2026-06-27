import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Message {
  id: string;
  subject: string;
  content: string;
  type: string;
  status: "draft" | "sent" | "delivered" | "failed";
  senderId: string;
  recipientIds: string[];
  organizationId: string;
  attachments: string[];
  scheduledFor?: Date;
  sentAt?: Date;
  createdAt: Date;
  updatedAt: Date;
}

export interface MessageState {
  messages: Message[];
  loading: boolean;
  error: string | null;
  selectedMessage: Message | null;
  filters: {
    search: string;
    type: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setMessages: (messages: Message[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedMessage: (message: Message | null) => void;
  setFilters: (filters: Partial<MessageState["filters"]>) => void;
  setPagination: (pagination: Partial<MessageState["pagination"]>) => void;
  addMessage: (message: Message) => void;
  updateMessage: (id: string, message: Partial<Message>) => void;
  removeMessage: (id: string) => void;
  clearFilters: () => void;
}

export const useMessagesStore = create<MessageState>()(
  devtools(
    (set) => ({
      messages: [],
      loading: false,
      error: null,
      selectedMessage: null,
      filters: {
        search: "",
        type: "all",
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
            type: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "messages-store" }
  )
);
