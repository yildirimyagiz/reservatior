import { apiClient } from "./client";

export interface Tenant {
  id: string;
  userId: string;
  firstName: string;
  lastName: string;
  email: string;
  phone?: string;
  phoneNumber?: string; // Some parts of schema use phoneNumber
  leaseStartDate: string;
  leaseEndDate: string;
  isActive: boolean;
  propertyId: string;
  emergencyContact?: string;
  notes?: string;
  createdAt: string;
  updatedAt: string;
  // Scoring fields
  creditScore?: number;
  profession?: string;
  professionCategory?: string;
  paymentMethod?: string;
  paymentHistoryScore?: number;
  depositStatus?: string;
  escrowScore?: number;
  overallScore?: number;
  riskLevel?: string;
  annualPayment?: boolean;
  commissionHistory?: any;
  incomeVerification?: any;
  employmentStatus?: string;
  employmentStartDate?: string;
  monthlyIncome?: number;
  bankAccountVerified?: boolean;
  openBankingConnected?: boolean;
  paymentReliability?: number;
  latePaymentCount?: number;
  onTimePaymentCount?: number;
  totalPaymentAmount?: number;
  lastScoreUpdate?: string;
  // Compliance fields
  rightToRentCheck?: boolean;
  rightToRentExpiry?: string;
  immigrationCheck?: boolean;
  immigrationExpiry?: string;
  propertyCompliance?: boolean;
  propertyComplianceExpiry?: string;
  gasSafetyCheck?: boolean;
  gasSafetyExpiry?: string;
  fireSafetyCheck?: boolean;
  fireSafetyExpiry?: string;
  energyCertificate?: boolean;
  energyCertificateExpiry?: string;
  overallComplianceScore?: number;
  complianceStatus?: 'COMPLIANT' | 'NON_COMPLIANT' | 'EXPIRING_SOON' | 'PENDING';
  User?: {
    id: string;
    name: string;
    email: string;
    phone?: string;
  };
  Lease?: any[]; // Simplified for now
  _count?: {
    Lease: number;
    Payment: number;
  };
}

export interface TenantCreate {
  userId: string;
  propertyId: string;
  firstName: string;
  lastName: string;
  email: string;
  leaseStartDate: string;
  leaseEndDate: string;
  isActive?: boolean;
  phone?: string;
  emergencyContact?: string;
  notes?: string;
  // Scoring fields
  creditScore?: number;
  profession?: string;
  professionCategory?: string;
  paymentMethod?: string;
  depositStatus?: string;
  annualPayment?: boolean;
  employmentStatus?: string;
  employmentStartDate?: string;
  monthlyIncome?: number;
  bankAccountVerified?: boolean;
  openBankingConnected?: boolean;
  // Compliance fields
  rightToRentCheck?: boolean;
  rightToRentExpiry?: string;
  immigrationCheck?: boolean;
  immigrationExpiry?: string;
  propertyCompliance?: boolean;
  propertyComplianceExpiry?: string;
  gasSafetyCheck?: boolean;
  gasSafetyExpiry?: string;
  fireSafetyCheck?: boolean;
  fireSafetyExpiry?: string;
  energyCertificate?: boolean;
  energyCertificateExpiry?: string;
}

export interface TenantUpdate extends Partial<Omit<TenantCreate, 'userId' | 'propertyId'>> {}

export interface TenantsResponse {
  success: boolean;
  data: Tenant[];
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
}

export interface Increase {
  id: string;
  propertyId: string;
  tenantId: string;
  proposedBy: string;
  oldRent: number;
  newRent: number;
  effectiveDate: string;
  status: "PENDING" | "ACCEPTED" | "REJECTED" | "WITHDRAWN";
  createdAt: string;
  updatedAt: string;
  reason?: string;
  percentage?: number;
  fixedAmount?: number;
}

export const tenantsApi = {
  // Existing methods...
  getAll: (params?: { orgId?: string; page?: number; limit?: number; active?: boolean }) => 
    apiClient.get<TenantsResponse>("/tenants", params),
  
  getById: (id: string) => 
    apiClient.get<Tenant>(`/tenants/${id}`),
  
  create: (data: TenantCreate) => 
    apiClient.post<Tenant>("/tenants", data),
  
  update: (id: string, data: TenantUpdate) => 
    apiClient.patch<Tenant>(`/tenants/${id}`, data),
  
  delete: (id: string) => 
    apiClient.delete(`/tenants/${id}`, { data: { tags: [] } }),

  // Rent Increases (HOA based)
  getIncreases: (params?: { orgId?: string; propertyId?: string; type?: string; page?: number; limit?: number }) =>
    apiClient.get<{ data: Increase[]; total: number }>("/hoa/increases", params),

  createIncrease: (data: Partial<Increase> & { orgId: string }) =>
    apiClient.post<{ data: Increase }>("/hoa/increases", data),

  updateIncrease: (id: string, data: Partial<Increase>) =>
    apiClient.patch<{ data: Increase }>(`/hoa/increases/${id}`, data),

  deleteIncrease: (id: string) =>
    apiClient.delete(`/hoa/increases/${id}`, { data: { tags: [] } }),

  getLeases: (id: string, params?: { page?: number; limit?: number; status?: string }) =>
    apiClient.get<any>(`/tenants/${id}/leases`, params),

  getPayments: (id: string, params?: { page?: number; limit?: number; status?: string; type?: string }) =>
    apiClient.get<any>(`/tenants/${id}/payments`, params),

  getMaintenance: (id: string, params?: { page?: number; limit?: number; status?: string; priority?: string }) =>
    apiClient.get<any>(`/tenants/${id}/maintenance`, params),

  // Scoring endpoints
  calculateScore: (id: string) =>
    apiClient.post<Tenant>(`/tenant/${id}/calculate-score`, {}),

  getScore: (id: string) =>
    apiClient.get<Tenant>(`/tenant/${id}/score`),
};
