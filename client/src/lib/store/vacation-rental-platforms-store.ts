import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface VacationRentalPlatform {
  id: string;
  name: string;
  displayName: string;
  type: string;
  description?: string;
  logo?: string;
  website: string;
  apiConfig: {
    baseUrl: string;
    apiKey?: string;
    webhookUrl?: string;
    syncSettings: {
      autoSync: boolean;
      syncInterval: number; // minutes
      syncFields: string[];
    };
  };
  features: string[];
  supportedFields: string[];
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface VacationRentalPlatformsState {
  platforms: VacationRentalPlatform[];
  loading: boolean;
  error: string | null;
  selectedPlatform: VacationRentalPlatform | null;
  filters: {
    search: string;
    type: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setPlatforms: (platforms: VacationRentalPlatform[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedPlatform: (platform: VacationRentalPlatform | null) => void;
  setFilters: (
    filters: Partial<VacationRentalPlatformsState["filters"]>
  ) => void;
  setPagination: (
    pagination: Partial<VacationRentalPlatformsState["pagination"]>
  ) => void;
  addPlatform: (platform: VacationRentalPlatform) => void;
  updatePlatform: (
    id: string,
    platform: Partial<VacationRentalPlatform>
  ) => void;
  removePlatform: (id: string) => void;
  clearFilters: () => void;
}

export const useVacationRentalPlatformsStore =
  create<VacationRentalPlatformsState>()(
    devtools(
      (set) => ({
        platforms: [],
        loading: false,
        error: null,
        selectedPlatform: null,
        filters: {
          search: "",
          type: "all",
          isActive: "all",
        },
        pagination: {
          page: 1,
          limit: 20,
          total: 0,
        },
        setPlatforms: (platforms) => set({ platforms }),
        setLoading: (loading) => set({ loading }),
        setError: (error) => set({ error }),
        setSelectedPlatform: (selectedPlatform) => set({ selectedPlatform }),
        setFilters: (filters) =>
          set((state) => ({ filters: { ...state.filters, ...filters } })),
        setPagination: (pagination) =>
          set((state) => ({
            pagination: { ...state.pagination, ...pagination },
          })),
        addPlatform: (platform) =>
          set((state) => ({ platforms: [...state.platforms, platform] })),
        updatePlatform: (id, updatedPlatform) =>
          set((state) => ({
            platforms: state.platforms.map((p) =>
              p.id === id ? { ...p, ...updatedPlatform } : p
            ),
          })),
        removePlatform: (id) =>
          set((state) => ({
            platforms: state.platforms.filter((p) => p.id !== id),
          })),
        clearFilters: () =>
          set({
            filters: {
              search: "",
              type: "all",
              isActive: "all",
            },
          }),
      }),
      { name: "vacation-rental-platforms-store" }
    )
  );
