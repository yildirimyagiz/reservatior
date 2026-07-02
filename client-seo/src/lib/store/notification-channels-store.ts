import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface NotificationChannel {
  id: string;
  name: string;
  type: string;
  description?: string;
  config: Record<string, any>;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface NotificationChannelsState {
  channels: NotificationChannel[];
  loading: boolean;
  error: string | null;
  selectedChannel: NotificationChannel | null;
  filters: {
    search: string;
    type: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setChannels: (channels: NotificationChannel[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedChannel: (channel: NotificationChannel | null) => void;
  setFilters: (filters: Partial<NotificationChannelsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<NotificationChannelsState["pagination"]>
  ) => void;
  addChannel: (channel: NotificationChannel) => void;
  updateChannel: (id: string, channel: Partial<NotificationChannel>) => void;
  removeChannel: (id: string) => void;
  clearFilters: () => void;
}

export const useNotificationChannelsStore = create<NotificationChannelsState>()(
  devtools(
    (set) => ({
      channels: [],
      loading: false,
      error: null,
      selectedChannel: null,
      filters: {
        search: "",
        type: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setChannels: (channels) => set({ channels }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedChannel: (selectedChannel) => set({ selectedChannel }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addChannel: (channel) =>
        set((state) => ({ channels: [...state.channels, channel] })),
      updateChannel: (id, updatedChannel) =>
        set((state) => ({
          channels: state.channels.map((c) =>
            c.id === id ? { ...c, ...updatedChannel } : c
          ),
        })),
      removeChannel: (id) =>
        set((state) => ({
          channels: state.channels.filter((c) => c.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "notification-channels-store" }
  )
);
