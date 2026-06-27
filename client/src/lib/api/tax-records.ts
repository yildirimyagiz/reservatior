import { apiClient } from "./client";

export interface TaxRecord {
  id: string;
  orgId: string;
  propertyId?: string;
  taxYear: number;
  taxType?: string;
  amount?: number;
  currency?: string;
  status?: string;
  dueDate?: string;
  paidDate?: string;
  notes?: string;
  createdAt: string;
}

export const taxRecordsApi = {
  getAll: (params?: { orgId?: string; propertyId?: string; taxYear?: number; taxType?: string; status?: string; page?: number; limit?: number }) =>
    apiClient.get("/tax-records", params),
  getById: (id: string) => apiClient.get(`/tax-records/${id}`),
  create: (data: Partial<TaxRecord>) => apiClient.post("/tax-records", data),
  update: (id: string, data: Partial<TaxRecord>) => apiClient.patch(`/tax-records/${id}`, data),
  delete: (id: string) => apiClient.delete(`/tax-records/${id}`),
  markAsPaid: (id: string, paidDate?: string) =>
    apiClient.patch(`/tax-records/${id}/pay`, { paidDate }),
  getByProperty: (propertyId: string, params?: any) =>
    apiClient.get(`/tax-records/property/${propertyId}`, params),
  getByYear: (taxYear: number, params?: any) =>
    apiClient.get(`/tax-records/year/${taxYear}`, params),
  getSummary: (params?: { orgId?: string; taxYear?: number }) =>
    apiClient.get("/tax-records/summary", params),
};
