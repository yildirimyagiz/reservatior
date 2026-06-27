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
    apiClient.get("/investors/portfolios", params),
  getPortfolioById: (id: string) => apiClient.get(`/investors/portfolios/${id}`),
  createPortfolio: (data: Partial<InvestorPortfolio>) => apiClient.post("/investors/portfolios", data),
  updatePortfolio: (id: string, data: Partial<InvestorPortfolio>) => apiClient.patch(`/investors/portfolios/${id}`, data),
  deletePortfolio: (id: string) => apiClient.delete(`/investors/portfolios/${id}`),

  // Portfolio Properties
  addPropertyToPortfolio: (portfolioId: string, data: any) =>
    apiClient.post(`/investors/portfolios/${portfolioId}/properties`, data),
  removePropertyFromPortfolio: (portfolioId: string, propertyId: string) =>
    apiClient.delete(`/investors/portfolios/${portfolioId}/properties/${propertyId}`),

  // Analytics
  getPortfolioAnalytics: (portfolioId: string) =>
    apiClient.get(`/investors/portfolios/${portfolioId}/analytics`),
};
