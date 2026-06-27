import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Webhook {
  id: string;
  name: string;
  url: string;
  events: string[];
  secret?: string;
  isActive: boolean;
  lastTriggered?: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface WebhookState {
  webhooks: Webhook[];
  loading: boolean;
  error: string | null;
  selectedWebhook: Webhook | null;
  filters: {
    search: string;
    isActive: string;
    event: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setWebhooks: (webhooks: Webhook[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedWebhook: (webhook: Webhook | null) => void;
  setFilters: (filters: Partial<WebhookState["filters"]>) => void;
  setPagination: (pagination: Partial<WebhookState["pagination"]>) => void;
  addWebhook: (webhook: Webhook) => void;
  updateWebhook: (id: string, webhook: Partial<Webhook>) => void;
  removeWebhook: (id: string) => void;
  clearFilters: () => void;
}

export const useWebhooksStore = create<WebhookState>()(
  devtools(
    (set) => ({
      webhooks: [],
      loading: false,
      error: null,
      selectedWebhook: null,
      filters: {
        search: "",
        isActive: "all",
        event: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setWebhooks: (webhooks) => set({ webhooks }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedWebhook: (selectedWebhook) => set({ selectedWebhook }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addWebhook: (webhook) =>
        set((state) => ({ webhooks: [...state.webhooks, webhook] })),
      updateWebhook: (id, updatedWebhook) =>
        set((state) => ({
          webhooks: state.webhooks.map((w) =>
            w.id === id ? { ...w, ...updatedWebhook } : w
          ),
        })),
      removeWebhook: (id) =>
        set((state) => ({
          webhooks: state.webhooks.filter((w) => w.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            isActive: "all",
            event: "all",
          },
        }),
    }),
    { name: "webhooks-store" }
  )
);
