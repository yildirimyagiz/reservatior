import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface PropertyPhoto {
  id: string;
  propertyId: string;
  url: string;
  caption?: string;
  order: number;
  isPrimary: boolean;
  tags: string[];
  uploadedBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface PropertyPhotosState {
  photos: PropertyPhoto[];
  loading: boolean;
  error: string | null;
  selectedPhoto: PropertyPhoto | null;
  filters: {
    search: string;
    propertyId: string;
    isPrimary: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setPhotos: (photos: PropertyPhoto[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedPhoto: (photo: PropertyPhoto | null) => void;
  setFilters: (filters: Partial<PropertyPhotosState["filters"]>) => void;
  setPagination: (
    pagination: Partial<PropertyPhotosState["pagination"]>
  ) => void;
  addPhoto: (photo: PropertyPhoto) => void;
  updatePhoto: (id: string, photo: Partial<PropertyPhoto>) => void;
  removePhoto: (id: string) => void;
  clearFilters: () => void;
}

export const usePropertyPhotosStore = create<PropertyPhotosState>()(
  devtools(
    (set) => ({
      photos: [],
      loading: false,
      error: null,
      selectedPhoto: null,
      filters: {
        search: "",
        propertyId: "all",
        isPrimary: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setPhotos: (photos) => set({ photos }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedPhoto: (selectedPhoto) => set({ selectedPhoto }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addPhoto: (photo) =>
        set((state) => ({ photos: [...state.photos, photo] })),
      updatePhoto: (id, updatedPhoto) =>
        set((state) => ({
          photos: state.photos.map((p) =>
            p.id === id ? { ...p, ...updatedPhoto } : p
          ),
        })),
      removePhoto: (id) =>
        set((state) => ({
          photos: state.photos.filter((p) => p.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyId: "all",
            isPrimary: "all",
          },
        }),
    }),
    { name: "property-photos-store" }
  )
);
