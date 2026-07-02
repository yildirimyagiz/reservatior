import { apiClient } from "./client";

export interface FinancialRecord {
  id: string;
  orgId: string;
  propertyId: string;
  type: string;
  amount: number;
  currency: string;
  occurredAt: string;
  dueDate?: string;
  recordType?: string;
  billData?: any;
  createdAt: string;
}

export const financialRecordsApi = {
  getAll: (params?: { orgId?: string; type?: string; status?: string; propertyId?: string; page?: number; limit?: number }) =>
    apiClient.get("/financial-records", params),
  getById: (id: string) => apiClient.get(`/financial-records/${id}`),
  create: (data: Partial<FinancialRecord>) => apiClient.post("/financial-records", data),
  update: (id: string, data: Partial<FinancialRecord>) => apiClient.patch(`/financial-records/${id}`, data),
  delete: (id: string) => apiClient.delete(`/financial-records/${id}`),
  getByProperty: (propertyId: string, params?: any) =>
    apiClient.get(`/financial-records/property/${propertyId}`, params),
  getByOrg: (orgId: string, params?: any) =>
    apiClient.get(`/financial-records/org/${orgId}`, params),
  getSummary: (orgId: string, params?: { fromDate?: string; toDate?: string; type?: string }) =>
    apiClient.get(`/financial-records/summary/org/${orgId}`, params),
};
