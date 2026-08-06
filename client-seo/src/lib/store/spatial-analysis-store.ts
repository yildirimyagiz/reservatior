import { create } from 'zustand';
import { devtools } from 'zustand/middleware';
import type { SpatialAnalysisResult, PropertyHealthReport, InsuranceRiskProfile } from '@/types/spatial-analysis';

export interface SpatialAnalysisState {
  analyses: SpatialAnalysisResult[];
  healthReports: PropertyHealthReport[];
  insuranceProfiles: Record<string, InsuranceRiskProfile>;
  activeAnalysisId: string | null;
  uploadQueue: { id: string; file: File; progress: number; status: string }[];
  loading: boolean;
  error: string | null;

  setAnalyses: (analyses: SpatialAnalysisResult[]) => void;
  setHealthReports: (reports: PropertyHealthReport[]) => void;
  setInsuranceProfile: (propertyId: string, profile: InsuranceRiskProfile) => void;
  setActiveAnalysis: (id: string | null) => void;
  addToUploadQueue: (item: { id: string; file: File }) => void;
  updateUploadProgress: (id: string, progress: number) => void;
  removeUploadItem: (id: string) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  clearError: () => void;
  reset: () => void;
}

export const useSpatialAnalysisStore = create<SpatialAnalysisState>()(
  devtools(
    (set) => ({
      analyses: [],
      healthReports: [],
      insuranceProfiles: {},
      activeAnalysisId: null,
      uploadQueue: [],
      loading: false,
      error: null,

      setAnalyses: (analyses) => set({ analyses }),
      setHealthReports: (healthReports) => set({ healthReports }),
      setInsuranceProfile: (propertyId, profile) =>
        set((state) => ({
          insuranceProfiles: { ...state.insuranceProfiles, [propertyId]: profile },
        })),
      setActiveAnalysis: (activeAnalysisId) => set({ activeAnalysisId }),
      addToUploadQueue: (item) =>
        set((state) => ({
          uploadQueue: [...state.uploadQueue, { ...item, progress: 0, status: 'UPLOADING' }],
        })),
      updateUploadProgress: (id, progress) =>
        set((state) => ({
          uploadQueue: state.uploadQueue.map((item) =>
            item.id === id ? { ...item, progress } : item
          ),
        })),
      removeUploadItem: (id) =>
        set((state) => ({
          uploadQueue: state.uploadQueue.filter((item) => item.id !== id),
        })),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      clearError: () => set({ error: null }),
      reset: () =>
        set({
          analyses: [],
          healthReports: [],
          insuranceProfiles: {},
          activeAnalysisId: null,
          uploadQueue: [],
          loading: false,
          error: null,
        }),
    }),
    { name: 'spatial-analysis-store' }
  )
);
