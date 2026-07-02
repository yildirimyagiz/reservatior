import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface PropertyOffer {
  id: string;
  propertyId: string;
  buyerId: string;
  agentId?: string;
  amount: number;
  currency: string;
  status: "pending" | "accepted" | "rejected" | "withdrawn" | "countered";
  offerType: "purchase" | "rental";
  terms: {
    financingType: string;
    contingencyPeriod: number; // days
    closingDate?: Date;
    earnestMoney?: number;
  };
  notes?: string;
  documents: string[];
  submittedAt: Date;
  respondedAt?: Date;
  createdAt: Date;
  updatedAt: Date;
}

export interface PropertyOffersState {
  offers: PropertyOffer[];
  loading: boolean;
  error: string | null;
  selectedOffer: PropertyOffer | null;
  filters: {
    search: string;
    propertyId: string;
    status: string;
    offerType: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setOffers: (offers: PropertyOffer[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedOffer: (offer: PropertyOffer | null) => void;
  setFilters: (filters: Partial<PropertyOffersState["filters"]>) => void;
  setPagination: (
    pagination: Partial<PropertyOffersState["pagination"]>
  ) => void;
  addOffer: (offer: PropertyOffer) => void;
  updateOffer: (id: string, offer: Partial<PropertyOffer>) => void;
  removeOffer: (id: string) => void;
  clearFilters: () => void;
}

export const usePropertyOffersStore = create<PropertyOffersState>()(
  devtools(
    (set) => ({
      offers: [],
      loading: false,
      error: null,
      selectedOffer: null,
      filters: {
        search: "",
        propertyId: "all",
        status: "all",
        offerType: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setOffers: (offers) => set({ offers }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedOffer: (selectedOffer) => set({ selectedOffer }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addOffer: (offer) =>
        set((state) => ({ offers: [...state.offers, offer] })),
      updateOffer: (id, updatedOffer) =>
        set((state) => ({
          offers: state.offers.map((o) =>
            o.id === id ? { ...o, ...updatedOffer } : o
          ),
        })),
      removeOffer: (id) =>
        set((state) => ({
          offers: state.offers.filter((o) => o.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyId: "all",
            status: "all",
            offerType: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "property-offers-store" }
  )
);
