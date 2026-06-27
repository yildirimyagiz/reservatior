import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface UserPreference {
  id: string;
  userId: string;
  key: string;
  value: string;
  category: string;
  description?: string;
  isPublic: boolean;
  createdAt: Date;
  updatedAt: Date;
}

export interface UserPreferencesState {
  preferences: UserPreference[];
  loading: boolean;
  error: string | null;
  selectedPreference: UserPreference | null;
  filters: {
    search: string;
    userId: string;
    category: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setPreferences: (preferences: UserPreference[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedPreference: (preference: UserPreference | null) => void;
  setFilters: (filters: Partial<UserPreferencesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<UserPreferencesState["pagination"]>
  ) => void;
  addPreference: (preference: UserPreference) => void;
  updatePreference: (id: string, preference: Partial<UserPreference>) => void;
  removePreference: (id: string) => void;
  clearFilters: () => void;
}

export const useUserPreferencesStore = create<UserPreferencesState>()(
  devtools(
    (set) => ({
      preferences: [],
      loading: false,
      error: null,
      selectedPreference: null,
      filters: {
        search: "",
        userId: "all",
        category: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setPreferences: (preferences) => set({ preferences }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedPreference: (selectedPreference) =>
        set({ selectedPreference }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addPreference: (preference) =>
        set((state) => ({ preferences: [...state.preferences, preference] })),
      updatePreference: (id, updatedPreference) =>
        set((state) => ({
          preferences: state.preferences.map((p) =>
            p.id === id ? { ...p, ...updatedPreference } : p
          ),
        })),
      removePreference: (id) =>
        set((state) => ({
          preferences: state.preferences.filter((p) => p.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            userId: "all",
            category: "all",
          },
        }),
    }),
    { name: "user-preferences-store" }
  )
);
