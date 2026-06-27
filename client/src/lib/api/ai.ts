import { apiClient } from "./client";

import { AIModel, AIModelDeployment, AIPrediction, VideoCaption } from "./ai-extended";
export type { AIModel, AIModelDeployment, AIPrediction, VideoCaption };

export interface AILeadScoring {
  id: string;
  orgId?: string;
  modelName: string;
  modelVersion: string;
  accuracy: number;
  lastTrainedAt: string;
  scoringLogic: any;
  status: string;
  createdAt: string;
  updatedAt: string;
  scores?: AILeadScore[];
  _count?: {
    scores: number;
  };
}

export interface AILeadScore {
  id: string;
  orgId?: string;
  modelId: string;
  leadId: string;
  score: number;
  scoreBreakdown: any;
  confidence: number;
  scoredAt: string;
  featuresUsed: any;
  status: string;
  createdAt: string;
}

export interface AiExtractedData {
  id: string;
  entityType: string;
  entityId: string;
  extractedJson: any;
  confidenceScore?: number;
  aiModel?: string;
  createdAt: string;
}

export interface AiServiceTask {
  id: string;
  orgId: string;
  propertyId?: string;
  listingId?: string;
  taskType: "REELS_VIDEO_GEN" | "BROCHURE_GEN" | "SEO_DESCRIPTION" | "DOCUMENT_EXTRACT" | "SENTIMENT_ANALYSIS";
  status: "PENDING" | "PROCESSING" | "COMPLETED" | "FAILED";
  inputData?: any;
  outputData?: any;
  progress: number;
  error?: string;
  createdAt: string;
  updatedAt: string;
}

export interface AIImageAnalysis {
  id: string;
  propertyId: string;
  imageUrl: string;
  analysisType: string;
  results: any;
  confidence: number;
  processedAt: string;
}

export interface AIInvestmentAnalysis {
  id: string;
  propertyId: string;
  investmentType: string;
  roi: number;
  riskLevel: string;
  marketAnalysis: any;
  recommendation: string;
}

export interface AIMarketAnalysis {
  id: string;
  region: string;
  propertyType: string;
  marketTrend: "RISING" | "STABLE" | "DECLINING";
  averagePrice: number;
  priceChange: number;
  demandScore: number;
  supplyScore: number;
  analysisDate: string;
}

export interface AIPredictiveMaintenance {
  id: string;
  propertyId: string;
  componentType: string;
  predictionType: "FAILURE" | "MAINTENANCE" | "INSPECTION";
  probability: number;
  estimatedTime: string;
  recommendedAction: string;
  factors: any;
}

export interface AIPropertyDescription {
  id: string;
  propertyId: string;
  description: string;
  language: string;
  quality: number;
  generatedAt: string;
}

export interface AIPropertyValuation {
  id: string;
  propertyId: string;
  valuationMethod: string;
  estimatedValue: number;
  confidence: number;
  factors: any;
  marketData: any;
}

export interface AIRecommendation {
  id: string;
  userId: string;
  propertyIds: string[];
  score: number;
  algorithm: string;
  reasoning: string;
}

export interface AITenantScreening {
  id: string;
  tenantId: string;
  screeningType: string;
  score: number;
  riskLevel: "LOW" | "MEDIUM" | "HIGH";
  factors: any;
  recommendations: string[];
}

export interface AIValuationModel {
  id: string;
  modelName: string;
  modelType: string;
  accuracy: number;
  trainingDataSize: number;
  lastTrainedAt: string;
  regions: string[];
}

export interface AiVideoGeneration {
  id: string;
  propertyId: string;
  listingId?: string;
  videoUrl: string;
  thumbnailUrl?: string;
  status: string;
  duration?: number;
  metadata?: any;
  captions?: VideoCaption[];
}

export interface AiBrochureGeneration {
  id: string;
  propertyId: string;
  listingId?: string;
  pdfUrl: string;
  language?: string;
  status: string;
  generatedAt: string;
}

export const aiApi = {
  // Dashboard & Analytics
  getDashboard: () => apiClient.get("/ai/dashboard"),
  getAnalytics: () => apiClient.get("/ai/analytics"),
  getInsights: () => apiClient.get("/ai/insights"),
  
  // Models
  getModels: () => apiClient.get<AIModel[]>("/ai/models"),
  getModelById: (id: string) => apiClient.get<AIModel>(`/ai/models/${id}`),
  createModel: (data: Partial<AIModel>) => apiClient.post<AIModel>("/ai/models", data),
  updateModel: (id: string, data: Partial<AIModel>) => apiClient.put<AIModel>(`/ai/models/${id}`, data),
  deleteModel: (id: string) => apiClient.delete(`/ai/models/${id}`),
  
  // Deployments
  getDeployments: () => apiClient.get<AIModelDeployment[]>("/ai/deployments"),
  deployModel: (modelId: string, data: any) => apiClient.post<AIModelDeployment>(`/ai/models/${modelId}/deploy`, data),
  
  // Predictions
  predict: (modelId: string, data: any) => apiClient.post<AIPrediction>(`/ai/models/${modelId}/predict`, data),
  getPredictions: (modelId: string) => apiClient.get<AIPrediction[]>(`/ai/models/${modelId}/predictions`),

  // Lead Scoring
  getLeadScoringModels: () => apiClient.get<AILeadScoring[]>("/ai/lead-scoring/models"),
  getLeadScores: (params?: any) => apiClient.get<AILeadScore[]>("/ai/lead-scoring/scores", params),
  retrainLeadScoringModel: (modelId: string) => apiClient.post(`/ai/lead-scoring/models/${modelId}/retrain`),

  // Service Tasks
  getServiceTasks: (params?: any) => apiClient.get<AiServiceTask[]>("/ai-service-task", params),
  getServiceTaskById: (id: string) => apiClient.get<AiServiceTask>(`/ai-service-task/${id}`),
  createServiceTask: (data: Partial<AiServiceTask>) => apiClient.post<AiServiceTask>("/ai-service-task", data),
  updateServiceTask: (id: string, data: Partial<AiServiceTask>) => apiClient.put<AiServiceTask>(`/ai-service-task/${id}`, data),
  cancelServiceTask: (id: string) => apiClient.delete(`/ai-service-task/${id}`),

  // Extracted Data
  getExtractedData: (params?: any) => apiClient.get<AiExtractedData[]>("/ai-extracted-data", params),
  getExtractedDataById: (id: string) => apiClient.get<AiExtractedData>(`/ai-extracted-data/${id}`),
  createExtractedData: (data: Partial<AiExtractedData>) => apiClient.post<AiExtractedData>("/ai-extracted-data", data),
  updateExtractedData: (id: string, data: Partial<AiExtractedData>) => apiClient.put<AiExtractedData>(`/ai-extracted-data/${id}`, data),
  deleteExtractedData: (id: string) => apiClient.delete(`/ai-extracted-data/${id}`),

  // Image Analysis
  getImageAnalyses: (params?: any) => apiClient.get<AIImageAnalysis[]>("/aiimage-analysis", params),
  getImageAnalysisById: (id: string) => apiClient.get<AIImageAnalysis>(`/aiimage-analysis/${id}`),
  createImageAnalysis: (data: Partial<AIImageAnalysis>) => apiClient.post<AIImageAnalysis>("/aiimage-analysis", data),
  updateImageAnalysis: (id: string, data: Partial<AIImageAnalysis>) => apiClient.put<AIImageAnalysis>(`/aiimage-analysis/${id}`, data),
  deleteImageAnalysis: (id: string) => apiClient.delete(`/aiimage-analysis/${id}`),

  // Investment Analysis
  getInvestmentAnalyses: (params?: any) => apiClient.get<AIInvestmentAnalysis[]>("/aiinvestment-analysis", params),
  getInvestmentAnalysisById: (id: string) => apiClient.get<AIInvestmentAnalysis>(`/aiinvestment-analysis/${id}`),
  createInvestmentAnalysis: (data: Partial<AIInvestmentAnalysis>) => apiClient.post<AIInvestmentAnalysis>("/aiinvestment-analysis", data),
  updateInvestmentAnalysis: (id: string, data: Partial<AIInvestmentAnalysis>) => apiClient.put<AIInvestmentAnalysis>(`/aiinvestment-analysis/${id}`, data),
  deleteInvestmentAnalysis: (id: string) => apiClient.delete(`/aiinvestment-analysis/${id}`),

  // Market Analysis
  getMarketAnalyses: (params?: any) => apiClient.get<AIMarketAnalysis[]>("/aimarket-analysis", params),
  getMarketAnalysisById: (id: string) => apiClient.get<AIMarketAnalysis>(`/aimarket-analysis/${id}`),
  createMarketAnalysis: (data: Partial<AIMarketAnalysis>) => apiClient.post<AIMarketAnalysis>("/aimarket-analysis", data),
  updateMarketAnalysis: (id: string, data: Partial<AIMarketAnalysis>) => apiClient.put<AIMarketAnalysis>(`/aimarket-analysis/${id}`, data),
  deleteMarketAnalysis: (id: string) => apiClient.delete(`/aimarket-analysis/${id}`),

  // Predictive Maintenance
  getPredictiveMaintenance: (params?: any) => apiClient.get<AIPredictiveMaintenance[]>("/aipredictive-maintenance", params),
  getPredictiveMaintenanceById: (id: string) => apiClient.get<AIPredictiveMaintenance>(`/aipredictive-maintenance/${id}`),
  createPredictiveMaintenance: (data: Partial<AIPredictiveMaintenance>) => apiClient.post<AIPredictiveMaintenance>("/aipredictive-maintenance", data),
  updatePredictiveMaintenance: (id: string, data: Partial<AIPredictiveMaintenance>) => apiClient.put<AIPredictiveMaintenance>(`/aipredictive-maintenance/${id}`, data),
  deletePredictiveMaintenance: (id: string) => apiClient.delete(`/aipredictive-maintenance/${id}`),

  // Property Descriptions
  getPropertyDescriptions: (params?: any) => apiClient.get<AIPropertyDescription[]>("/aiproperty-description", params),
  getPropertyDescriptionById: (id: string) => apiClient.get<AIPropertyDescription>(`/aiproperty-description/${id}`),
  createPropertyDescription: (data: Partial<AIPropertyDescription>) => apiClient.post<AIPropertyDescription>("/aiproperty-description", data),
  updatePropertyDescription: (id: string, data: Partial<AIPropertyDescription>) => apiClient.put<AIPropertyDescription>(`/aiproperty-description/${id}`, data),
  deletePropertyDescription: (id: string) => apiClient.delete(`/aiproperty-description/${id}`),

  // Property Valuations
  getPropertyValuations: (params?: any) => apiClient.get<AIPropertyValuation[]>("/aiproperty-valuation", params),
  getPropertyValuationById: (id: string) => apiClient.get<AIPropertyValuation>(`/aiproperty-valuation/${id}`),
  createPropertyValuation: (data: Partial<AIPropertyValuation>) => apiClient.post<AIPropertyValuation>("/aiproperty-valuation", data),
  updatePropertyValuation: (id: string, data: Partial<AIPropertyValuation>) => apiClient.put<AIPropertyValuation>(`/aiproperty-valuation/${id}`, data),
  deletePropertyValuation: (id: string) => apiClient.delete(`/aiproperty-valuation/${id}`),

  // Recommendations
  getRecommendations: (params?: any) => apiClient.get<AIRecommendation[]>("/airecommendation", params),
  getRecommendationById: (id: string) => apiClient.get<AIRecommendation>(`/airecommendation/${id}`),
  createRecommendation: (data: Partial<AIRecommendation>) => apiClient.post<AIRecommendation>("/airecommendation", data),
  updateRecommendation: (id: string, data: Partial<AIRecommendation>) => apiClient.put<AIRecommendation>(`/airecommendation/${id}`, data),
  deleteRecommendation: (id: string) => apiClient.delete(`/airecommendation/${id}`),

  // Tenant Screening
  getTenantScreenings: (params?: any) => apiClient.get<AITenantScreening[]>("/aitenant-screening", params),
  getTenantScreeningById: (id: string) => apiClient.get<AITenantScreening>(`/aitenant-screening/${id}`),
  createTenantScreening: (data: Partial<AITenantScreening>) => apiClient.post<AITenantScreening>("/aitenant-screening", data),
  updateTenantScreening: (id: string, data: Partial<AITenantScreening>) => apiClient.put<AITenantScreening>(`/aitenant-screening/${id}`, data),
  deleteTenantScreening: (id: string) => apiClient.delete(`/aitenant-screening/${id}`),

  // Valuation Models
  getValuationModels: (params?: any) => apiClient.get<AIValuationModel[]>("/aivaluation-model", params),
  getValuationModelById: (id: string) => apiClient.get<AIValuationModel>(`/aivaluation-model/${id}`),
  createValuationModel: (data: Partial<AIValuationModel>) => apiClient.post<AIValuationModel>("/aivaluation-model", data),
  updateValuationModel: (id: string, data: Partial<AIValuationModel>) => apiClient.put<AIValuationModel>(`/aivaluation-model/${id}`, data),
  deleteValuationModel: (id: string) => apiClient.delete(`/aivaluation-model/${id}`),
};
