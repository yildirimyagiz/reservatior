import { apiClient } from "./client";

export interface VacationRental {
  id: string;
  orgId: string;
  propertyId?: string;
  isActive: boolean;
  ownershipVerified?: boolean;
  verificationStatus?: string;
  licenseNumber?: string;
  maxGuests?: number;
  amenities?: any;
  rules?: any;
  checkInTime?: string;
  checkOutTime?: string;
  createdAt: string;
}

export const vacationRentalsApi = {
  getAll: (params?: { 
    orgId?: string; 
    isActive?: boolean; 
    propertyId?: string; 
    ownershipVerified?: boolean; 
    verificationStatus?: string; 
    page?: number; 
    limit?: number;
    query?: string;
    [key: string]: any;
  }) =>
    apiClient.get("/api/v1/vacation-rental", params),
  getById: (id: string) => apiClient.get(`/vacation-rentals/${id}`),
  create: (data: Partial<VacationRental>) => apiClient.post("/vacation-rentals", data),
  update: (id: string, data: Partial<VacationRental>) => apiClient.patch(`/vacation-rentals/${id}`, data),
  delete: (id: string) => apiClient.delete(`/vacation-rentals/${id}`),
  activate: (id: string) => apiClient.patch(`/vacation-rentals/${id}/activate`),
  deactivate: (id: string) => apiClient.patch(`/vacation-rentals/${id}/deactivate`),
  verify: (id: string, verificationData: any) =>
    apiClient.post(`/vacation-rentals/${id}/verify`, verificationData),
  getByProperty: (propertyId: string) =>
    apiClient.get(`/vacation-rentals/property/${propertyId}`),
  getCalendar: (id: string, params?: any) =>
    apiClient.get(`/vacation-rentals/${id}/calendar`, params),
  getAnalytics: (id: string, params?: any) =>
    apiClient.get(`/vacation-rentals/${id}/analytics`, params),
};
