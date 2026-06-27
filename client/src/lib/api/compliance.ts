import { apiClient } from "./index";

export interface RightToRentCheck {
  id: string;
  orgId: string;
  leaseId?: string;
  contactId: string;
  checkType: string;
  reference: string;
  status: string;
  checkedAt?: string;
  expiresAt?: string;
  result?: any;
  createdAt: string;
  updatedAt: string;
}

export interface ImmigrationStatusCheck {
  id: string;
  orgId: string;
  leaseId: string;
  tenantId: string;
  checkStatus: string;
  checkDate?: string;
  validUntil?: string;
  immigrationStatus?: string;
  visaType?: string;
  visaExpiry?: string;
  documentType?: string;
  documentNumber?: string;
  documentVerified: boolean;
  shareCode?: string;
  checkReference?: string;
  notes?: string;
  createdAt: string;
  updatedAt: string;
}

export interface PropertyCompliance {
  id: string;
  orgId: string;
  propertyId: string;
  type: string;
  status: string;
  data?: any;
  inspectorId?: string;
  inspectorContactId?: string;
  createdAt: string;
  updatedAt: string;
}

export interface PropertyDisclosure {
  id: string;
  orgId: string;
  propertyId: string;
  packStatus: string;
  submittedDate?: string;
  energyPerformanceCertificate?: any;
  floorPlan?: any;
  leaseholdInfo?: any;
  boundaryPlan?: any;
  planningPermission?: any;
  propertyQuestionnaire?: any;
  electricalSafety?: any;
  gasSafety?: any;
  fireSafety?: any;
  completionNotes?: string;
  createdAt: string;
}

export const complianceApi = {
  // Right to Rent
  getRightToRentChecks: (params?: any) => apiClient.get("/right-to-rent-check", params),
  getRightToRentCheck: (id: string) => apiClient.get(`/right-to-rent-check/${id}`),
  createRightToRentCheck: (data: any) => apiClient.post("/right-to-rent-check", data),
  updateRightToRentCheck: (id: string, data: any) => apiClient.patch(`/right-to-rent-check/${id}`, data),
  deleteRightToRentCheck: (id: string) => apiClient.delete(`/right-to-rent-check/${id}`),

  // Immigration Status
  getImmigrationChecks: (params?: any) => apiClient.get("/compliance/immigration", params),
  getImmigrationCheck: (id: string) => apiClient.get(`/compliance/immigration/${id}`),
  updateImmigrationCheck: (id: string, data: any) => apiClient.patch(`/compliance/immigration/${id}`, data),

  // Property Compliance (Inspections)
  getPropertyCompliance: (params?: any) => apiClient.get("/compliance/property", params),
  getPropertyComplianceDetail: (id: string) => apiClient.get(`/compliance/property/${id}`),
  createPropertyCompliance: (data: any) => apiClient.post("/compliance/property", data),
  updatePropertyCompliance: (id: string, data: any) => apiClient.patch(`/compliance/property/${id}`, data),

  // Property Disclosures
  getPropertyDisclosures: (params?: any) => apiClient.get("/compliance/disclosures", params),
  getDisclosure: (id: string) => apiClient.get(`/compliance/disclosures/${id}`),
  updateDisclosure: (id: string, data: any) => apiClient.patch(`/compliance/disclosures/${id}`, data),

  // Compliance Records
  getComplianceRecords: (params?: any) => apiClient.get("/compliance-record", params),
  getComplianceRecord: (id: string) => apiClient.get(`/compliance-record/${id}`),
  createComplianceRecord: (data: any) => apiClient.post("/compliance-record", data),
  updateComplianceRecord: (id: string, data: any) => apiClient.patch(`/compliance-record/${id}`, data),
  deleteComplianceRecord: (id: string) => apiClient.delete(`/compliance-record/${id}`),

  // Tenant Compliance
  getTenantCompliance: (tenantId: string) => apiClient.get(`/tenant/${tenantId}/compliance`),
  updateTenantCompliance: (tenantId: string, data: any) => apiClient.patch(`/tenant/${tenantId}/compliance`, data),
  calculateComplianceScore: (tenantId: string) => apiClient.post(`/tenant/${tenantId}/calculate-compliance-score`, {}),
};
