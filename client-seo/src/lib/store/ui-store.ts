import { create } from "zustand";
import { devtools, persist } from "zustand/middleware";

// Global UI State
export interface UIState {
  sidebarOpen: boolean;
  theme: "light" | "dark" | "system";
  loading: boolean;
  currentPage: string;
  breadcrumbs: Array<{ label: string; href?: string }>;
  notifications: Array<{
    id: string;
    type: "success" | "error" | "warning" | "info";
    title: string;
    message: string;
    timestamp: Date;
    read: boolean;
  }>;
  setSidebarOpen: (open: boolean) => void;
  setTheme: (theme: "light" | "dark" | "system") => void;
  setLoading: (loading: boolean) => void;
  setCurrentPage: (page: string) => void;
  setBreadcrumbs: (
    breadcrumbs: Array<{ label: string; href?: string }>
  ) => void;
  addNotification: (
    notification: Omit<UIState["notifications"][0], "id" | "timestamp" | "read">
  ) => void;
  markNotificationRead: (id: string) => void;
  removeNotification: (id: string) => void;
  clearNotifications: () => void;
}

export const useUIStore = create<UIState>()(
  devtools(
    persist(
      (set) => ({
        sidebarOpen: true,
        theme: "system",
        loading: false,
        currentPage: "dashboard",
        breadcrumbs: [],
        notifications: [],
        setSidebarOpen: (open) => set({ sidebarOpen: open }),
        setTheme: (theme) => set({ theme }),
        setLoading: (loading) => set({ loading }),
        setCurrentPage: (currentPage) => set({ currentPage }),
        setBreadcrumbs: (breadcrumbs) => set({ breadcrumbs }),
        addNotification: (notification) => {
          const newNotification = {
            ...notification,
            id: Date.now().toString(),
            timestamp: new Date(),
            read: false,
          };
          set((state) => ({
            notifications: [newNotification, ...state.notifications].slice(
              0,
              50
            ),
          }));
        },
        markNotificationRead: (id) =>
          set((state) => ({
            notifications: state.notifications.map((n) =>
              n.id === id ? { ...n, read: true } : n
            ),
          })),
        removeNotification: (id) =>
          set((state) => ({
            notifications: state.notifications.filter((n) => n.id !== id),
          })),
        clearNotifications: () => set({ notifications: [] }),
      }),
      {
        name: "ui-storage",
        partialize: (state) => ({
          sidebarOpen: state.sidebarOpen,
          theme: state.theme,
        }),
      }
    )
  )
);
