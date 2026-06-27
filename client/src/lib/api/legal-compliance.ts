import { apiClient } from "./client";

export interface ComplianceRecord {
  id: string;
  orgId: string;
  type: string;
  title?: string;
  status?: string;
  entityType?: string;
  entityId?: string;
  details?: any;
  expiresAt?: string;
  createdAt: string;
}

export const legalComplianceApi = {
  getRecords: (params?: { orgId?: string; type?: string; status?: string; search?: string; page?: number; limit?: number }) =>
    apiClient.get("/legal-compliance/records", params),
  getRecordById: (id: string) => apiClient.get(`/legal-compliance/records/${id}`),
  createRecord: (data: Partial<ComplianceRecord>) => apiClient.post("/legal-compliance/records", data),
  updateRecord: (id: string, data: Partial<ComplianceRecord>) => apiClient.patch(`/legal-compliance/records/${id}`, data),
  deleteRecord: (id: string) => apiClient.delete(`/legal-compliance/records/${id}`),
  getExpiring: (params?: { orgId?: string; days?: number }) =>
    apiClient.get("/legal-compliance/records/expiring", params),
};
