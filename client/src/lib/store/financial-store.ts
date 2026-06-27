import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface FinancialRecord {
  id: string;
  organizationId: string;
  type: "income" | "expense" | "transfer";
  category: string;
  amount: number;
  currency: string;
  description: string;
  date: Date;
  propertyId?: string;
  leaseId?: string;
  dealId?: string;
  tags: string[];
  attachments: string[];
  createdAt: Date;
  updatedAt: Date;
}

export interface FinancialState {
  records: FinancialRecord[];
  loading: boolean;
  error: string | null;
  selectedRecord: FinancialRecord | null;
  filters: {
    search: string;
    type: string;
    category: string;
    dateRange: [Date | null, Date | null];
    propertyId: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setRecords: (records: FinancialRecord[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedRecord: (record: FinancialRecord | null) => void;
  setFilters: (filters: Partial<FinancialState["filters"]>) => void;
  setPagination: (pagination: Partial<FinancialState["pagination"]>) => void;
  addRecord: (record: FinancialRecord) => void;
  updateRecord: (id: string, record: Partial<FinancialRecord>) => void;
  removeRecord: (id: string) => void;
  clearFilters: () => void;
}

export const useFinancialStore = create<FinancialState>()(
  devtools(
    (set) => ({
      records: [],
      loading: false,
      error: null,
      selectedRecord: null,
      filters: {
        search: "",
        type: "all",
        category: "all",
        dateRange: [null, null],
        propertyId: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setRecords: (records) => set({ records }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedRecord: (selectedRecord) => set({ selectedRecord }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addRecord: (record) =>
        set((state) => ({ records: [...state.records, record] })),
      updateRecord: (id, updatedRecord) =>
        set((state) => ({
          records: state.records.map((r) =>
            r.id === id ? { ...r, ...updatedRecord } : r
          ),
        })),
      removeRecord: (id) =>
        set((state) => ({
          records: state.records.filter((r) => r.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            category: "all",
            dateRange: [null, null],
            propertyId: "all",
          },
        }),
    }),
    { name: "financial-store" }
  )
);
