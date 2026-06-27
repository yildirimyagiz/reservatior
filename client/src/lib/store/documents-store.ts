import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Document {
  id: string;
  title: string;
  type: string;
  category: string;
  size: number;
  url: string;
  mimeType: string;
  uploadedBy: string;
  organizationId: string;
  propertyId?: string;
  contractId?: string;
  tags: string[];
  createdAt: Date;
  updatedAt: Date;
}

export interface DocumentState {
  documents: Document[];
  loading: boolean;
  error: string | null;
  selectedDocument: Document | null;
  filters: {
    search: string;
    type: string;
    category: string;
    propertyId: string;
    contractId: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setDocuments: (documents: Document[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedDocument: (document: Document | null) => void;
  setFilters: (filters: Partial<DocumentState["filters"]>) => void;
  setPagination: (pagination: Partial<DocumentState["pagination"]>) => void;
  addDocument: (document: Document) => void;
  updateDocument: (id: string, document: Partial<Document>) => void;
  removeDocument: (id: string) => void;
  clearFilters: () => void;
}

export const useDocumentsStore = create<DocumentState>()(
  devtools(
    (set) => ({
      documents: [],
      loading: false,
      error: null,
      selectedDocument: null,
      filters: {
        search: "",
        type: "all",
        category: "all",
        propertyId: "all",
        contractId: "all",
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
            type: "all",
            category: "all",
            propertyId: "all",
            contractId: "all",
          },
        }),
    }),
    { name: "documents-store" }
  )
);
