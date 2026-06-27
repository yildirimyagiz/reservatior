import { apiClient } from "./client";

export const listingsExtendedApi = {
  // Pricing Rules
  getPricingRules: (params?: { listingId?: string; orgId?: string; isActive?: boolean }) =>
    apiClient.get("/listings-extended/pricing-rules", params),
  createPricingRule: (data: any) => apiClient.post("/listings-extended/pricing-rules", data),
  updatePricingRule: (id: string, data: any) => apiClient.patch(`/listings-extended/pricing-rules/${id}`, data),
  deletePricingRule: (id: string) => apiClient.delete(`/listings-extended/pricing-rules/${id}`),

  // Availability
  getAvailability: (params?: { listingId?: string; startDate?: string; endDate?: string }) =>
    apiClient.get("/listings-extended/availability", params),
  setAvailability: (listingId: string, data: any) =>
    apiClient.post(`/listings-extended/${listingId}/availability`, data),

  // Channels
  getListingChannels: (listingId: string) =>
    apiClient.get(`/listings-extended/${listingId}/channels`),
  addChannel: (listingId: string, data: any) =>
    apiClient.post(`/listings-extended/${listingId}/channels`, data),
};
