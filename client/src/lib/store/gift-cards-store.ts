import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface GiftCard {
  id: string;
  code: string;
  amount: number;
  currency: string;
  balance: number;
  status: "active" | "used" | "expired" | "cancelled";
  issuedTo?: string;
  issuedBy: string;
  issuedAt: Date;
  expiresAt?: Date;
  usedAt?: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface GiftCardsState {
  giftCards: GiftCard[];
  loading: boolean;
  error: string | null;
  selectedGiftCard: GiftCard | null;
  filters: {
    search: string;
    status: string;
    issuedTo: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setGiftCards: (giftCards: GiftCard[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedGiftCard: (giftCard: GiftCard | null) => void;
  setFilters: (filters: Partial<GiftCardsState["filters"]>) => void;
  setPagination: (pagination: Partial<GiftCardsState["pagination"]>) => void;
  addGiftCard: (giftCard: GiftCard) => void;
  updateGiftCard: (id: string, giftCard: Partial<GiftCard>) => void;
  removeGiftCard: (id: string) => void;
  clearFilters: () => void;
}

export const useGiftCardsStore = create<GiftCardsState>()(
  devtools(
    (set) => ({
      giftCards: [],
      loading: false,
      error: null,
      selectedGiftCard: null,
      filters: {
        search: "",
        status: "all",
        issuedTo: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setGiftCards: (giftCards) => set({ giftCards }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedGiftCard: (selectedGiftCard) => set({ selectedGiftCard }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addGiftCard: (giftCard) =>
        set((state) => ({ giftCards: [...state.giftCards, giftCard] })),
      updateGiftCard: (id, updatedGiftCard) =>
        set((state) => ({
          giftCards: state.giftCards.map((gc) =>
            gc.id === id ? { ...gc, ...updatedGiftCard } : gc
          ),
        })),
      removeGiftCard: (id) =>
        set((state) => ({
          giftCards: state.giftCards.filter((gc) => gc.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            status: "all",
            issuedTo: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "gift-cards-store" }
  )
);
