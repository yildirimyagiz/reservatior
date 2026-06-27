import { apiClient } from "./client";

export const ledgerEntriesNewApi = {
  getAll: (params?: { orgId?: string; accountId?: string; transactionType?: string; fromDate?: string; toDate?: string; page?: number; limit?: number }) =>
    apiClient.get("/ledger-entries", params),
  getById: (id: string) => apiClient.get(`/ledger-entries/${id}`),
  create: (data: any) => apiClient.post("/ledger-entries", data),
  update: (id: string, data: any) => apiClient.patch(`/ledger-entries/${id}`, data),
  delete: (id: string) => apiClient.delete(`/ledger-entries/${id}`),
  bulkCreate: (entries: any[]) => apiClient.post("/ledger-entries/bulk", { entries }),
  getSummary: (params?: { orgId?: string; fromDate?: string; toDate?: string }) =>
    apiClient.get("/ledger-entries/summary", params),
};
