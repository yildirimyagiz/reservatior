import { apiClient } from "./client";

export interface PropertyPromotion {
  id: string;
  propertyId: string;
  agencyId?: string;
  agentId?: string;
  promotionType: string;
  status: string;
  startDate: string;
  endDate: string;
  price: number;
  currency: string;
  isAutoRenew: boolean;
  features: string[];
  paymentHistoryId?: string;
  userId?: string;
  createdAt: string;
  updatedAt?: string;
}

export const propertyPromotionsApi = {
  getAll: (params?: { propertyId?: string; agencyId?: string; agentId?: string; promotionType?: string; status?: string; page?: number; limit?: number }) =>
    apiClient.get("/property-promotions", params),
  getById: (id: string) => apiClient.get(`/property-promotions/${id}`),
  create: (data: Partial<PropertyPromotion>) => apiClient.post("/property-promotions", data),
  update: (id: string, data: Partial<PropertyPromotion>) => apiClient.patch(`/property-promotions/${id}`, data),
  delete: (id: string) => apiClient.delete(`/property-promotions/${id}`),
  activate: (id: string) => apiClient.patch(`/property-promotions/${id}/activate`),
  deactivate: (id: string) => apiClient.patch(`/property-promotions/${id}/deactivate`),
  getByProperty: (propertyId: string, params?: any) =>
    apiClient.get(`/property-promotions/property/${propertyId}`, params),
  getAnalytics: (id: string) => apiClient.get(`/property-promotions/${id}/analytics`),
};
