import { apiClient } from "./client";

export interface InvestorPortfolio {
  id: string;
  userId: string;
  name: string;
  riskTolerance: string;
  targetIrr?: number;
  investmentHorizon?: string;
  organizationId?: string;
  createdAt: string;
}

export const investorsApi = {
  // Portfolios
  getPortfolios: (params?: { userId?: string }) =>
    apiClient.get("/api/investor-portfolios", { params }),
  getPortfolioById: (id: string) => apiClient.get(`/api/investor-portfolios/${id}`),
  createPortfolio: (data: Partial<InvestorPortfolio>) => apiClient.post("/api/investor-portfolios", data),
  updatePortfolio: (id: string, data: Partial<InvestorPortfolio>) => apiClient.patch(`/api/investor-portfolios/${id}`, data),
  deletePortfolio: (id: string) => apiClient.delete(`/api/investor-portfolios/${id}`),

  // Portfolio Properties
  addPropertyToPortfolio: (portfolioId: string, data: any) =>
    apiClient.post(`/api/investor-portfolios/${portfolioId}/properties`, data),
  removePropertyFromPortfolio: (portfolioId: string, propertyId: string) =>
    apiClient.delete(`/api/investor-portfolios/${portfolioId}/properties/${propertyId}`),

  // Analytics
  getPortfolioAnalytics: (portfolioId: string) =>
    apiClient.get(`/api/investor-portfolios/${portfolioId}/analytics`),
};
