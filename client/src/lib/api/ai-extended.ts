import { apiClient } from "./client";

// --- AI Service Models ---

export interface AIModel {
  id: string;
  modelName: string;
  modelVersion: string;
  modelType: string;
  provider: string;
  orgId?: string;
  endpointUrl?: string;
  status?: string;
  accuracy: number;
  lastTrainedAt?: string;
  config?: any;
  metadata?: any;
  createdAt: string;
  updatedAt: string;
}

export interface AIModelDeployment {
  id: string;
  orgId?: string;
  modelId: string;
  deploymentId: string;
  environment: string;
  status: string;
  deployedAt?: string;
  lastHealthCheck?: string;
  config?: any;
  metrics?: any;
  createdAt: string;
  updatedAt: string;
}

export interface AIPrediction {
  id: string;
  modelId: string;
  input: any;
  output: any;
  confidence?: number;
  latency?: number;
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

export interface VideoCaption {
  id: string;
  videoId: string;
  language: string;
  captionText: string;
  timestampStart: number;
  timestampEnd: number;
}

export interface AiBrochureGeneration {
  id: string;
  propertyId: string;
  listingId: string;
  pdfUrl: string;
  language?: string;
  status: string;
  generatedAt: string;
}

export interface AiExtractedData {
  id: string;
  entityType: string;
  entityId: string;
  extractedJson: any;
  confidenceScore?: number;
  aiModel?: string;
}

// --- Specialized AI Analysis Modals ---

export interface AIPriceOptimization {
  id: string;
  listingId: string;
  suggestedPrice: number;
  marketTrend: "UPWARD" | "STABLE" | "DOWNWARD";
  confidence: number;
  factors: any;
}

export interface AISentimentAnalysis {
  id: string;
  reviewId?: string;
  messageId?: string;
  score: number;
  sentiment: "POSITIVE" | "NEGATIVE" | "NEUTRAL";
  keywords: string[];
}

export interface AIFraudDetection {
  id: string;
  reservationId?: string;
  paymentId?: string;
  riskScore: number;
  status: "SAFE" | "SUSPICIOUS" | "FRAUDULENT";
  reasons: string[];
}

export interface AIRecommendation {
  id: string;
  userId: string;
  propertyIds: string[];
  score: number;
  algorithm: string;
}

export interface MarketInsight {
  id: string;
  region: string;
  category: string;
  averagePrice: number;
  demandScore: number;
  forecastData?: any;
}

// --- API Service ---

export const aiExtendedApi = {
  // Task Management (Bridge Service)
  getTasks: (params?: { orgId?: string; propertyId?: string; status?: string }) => 
    apiClient.get<AiServiceTask[]>("/ai-ext/tasks", params),
  getTaskById: (id: string) => 
    apiClient.get<AiServiceTask>(`/ai-ext/tasks/${id}`),
  cancelTask: (id: string) => 
    apiClient.delete(`/ai-ext/tasks/${id}`),

  // Video Suite
  getVideos: (propertyId?: string) => 
    apiClient.get<AiVideoGeneration[]>("/ai-ext/videos", { propertyId }),
  generateVideo: (listingId: string, data?: any) => 
    apiClient.post<AiServiceTask>(`/listings/${listingId}/ai-task`, { taskType: "REELS_VIDEO_GEN", inputData: data }),

  // Brochure Suite
  getBrochures: (propertyId?: string) => 
    apiClient.get<AiBrochureGeneration[]>("/ai-ext/brochures", { propertyId }),
  generateBrochure: (listingId: string, data?: any) => 
    apiClient.post<AiServiceTask>(`/listings/${listingId}/ai-task`, { taskType: "BROCHURE_GEN", inputData: data }),

  // Intelligent Analysis
  getPriceOptimization: (listingId: string) => 
    apiClient.get<AIPriceOptimization>(`/ai-ext/listings/${listingId}/optimize-price`),
  getSentiment: (entityId: string, type: "review" | "message") => 
    apiClient.get<AISentimentAnalysis>(`/ai-ext/sentiment`, { entityId, type }),
  checkFraud: (reservationId: string) => 
    apiClient.get<AIFraudDetection>(`/ai-ext/reservations/${reservationId}/fraud-check`),

  // Market Intelligence
  getMarketInsights: (region: string, category?: string) => 
    apiClient.get<MarketInsight[]>("/ai-ext/market-insights", { region, category }),

  // Model Management
  getModels: (params?: any) => apiClient.get<AIModel[]>("/ai-ext/models", params),
  getMLConfig: () => apiClient.get("/ai-ext/ml-config"),
  updateMLConfig: (data: any) => apiClient.put("/ai-ext/ml-config", data),
};
