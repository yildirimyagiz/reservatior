import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Currency {
  id: string;
  code: string;
  name: string;
  symbol: string;
  isActive: boolean;
  exchangeRate: number;
  lastUpdated: Date;
  createdAt: Date;
  updatedAt: Date;
}

export interface CurrenciesState {
  currencies: Currency[];
  loading: boolean;
  error: string | null;
  selectedCurrency: Currency | null;
  filters: {
    search: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setCurrencies: (currencies: Currency[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedCurrency: (currency: Currency | null) => void;
  setFilters: (filters: Partial<CurrenciesState["filters"]>) => void;
  setPagination: (pagination: Partial<CurrenciesState["pagination"]>) => void;
  addCurrency: (currency: Currency) => void;
  updateCurrency: (id: string, currency: Partial<Currency>) => void;
  removeCurrency: (id: string) => void;
  clearFilters: () => void;
}

export const useCurrenciesStore = create<CurrenciesState>()(
  devtools(
    (set) => ({
      currencies: [],
      loading: false,
      error: null,
      selectedCurrency: null,
      filters: {
        search: "",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setCurrencies: (currencies) => set({ currencies }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedCurrency: (selectedCurrency) => set({ selectedCurrency }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addCurrency: (currency) =>
        set((state) => ({ currencies: [...state.currencies, currency] })),
      updateCurrency: (id, updatedCurrency) =>
        set((state) => ({
          currencies: state.currencies.map((c) =>
            c.id === id ? { ...c, ...updatedCurrency } : c
          ),
        })),
      removeCurrency: (id) =>
        set((state) => ({
          currencies: state.currencies.filter((c) => c.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            isActive: "all",
          },
        }),
    }),
    { name: "currencies-store" }
  )
);
