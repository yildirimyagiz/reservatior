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
  getRightToRentChecks: (params?: any) => apiClient.get("/right-to-rent-checks", params),
  getRightToRentCheck: (id: string) => apiClient.get(`/right-to-rent-checks/${id}`),
  createRightToRentCheck: (data: any) => apiClient.post("/right-to-rent-checks", data),
  updateRightToRentCheck: (id: string, data: any) => apiClient.patch(`/right-to-rent-checks/${id}`, data),
  deleteRightToRentCheck: (id: string) => apiClient.delete(`/right-to-rent-checks/${id}`),

  // Immigration Status
  getImmigrationChecks: (params?: any) => apiClient.get("/immigration-status-checks", params),
  getImmigrationCheck: (id: string) => apiClient.get(`/immigration-status-checks/${id}`),
  updateImmigrationCheck: (id: string, data: any) => apiClient.patch(`/immigration-status-checks/${id}`, data),

  // Property Compliance (Inspections)
  getPropertyCompliance: (params?: any) => apiClient.get("/property-compliance", params),
  getPropertyComplianceDetail: (id: string) => apiClient.get(`/property-compliance/${id}`),
  createPropertyCompliance: (data: any) => apiClient.post("/property-compliance", data),
  updatePropertyCompliance: (id: string, data: any) => apiClient.patch(`/property-compliance/${id}`, data),

  // Property Disclosures
  getPropertyDisclosures: (params?: any) => apiClient.get("/property-disclosure", params),
  getDisclosure: (id: string) => apiClient.get(`/property-disclosure/${id}`),
  updateDisclosure: (id: string, data: any) => apiClient.patch(`/property-disclosure/${id}`, data),

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
