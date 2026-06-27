import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Tag {
  id: string;
  name: string;
  color?: string;
  description?: string;
  organizationId: string;
  usageCount: number;
  createdAt: Date;
  updatedAt: Date;
}

export interface TagState {
  tags: Tag[];
  loading: boolean;
  error: string | null;
  selectedTag: Tag | null;
  filters: {
    search: string;
    organizationId: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTags: (tags: Tag[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedTag: (tag: Tag | null) => void;
  setFilters: (filters: Partial<TagState["filters"]>) => void;
  setPagination: (pagination: Partial<TagState["pagination"]>) => void;
  addTag: (tag: Tag) => void;
  updateTag: (id: string, tag: Partial<Tag>) => void;
  removeTag: (id: string) => void;
  clearFilters: () => void;
}

export const useTagsStore = create<TagState>()(
  devtools(
    (set) => ({
      tags: [],
      loading: false,
      error: null,
      selectedTag: null,
      filters: {
        search: "",
        organizationId: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setTags: (tags) => set({ tags }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedTag: (selectedTag) => set({ selectedTag }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addTag: (tag) => set((state) => ({ tags: [...state.tags, tag] })),
      updateTag: (id, updatedTag) =>
        set((state) => ({
          tags: state.tags.map((t) =>
            t.id === id ? { ...t, ...updatedTag } : t
          ),
        })),
      removeTag: (id) =>
        set((state) => ({
          tags: state.tags.filter((t) => t.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            organizationId: "all",
          },
        }),
    }),
    { name: "tags-store" }
  )
);
