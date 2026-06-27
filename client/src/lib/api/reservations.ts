import { apiClient } from "./client";

export interface Reservation {
  id: string;
  orgId?: string;
  listingId: string;
  guestId?: string;
  checkIn: string;
  checkOut: string;
  status: string;
  totalAmount?: number;
  currency?: string;
  guestCount?: number;
  notes?: string;
  source?: string;
  externalId?: string;
  createdAt: string;
}

export const reservationsApi = {
  getAll: (params?: { orgId?: string; listingId?: string; guestId?: string; status?: string; checkInFrom?: string; checkInTo?: string; page?: number; limit?: number }) =>
    apiClient.get("/reservations", params),
  getById: (id: string) => apiClient.get(`/reservations/${id}`),
  create: (data: Partial<Reservation>) => apiClient.post("/reservations", data),
  update: (id: string, data: Partial<Reservation>) => apiClient.patch(`/reservations/${id}`, data),
  cancel: (id: string, reason?: string) => apiClient.patch(`/reservations/${id}/cancel`, { reason }),
  confirm: (id: string) => apiClient.patch(`/reservations/${id}/confirm`),
  checkIn: (id: string) => apiClient.patch(`/reservations/${id}/check-in`),
  checkOut: (id: string) => apiClient.patch(`/reservations/${id}/check-out`),
  getByListing: (listingId: string, params?: any) =>
    apiClient.get(`/reservations/listing/${listingId}`, params),
  getCalendar: (listingId: string, params?: any) =>
    apiClient.get(`/reservations/calendar/${listingId}`, params),
  getAnalytics: (params?: any) => apiClient.get("/reservations/analytics", params),
};
