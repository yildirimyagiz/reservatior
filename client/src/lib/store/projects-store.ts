import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Project {
  id: string;
  name: string;
  description: string;
  status: "planning" | "active" | "completed" | "on_hold";
  type: string;
  priority: "low" | "medium" | "high";
  startDate?: Date;
  endDate?: Date;
  budget?: number;
  currency: string;
  managerId: string;
  teamMembers: string[];
  progress: number; // 0-100
  createdAt: Date;
  updatedAt: Date;
}

export interface ProjectState {
  projects: Project[];
  loading: boolean;
  error: string | null;
  selectedProject: Project | null;
  filters: {
    search: string;
    status: string;
    type: string;
    managerId: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setProjects: (projects: Project[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedProject: (project: Project | null) => void;
  setFilters: (filters: Partial<ProjectState["filters"]>) => void;
  setPagination: (pagination: Partial<ProjectState["pagination"]>) => void;
  addProject: (project: Project) => void;
  updateProject: (id: string, project: Partial<Project>) => void;
  removeProject: (id: string) => void;
  clearFilters: () => void;
}

export const useProjectsStore = create<ProjectState>()(
  devtools(
    (set) => ({
      projects: [],
      loading: false,
      error: null,
      selectedProject: null,
      filters: {
        search: "",
        status: "all",
        type: "all",
        managerId: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setProjects: (projects) => set({ projects }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedProject: (selectedProject) => set({ selectedProject }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addProject: (project) =>
        set((state) => ({ projects: [...state.projects, project] })),
      updateProject: (id, updatedProject) =>
        set((state) => ({
          projects: state.projects.map((p) =>
            p.id === id ? { ...p, ...updatedProject } : p
          ),
        })),
      removeProject: (id) =>
        set((state) => ({
          projects: state.projects.filter((p) => p.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            status: "all",
            type: "all",
            managerId: "all",
          },
        }),
    }),
    { name: "projects-store" }
  )
);
