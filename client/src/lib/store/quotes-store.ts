import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Quote {
  id: string;
  title: string;
  description?: string;
  type: string;
  status: "draft" | "sent" | "accepted" | "rejected" | "expired";
  amount: number;
  currency: string;
  validUntil: Date;
  contactId?: string;
  propertyId?: string;
  items: Array<{
    name: string;
    description?: string;
    quantity: number;
    unitPrice: number;
    totalPrice: number;
  }>;
  terms?: string;
  notes?: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface QuotesState {
  quotes: Quote[];
  loading: boolean;
  error: string | null;
  selectedQuote: Quote | null;
  filters: {
    search: string;
    type: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setQuotes: (quotes: Quote[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedQuote: (quote: Quote | null) => void;
  setFilters: (filters: Partial<QuotesState["filters"]>) => void;
  setPagination: (pagination: Partial<QuotesState["pagination"]>) => void;
  addQuote: (quote: Quote) => void;
  updateQuote: (id: string, quote: Partial<Quote>) => void;
  removeQuote: (id: string) => void;
  clearFilters: () => void;
}

export const useQuotesStore = create<QuotesState>()(
  devtools(
    (set) => ({
      quotes: [],
      loading: false,
      error: null,
      selectedQuote: null,
      filters: {
        search: "",
        type: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setQuotes: (quotes) => set({ quotes }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedQuote: (selectedQuote) => set({ selectedQuote }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addQuote: (quote) =>
        set((state) => ({ quotes: [...state.quotes, quote] })),
      updateQuote: (id, updatedQuote) =>
        set((state) => ({
          quotes: state.quotes.map((q) =>
            q.id === id ? { ...q, ...updatedQuote } : q
          ),
        })),
      removeQuote: (id) =>
        set((state) => ({
          quotes: state.quotes.filter((q) => q.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "quotes-store" }
  )
);
