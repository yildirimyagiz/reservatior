import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface LoginAttempt {
  id: string;
  userId?: string;
  email: string;
  ipAddress: string;
  userAgent?: string;
  success: boolean;
  failureReason?: string;
  location?: string;
  timestamp: Date;
  organizationId: string;
}

export interface LoginAttemptsState {
  loginAttempts: LoginAttempt[];
  loading: boolean;
  error: string | null;
  selectedLoginAttempt: LoginAttempt | null;
  filters: {
    search: string;
    success: string;
    email: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setLoginAttempts: (loginAttempts: LoginAttempt[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedLoginAttempt: (loginAttempt: LoginAttempt | null) => void;
  setFilters: (filters: Partial<LoginAttemptsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<LoginAttemptsState["pagination"]>
  ) => void;
  addLoginAttempt: (loginAttempt: LoginAttempt) => void;
  updateLoginAttempt: (id: string, loginAttempt: Partial<LoginAttempt>) => void;
  removeLoginAttempt: (id: string) => void;
  clearFilters: () => void;
}

export const useLoginAttemptsStore = create<LoginAttemptsState>()(
  devtools(
    (set) => ({
      loginAttempts: [],
      loading: false,
      error: null,
      selectedLoginAttempt: null,
      filters: {
        search: "",
        success: "all",
        email: "",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 50,
        total: 0,
      },
      setLoginAttempts: (loginAttempts) => set({ loginAttempts }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedLoginAttempt: (selectedLoginAttempt) =>
        set({ selectedLoginAttempt }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addLoginAttempt: (loginAttempt) =>
        set((state) => ({
          loginAttempts: [...state.loginAttempts, loginAttempt],
        })),
      updateLoginAttempt: (id, updatedLoginAttempt) =>
        set((state) => ({
          loginAttempts: state.loginAttempts.map((la) =>
            la.id === id ? { ...la, ...updatedLoginAttempt } : la
          ),
        })),
      removeLoginAttempt: (id) =>
        set((state) => ({
          loginAttempts: state.loginAttempts.filter((la) => la.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            success: "all",
            email: "",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "login-attempts-store" }
  )
);
