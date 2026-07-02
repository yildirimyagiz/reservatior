import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Notification {
  id: string;
  type: "info" | "success" | "warning" | "error";
  title: string;
  message: string;
  timestamp: Date;
  read: boolean;
  actionUrl?: string;
  actionText?: string;
  metadata?: Record<string, any>;
}

export interface NotificationsState {
  notifications: Notification[];
  unreadCount: number;
  loading: boolean;
  error: string | null;
  filters: {
    type: string;
    read: "all" | "read" | "unread";
    dateRange: [Date | null, Date | null];
  };
  setNotifications: (notifications: Notification[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  addNotification: (
    notification: Omit<Notification, "id" | "timestamp" | "read">
  ) => void;
  markAsRead: (id: string) => void;
  markAllAsRead: () => void;
  removeNotification: (id: string) => void;
  clearAll: () => void;
  setFilters: (filters: Partial<NotificationsState["filters"]>) => void;
}

export const useNotificationsStore = create<NotificationsState>()(
  devtools(
    (set) => ({
      notifications: [],
      unreadCount: 0,
      loading: false,
      error: null,
      filters: {
        type: "all",
        read: "all",
        dateRange: [null, null],
      },
      setNotifications: (notifications) => {
        const unreadCount = notifications.filter((n) => !n.read).length;
        set({ notifications, unreadCount });
      },
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      addNotification: (notification) => {
        const newNotification: Notification = {
          ...notification,
          id: Date.now().toString(),
          timestamp: new Date(),
          read: false,
        };
        set((state) => {
          const updatedNotifications = [
            newNotification,
            ...state.notifications,
          ];
          const unreadCount = updatedNotifications.filter(
            (n) => !n.read
          ).length;
          return {
            notifications: updatedNotifications.slice(0, 100), // Keep only last 100
            unreadCount,
          };
        });
      },
      markAsRead: (id) =>
        set((state) => {
          const updatedNotifications = state.notifications.map((n) =>
            n.id === id ? { ...n, read: true } : n
          );
          const unreadCount = updatedNotifications.filter(
            (n) => !n.read
          ).length;
          return {
            notifications: updatedNotifications,
            unreadCount,
          };
        }),
      markAllAsRead: () =>
        set((state) => ({
          notifications: state.notifications.map((n) => ({ ...n, read: true })),
          unreadCount: 0,
        })),
      removeNotification: (id) =>
        set((state) => {
          const updatedNotifications = state.notifications.filter(
            (n) => n.id !== id
          );
          const unreadCount = updatedNotifications.filter(
            (n) => !n.read
          ).length;
          return {
            notifications: updatedNotifications,
            unreadCount,
          };
        }),
      clearAll: () => set({ notifications: [], unreadCount: 0 }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
    }),
    { name: "notifications-store" }
  )
);
