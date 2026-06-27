import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AIChatbotSession {
  id: string;
  userId: string;
  sessionId: string;
  messages: Array<{
    id: string;
    role: "user" | "assistant";
    content: string;
    timestamp: Date;
  }>;
  status: "active" | "completed" | "abandoned";
  context: Record<string, any>;
  modelId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AIChatbotSessionsState {
  sessions: AIChatbotSession[];
  loading: boolean;
  error: string | null;
  selectedSession: AIChatbotSession | null;
  filters: {
    search: string;
    userId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setSessions: (sessions: AIChatbotSession[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedSession: (session: AIChatbotSession | null) => void;
  setFilters: (filters: Partial<AIChatbotSessionsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AIChatbotSessionsState["pagination"]>
  ) => void;
  addSession: (session: AIChatbotSession) => void;
  updateSession: (id: string, session: Partial<AIChatbotSession>) => void;
  removeSession: (id: string) => void;
  clearFilters: () => void;
}

export const useAIChatbotSessionsStore = create<AIChatbotSessionsState>()(
  devtools(
    (set) => ({
      sessions: [],
      loading: false,
      error: null,
      selectedSession: null,
      filters: {
        search: "",
        userId: "all",
        status: "all",
        dateRange: [null, null],
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
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "ai-chatbot-sessions-store" }
  )
);
