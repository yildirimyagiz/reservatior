import { apiClient } from "./client";

export enum PaymentLedgerStatus {
  PAID = "PAID",
  UNPAID = "UNPAID",
  OVERDUE = "OVERDUE",
  REFUNDED = "REFUNDED",
  PARTIAL = "PARTIAL",
}

export interface Payment {
  id: string;
  orgId: string;
  propertyId?: string;
  leaseId?: string;
  tenantId?: string;
  amount: number;
  currency: string;
  paymentDate?: string;
  dueDate: string;
  status: PaymentLedgerStatus;
  paymentMethod?: string;
  reference?: string;
  notes?: string;
  createdAt: string;
  updatedAt: string;
  property?: {
    id: string;
    name: string;
    addressLine1: string;
  };
  tenant?: {
    id: string;
    name: string;
    email: string;
  };
}

export interface PaymentsPaginatedResponse<T> {
  data: T[];
  total: number;
  page: number;
  limit: number;
}

export const paymentsApi = {
  getPayments: (params?: { 
    orgId?: string; 
    status?: string; 
    propertyId?: string; 
    page?: number; 
    limit?: number 
  }) => apiClient.get<Payment[]>("/payments", params), // Backend returns array directly for GET / according to code
  
  getPayment: (id: string) => apiClient.get<Payment>(`/payments/${id}`),
  
  createPayment: (data: Partial<Payment> & { orgId: string; amount: number; status: string }) => 
    apiClient.post<Payment>("/payments", data),
    
  updatePayment: (id: string, data: Partial<Payment>) => 
    apiClient.patch<Payment>(`/payments/${id}`, data),
    
  deletePayment: (id: string) => 
    apiClient.delete(`/payments/${id}`, { data: { tags: [] } } as any),
};
