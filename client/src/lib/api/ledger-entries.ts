import { apiClient } from "./client";

export interface LedgerEntry {
  id: string;
  orgId: string;
  accountId?: string;
  transactionType?: string;
  amount: number;
  currency: string;
  occurredAt: string;
  description?: string;
  reference?: string;
  createdAt: string;
}

export const ledgerEntriesApi = {
  getAll: (params?: { orgId?: string; accountId?: string; transactionType?: string; fromDate?: string; toDate?: string; page?: number; limit?: number }) =>
    apiClient.get("/ledger-entries", params),
  getById: (id: string) => apiClient.get(`/ledger-entries/${id}`),
  create: (data: Partial<LedgerEntry>) => apiClient.post("/ledger-entries", data),
  update: (id: string, data: Partial<LedgerEntry>) => apiClient.patch(`/ledger-entries/${id}`, data),
  delete: (id: string) => apiClient.delete(`/ledger-entries/${id}`),
  getByAccount: (accountId: string, params?: any) =>
    apiClient.get(`/ledger-entries/account/${accountId}`, params),
  getSummary: (params?: { orgId?: string; fromDate?: string; toDate?: string }) =>
    apiClient.get("/ledger-entries/summary", params),
};
