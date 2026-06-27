import { apiClient } from "./client";

// Valuation Types
export type ValuationType = 'BASIC' | 'PROFESSIONAL' | 'ENTERPRISE' | 'INSTANT' | 'DETAILED';
export type ValuationStatus = 'PENDING' | 'PROCESSING' | 'COMPLETED' | 'FAILED' | 'EXPIRED';
export type SecurityScreeningStatus = 'PENDING' | 'PASSED' | 'FAILED' | 'REVIEW_REQUIRED';
export type SecurityRiskLevel = 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
export type OwnershipVerificationStatus = 'PENDING' | 'VERIFIED' | 'REJECTED' | 'EXPIRED';
export type VerificationMethod = 'MANUAL' | 'API' | 'BLOCKCHAIN' | 'AI';

// Base Interfaces
export interface PropertyValuation {
  id: string;
  propertyId: string;
  agentId?: string;
  orgId: string;
  userId?: string;
  valuationType: ValuationType;
  status: ValuationStatus;
  value: number;
  confidence?: number;
  valuationDate: string;
  source: string;
  metadata?: any;
  createdAt: string;
  updatedAt: string;
  
  // Relations
  property?: {
    id: string;
    name: string;
    address: string;
    type: string;
  };
  agent?: {
    id: string;
    name: string;
    email: string;
  };
  organization?: {
    id: string;
    name: string;
  };
  user?: {
    id: string;
    name: string;
    email: string;
  };
  valuationRequests?: ValuationRequest[];
  valuationReports?: ValuationReport[];
  leadConversions?: LeadConversion[];
}

export interface ValuationRequest {
  id: string;
  valuationId: string;
  userId: string;
  propertyId?: string;
  orgId: string;
  requestType: string;
  priority: string;
  contactInfo?: any;
  propertyData?: any;
  videoUrl?: string;
  images: string[];
  requirements: string[];
  status: string;
  processingStartedAt?: string;
  completedAt?: string;
  estimatedPrice?: number;
  confidenceScore?: number;
  errorMessage?: string;
  processingMetadata?: any;
  userFeedback?: any;
  createdAt: string;
  updatedAt: string;
  
  // Relations
  valuation?: PropertyValuation;
  user?: {
    id: string;
    name: string;
    email: string;
  };
  property?: {
    id: string;
    name: string;
    address: string;
  };
  organization?: {
    id: string;
    name: string;
  };
}

export interface ValuationReport {
  id: string;
  valuationId: string;
  userId: string;
  orgId: string;
  reportType: string;
  format: string;
  content?: any;
  summary?: string;
  insights: string[];
  recommendations: string[];
  charts?: any;
  isPublic: boolean;
  shareToken?: string;
  downloadCount: number;
  viewCount: number;
  generatedAt: string;
  createdAt: string;
  updatedAt: string;
  
  // Relations
  valuation?: PropertyValuation;
  user?: {
    id: string;
    name: string;
    email: string;
  };
  organization?: {
    id: string;
    name: string;
  };
}

export interface LeadConversion {
  id: string;
  valuationId: string;
  contactId?: string;
  orgId: string;
  conversionType: string;
  conversionValue?: number;
  commissionAmount?: number;
  status: string;
  convertedAt?: string;
  notes?: string;
  createdAt: string;
  updatedAt: string;
  
  // Relations
  valuation?: PropertyValuation;
  contact?: {
    id: string;
    name: string;
    email: string;
  };
  organization?: {
    id: string;
    name: string;
  };
}

// Response Types
export interface ValuationsResponse {
  data: PropertyValuation[];
  total: number;
  page: number;
  limit: number;
}

export interface ValuationAnalytics {
  valuation: {
    value: number;
    confidence: number;
    valuationDate: string;
    status: string;
  };
  requests: {
    total: number;
    pending: number;
    completed: number;
    averageProcessingTime: number;
  };
  reports: {
    total: number;
    downloads: number;
    views: number;
    publicReports: number;
  };
  conversions: {
    total: number;
    inquiries: number;
    viewings: number;
    offers: number;
    sales: number;
    totalValue: number;
    totalCommission: number;
  };
}

// API Functions
export const valuationsApi = {
  // Property Valuations
  getValuations: (params?: {
    page?: number;
    limit?: number;
    propertyId?: string;
    agentId?: string;
    status?: ValuationStatus;
    valuationType?: ValuationType;
  }) => apiClient.get<ValuationsResponse>("/valuations", params),

  getValuationById: (id: string) => 
    apiClient.get<{ data: PropertyValuation }>(`/valuations/${id}`),

  createValuation: (data: {
    propertyId: string;
    valuationType?: ValuationType;
    priority?: string;
    contactInfo?: any;
    propertyData?: any;
    videoUrl?: string;
    images?: string[];
    requirements?: string[];
  }) => apiClient.post<{ 
    data: PropertyValuation;
    request: ValuationRequest;
    message: string;
  }>("/valuations", data),

  updateValuation: (id: string, data: {
    value?: number;
    confidence?: number;
    status?: ValuationStatus;
    priceRange?: any;
    marketTrends?: any;
    comparableProperties?: any;
    factors?: any;
    aiAnalysis?: any;
    videoAnalysis?: any;
    userBehavior?: any;
    recommendations?: string[];
  }) => apiClient.patch<{ data: PropertyValuation }>(`/valuations/${id}`, data),

  deleteValuation: (id: string) => 
    apiClient.delete(`/valuations/${id}`),

  // Valuation Processing
  processValuation: (id: string) => 
    apiClient.post<{ 
      valuation: PropertyValuation;
      message: string;
    }>(`/valuations/${id}/process`),

  // Valuation Analytics
  getValuationAnalytics: (id: string) => 
    apiClient.get<ValuationAnalytics>(`/valuations/${id}/analytics`),

  // Valuation Reports
  createValuationReport: (id: string, data: {
    reportType?: string;
    format?: string;
    content?: any;
    summary?: string;
    insights?: string[];
    recommendations?: string[];
    charts?: any;
    isPublic?: boolean;
  }) => apiClient.post<{ 
    report: ValuationReport;
    message: string;
  }>(`/valuations/${id}/reports`, data),

  getValuationReports: (id: string) => 
    apiClient.get<{ data: ValuationReport[] }>(`/valuations/${id}/reports`),

  getPublicReport: (shareToken: string) => 
    apiClient.get<{ data: ValuationReport }>(`/valuations/public/${shareToken}`),

  // Bulk Operations
  bulkUpdateValuations: (ids: string[], data: Partial<PropertyValuation>) => 
    apiClient.patch<{ data: PropertyValuation[] }>("/valuations/bulk", { ids, data }),

  exportValuations: (params?: {
    format?: 'csv' | 'excel' | 'pdf';
    propertyId?: string;
    status?: ValuationStatus;
    dateFrom?: string;
    dateTo?: string;
  }) => apiClient.get<Blob>("/valuations/export", params),

  // Search and Filter
  searchValuations: (query: string, filters?: {
    propertyId?: string;
    status?: ValuationStatus;
    valuationType?: ValuationType;
    dateFrom?: string;
    dateTo?: string;
  }) => apiClient.get<ValuationsResponse>("/valuations/search", { query, ...filters }),

  // Statistics
  getValuationStats: (params?: {
    orgId?: string;
    propertyId?: string;
    dateFrom?: string;
    dateTo?: string;
  }) => apiClient.get<{
    totalValuations: number;
    totalValue: number;
    averageValue: number;
    completionRate: number;
    averageProcessingTime: number;
    valuationTypeBreakdown: Record<ValuationType, number>;
    statusBreakdown: Record<ValuationStatus, number>;
  }>("/valuations/stats", params),
};
