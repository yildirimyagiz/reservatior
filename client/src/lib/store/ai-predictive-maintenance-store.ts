import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AIPredictiveMaintenance {
  id: string;
  propertyId: string;
  equipmentId?: string;
  modelId: string;
  modelVersion: string;
  maintenanceType: string;
  priority: "low" | "medium" | "high" | "urgent";
  predictedDate: Date;
  confidence: number; // 0-1
  factors: Array<{
    name: string;
    value: any;
    impact: number;
    description: string;
  }>;
  recommendations: Array<{
    action: string;
    urgency: string;
    estimatedCost?: number;
    description: string;
  }>;
  status: "pending" | "scheduled" | "completed" | "cancelled";
  scheduledDate?: Date;
  completedDate?: Date;
  actualCost?: number;
  notes?: string;
  detectedAt: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AIPredictiveMaintenanceState {
  predictions: AIPredictiveMaintenance[];
  loading: boolean;
  error: string | null;
  selectedPrediction: AIPredictiveMaintenance | null;
  filters: {
    search: string;
    propertyId: string;
    maintenanceType: string;
    priority: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setPredictions: (predictions: AIPredictiveMaintenance[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedPrediction: (prediction: AIPredictiveMaintenance | null) => void;
  setFilters: (
    filters: Partial<AIPredictiveMaintenanceState["filters"]>
  ) => void;
  setPagination: (
    pagination: Partial<AIPredictiveMaintenanceState["pagination"]>
  ) => void;
  addPrediction: (prediction: AIPredictiveMaintenance) => void;
  updatePrediction: (
    id: string,
    prediction: Partial<AIPredictiveMaintenance>
  ) => void;
  removePrediction: (id: string) => void;
  clearFilters: () => void;
}

export const useAIPredictiveMaintenanceStore =
  create<AIPredictiveMaintenanceState>()(
    devtools(
      (set) => ({
        predictions: [],
        loading: false,
        error: null,
        selectedPrediction: null,
        filters: {
          search: "",
          propertyId: "all",
          maintenanceType: "all",
          priority: "all",
          status: "all",
          dateRange: [null, null],
        },
        pagination: {
          page: 1,
          limit: 20,
          total: 0,
        },
        setPredictions: (predictions) => set({ predictions }),
        setLoading: (loading) => set({ loading }),
        setError: (error) => set({ error }),
        setSelectedPrediction: (selectedPrediction) =>
          set({ selectedPrediction }),
        setFilters: (filters) =>
          set((state) => ({ filters: { ...state.filters, ...filters } })),
        setPagination: (pagination) =>
          set((state) => ({
            pagination: { ...state.pagination, ...pagination },
          })),
        addPrediction: (prediction) =>
          set((state) => ({ predictions: [...state.predictions, prediction] })),
        updatePrediction: (id, updatedPrediction) =>
          set((state) => ({
            predictions: state.predictions.map((p) =>
              p.id === id ? { ...p, ...updatedPrediction } : p
            ),
          })),
        removePrediction: (id) =>
          set((state) => ({
            predictions: state.predictions.filter((p) => p.id !== id),
          })),
        clearFilters: () =>
          set({
            filters: {
              search: "",
              propertyId: "all",
              maintenanceType: "all",
              priority: "all",
              status: "all",
              dateRange: [null, null],
            },
          }),
      }),
      { name: "ai-predictive-maintenance-store" }
    )
  );
