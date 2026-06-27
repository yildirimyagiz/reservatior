import { apiClient } from "./client";

export const hoaApi = {
  // Shared Amenities
  getAmenities: (params?: { orgId?: string; propertyId?: string; type?: string; search?: string; page?: number; limit?: number }) =>
    apiClient.get("/hoa/amenities", params),
  getAmenityById: (id: string) => apiClient.get(`/hoa/amenities/${id}`),
  createAmenity: (data: any) => apiClient.post("/hoa/amenities", data),
  updateAmenity: (id: string, data: any) => apiClient.patch(`/hoa/amenities/${id}`, data),
  deleteAmenity: (id: string) => apiClient.delete(`/hoa/amenities/${id}`),

  // Amenity Bookings
  getAmenityBookings: (params?: { amenityId?: string; orgId?: string; userId?: string; status?: string; page?: number; limit?: number }) =>
    apiClient.get("/hoa/amenity-bookings", params),
  getAmenityBookingById: (id: string) => apiClient.get(`/hoa/amenity-bookings/${id}`),
  createAmenityBooking: (data: any) => apiClient.post("/hoa/amenity-bookings", data),
  updateAmenityBooking: (id: string, data: any) => apiClient.patch(`/hoa/amenity-bookings/${id}`, data),
  cancelAmenityBooking: (id: string) => apiClient.delete(`/hoa/amenity-bookings/${id}`),
};
