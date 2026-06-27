import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface PropertyCompliance {
  id: string;
  propertyId: string;
  type: string;
  status: "compliant" | "non_compliant" | "pending_review" | "exempt";
  lastInspectionDate?: Date;
  nextInspectionDate?: Date;
  inspectorId?: string;
  notes?: string;
  documents: string[];
  violations: Array<{
    type: string;
    severity: "low" | "medium" | "high" | "critical";
    description: string;
    dueDate?: Date;
  }>;
  createdAt: Date;
  updatedAt: Date;
}

export interface PropertyComplianceState {
  complianceRecords: PropertyCompliance[];
  loading: boolean;
  error: string | null;
  selectedCompliance: PropertyCompliance | null;
  filters: {
    search: string;
    propertyId: string;
    type: string;
    status: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setComplianceRecords: (complianceRecords: PropertyCompliance[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedCompliance: (compliance: PropertyCompliance | null) => void;
  setFilters: (filters: Partial<PropertyComplianceState["filters"]>) => void;
  setPagination: (
    pagination: Partial<PropertyComplianceState["pagination"]>
  ) => void;
  addComplianceRecord: (compliance: PropertyCompliance) => void;
  updateComplianceRecord: (
    id: string,
    compliance: Partial<PropertyCompliance>
  ) => void;
  removeComplianceRecord: (id: string) => void;
  clearFilters: () => void;
}

export const usePropertyComplianceStore = create<PropertyComplianceState>()(
  devtools(
    (set) => ({
      complianceRecords: [],
      loading: false,
      error: null,
      selectedCompliance: null,
      filters: {
        search: "",
        propertyId: "all",
        type: "all",
        status: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setComplianceRecords: (complianceRecords) => set({ complianceRecords }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedCompliance: (selectedCompliance) =>
        set({ selectedCompliance }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addComplianceRecord: (compliance) =>
        set((state) => ({
          complianceRecords: [...state.complianceRecords, compliance],
        })),
      updateComplianceRecord: (id, updatedCompliance) =>
        set((state) => ({
          complianceRecords: state.complianceRecords.map((c) =>
            c.id === id ? { ...c, ...updatedCompliance } : c
          ),
        })),
      removeComplianceRecord: (id) =>
        set((state) => ({
          complianceRecords: state.complianceRecords.filter((c) => c.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            propertyId: "all",
            type: "all",
            status: "all",
          },
        }),
    }),
    { name: "property-compliance-store" }
  )
);
