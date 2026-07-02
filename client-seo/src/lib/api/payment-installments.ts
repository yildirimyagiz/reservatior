import { apiClient } from "./client";

export interface PaymentInstallment {
  id: string;
  orgId: string;
  negotiationId: string;
  status: string;
  dueDate: string;
  amount: number;
  currency?: string;
  paidAt?: string;
  notes?: string;
  createdAt: string;
}

export const paymentInstallmentsApi = {
  getAll: (params?: { orgId?: string; negotiationId?: string; status?: string; dueDateFrom?: string; dueDateTo?: string; page?: number; limit?: number }) =>
    apiClient.get("/payment-installments", params),
  getById: (id: string) => apiClient.get(`/payment-installments/${id}`),
  create: (data: Partial<PaymentInstallment>) => apiClient.post("/payment-installments", data),
  update: (id: string, data: Partial<PaymentInstallment>) => apiClient.patch(`/payment-installments/${id}`, data),
  delete: (id: string) => apiClient.delete(`/payment-installments/${id}`),
  markAsPaid: (id: string, paidAt?: string) => apiClient.patch(`/payment-installments/${id}/pay`, { paidAt }),
  getOverdue: (params?: { orgId?: string }) => apiClient.get("/payment-installments/overdue", params),
};
