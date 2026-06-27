import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ListingTag {
  id: string;
  listingId: string;
  tagId: string;
  createdAt: Date;
}

export interface ListingTagsState {
  listingTags: ListingTag[];
  loading: boolean;
  error: string | null;
  selectedListingTag: ListingTag | null;
  filters: {
    search: string;
    listingId: string;
    tagId: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setListingTags: (listingTags: ListingTag[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedListingTag: (listingTag: ListingTag | null) => void;
  setFilters: (filters: Partial<ListingTagsState["filters"]>) => void;
  setPagination: (pagination: Partial<ListingTagsState["pagination"]>) => void;
  addListingTag: (listingTag: ListingTag) => void;
  updateListingTag: (id: string, listingTag: Partial<ListingTag>) => void;
  removeListingTag: (id: string) => void;
  clearFilters: () => void;
}

export const useListingTagsStore = create<ListingTagsState>()(
  devtools(
    (set) => ({
      listingTags: [],
      loading: false,
      error: null,
      selectedListingTag: null,
      filters: {
        search: "",
        listingId: "all",
        tagId: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setListingTags: (listingTags) => set({ listingTags }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedListingTag: (selectedListingTag) =>
        set({ selectedListingTag }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addListingTag: (listingTag) =>
        set((state) => ({ listingTags: [...state.listingTags, listingTag] })),
      updateListingTag: (id, updatedListingTag) =>
        set((state) => ({
          listingTags: state.listingTags.map((lt) =>
            lt.id === id ? { ...lt, ...updatedListingTag } : lt
          ),
        })),
      removeListingTag: (id) =>
        set((state) => ({
          listingTags: state.listingTags.filter((lt) => lt.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            listingId: "all",
            tagId: "all",
          },
        }),
    }),
    { name: "listing-tags-store" }
  )
);
