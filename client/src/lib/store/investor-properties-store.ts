import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface InvestorProperty {
  id: string;
  portfolioId: string;
  propertyId: string;
  investorId: string;
  investmentAmount: number;
  currency: string;
  ownershipPercentage: number;
  purchaseDate: Date;
  currentValue?: number;
  expectedReturn: number;
  status: "active" | "sold" | "transferred";
  documents: string[];
  notes?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface InvestorPropertiesState {
  investorProperties: InvestorProperty[];
  loading: boolean;
  error: string | null;
  selectedInvestorProperty: InvestorProperty | null;
  filters: {
    search: string;
    portfolioId: string;
    investorId: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setInvestorProperties: (investorProperties: InvestorProperty[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedInvestorProperty: (
    investorProperty: InvestorProperty | null
  ) => void;
  setFilters: (filters: Partial<InvestorPropertiesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<InvestorPropertiesState["pagination"]>
  ) => void;
  addInvestorProperty: (investorProperty: InvestorProperty) => void;
  updateInvestorProperty: (
    id: string,
    investorProperty: Partial<InvestorProperty>
  ) => void;
  removeInvestorProperty: (id: string) => void;
  clearFilters: () => void;
}

export const useInvestorPropertiesStore = create<InvestorPropertiesState>()(
  devtools(
    (set) => ({
      investorProperties: [],
      loading: false,
      error: null,
      selectedInvestorProperty: null,
      filters: {
        search: "",
        portfolioId: "all",
        investorId: "all",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setInvestorProperties: (investorProperties) =>
        set({ investorProperties }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedInvestorProperty: (selectedInvestorProperty) =>
        set({ selectedInvestorProperty }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addInvestorProperty: (investorProperty) =>
        set((state) => ({
          investorProperties: [...state.investorProperties, investorProperty],
        })),
      updateInvestorProperty: (id, updatedInvestorProperty) =>
        set((state) => ({
          investorProperties: state.investorProperties.map((ip) =>
            ip.id === id ? { ...ip, ...updatedInvestorProperty } : ip
          ),
        })),
      removeInvestorProperty: (id) =>
        set((state) => ({
          investorProperties: state.investorProperties.filter(
            (ip) => ip.id !== id
          ),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            portfolioId: "all",
            investorId: "all",
            status: "all",
          },
        }),
    }),
    { name: "investor-properties-store" }
  )
);
