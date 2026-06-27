import { apiClient } from "./client";

export const tax1099FormsApi = {
  getForms: (params?: { orgId?: string; taxYear?: number; status?: string; recipientId?: string; page?: number; limit?: number }) =>
    apiClient.get("/tax-1099-forms", params),
  getFormById: (id: string) => apiClient.get(`/tax-1099-forms/${id}`),
  createForm: (data: any) => apiClient.post("/tax-1099-forms", data),
  updateForm: (id: string, data: any) => apiClient.patch(`/tax-1099-forms/${id}`, data),
  deleteForm: (id: string) => apiClient.delete(`/tax-1099-forms/${id}`),
  submitForm: (id: string) => apiClient.patch(`/tax-1099-forms/${id}/submit`),
  sendToRecipient: (id: string) => apiClient.post(`/tax-1099-forms/${id}/send`),
  downloadForm: (id: string) => apiClient.get(`/tax-1099-forms/${id}/download`),
  bulkGenerate: (orgId: string, taxYear: number) =>
    apiClient.post("/tax-1099-forms/bulk-generate", { orgId, taxYear }),
};
