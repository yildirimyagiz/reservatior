import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Referral {
  id: string;
  referrerId: string;
  referredId?: string;
  type: string;
  status: "pending" | "accepted" | "rejected" | "completed";
  description?: string;
  value?: number;
  currency?: string;
  commissionRate?: number;
  commissionAmount?: number;
  commissionStatus: "pending" | "earned" | "paid" | "cancelled";
  paidDate?: Date;
  notes?: string;
  documents: string[];
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ReferralsState {
  referrals: Referral[];
  loading: boolean;
  error: string | null;
  selectedReferral: Referral | null;
  filters: {
    search: string;
    referrerId: string;
    type: string;
    status: string;
    commissionStatus: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setReferrals: (referrals: Referral[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedReferral: (referral: Referral | null) => void;
  setFilters: (filters: Partial<ReferralsState["filters"]>) => void;
  setPagination: (pagination: Partial<ReferralsState["pagination"]>) => void;
  addReferral: (referral: Referral) => void;
  updateReferral: (id: string, referral: Partial<Referral>) => void;
  removeReferral: (id: string) => void;
  clearFilters: () => void;
}

export const useReferralsStore = create<ReferralsState>()(
  devtools(
    (set) => ({
      referrals: [],
      loading: false,
      error: null,
      selectedReferral: null,
      filters: {
        search: "",
        referrerId: "all",
        type: "all",
        status: "all",
        commissionStatus: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setReferrals: (referrals) => set({ referrals }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedReferral: (selectedReferral) => set({ selectedReferral }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addReferral: (referral) =>
        set((state) => ({ referrals: [...state.referrals, referral] })),
      updateReferral: (id, updatedReferral) =>
        set((state) => ({
          referrals: state.referrals.map((r) =>
            r.id === id ? { ...r, ...updatedReferral } : r
          ),
        })),
      removeReferral: (id) =>
        set((state) => ({
          referrals: state.referrals.filter((r) => r.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            referrerId: "all",
            type: "all",
            status: "all",
            commissionStatus: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "referrals-store" }
  )
);
