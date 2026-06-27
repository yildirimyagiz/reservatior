import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Listing {
  id: string;
  propertyId: string;
  title: string;
  description: string;
  price: number;
  currency: string;
  status: "active" | "inactive" | "sold" | "rented";
  listingType: "sale" | "rent" | "lease";
  bedrooms?: number;
  bathrooms?: number;
  area?: number;
  address: string;
  city: string;
  state: string;
  zipCode: string;
  photos: string[];
  features: string[];
  createdAt: Date;
  updatedAt: Date;
}

export interface ListingState {
  listings: Listing[];
  loading: boolean;
  error: string | null;
  selectedListing: Listing | null;
  filters: {
    search: string;
    status: string;
    listingType: string;
    priceRange: [number, number];
    city: string;
    bedrooms: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setListings: (listings: Listing[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedListing: (listing: Listing | null) => void;
  setFilters: (filters: Partial<ListingState["filters"]>) => void;
  setPagination: (pagination: Partial<ListingState["pagination"]>) => void;
  addListing: (listing: Listing) => void;
  updateListing: (id: string, listing: Partial<Listing>) => void;
  removeListing: (id: string) => void;
  clearFilters: () => void;
}

export const useListingsStore = create<ListingState>()(
  devtools(
    (set) => ({
      listings: [],
      loading: false,
      error: null,
      selectedListing: null,
      filters: {
        search: "",
        status: "all",
        listingType: "all",
        priceRange: [0, 1000000],
        city: "all",
        bedrooms: "all",
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
            status: "all",
            listingType: "all",
            priceRange: [0, 1000000],
            city: "all",
            bedrooms: "all",
          },
        }),
    }),
    { name: "listings-store" }
  )
);
