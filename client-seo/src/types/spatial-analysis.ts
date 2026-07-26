// ============================================================================
// MODULE 1: MULTIMODAL SPATIAL ANALYSIS & INSURTECH (GEMINI ML PIPELINE)
// ============================================================================

export type SpatialAssetType = "VIDEO" | "PHOTO" | "360_PHOTO" | "DRONE";
export type RoomType = "LIVING_ROOM" | "BEDROOM" | "KITCHEN" | "BATHROOM" | "HOME_OFFICE" | "DINING_ROOM" | "GARAGE" | "BALCONY" | "HALLWAY" | "UTILITY" | "STORAGE" | "EXTERIOR";
export type DesignStyle = "MODERN_MINIMALIST" | "SCANDINAVIAN" | "INDUSTRIAL_LOFT" | "MID_CENTURY_MODERN" | "BOHEMIAN" | "COASTAL" | "JAPANDI" | "ART_DECO" | "EAST_ASIAN_LUXURY" | "MENA_FUSION" | "CIS_FUNCTIONAL";
export type RiskSeverity = "NONE" | "LOW" | "MEDIUM" | "HIGH" | "CRITICAL";
export type SpatialAnalysisStatus = "PENDING" | "PROCESSING" | "COMPLETED" | "FAILED";
export type DemographicTarget = "EAST_ASIAN" | "GULF_MENA" | "WESTERN" | "CIS_EASTERN_EUROPE" | "SOUTH_ASIAN" | "SOUTHEAST_ASIAN" | "LATIN_AMERICAN";
export type InsuranceProductType = "PROPERTY_DAMAGE" | "NATURAL_DISASTER" | "DEPOSIT_PROTECTION" | "LIABILITY" | "RENT_GUARANTEE" | "CONTENTS" | "FLOOD" | "EARTHQUAKE";

export interface SpatialAsset {
  id: string;
  propertyId: string;
  url: string;
  type: SpatialAssetType;
  fileSize: number;
  duration?: number;
  resolution?: string;
  uploadedAt: string;
  analysisStatus: SpatialAnalysisStatus;
}

export interface SpatialDimensions {
  width: number;
  height: number;
  depth: number;
  areaSqm: number;
  ceilingHeightM: number;
  totalAreaSqm: number;
}

export interface LightAssessment {
  naturalLightScore: number;
  windowCount: number;
  windowOrientation: string;
  artificialLightCoverage: number;
  luxLevel: number;
  lightQuality: "POOR" | "ADEQUATE" | "GOOD" | "EXCELLENT";
}

export interface PhysicalDefect {
  id: string;
  type: "WALL_CRACK" | "WATER_STAIN" | "FLOOR_DAMAGE" | "BROKEN_FIXTURE" | "CEILING_DAMAGE" | "WINDOW_DAMAGE" | "DOOR_DAMAGE" | "ELECTRICAL" | "PLUMBING" | "MOLD" | "PEST" | "STRUCTURAL";
  severity: RiskSeverity;
  location: string;
  description: string;
  imageUrl?: string;
  timestampDetected: string;
  estimatedRepairCost?: number;
  coordinates?: { x: number; y: number };
}

export interface PropertyHealthReport {
  id: string;
  propertyId: string;
  overallScore: number;
  structuralIntegrity: number;
  cosmeticCondition: number;
  systemsHealth: number;
  safetyScore: number;
  defects: PhysicalDefect[];
  totalDefects: number;
  criticalDefects: number;
  estimatedRepairCost: number;
  baselineTimestamp: string;
  comparisonMode?: "CHECK_IN" | "CHECK_OUT" | "PERIODIC";
  previousReportId?: string;
  conditionDelta?: number;
  generatedAt: string;
  geminiModelVersion: string;
}

export interface RoomAnalysis {
  id: string;
  roomId: string;
  roomType: RoomType;
  name: string;
  dimensions: SpatialDimensions;
  lightAssessment: LightAssessment;
  conditionScore: number;
  defects: PhysicalDefect[];
  suggestedStagingStyles: DesignStyle[];
  targetDemographics: DemographicTarget[];
  stagingReadiness: number;
  photos: string[];
  vacantAreas: { x: number; y: number; width: number; height: number; label: string }[];
}

export interface SpatialAnalysisResult {
  id: string;
  propertyId: string;
  rooms: RoomAnalysis[];
  overallDimensions: SpatialDimensions;
  lightAssessment: LightAssessment;
  healthReport: PropertyHealthReport;
  virtualStagingRecommendations: VirtualStagingRecommendation[];
  insuranceRiskProfile: InsuranceRiskProfile;
  status: SpatialAnalysisStatus;
  processingTimeMs: number;
  createdAt: string;
}

export interface VirtualStagingRecommendation {
  roomType: RoomType;
  style: DesignStyle;
  targetDemographic: DemographicTarget;
  confidence: number;
  rationale: string;
  estimatedImpact: {
    priceIncreasePercent: number;
    timeOnMarketReductionDays: number;
    conversionLiftPercent: number;
  };
}

export interface InsuranceRiskProfile {
  propertyId: string;
  overallRiskScore: number;
  floodRisk: number;
  earthquakeRisk: number;
  fireRisk: number;
  theftRisk: number;
  naturalDisasterExposure: number;
  recommendedProducts: InsuranceProduct[];
  estimatedAnnualPremium: number;
  coverageGaps: string[];
}

export interface InsuranceProduct {
  id: string;
  type: InsuranceProductType;
  name: string;
  provider: string;
  coverageAmount: number;
  annualPremium: number;
  monthlyPremium: number;
  deductible: number;
  highlights: string[];
 适合For: ("OWNER" | "TENANT")[];
  riskScoreReduction: number;
}

export interface MediaLocalization {
  id: string;
  assetId: string;
  sourceLanguage: string;
  targetLanguage: string;
  localizedTitle: string;
  localizedDescription: string;
  subtitles?: SubtitleTrack[];
  dubbingUrl?: string;
  semanticTags: string[];
  seoMeta: { title: string; description: string; keywords: string[] };
  generatedAt: string;
}

export interface SubtitleTrack {
  language: string;
  format: "SRT" | "VTT" | "ASS";
  url: string;
  segments: SubtitleSegment[];
}

export interface SubtitleSegment {
  startMs: number;
  endMs: number;
  text: string;
  translation?: string;
}

export interface BrochureAsset {
  id: string;
  propertyId: string;
  language: string;
  demographicTarget: DemographicTarget;
  pdfUrl: string;
  landingPageUrl?: string;
  title: string;
  sections: BrochureSection[];
  generatedAt: string;
  status: "GENERATING" | "READY" | "FAILED";
}

export interface BrochureSection {
  type: "HEADER" | "FEATURES" | "GALLERY" | "MAP" | "PRICING" | "CONTACT" | "INSURANCE" | "INVESTMENT";
  title: string;
  content: string;
  mediaUrls: string[];
}
