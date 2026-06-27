import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Achievement {
  id: string;
  name: string;
  description: string;
  type: string;
  category: string;
  points: number;
  badge?: string;
  requirements: Array<{
    type: string;
    value: number;
    description: string;
  }>;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AchievementsState {
  achievements: Achievement[];
  loading: boolean;
  error: string | null;
  selectedAchievement: Achievement | null;
  filters: {
    search: string;
    type: string;
    category: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setAchievements: (achievements: Achievement[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedAchievement: (achievement: Achievement | null) => void;
  setFilters: (filters: Partial<AchievementsState["filters"]>) => void;
  setPagination: (pagination: Partial<AchievementsState["pagination"]>) => void;
  addAchievement: (achievement: Achievement) => void;
  updateAchievement: (id: string, achievement: Partial<Achievement>) => void;
  removeAchievement: (id: string) => void;
  clearFilters: () => void;
}

export const useAchievementsStore = create<AchievementsState>()(
  devtools(
    (set) => ({
      achievements: [],
      loading: false,
      error: null,
      selectedAchievement: null,
      filters: {
        search: "",
        type: "all",
        category: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setAchievements: (achievements) => set({ achievements }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedAchievement: (selectedAchievement) =>
        set({ selectedAchievement }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addAchievement: (achievement) =>
        set((state) => ({
          achievements: [...state.achievements, achievement],
        })),
      updateAchievement: (id, updatedAchievement) =>
        set((state) => ({
          achievements: state.achievements.map((a) =>
            a.id === id ? { ...a, ...updatedAchievement } : a
          ),
        })),
      removeAchievement: (id) =>
        set((state) => ({
          achievements: state.achievements.filter((a) => a.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            category: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "achievements-store" }
  )
);
