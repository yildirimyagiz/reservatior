import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Session {
  id: string;
  userId: string;
  token: string;
  refreshToken?: string;
  expiresAt: Date;
  isActive: boolean;
  ipAddress?: string;
  userAgent?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface SessionState {
  sessions: Session[];
  loading: boolean;
  error: string | null;
  selectedSession: Session | null;
  filters: {
    search: string;
    userId: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setSessions: (sessions: Session[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedSession: (session: Session | null) => void;
  setFilters: (filters: Partial<SessionState["filters"]>) => void;
  setPagination: (pagination: Partial<SessionState["pagination"]>) => void;
  addSession: (session: Session) => void;
  updateSession: (id: string, session: Partial<Session>) => void;
  removeSession: (id: string) => void;
  clearFilters: () => void;
}

export const useSessionsStore = create<SessionState>()(
  devtools(
    (set) => ({
      sessions: [],
      loading: false,
      error: null,
      selectedSession: null,
      filters: {
        search: "",
        userId: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setSessions: (sessions) => set({ sessions }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedSession: (selectedSession) => set({ selectedSession }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addSession: (session) =>
        set((state) => ({ sessions: [...state.sessions, session] })),
      updateSession: (id, updatedSession) =>
        set((state) => ({
          sessions: state.sessions.map((s) =>
            s.id === id ? { ...s, ...updatedSession } : s
          ),
        })),
      removeSession: (id) =>
        set((state) => ({
          sessions: state.sessions.filter((s) => s.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            userId: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "sessions-store" }
  )
);
