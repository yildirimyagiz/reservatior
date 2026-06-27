import { apiClient } from "./client";

export const marketAnalysisApi = {
  // Neighborhoods
  getNeighborhoods: (params?: { city?: string; district?: string; search?: string; page?: number; limit?: number }) =>
    apiClient.get("/market-analysis/neighborhoods", params),
  createNeighborhood: (data: any) => apiClient.post("/market-analysis/neighborhoods", data),
  updateNeighborhood: (id: string, data: any) => apiClient.patch(`/market-analysis/neighborhoods/${id}`, data),
  deleteNeighborhood: (id: string) => apiClient.delete(`/market-analysis/neighborhoods/${id}`),

  // Market Trends
  getMarketTrends: (params?: { neighborhoodId?: string; propertyType?: string; period?: string; page?: number; limit?: number }) =>
    apiClient.get("/market-analysis/trends", params),
  createMarketTrend: (data: any) => apiClient.post("/market-analysis/trends", data),

  // Comparables
  getComparables: (params?: { propertyId?: string; neighborhoodId?: string }) =>
    apiClient.get("/market-analysis/comparables", params),
  createComparable: (data: any) => apiClient.post("/market-analysis/comparables", data),

  // Price History
  getPriceHistory: (params?: { propertyId?: string; neighborhoodId?: string; fromDate?: string; toDate?: string }) =>
    apiClient.get("/market-analysis/price-history", params),
};
