import { apiClient } from "./client";
import type {
  SpatialAnalysisResult,
  PropertyHealthReport,
  RoomAnalysis,
  InsuranceRiskProfile,
  InsuranceProduct,
  MediaLocalization,
  BrochureAsset,
  SpatialAsset,
} from "@/types/spatial-analysis";

export const spatialAnalysisApi = {
  getAnalyses: (params?: any) =>
    apiClient.get<{ data: SpatialAnalysisResult[] }>("/spatial-analysis", params),

  getAnalysisById: (id: string) =>
    apiClient.get<{ data: SpatialAnalysisResult }>(`/spatial-analysis/${id}`),

  createAnalysis: (data: { propertyId: string; assets: string[] }) =>
    apiClient.post<{ data: SpatialAnalysisResult }>("/spatial-analysis", data),

  getHealthReports: (params?: any) =>
    apiClient.get<{ data: PropertyHealthReport[] }>("/property-health-report", params),

  getHealthReportById: (id: string) =>
    apiClient.get<{ data: PropertyHealthReport }>(`/property-health-report/${id}`),

  createHealthReport: (data: { propertyId: string; assets: string[] }) =>
    apiClient.post<{ data: PropertyHealthReport }>("/property-health-report", data),

  getRoomAnalyses: (propertyId: string) =>
    apiClient.get<{ data: RoomAnalysis[] }>(`/spatial-analysis/${propertyId}/rooms`),

  compareReports: (baselineId: string, currentId: string) =>
    apiClient.get<{ data: { baseline: PropertyHealthReport; current: PropertyHealthReport; delta: number } }>(
      `/property-health-report/compare?baseline=${baselineId}&current=${currentId}`
    ),

  getInsuranceRiskProfile: (propertyId: string) =>
    apiClient.get<{ data: InsuranceRiskProfile }>(`/insurance-risk/${propertyId}`),

  getInsuranceProducts: (params?: any) =>
    apiClient.get<{ data: InsuranceProduct[] }>("/insurance-products", params),

  attachInsurance: (data: { propertyId: string; productId: string; holderType: "OWNER" | "TENANT" }) =>
    apiClient.post("/insurance-attachments", data),

  getAssets: (propertyId: string) =>
    apiClient.get<{ data: SpatialAsset[] }>(`/spatial-assets/${propertyId}`),

  uploadAsset: (data: FormData) =>
    apiClient.post<{ data: SpatialAsset }>("/spatial-assets", data),

  getLocalizations: (assetId: string) =>
    apiClient.get<{ data: MediaLocalization[] }>(`/media-localization/${assetId}`),

  generateLocalization: (data: { assetId: string; targetLanguages: string[] }) =>
    apiClient.post<{ data: MediaLocalization[] }>("/media-localization/generate", data),

  getBrochures: (propertyId: string) =>
    apiClient.get<{ data: BrochureAsset[] }>(`/brochures/${propertyId}`),

  generateBrochure: (data: { propertyId: string; languages: string[]; demographicTarget: string }) =>
    apiClient.post<{ data: BrochureAsset }>("/brochures/generate", data),
};
