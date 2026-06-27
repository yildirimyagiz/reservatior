import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface Tax1099Form {
  id: string;
  recipientId: string;
  recipientName: string;
  recipientTaxId: string;
  formType: string;
  taxYear: number;
  payerId: string;
  payerName: string;
  payerTaxId: string;
  amounts: {
    nonemployeeCompensation?: number;
    rents?: number;
    royalties?: number;
    otherIncome?: number;
    federalIncomeTaxWithheld?: number;
  };
  status: "draft" | "submitted" | "accepted" | "rejected" | "corrected";
  submissionDate?: Date;
  acceptanceDate?: Date;
  rejectionReason?: string;
  correctedFormId?: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface Tax1099FormsState {
  forms: Tax1099Form[];
  loading: boolean;
  error: string | null;
  selectedForm: Tax1099Form | null;
  filters: {
    search: string;
    recipientId: string;
    formType: string;
    taxYear: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setForms: (forms: Tax1099Form[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedForm: (form: Tax1099Form | null) => void;
  setFilters: (filters: Partial<Tax1099FormsState["filters"]>) => void;
  setPagination: (pagination: Partial<Tax1099FormsState["pagination"]>) => void;
  addForm: (form: Tax1099Form) => void;
  updateForm: (id: string, form: Partial<Tax1099Form>) => void;
  removeForm: (id: string) => void;
  clearFilters: () => void;
}

export const useTax1099FormsStore = create<Tax1099FormsState>()(
  devtools(
    (set) => ({
      forms: [],
      loading: false,
      error: null,
      selectedForm: null,
      filters: {
        search: "",
        recipientId: "all",
        formType: "all",
        taxYear: "all",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setForms: (forms) => set({ forms }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedForm: (selectedForm) => set({ selectedForm }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addForm: (form) => set((state) => ({ forms: [...state.forms, form] })),
      updateForm: (id, updatedForm) =>
        set((state) => ({
          forms: state.forms.map((f) =>
            f.id === id ? { ...f, ...updatedForm } : f
          ),
        })),
      removeForm: (id) =>
        set((state) => ({
          forms: state.forms.filter((f) => f.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            recipientId: "all",
            formType: "all",
            taxYear: "all",
            status: "all",
          },
        }),
    }),
    { name: "tax-1099-forms-store" }
  )
);
