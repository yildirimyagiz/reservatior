import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface MlsListingEnhancement {
  id: string;
  mlsConnectionId: string;
  listingId: string;
  type: string;
  title: string;
  description?: string;
  photos: string[];
  videos: string[];
  virtualTours: string[];
  floorPlans: string[];
  documents: string[];
  enhancedFeatures: string[];
  status: "pending" | "approved" | "rejected";
  appliedAt?: Date;
  rejectedReason?: string;
  organizationId: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface MlsListingEnhancementsState {
  enhancements: MlsListingEnhancement[];
  loading: boolean;
  error: string | null;
  selectedEnhancement: MlsListingEnhancement | null;
  filters: {
    search: string;
    mlsConnectionId: string;
    listingId: string;
    type: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setEnhancements: (enhancements: MlsListingEnhancement[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedEnhancement: (enhancement: MlsListingEnhancement | null) => void;
  setFilters: (
    filters: Partial<MlsListingEnhancementsState["filters"]>
  ) => void;
  setPagination: (
    pagination: Partial<MlsListingEnhancementsState["pagination"]>
  ) => void;
  addEnhancement: (enhancement: MlsListingEnhancement) => void;
  updateEnhancement: (
    id: string,
    enhancement: Partial<MlsListingEnhancement>
  ) => void;
  removeEnhancement: (id: string) => void;
  clearFilters: () => void;
}

export const useMlsListingEnhancementsStore =
  create<MlsListingEnhancementsState>()(
    devtools(
      (set) => ({
        enhancements: [],
        loading: false,
        error: null,
        selectedEnhancement: null,
        filters: {
          search: "",
          mlsConnectionId: "all",
          listingId: "all",
          type: "all",
          status: "all",
          dateRange: [null, null],
        },
        pagination: {
          page: 1,
          limit: 20,
          total: 0,
        },
        setEnhancements: (enhancements) => set({ enhancements }),
        setLoading: (loading) => set({ loading }),
        setError: (error) => set({ error }),
        setSelectedEnhancement: (selectedEnhancement) =>
          set({ selectedEnhancement }),
        setFilters: (filters) =>
          set((state) => ({ filters: { ...state.filters, ...filters } })),
        setPagination: (pagination) =>
          set((state) => ({
            pagination: { ...state.pagination, ...pagination },
          })),
        addEnhancement: (enhancement) =>
          set((state) => ({
            enhancements: [...state.enhancements, enhancement],
          })),
        updateEnhancement: (id, updatedEnhancement) =>
          set((state) => ({
            enhancements: state.enhancements.map((e) =>
              e.id === id ? { ...e, ...updatedEnhancement } : e
            ),
          })),
        removeEnhancement: (id) =>
          set((state) => ({
            enhancements: state.enhancements.filter((e) => e.id !== id),
          })),
        clearFilters: () =>
          set({
            filters: {
              search: "",
              mlsConnectionId: "all",
              listingId: "all",
              type: "all",
              status: "all",
              dateRange: [null, null],
            },
          }),
      }),
      { name: "mls-listing-enhancements-store" }
    )
  );
