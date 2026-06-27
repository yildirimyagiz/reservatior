import { apiClient } from "./client";

export interface Quote {
  id: string;
  orgId: string;
  clientId?: string;
  propertyId?: string;
  status?: string;
  totalAmount?: number;
  currency?: string;
  validUntil?: string;
  lineItems?: any;
  notes?: string;
  createdAt: string;
}

export const quotesApi = {
  getAll: (params?: { orgId?: string; clientId?: string; status?: string; page?: number; limit?: number }) =>
    apiClient.get("/quotes", params),
  getById: (id: string) => apiClient.get(`/quotes/${id}`),
  create: (data: Partial<Quote>) => apiClient.post("/quotes", data),
  update: (id: string, data: Partial<Quote>) => apiClient.patch(`/quotes/${id}`, data),
  delete: (id: string) => apiClient.delete(`/quotes/${id}`),
  send: (id: string) => apiClient.patch(`/quotes/${id}/send`),
  accept: (id: string) => apiClient.patch(`/quotes/${id}/accept`),
  reject: (id: string, reason?: string) => apiClient.patch(`/quotes/${id}/reject`, { reason }),
  convertToInvoice: (id: string) => apiClient.post(`/quotes/${id}/convert`),
};
