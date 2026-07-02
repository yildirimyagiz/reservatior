import { create } from "zustand";
import { devtools } from "zustand/middleware";
import { Task } from "../api/tasks";

export interface TasksState {
  tasks: Task[];
  loading: boolean;
  error: string | null;
  selectedTask: Task | null;
  filters: {
    search: string;
    status: string;
    priority: string;
    assignee: string;
    dueDateRange: [Date | null, Date | null];
    project: string;
  };
  view: "list" | "kanban" | "calendar";
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTasks: (tasks: Task[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedTask: (task: Task | null) => void;
  setFilters: (filters: Partial<TasksState["filters"]>) => void;
  setView: (view: "list" | "kanban" | "calendar") => void;
  setPagination: (pagination: Partial<TasksState["pagination"]>) => void;
  addTask: (task: Task) => void;
  updateTask: (id: string, task: Partial<Task>) => void;
  removeTask: (id: string) => void;
  clearFilters: () => void;
}

export const useTasksStore = create<TasksState>()(
  devtools(
    (set) => ({
      tasks: [],
      loading: false,
      error: null,
      selectedTask: null,
      filters: {
        search: "",
        status: "all",
        priority: "all",
        assignee: "all",
        dueDateRange: [null, null],
        project: "all",
      },
      view: "list",
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setTasks: (tasks) => set({ tasks }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedTask: (selectedTask) => set({ selectedTask }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setView: (view) => set({ view }),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addTask: (task) => set((state) => ({ tasks: [...state.tasks, task] })),
      updateTask: (id, updatedTask) =>
        set((state) => ({
          tasks: state.tasks.map((t) =>
            t.id === id ? { ...t, ...updatedTask } : t
          ),
        })),
      removeTask: (id) =>
        set((state) => ({
          tasks: state.tasks.filter((t) => t.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            status: "all",
            priority: "all",
            assignee: "all",
            dueDateRange: [null, null],
            project: "all",
          },
        }),
    }),
    { name: "tasks-store" }
  )
);
