import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Reward {
  id: string;
  name: string;
  description: string;
  type: string;
  category: string;
  pointsRequired: number;
  value: number;
  currency: string;
  status: "available" | "unavailable" | "expired";
  imageUrl?: string;
  terms?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface RewardsState {
  rewards: Reward[];
  loading: boolean;
  error: string | null;
  selectedReward: Reward | null;
  filters: {
    search: string;
    type: string;
    category: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setRewards: (rewards: Reward[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedReward: (reward: Reward | null) => void;
  setFilters: (filters: Partial<RewardsState["filters"]>) => void;
  setPagination: (pagination: Partial<RewardsState["pagination"]>) => void;
  addReward: (reward: Reward) => void;
  updateReward: (id: string, reward: Partial<Reward>) => void;
  removeReward: (id: string) => void;
  clearFilters: () => void;
}

export const useRewardsStore = create<RewardsState>()(
  devtools(
    (set) => ({
      rewards: [],
      loading: false,
      error: null,
      selectedReward: null,
      filters: {
        search: "",
        type: "all",
        category: "all",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setRewards: (rewards) => set({ rewards }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedReward: (selectedReward) => set({ selectedReward }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addReward: (reward) =>
        set((state) => ({ rewards: [...state.rewards, reward] })),
      updateReward: (id, updatedReward) =>
        set((state) => ({
          rewards: state.rewards.map((r) =>
            r.id === id ? { ...r, ...updatedReward } : r
          ),
        })),
      removeReward: (id) =>
        set((state) => ({
          rewards: state.rewards.filter((r) => r.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            category: "all",
            status: "all",
          },
        }),
    }),
    { name: "rewards-store" }
  )
);
