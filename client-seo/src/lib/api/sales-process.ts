import { apiClient } from "./client";

export const salesProcessApi = {
  // Sales Stages
  getStages: (params?: { orgId?: string }) =>
    apiClient.get("/sales-process/stages", params),
  createStage: (data: any) => apiClient.post("/sales-process/stages", data),
  updateStage: (id: string, data: any) => apiClient.patch(`/sales-process/stages/${id}`, data),
  deleteStage: (id: string) => apiClient.delete(`/sales-process/stages/${id}`),

  // Negotiations
  getNegotiations: (params?: { orgId?: string; dealId?: string; status?: string; page?: number; limit?: number }) =>
    apiClient.get("/sales-process/negotiations", params),
  getNegotiationById: (id: string) => apiClient.get(`/sales-process/negotiations/${id}`),
  createNegotiation: (data: any) => apiClient.post("/sales-process/negotiations", data),
  updateNegotiation: (id: string, data: any) => apiClient.patch(`/sales-process/negotiations/${id}`, data),
  advanceNegotiation: (id: string) => apiClient.patch(`/sales-process/negotiations/${id}/advance`),

  // Offers
  getOffers: (params?: { orgId?: string; status?: string; page?: number; limit?: number }) =>
    apiClient.get("/sales-process/offers", params),
  createOffer: (data: any) => apiClient.post("/sales-process/offers", data),
  updateOffer: (id: string, data: any) => apiClient.patch(`/sales-process/offers/${id}`, data),
  acceptOffer: (id: string) => apiClient.patch(`/sales-process/offers/${id}/accept`),
  rejectOffer: (id: string, reason?: string) =>
    apiClient.patch(`/sales-process/offers/${id}/reject`, { reason }),
};
