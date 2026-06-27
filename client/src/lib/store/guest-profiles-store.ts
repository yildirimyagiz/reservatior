import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface GuestProfile {
  id: string;
  firstName: string;
  lastName: string;
  email?: string;
  phone?: string;
  dateOfBirth?: Date;
  nationality?: string;
  idNumber?: string;
  passportNumber?: string;
  address?: string;
  city?: string;
  country?: string;
  emergencyContact?: {
    name: string;
    phone: string;
    relationship: string;
  };
  preferences: {
    smoking: boolean;
    pets: boolean;
    children: boolean;
    accessibility: boolean;
    notes?: string;
  };
  verificationStatus: "unverified" | "pending" | "verified" | "rejected";
  totalBookings: number;
  totalRevenue: number;
  averageRating?: number;
  reviews: number;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface GuestProfilesState {
  profiles: GuestProfile[];
  loading: boolean;
  error: string | null;
  selectedProfile: GuestProfile | null;
  filters: {
    search: string;
    verificationStatus: string;
    isActive: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setProfiles: (profiles: GuestProfile[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedProfile: (profile: GuestProfile | null) => void;
  setFilters: (filters: Partial<GuestProfilesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<GuestProfilesState["pagination"]>
  ) => void;
  addProfile: (profile: GuestProfile) => void;
  updateProfile: (id: string, profile: Partial<GuestProfile>) => void;
  removeProfile: (id: string) => void;
  clearFilters: () => void;
}

export const useGuestProfilesStore = create<GuestProfilesState>()(
  devtools(
    (set) => ({
      profiles: [],
      loading: false,
      error: null,
      selectedProfile: null,
      filters: {
        search: "",
        verificationStatus: "all",
        isActive: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setProfiles: (profiles) => set({ profiles }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedProfile: (selectedProfile) => set({ selectedProfile }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addProfile: (profile) =>
        set((state) => ({ profiles: [...state.profiles, profile] })),
      updateProfile: (id, updatedProfile) =>
        set((state) => ({
          profiles: state.profiles.map((p) =>
            p.id === id ? { ...p, ...updatedProfile } : p
          ),
        })),
      removeProfile: (id) =>
        set((state) => ({
          profiles: state.profiles.filter((p) => p.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            verificationStatus: "all",
            isActive: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "guest-profiles-store" }
  )
);
