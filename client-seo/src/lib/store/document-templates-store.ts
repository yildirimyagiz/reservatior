import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface DocumentTemplate {
  id: string;
  name: string;
  description?: string;
  type: string;
  category: string;
  content: string;
  variables: Array<{
    name: string;
    type: string;
    required: boolean;
    defaultValue?: string;
  }>;
  isActive: boolean;
  organizationId: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface DocumentTemplatesState {
  templates: DocumentTemplate[];
  loading: boolean;
  error: string | null;
  selectedTemplate: DocumentTemplate | null;
  filters: {
    search: string;
    type: string;
    category: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setTemplates: (templates: DocumentTemplate[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedTemplate: (template: DocumentTemplate | null) => void;
  setFilters: (filters: Partial<DocumentTemplatesState["filters"]>) => void;
  setPagination: (
    pagination: Partial<DocumentTemplatesState["pagination"]>
  ) => void;
  addTemplate: (template: DocumentTemplate) => void;
  updateTemplate: (id: string, template: Partial<DocumentTemplate>) => void;
  removeTemplate: (id: string) => void;
  clearFilters: () => void;
}

export const useDocumentTemplatesStore = create<DocumentTemplatesState>()(
  devtools(
    (set) => ({
      templates: [],
      loading: false,
      error: null,
      selectedTemplate: null,
      filters: {
        search: "",
        type: "all",
        category: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setTemplates: (templates) => set({ templates }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedTemplate: (selectedTemplate) => set({ selectedTemplate }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addTemplate: (template) =>
        set((state) => ({ templates: [...state.templates, template] })),
      updateTemplate: (id, updatedTemplate) =>
        set((state) => ({
          templates: state.templates.map((t) =>
            t.id === id ? { ...t, ...updatedTemplate } : t
          ),
        })),
      removeTemplate: (id) =>
        set((state) => ({
          templates: state.templates.filter((t) => t.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            type: "all",
            category: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "document-templates-store" }
  )
);
