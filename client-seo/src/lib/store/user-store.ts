import { create } from "zustand";
import { devtools, persist } from "zustand/middleware";

export interface User {
  id: string;
  clerkId?: string;
  email: string;
  firstName: string;
  lastName: string;
  name?: string; // Derived field
  imageUrl?: string;
  phone?: string;
  locale: string;
  timezone: string;
  createdAt: string;
  updatedAt: string;
  role: "OWNER" | "VENDOR_MANAGER" | "AGENCY_ADMIN" | "AGENT" | "ACCOUNTANT" | "MAINTENANCE" | "TENANT_GUEST" | "ORG_ADMIN" | "READ_ONLY" | "SUPER_ADMIN" | "ADMIN" | "TENANT" | "USER" | "V1_ADMIN";
  status: "ACTIVE" | "INACTIVE" | "PENDING" | "SUSPENDED" | "DELETED" | "VERIFIED";
  permissions: string[];
  originRegion?: string;
  orgId?: string | null;
  preferences?: {
    theme?: "light" | "dark" | "system";
    language?: string;
    timezone?: string;
    currency?: string;
    notifications?: {
      email?: boolean;
      push?: boolean;
      sms?: boolean;
    };
  };
}

export interface UserState {
  user: User | null;
  token: string | null;
  loading: boolean;
  error: string | null;
  isAuthenticated: boolean;
  setUser: (user: User) => void;
  setToken: (token: string | null) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  login: (email: string, password: string) => Promise<void>;
  register: (
    email: string,
    password: string,
    name: string,
    phone?: string,
    organizationName?: string
  ) => Promise<void>;
  logout: () => Promise<void>;
  updateProfile: (profile: Partial<User>) => void;
  refreshToken: () => Promise<boolean>;
}

export const useUserStore = create<UserState>()(
  devtools(
    persist(
      (set, get) => ({
        user: null,
        token: null,
        loading: false,
        error: null,
        isAuthenticated: false,
        setUser: (user) => set({ user, isAuthenticated: true }),
        setToken: (token) => set({ token }),
        setLoading: (loading) => set({ loading }),
        setError: (error) => set({ error }),
        login: async (email, password) => {
          set({ loading: true, error: null });
          try {
            const { authApi } = await import("../api/auth");
            const response = await authApi.login({ email, password });
            set({
              user: {
                ...response.user,
                name: (response.user as any).name || `${response.user.firstName} ${response.user.lastName}`,
                updatedAt: response.user.updatedAt,
              },
              token: response.token,
              isAuthenticated: true,
              error: null,
            });
          } catch (error: any) {
            const errorMessage =
              error.response?.data?.message || "Login failed";
            set({ error: errorMessage });
            throw error;
          } finally {
            set({ loading: false });
          }
        },
        register: async (email, password, name, phone, organizationName) => {
          set({ loading: true, error: null });
          try {
            const { authApi } = await import("../api/auth");
            const response = await authApi.register({
              email,
              password,
              name,
              phone,
              organizationName,
            });
            set({
              user: {
                ...response.user,
                name: (response.user as any).name || `${response.user.firstName} ${response.user.lastName}`,
                updatedAt: response.user.updatedAt,
              },
              token: response.token,
              isAuthenticated: true,
              error: null,
            });
          } catch (error: any) {
            const errorMessage =
              error.response?.data?.message || "Registration failed";
            set({ error: errorMessage });
            throw error;
          } finally {
            set({ loading: false });
          }
        },
        logout: async () => {
          try {
            const { authApi } = await import("../api/auth");
            const { token } = get();
            if (token) {
              await authApi.logout();
            }
          } catch (error) {
            console.error("Logout API call failed:", error);
          } finally {
            set({
              user: null,
              token: null,
              isAuthenticated: false,
              error: null,
            });
          }
        },
        refreshToken: async () => {
          // Simple implementation - just logout since we don't have refresh tokens
          get().logout();
          return false;
        },
        updateProfile: (profile) =>
          set((state) =>
            state.user ? { user: { ...state.user, ...profile } } : state
          ),
      }),
      {
        name: "user-storage",
        partialize: (state) => ({
          user: state.user,
          token: state.token,
        }),
        onRehydrateStorage: () => (state) => {
          if (state) {
            if (state.token && state.user) {
              state.isAuthenticated = true;
            } else {
              state.isAuthenticated = false;
              state.user = null;
              state.token = null;
            }
          }
        },
      }
    )
  )
);
