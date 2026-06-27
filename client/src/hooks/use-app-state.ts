import { useState } from "react";
import { create } from "zustand";
import { devtools, persist } from "zustand/middleware";
import { useUserStore } from "@/lib/store/user-store";

// Global app state that doesn't relate to authentication
export interface AppState {
  // UI State
  sidebarOpen: boolean;
  theme: 'light' | 'dark' | 'system';
  language: string;
  
  // Notifications
  notifications: Array<{
    id: string;
    title: string;
    message: string;
    type: 'info' | 'success' | 'warning' | 'error';
    timestamp: string;
    read: boolean;
  }>;
  
  // Loading states
  loadingStates: Record<string, boolean>;
  
  // Error states
  errors: Record<string, string | null>;
  
  // Actions
  setSidebarOpen: (open: boolean) => void;
  setTheme: (theme: 'light' | 'dark' | 'system') => void;
  setLanguage: (language: string) => void;
  addNotification: (notification: Omit<AppState['notifications'][0], 'id' | 'timestamp'>) => void;
  markNotificationRead: (id: string) => void;
  clearNotifications: () => void;
  setLoadingState: (key: string, loading: boolean) => void;
  setError: (key: string, error: string | null) => void;
  clearError: (key: string) => void;
}

export const useAppState = create<AppState>()(
  devtools(
    persist(
      (set) => ({
        // Initial state
        sidebarOpen: true,
        theme: 'system',
        language: 'en',
        notifications: [],
        loadingStates: {},
        errors: {},

        // UI Actions
        setSidebarOpen: (open) => set({ sidebarOpen: open }),
        setTheme: (theme) => set({ theme }),
        setLanguage: (language) => set({ language }),

        // Notification Actions
        addNotification: (notification) => {
          const newNotification = {
            ...notification,
            id: Date.now().toString(),
            timestamp: new Date().toISOString(),
            read: false,
          };
          
          set((state) => ({
            notifications: [newNotification, ...state.notifications].slice(0, 50), // Keep only last 50
          }));
        },

        markNotificationRead: (id) => {
          set((state) => ({
            notifications: state.notifications.map((n) =>
              n.id === id ? { ...n, read: true } : n
            ),
          }));
        },

        clearNotifications: () => set({ notifications: [] }),

        // Loading State Actions
        setLoadingState: (key, loading) => {
          set((state) => ({
            loadingStates: { ...state.loadingStates, [key]: loading },
          }));
        },

        // Error Actions
        setError: (key, error) => {
          set((state) => ({
            errors: { ...state.errors, [key]: error },
          }));
        },

        clearError: (key) => {
          set((state) => ({
            errors: { ...state.errors, [key]: null },
          }));
        },
      }),
      {
        name: "app-state",
        partialize: (state) => ({
          sidebarOpen: state.sidebarOpen,
          theme: state.theme,
          language: state.language,
        }),
      }
    )
  )
);

// Combined hooks for easier access to all state
export const useAuth = () => {
  const userStore = useUserStore();
  return userStore;
};

export const useGlobalLoading = (key: string) => {
  const setLoadingState = useAppState((state) => state.setLoadingState);
  const loading = useAppState((state) => state.loadingStates[key] || false);

  const startLoading = () => setLoadingState(key, true);
  const stopLoading = () => setLoadingState(key, false);

  return {
    loading,
    startLoading,
    stopLoading,
  };
};

export const useGlobalError = (key: string) => {
  const setError = useAppState((state) => state.setError);
  const clearError = useAppState((state) => state.clearError);
  const error = useAppState((state) => state.errors[key]);

  const setGlobalError = (errorMessage: string) => setError(key, errorMessage);
  const clearGlobalError = () => clearError(key);

  return {
    error,
    setError: setGlobalError,
    clearError: clearGlobalError,
  };
};

// Standardized state management hook for components
export const useComponentState = <T extends Record<string, any>>(
  initialState: T,
  componentKey: string
) => {
  const [state, setState] = useState<T>(initialState);
  const { startLoading, stopLoading } = useGlobalLoading(componentKey);
  const { setError, clearError } = useGlobalError(componentKey);

  const updateState = (updates: Partial<T>) => {
    setState((prev: T) => ({ ...prev, ...updates }));
  };

  const resetState = () => {
    setState(initialState);
    clearError();
  };

  return {
    state,
    updateState,
    resetState,
    startLoading,
    stopLoading,
    setError,
    clearError,
  };
};
