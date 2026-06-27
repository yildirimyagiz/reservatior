import { apiClient } from "./client";

export interface PropertyOffer {
  id: string;
  orgId: string;
  propertyId: string;
  status?: string;
  offerAmount?: number;
  currency?: string;
  offerDate?: string;
  expiresAt?: string;
  buyerId?: string;
  agentId?: string;
  notes?: string;
  createdAt: string;
}

export const propertyOffersApi = {
  getAll: (params?: { orgId?: string; propertyId?: string; status?: string; page?: number; limit?: number }) =>
    apiClient.get("/property-offers", params),
  getById: (id: string) => apiClient.get(`/property-offers/${id}`),
  create: (data: Partial<PropertyOffer>) => apiClient.post("/property-offers", data),
  update: (id: string, data: Partial<PropertyOffer>) => apiClient.patch(`/property-offers/${id}`, data),
  delete: (id: string) => apiClient.delete(`/property-offers/${id}`),
  accept: (id: string, notes?: string) => apiClient.patch(`/property-offers/${id}/accept`, { notes }),
  reject: (id: string, reason?: string) => apiClient.patch(`/property-offers/${id}/reject`, { reason }),
  counteroffer: (id: string, counterAmount: number, notes?: string) =>
    apiClient.patch(`/property-offers/${id}/counteroffer`, { counterAmount, notes }),
  getByProperty: (propertyId: string, params?: any) =>
    apiClient.get(`/property-offers/property/${propertyId}`, params),
};
