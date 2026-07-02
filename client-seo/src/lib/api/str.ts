import { apiClient } from "./client";

export const strApi = {
  // Vacation Rentals (STR)
  getRentals: (params?: { orgId?: string; listingId?: string; status?: string; search?: string; page?: number; limit?: number }) =>
    apiClient.get("/str/rentals", params),
  getRentalById: (id: string) => apiClient.get(`/str/rentals/${id}`),
  createRental: (data: any) => apiClient.post("/str/rentals", data),
  updateRental: (id: string, data: any) => apiClient.patch(`/str/rentals/${id}`, data),
  deleteRental: (id: string) => apiClient.delete(`/str/rentals/${id}`),

  // STR Regulations
  getRegulations: (params?: { orgId?: string; region?: string; isActive?: boolean }) =>
    apiClient.get("/str/regulations", params),
  createRegulation: (data: any) => apiClient.post("/str/regulations", data),
  updateRegulation: (id: string, data: any) => apiClient.patch(`/str/regulations/${id}`, data),

  // STR Licenses
  getLicenses: (params?: { orgId?: string; propertyId?: string; status?: string }) =>
    apiClient.get("/str/licenses", params),
  createLicense: (data: any) => apiClient.post("/str/licenses", data),
  updateLicense: (id: string, data: any) => apiClient.patch(`/str/licenses/${id}`, data),
  renewLicense: (id: string) => apiClient.post(`/str/licenses/${id}/renew`),

  // STR Analytics
  getAnalytics: (params?: { propertyId?: string; startDate?: string; endDate?: string }) =>
    apiClient.get("/str/analytics", params),
};
