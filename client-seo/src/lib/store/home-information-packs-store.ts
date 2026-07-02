import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface HomeInformationPack {
  id: string;
  propertyId: string;
  leaseId: string;
  tenantId: string;
  status: "draft" | "generated" | "sent" | "acknowledged" | "expired";
  version: number;
  content: {
    energyPerformance: {
      rating: string;
      certificateUrl?: string;
      validUntil?: Date;
    };
    gasSafety: {
      certificateUrl?: string;
      checkDate?: Date;
      expiryDate?: Date;
    };
    electricalSafety: {
      certificateUrl?: string;
      checkDate?: Date;
      expiryDate?: Date;
    };
    fireSafety: {
      equipment: Array<{
        type: string;
        location: string;
        lastChecked?: Date;
        expiryDate?: Date;
      }>;
    };
    smokeAlarms: Array<{
      location: string;
      lastTested?: Date;
      batteryExpiry?: Date;
    }>;
    carbonMonoxideAlarms: Array<{
      location: string;
      lastTested?: Date;
      batteryExpiry?: Date;
    }>;
  };
  documents: Array<{
    type: string;
    name: string;
    url: string;
    required: boolean;
    provided: boolean;
  }>;
  sentAt?: Date;
  acknowledgedAt?: Date;
  expiresAt?: Date;
  organizationId: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface HomeInformationPacksState {
  packs: HomeInformationPack[];
  loading: boolean;
  error: string | null;
  selectedPack: HomeInformationPack | null;
  filters: {
    search: string;
    propertyId: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setPacks: (packs: HomeInformationPack[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedPack: (pack: HomeInformationPack | null) => void;
  setFilters: (filters: Partial<HomeInformationPacksState["filters"]>) => void;
  setPagination: (
    pagination: Partial<HomeInformationPacksState["pagination"]>
  ) => void;
  addPack: (pack: HomeInformationPack) => void;
  updatePack: (id: string, pack: Partial<HomeInformationPack>) => void;
  removePack: (id: string) => void;
  clearFilters: () => void;
}

export const useHomeInformationPacksStore = create<HomeInformationPacksState>()(
  devtools(
    (set) => ({
      packs: [],
      loading: false,
      error: null,
      selectedPack: null,
      filters: {
        search: "",
        propertyId: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setPacks: (packs) => set({ packs }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedPack: (selectedPack) => set({ selectedPack }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addPack: (pack) => set((state) => ({ packs: [...state.packs, pack] })),
      updatePack: (id, updatedPack) =>
        set((state) => ({
          packs: state.packs.map((p) =>
            p.id === id ? { ...p, ...updatedPack } : p
          ),
        })),
      removePack: (id) =>
        set((state) => ({
          packs: state.packs.filter((p) => p.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyId: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "home-information-packs-store" }
  )
);
