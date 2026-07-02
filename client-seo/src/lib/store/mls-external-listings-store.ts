import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface MLSExternalListing {
  id: string;
  mlsConnectionId: string;
  externalId: string;
  listingId?: string;
  address: string;
  city: string;
  state: string;
  zipCode: string;
  price: number;
  bedrooms: number;
  bathrooms: number;
  squareFeet: number;
  lotSize?: number;
  yearBuilt?: number;
  propertyType: string;
  status: string;
  description?: string;
  photos: string[];
  features: string[];
  lastSyncedAt: Date;
  isActive: boolean;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface MLSExternalListingsState {
  listings: MLSExternalListing[];
  loading: boolean;
  error: string | null;
  selectedListing: MLSExternalListing | null;
  filters: {
    search: string;
    mlsConnectionId: string;
    status: string;
    propertyType: string;
    priceRange: [number, number];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setListings: (listings: MLSExternalListing[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedListing: (listing: MLSExternalListing | null) => void;
  setFilters: (filters: Partial<MLSExternalListingsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<MLSExternalListingsState["pagination"]>
  ) => void;
  addListing: (listing: MLSExternalListing) => void;
  updateListing: (id: string, listing: Partial<MLSExternalListing>) => void;
  removeListing: (id: string) => void;
  clearFilters: () => void;
}

export const useMLSExternalListingsStore = create<MLSExternalListingsState>()(
  devtools(
    (set) => ({
      listings: [],
      loading: false,
      error: null,
      selectedListing: null,
      filters: {
        search: "",
        mlsConnectionId: "all",
        status: "all",
        propertyType: "all",
        priceRange: [0, 10000000],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setListings: (listings) => set({ listings }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedListing: (selectedListing) => set({ selectedListing }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addListing: (listing) =>
        set((state) => ({ listings: [...state.listings, listing] })),
      updateListing: (id, updatedListing) =>
        set((state) => ({
          listings: state.listings.map((l) =>
            l.id === id ? { ...l, ...updatedListing } : l
          ),
        })),
      removeListing: (id) =>
        set((state) => ({
          listings: state.listings.filter((l) => l.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            mlsConnectionId: "all",
            status: "all",
            propertyType: "all",
            priceRange: [0, 10000000],
          },
        }),
    }),
    { name: "mls-external-listings-store" }
  )
);
