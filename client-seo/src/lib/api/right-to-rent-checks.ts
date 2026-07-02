import { apiClient } from "./client";

export interface RightToRentCheck {
  id: string;
  orgId: string;
  tenantId: string;
  propertyId?: string;
  leaseId?: string;
  status: string;
  checkDate?: string;
  expiryDate?: string;
  documentType?: string;
  documentReference?: string;
  conductedBy?: string;
  notes?: string;
  createdAt: string;
}

export const rightToRentChecksApi = {
  getAll: (params?: { orgId?: string; tenantId?: string; propertyId?: string; status?: string; page?: number; limit?: number }) =>
    apiClient.get("/right-to-rent-checks", params),
  getById: (id: string) => apiClient.get(`/right-to-rent-checks/${id}`),
  create: (data: Partial<RightToRentCheck>) => apiClient.post("/right-to-rent-checks", data),
  update: (id: string, data: Partial<RightToRentCheck>) => apiClient.patch(`/right-to-rent-checks/${id}`, data),
  delete: (id: string) => apiClient.delete(`/right-to-rent-checks/${id}`),
  getByTenant: (tenantId: string, params?: any) =>
    apiClient.get(`/right-to-rent-checks/tenant/${tenantId}`, params),
  getExpiring: (params?: { orgId?: string; days?: number }) =>
    apiClient.get("/right-to-rent-checks/expiring", params),
  verify: (id: string, verificationData: any) =>
    apiClient.patch(`/right-to-rent-checks/${id}/verify`, verificationData),
};
