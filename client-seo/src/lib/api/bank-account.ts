import { apiClient } from "./client";

export interface BankAccount {
  id: string;
  orgId: string;
  accountType: string;
  bankName: string;
  bankCode: string;
  accountName: string;
  accountNumber: string;
  iban: string;
  routingNumber: string;
  sortCode: string;
  currency: string;
  country: string;
  status: string;
  verifiedAt: string;
  verifiedBy: string;
  isDefaultForPayouts: boolean;
  isDefaultForReceipts: boolean;
  lastUsedAt: string;
  metadata: Record<string, any>;
  createdAt: string;
  updatedAt: string;
}

export const bankAccountApi = {
  getAll: (params?: { orgId?: string; status?: string; currency?: string }) =>
    apiClient.get<{ data: BankAccount[] }>("/bank-accounts", params),

  getById: (id: string) =>
    apiClient.get<{ data: BankAccount }>(`/bank-accounts/${id}`),

  create: (data: {
    orgId: string;
    accountType: string;
    bankName: string;
    bankCode: string;
    accountName: string;
    accountNumber: string;
    iban?: string;
    routingNumber?: string;
    sortCode?: string;
    currency: string;
    country: string;
    isDefaultForPayouts?: boolean;
    isDefaultForReceipts?: boolean;
    metadata?: Record<string, any>;
  }) =>
    apiClient.post<{ data: BankAccount }>("/bank-accounts", data),

  update: (id: string, data: Partial<BankAccount>) =>
    apiClient.patch<{ data: BankAccount }>(`/bank-accounts/${id}`, data),

  delete: (id: string) =>
    apiClient.delete(`/bank-accounts/${id}`),

  setDefaultPayout: (id: string) =>
    apiClient.patch<{ data: BankAccount }>(`/bank-accounts/${id}/default-payout`),

  setDefaultReceipt: (id: string) =>
    apiClient.patch<{ data: BankAccount }>(`/bank-accounts/${id}/default-receipt`),

  verify: (id: string) =>
    apiClient.post<{ data: BankAccount }>(`/bank-accounts/${id}/verify`),
};
