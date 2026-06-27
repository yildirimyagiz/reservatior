import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ExchangeRate {
  id: string;
  fromCurrency: string;
  toCurrency: string;
  rate: number;
  date: Date;
  source: string;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
}

export interface ExchangeRatesState {
  exchangeRates: ExchangeRate[];
  loading: boolean;
  error: string | null;
  selectedExchangeRate: ExchangeRate | null;
  filters: {
    search: string;
    fromCurrency: string;
    toCurrency: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setExchangeRates: (exchangeRates: ExchangeRate[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedExchangeRate: (exchangeRate: ExchangeRate | null) => void;
  setFilters: (filters: Partial<ExchangeRatesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<ExchangeRatesState["pagination"]>
  ) => void;
  addExchangeRate: (exchangeRate: ExchangeRate) => void;
  updateExchangeRate: (id: string, exchangeRate: Partial<ExchangeRate>) => void;
  removeExchangeRate: (id: string) => void;
  clearFilters: () => void;
}

export const useExchangeRatesStore = create<ExchangeRatesState>()(
  devtools(
    (set) => ({
      exchangeRates: [],
      loading: false,
      error: null,
      selectedExchangeRate: null,
      filters: {
        search: "",
        fromCurrency: "all",
        toCurrency: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setExchangeRates: (exchangeRates) => set({ exchangeRates }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedExchangeRate: (selectedExchangeRate) =>
        set({ selectedExchangeRate }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addExchangeRate: (exchangeRate) =>
        set((state) => ({
          exchangeRates: [...state.exchangeRates, exchangeRate],
        })),
      updateExchangeRate: (id, updatedExchangeRate) =>
        set((state) => ({
          exchangeRates: state.exchangeRates.map((er) =>
            er.id === id ? { ...er, ...updatedExchangeRate } : er
          ),
        })),
      removeExchangeRate: (id) =>
        set((state) => ({
          exchangeRates: state.exchangeRates.filter((er) => er.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            fromCurrency: "all",
            toCurrency: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "exchange-rates-store" }
  )
);
