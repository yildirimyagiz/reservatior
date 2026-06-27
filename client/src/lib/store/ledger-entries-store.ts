import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface LedgerEntry {
  id: string;
  accountId: string;
  amount: number;
  currency: string;
  debit: boolean;
  credit: boolean;
  description: string;
  reference?: string;
  transactionDate: Date;
  postedDate: Date;
  balance: number;
  category: string;
  tags: string[];
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface LedgerEntriesState {
  entries: LedgerEntry[];
  loading: boolean;
  error: string | null;
  selectedEntry: LedgerEntry | null;
  filters: {
    search: string;
    accountId: string;
    category: string;
    debitCredit: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setEntries: (entries: LedgerEntry[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedEntry: (entry: LedgerEntry | null) => void;
  setFilters: (filters: Partial<LedgerEntriesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<LedgerEntriesState["pagination"]>
  ) => void;
  addEntry: (entry: LedgerEntry) => void;
  updateEntry: (id: string, entry: Partial<LedgerEntry>) => void;
  removeEntry: (id: string) => void;
  clearFilters: () => void;
}

export const useLedgerEntriesStore = create<LedgerEntriesState>()(
  devtools(
    (set) => ({
      entries: [],
      loading: false,
      error: null,
      selectedEntry: null,
      filters: {
        search: "",
        accountId: "all",
        category: "all",
        debitCredit: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 50,
        total: 0,
      },
      setEntries: (entries) => set({ entries }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedEntry: (selectedEntry) => set({ selectedEntry }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addEntry: (entry) =>
        set((state) => ({ entries: [...state.entries, entry] })),
      updateEntry: (id, updatedEntry) =>
        set((state) => ({
          entries: state.entries.map((e) =>
            e.id === id ? { ...e, ...updatedEntry } : e
          ),
        })),
      removeEntry: (id) =>
        set((state) => ({
          entries: state.entries.filter((e) => e.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            accountId: "all",
            category: "all",
            debitCredit: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "ledger-entries-store" }
  )
);
