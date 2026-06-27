import { apiClient } from "./client";

export interface PricingRule {
  id: string;
  listingId: string;
  name?: string;
  ruleType?: string;
  amount?: number;
  percentage?: number;
  minStay?: number;
  maxStay?: number;
  startDate?: string;
  endDate?: string;
  isActive: boolean;
  priority?: number;
  createdAt: string;
}

export const pricingRulesApi = {
  getAll: (params?: { listingId?: string; orgId?: string; isActive?: boolean; page?: number; limit?: number }) =>
    apiClient.get("/pricing-rules", params),
  getById: (id: string) => apiClient.get(`/pricing-rules/${id}`),
  create: (data: Partial<PricingRule>) => apiClient.post("/pricing-rules", data),
  update: (id: string, data: Partial<PricingRule>) => apiClient.patch(`/pricing-rules/${id}`, data),
  delete: (id: string) => apiClient.delete(`/pricing-rules/${id}`),
  getByListing: (listingId: string, params?: any) =>
    apiClient.get(`/pricing-rules/listing/${listingId}`, params),
  applyRules: (listingId: string, checkIn: string, checkOut: string) =>
    apiClient.post(`/pricing-rules/apply`, { listingId, checkIn, checkOut }),
};
