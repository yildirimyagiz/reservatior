import { apiClient } from "./client";

export interface Prediction {
  id: string;
  type: string;
  entityId: string;
  predictedValue: number;
  confidence: number;
  factors: Array<{ factor: string; impact: number }>;
  metadata?: Record<string, unknown>;
  generatedAt: string;
}

export interface PredictionSummary {
  totalPredictions: number;
  accuracyRate: number;
  avgConfidence: number;
  byType: Record<string, number>;
  recentPredictions: Prediction[];
}

export const dataIntelligenceOSApi = {
  // Property valuation prediction
  predictPropertyValuation: async (propertyId: string): Promise<Prediction> => {
    const response = await apiClient.get<Prediction>(
      `/api/v1/data-intelligence-os/prediction/property-valuation/${propertyId}`
    );
    return response;
  },

  // Rental income prediction
  predictRentalIncome: async (propertyId: string): Promise<Prediction> => {
    const response = await apiClient.get<Prediction>(
      `/api/v1/data-intelligence-os/prediction/rental-income/${propertyId}`
    );
    return response;
  },

  // Vacancy prediction
  predictVacancy: async (propertyId: string): Promise<Prediction> => {
    const response = await apiClient.get<Prediction>(
      `/api/v1/data-intelligence-os/prediction/vacancy/${propertyId}`
    );
    return response;
  },

  // Tenant LTV prediction
  predictTenantLTV: async (tenantId: string): Promise<Prediction> => {
    const response = await apiClient.get<Prediction>(
      `/api/v1/data-intelligence-os/prediction/tenant-ltv/${tenantId}`
    );
    return response;
  },

  // Market trends prediction
  predictMarketTrends: async (location: string): Promise<Prediction> => {
    const response = await apiClient.get<Prediction>(
      `/api/v1/data-intelligence-os/prediction/market-trends/${location}`
    );
    return response;
  },

  // Portfolio optimization
  optimizePortfolio: async (orgId: string): Promise<Prediction> => {
    const response = await apiClient.get<Prediction>(
      `/api/v1/data-intelligence-os/prediction/portfolio-optimization/${orgId}`
    );
    return response;
  },

  // Batch predictions
  batchPredict: async (data: { type: string; entityIds: string[] }): Promise<Prediction[]> => {
    const response = await apiClient.post<Prediction[]>(
      `/api/v1/data-intelligence-os/prediction/batch`,
      data
    );
    return response;
  },

  // Get prediction summary
  getSummary: async (orgId?: string): Promise<PredictionSummary> => {
    const response = await apiClient.get<PredictionSummary>(
      `/api/v1/data-intelligence-os/summary`,
      { params: { orgId } }
    );
    return response;
  },

  // Get dashboard
  getDashboard: async (orgId?: string): Promise<any> => {
    const response = await apiClient.get(`/api/v1/data-intelligence-os/dashboard`, {
      params: { orgId },
    });
    return response;
  },
};
