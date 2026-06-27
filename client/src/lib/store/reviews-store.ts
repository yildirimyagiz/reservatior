import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Review {
  id: string;
  rating: number; // 1-5
  title?: string;
  content: string;
  authorId: string;
  authorName: string;
  authorEmail?: string;
  entityType: string;
  entityId: string;
  status: "pending" | "approved" | "rejected";
  verified: boolean;
  helpful: number;
  notHelpful: number;
  response?: {
    content: string;
    respondedBy: string;
    respondedAt: Date;
  };
  metadata: Record<string, any>;
  createdAt: Date;
  updatedAt: Date;
}

export interface ReviewsState {
  reviews: Review[];
  loading: boolean;
  error: string | null;
  selectedReview: Review | null;
  filters: {
    search: string;
    rating: string;
    entityType: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setReviews: (reviews: Review[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedReview: (review: Review | null) => void;
  setFilters: (filters: Partial<ReviewsState["filters"]>) => void;
  setPagination: (pagination: Partial<ReviewsState["pagination"]>) => void;
  addReview: (review: Review) => void;
  updateReview: (id: string, review: Partial<Review>) => void;
  removeReview: (id: string) => void;
  clearFilters: () => void;
}

export const useReviewsStore = create<ReviewsState>()(
  devtools(
    (set) => ({
      reviews: [],
      loading: false,
      error: null,
      selectedReview: null,
      filters: {
        search: "",
        rating: "all",
        entityType: "all",
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
            rating: "all",
            entityType: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "reviews-store" }
  )
);
