import { apiClient } from "./client";

export interface Supplier {
  id: string;
  orgId: string;
  name: string;
  description?: string;
  contactName?: string;
  email?: string;
  phone?: string;
  website?: string;
  logo?: string;
  taxId?: string;
  businessType?: string;
  country?: string;
  city?: string;
  paymentTerms?: string;
  minimumOrder?: number;
  currency?: string;
  leadTimeDays?: number;
  commissionRate?: number;
  status: string;
  rating?: number;
  verifiedAt?: string;
  metadata?: any;
  createdAt: string;
  updatedAt: string;
}

export interface SupplierCreate {
  name: string;
  description?: string;
  contactName?: string;
  email?: string;
  phone?: string;
  website?: string;
  taxId?: string;
  businessType?: string;
  country?: string;
  city?: string;
  paymentTerms?: string;
  minimumOrder?: number;
  currency?: string;
  leadTimeDays?: number;
  commissionRate?: number;
}

export const suppliersApi = {
  getAll: async (params?: any) => {
    return apiClient.get<Supplier[]>("/suppliers", params);
  },
  getById: async (id: string) => {
    return apiClient.get<Supplier>(`/suppliers/${id}`);
  },
  create: async (data: SupplierCreate) => {
    return apiClient.post<Supplier>("/suppliers", data);
  },
  update: async (id: string, data: Partial<SupplierCreate>) => {
    return apiClient.patch<Supplier>(`/suppliers/${id}`, data);
  },
  delete: async (id: string) => {
    return apiClient.delete(`/suppliers/${id}`);
  },
};
