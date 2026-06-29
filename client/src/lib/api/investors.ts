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
    apiClient.get("/investor-portfolios", params),
  getPortfolioById: (id: string) => apiClient.get(`/investor-portfolios/${id}`),
  createPortfolio: (data: Partial<InvestorPortfolio>) => apiClient.post("/investor-portfolios", data),
  updatePortfolio: (id: string, data: Partial<InvestorPortfolio>) => apiClient.patch(`/investor-portfolios/${id}`, data),
  deletePortfolio: (id: string) => apiClient.delete(`/investor-portfolios/${id}`),

  // Portfolio Properties
  addPropertyToPortfolio: (portfolioId: string, data: any) =>
    apiClient.post(`/investor-portfolios/${portfolioId}/properties`, data),
  removePropertyFromPortfolio: (portfolioId: string, propertyId: string) =>
    apiClient.delete(`/investor-portfolios/${portfolioId}/properties/${propertyId}`),

  // Analytics
  getPortfolioAnalytics: (portfolioId: string) =>
    apiClient.get(`/investor-portfolios/${portfolioId}/analytics`),
};
