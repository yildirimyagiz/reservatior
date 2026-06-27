import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ListingChannel {
  id: string;
  name: string;
  type: string;
  description?: string;
  isActive: boolean;
  config: Record<string, any>;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ListingChannelsState {
  channels: ListingChannel[];
  loading: boolean;
  error: string | null;
  selectedChannel: ListingChannel | null;
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
  setChannels: (channels: ListingChannel[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedChannel: (channel: ListingChannel | null) => void;
  setFilters: (filters: Partial<ListingChannelsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<ListingChannelsState["pagination"]>
  ) => void;
  addChannel: (channel: ListingChannel) => void;
  updateChannel: (id: string, channel: Partial<ListingChannel>) => void;
  removeChannel: (id: string) => void;
  clearFilters: () => void;
}

export const useListingChannelsStore = create<ListingChannelsState>()(
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
    { name: "listing-channels-store" }
  )
);
