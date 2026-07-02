import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AIFraudDetection {
  id: string;
  entityType: string;
  entityId: string;
  modelId: string;
  modelVersion: string;
  riskScore: number; // 0-100
  riskLevel: "low" | "medium" | "high" | "critical";
  confidence: number; // 0-1
  indicators: Array<{
    name: string;
    value: any;
    risk: number;
    description: string;
  }>;
  patterns: Array<{
    name: string;
    severity: number;
    description: string;
    evidence: string[];
  }>;
  recommendations: string[];
  status:
    | "pending"
    | "reviewing"
    | "confirmed"
    | "false_positive"
    | "dismissed";
  reviewedBy?: string;
  reviewedAt?: Date;
  notes?: string;
  detectedAt: Date;
  expiresAt: Date;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface AIFraudDetectionState {
  detections: AIFraudDetection[];
  loading: boolean;
  error: string | null;
  selectedDetection: AIFraudDetection | null;
  filters: {
    search: string;
    entityType: string;
    modelId: string;
    riskLevel: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setDetections: (detections: AIFraudDetection[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedDetection: (detection: AIFraudDetection | null) => void;
  setFilters: (filters: Partial<AIFraudDetectionState["filters"]>) => void;
  setPagination: (
    pagination: Partial<AIFraudDetectionState["pagination"]>
  ) => void;
  addDetection: (detection: AIFraudDetection) => void;
  updateDetection: (id: string, detection: Partial<AIFraudDetection>) => void;
  removeDetection: (id: string) => void;
  clearFilters: () => void;
}

export const useAIFraudDetectionStore = create<AIFraudDetectionState>()(
  devtools(
    (set) => ({
      detections: [],
      loading: false,
      error: null,
      selectedDetection: null,
      filters: {
        search: "",
        entityType: "all",
        modelId: "all",
        riskLevel: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setDetections: (detections) => set({ detections }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedDetection: (selectedDetection) => set({ selectedDetection }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addDetection: (detection) =>
        set((state) => ({ detections: [...state.detections, detection] })),
      updateDetection: (id, updatedDetection) =>
        set((state) => ({
          detections: state.detections.map((d) =>
            d.id === id ? { ...d, ...updatedDetection } : d
          ),
        })),
      removeDetection: (id) =>
        set((state) => ({
          detections: state.detections.filter((d) => d.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            entityType: "all",
            modelId: "all",
            riskLevel: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "ai-fraud-detection-store" }
  )
);
