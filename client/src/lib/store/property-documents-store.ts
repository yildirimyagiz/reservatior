import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface PropertyDocument {
  id: string;
  propertyId: string;
  title: string;
  type: string;
  category: string;
  url: string;
  size: number;
  mimeType: string;
  isPublic: boolean;
  uploadedBy: string;
  tags: string[];
  expiresAt?: Date;
  createdAt: Date;
  updatedAt: Date;
}

export interface PropertyDocumentsState {
  documents: PropertyDocument[];
  loading: boolean;
  error: string | null;
  selectedDocument: PropertyDocument | null;
  filters: {
    search: string;
    propertyId: string;
    type: string;
    category: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setDocuments: (documents: PropertyDocument[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedDocument: (document: PropertyDocument | null) => void;
  setFilters: (filters: Partial<PropertyDocumentsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<PropertyDocumentsState["pagination"]>
  ) => void;
  addDocument: (document: PropertyDocument) => void;
  updateDocument: (id: string, document: Partial<PropertyDocument>) => void;
  removeDocument: (id: string) => void;
  clearFilters: () => void;
}

export const usePropertyDocumentsStore = create<PropertyDocumentsState>()(
  devtools(
    (set) => ({
      documents: [],
      loading: false,
      error: null,
      selectedDocument: null,
      filters: {
        search: "",
        propertyId: "all",
        type: "all",
        category: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setDocuments: (documents) => set({ documents }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedDocument: (selectedDocument) => set({ selectedDocument }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addDocument: (document) =>
        set((state) => ({ documents: [...state.documents, document] })),
      updateDocument: (id, updatedDocument) =>
        set((state) => ({
          documents: state.documents.map((d) =>
            d.id === id ? { ...d, ...updatedDocument } : d
          ),
        })),
      removeDocument: (id) =>
        set((state) => ({
          documents: state.documents.filter((d) => d.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyId: "all",
            type: "all",
            category: "all",
          },
        }),
    }),
    { name: "property-documents-store" }
  )
);
