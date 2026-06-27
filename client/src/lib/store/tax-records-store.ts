import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface TaxRecord {
  id: string;
  type: string;
  category: string;
  year: number;
  amount: number;
  currency: string;
  status: "draft" | "filed" | "accepted" | "rejected" | "amended";
  dueDate: Date;
  filedDate?: Date;
  propertyId?: string;
  organizationId: string;
  documents: string[];
  notes?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface TaxRecordsState {
  taxRecords: TaxRecord[];
  loading: boolean;
  error: string | null;
  selectedTaxRecord: TaxRecord | null;
  filters: {
    search: string;
    type: string;
    category: string;
    year: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTaxRecords: (taxRecords: TaxRecord[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedTaxRecord: (taxRecord: TaxRecord | null) => void;
  setFilters: (filters: Partial<TaxRecordsState["filters"]>) => void;
  setPagination: (pagination: Partial<TaxRecordsState["pagination"]>) => void;
  addTaxRecord: (taxRecord: TaxRecord) => void;
  updateTaxRecord: (id: string, taxRecord: Partial<TaxRecord>) => void;
  removeTaxRecord: (id: string) => void;
  clearFilters: () => void;
}

export const useTaxRecordsStore = create<TaxRecordsState>()(
  devtools(
    (set) => ({
      taxRecords: [],
      loading: false,
      error: null,
      selectedTaxRecord: null,
      filters: {
        search: "",
        type: "all",
        category: "all",
        year: "all",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setTaxRecords: (taxRecords) => set({ taxRecords }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedTaxRecord: (selectedTaxRecord) => set({ selectedTaxRecord }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addTaxRecord: (taxRecord) =>
        set((state) => ({ taxRecords: [...state.taxRecords, taxRecord] })),
      updateTaxRecord: (id, updatedTaxRecord) =>
        set((state) => ({
          taxRecords: state.taxRecords.map((tr) =>
            tr.id === id ? { ...tr, ...updatedTaxRecord } : tr
          ),
        })),
      removeTaxRecord: (id) =>
        set((state) => ({
          taxRecords: state.taxRecords.filter((tr) => tr.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            category: "all",
            year: "all",
            status: "all",
          },
        }),
    }),
    { name: "tax-records-store" }
  )
);
