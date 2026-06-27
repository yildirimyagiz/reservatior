import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface GuestReview {
  id: string;
  guestId: string;
  bookingId: string;
  propertyId: string;
  rating: number; // 1-5
  title?: string;
  content: string;
  aspects: {
    cleanliness: number;
    communication: number;
    checkIn: number;
    accuracy: number;
    location: number;
    value: number;
  };
  photos: string[];
  response?: {
    content: string;
    respondedBy: string;
    respondedAt: Date;
  };
  status: "pending" | "published" | "hidden";
  helpful: number;
  notHelpful: number;
  verified: boolean;
  createdAt: Date;
  updatedAt: Date;
}

export interface GuestReviewsState {
  reviews: GuestReview[];
  loading: boolean;
  error: string | null;
  selectedReview: GuestReview | null;
  filters: {
    search: string;
    guestId: string;
    propertyId: string;
    rating: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setReviews: (reviews: GuestReview[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedReview: (review: GuestReview | null) => void;
  setFilters: (filters: Partial<GuestReviewsState["filters"]>) => void;
  setPagination: (pagination: Partial<GuestReviewsState["pagination"]>) => void;
  addReview: (review: GuestReview) => void;
  updateReview: (id: string, review: Partial<GuestReview>) => void;
  removeReview: (id: string) => void;
  clearFilters: () => void;
}

export const useGuestReviewsStore = create<GuestReviewsState>()(
  devtools(
    (set) => ({
      reviews: [],
      loading: false,
      error: null,
      selectedReview: null,
      filters: {
        search: "",
        guestId: "all",
        propertyId: "all",
        rating: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setReviews: (reviews) => set({ reviews }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedReview: (selectedReview) => set({ selectedReview }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addReview: (review) =>
        set((state) => ({ reviews: [...state.reviews, review] })),
      updateReview: (id, updatedReview) =>
        set((state) => ({
          reviews: state.reviews.map((r) =>
            r.id === id ? { ...r, ...updatedReview } : r
          ),
        })),
      removeReview: (id) =>
        set((state) => ({
          reviews: state.reviews.filter((r) => r.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            guestId: "all",
            propertyId: "all",
            rating: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "guest-reviews-store" }
  )
);
