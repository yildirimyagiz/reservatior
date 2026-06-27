import { apiClient } from "./client";

export interface Tax1099 {
  id: string;
  orgId: string;
  recipientId?: string;
  taxYear: number;
  formType?: string;
  status?: string;
  totalAmount?: number;
  submittedAt?: string;
  createdAt: string;
}

export const tax1099Api = {
  getAll: (params?: { orgId?: string; taxYear?: number; status?: string; page?: number; limit?: number }) =>
    apiClient.get("/tax-1099", params),
  getById: (id: string) => apiClient.get(`/tax-1099/${id}`),
  create: (data: Partial<Tax1099>) => apiClient.post("/tax-1099", data),
  update: (id: string, data: Partial<Tax1099>) => apiClient.patch(`/tax-1099/${id}`, data),
  delete: (id: string) => apiClient.delete(`/tax-1099/${id}`),
  submit: (id: string) => apiClient.patch(`/tax-1099/${id}/submit`),
  getByYear: (taxYear: number, params?: any) =>
    apiClient.get(`/tax-1099/year/${taxYear}`, params),
  generateForms: (orgId: string, taxYear: number) =>
    apiClient.post(`/tax-1099/generate`, { orgId, taxYear }),
  export: (params?: { orgId?: string; taxYear?: number; format?: string }) =>
    apiClient.get("/tax-1099/export", params),
};
