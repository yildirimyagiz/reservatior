import { apiClient } from "./client";

export interface MortgageOffer {
  id: string;
  orgId: string;
  status?: string;
  lenderId?: string;
  amount?: number;
  interestRate?: number;
  termYears?: number;
  expiresAt?: string;
  createdAt: string;
}

export const mortgageOffersApi = {
  getAll: (params?: { orgId?: string; status?: string; lenderId?: string; page?: number; limit?: number }) =>
    apiClient.get("/mortgage-offers", params),
  getById: (id: string) => apiClient.get(`/mortgage-offers/${id}`),
  create: (data: Partial<MortgageOffer>) => apiClient.post("/mortgage-offers", data),
  update: (id: string, data: Partial<MortgageOffer>) => apiClient.patch(`/mortgage-offers/${id}`, data),
  delete: (id: string) => apiClient.delete(`/mortgage-offers/${id}`),
  accept: (id: string) => apiClient.patch(`/mortgage-offers/${id}/accept`),
  reject: (id: string, reason?: string) => apiClient.patch(`/mortgage-offers/${id}/reject`, { reason }),
  getByStatus: (status: string, params?: any) =>
    apiClient.get(`/mortgage-offers/status/${status}`, params),
};
