import { apiClient } from "./client";

export interface Mortgage {
  id: string;
  propertyId: string;
  lender: string;
  principal: number;
  interestRate: number;
  startDate: string;
  endDate?: string;
  status?: string;
  notes?: string;
  createdAt: string;
}

export const mortgagesApi = {
  getAll: (params?: { propertyId?: string; status?: string }) =>
    apiClient.get("/mortgages", params),
  getById: (id: string) => apiClient.get(`/mortgages/${id}`),
  create: (data: Partial<Mortgage>) => apiClient.post("/mortgages", data),
  update: (id: string, data: Partial<Mortgage>) => apiClient.patch(`/mortgages/${id}`, data),
  delete: (id: string) => apiClient.delete(`/mortgages/${id}`),
  getByProperty: (propertyId: string) => apiClient.get(`/mortgages/property/${propertyId}`),
  getPaymentSchedule: (id: string) => apiClient.get(`/mortgages/${id}/schedule`),
  recordPayment: (id: string, data: any) => apiClient.post(`/mortgages/${id}/payments`, data),
};
