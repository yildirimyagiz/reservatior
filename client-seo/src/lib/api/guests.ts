import { apiClient } from "./client";

export interface Guest {
  id: string;
  firstName: string;
  lastName: string;
  email: string;
  phone?: string;
  preferredContact?: "email" | "phone" | "sms" | "whatsapp";
  status?: string;
  propertyId?: string;
  unit?: string;
  checkInDate?: string;
  checkOutDate?: string;
  notes?: string;
  createdAt: string;
  updatedAt: string;
}

export interface GuestCreate {
  firstName: string;
  lastName: string;
  email: string;
  phone?: string;
  preferredContact?: "email" | "phone" | "sms" | "whatsapp";
  status?: string;
  propertyId?: string;
  unit?: string;
  checkInDate?: string;
  checkOutDate?: string;
  notes?: string;
}

export interface GuestUpdate {
  firstName?: string;
  lastName?: string;
  email?: string;
  phone?: string;
  preferredContact?: "email" | "phone" | "sms" | "whatsapp";
  status?: string;
  propertyId?: string;
  unit?: string;
  checkInDate?: string;
  checkOutDate?: string;
  notes?: string;
}

export const guestsApi = {
  getAll: async (params?: { page?: number; limit?: number; search?: string; status?: string }) => 
    apiClient.get<Guest[]>("/api/guests", { params }),
  
  getById: async (id: string) => 
    apiClient.get<Guest>(`/api/guests/${id}`),
  
  create: async (data: GuestCreate) => 
    apiClient.post<Guest>("/api/guests", data),
  
  update: async (id: string, data: GuestUpdate) => 
    apiClient.patch<Guest>(`/api/guests/${id}`, data),
  
  delete: async (id: string) => 
    apiClient.delete(`/api/guests/${id}`),

  getFollowUps: (params?: any) => apiClient.get("/api/guests/follow-ups", { params }),
  getFollowUpAnalytics: () => apiClient.get("/api/guests/analytics"),
};
