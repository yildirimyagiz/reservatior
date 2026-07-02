import { apiClient } from "./client";

export interface GlobalTaxRegulation {
  id: string;
  orgId: string;
  propertyId: string;
  taxAuthority: string; // 'IRS', 'GIB', 'GELIR_IDARESI'
  taxType: string; // 'VAT', 'GST', 'ISS', 'TOT'
  taxRate: number;
  isAutomated: boolean;
  reportingInterval: "MONTHLY" | "QUARTERLY" | "ANNUALLY";
  lastReportedAt?: string;
  config?: any;
}

export interface LegalCompliance {
  id: string;
  orgId: string;
  countryCode: string;
  regionCode?: string;
  complianceType: string; // 'GDPR', 'KVKK', 'AML', 'KYC'
  status: "COMPLIANT" | "NON_COMPLIANT" | "PENDING" | "EXEMPT";
  lastAuditAt?: string;
  nextAuditDue?: string;
  metadata?: any;
}

export interface PlatformRevenueRecord {
  id: string;
  orgId: string;
  transactionId?: string;
  bookingId?: string;
  leaseId?: string;
  amount: number;
  currency: string;
  source: "COMMISSION" | "SUBSCRIPTION" | "AI_SERVICE" | "ADVERTISING";
  sourceType: "PLATFORM_FEE" | "PARTNER_FEE" | "TAX_RETENTION";
  billingPeriod?: string;
  status: "PENDING" | "PROCESSED" | "FAILED";
  processedAt?: string;
  metadata?: any;
  createdAt: string;
}

export const orchestrationApi = {
  // Tax Regulations
  getTaxRegulations: (params?: { orgId?: string; propertyId?: string }) => 
    apiClient.get<GlobalTaxRegulation[]>("/orchestration/tax-regulations", params),
  updateTaxRegulation: (id: string, data: Partial<GlobalTaxRegulation>) =>
    apiClient.patch<GlobalTaxRegulation>(`/orchestration/tax-regulations/${id}`, data),

  // Legal Compliance
  getComplianceRecords: (params?: { countryCode?: string; status?: string }) =>
    apiClient.get<LegalCompliance[]>("/orchestration/compliance", params),
  verifyCompliance: (id: string) =>
    apiClient.post(`/orchestration/compliance/${id}/verify`),

  // Platform Revenue
  getRevenueRecords: (params?: { source?: string; status?: string }) =>
    apiClient.get<PlatformRevenueRecord[]>("/orchestration/revenue", params),
  getRevenueStats: (params?: { startDate?: string; endDate?: string }) =>
    apiClient.get("/orchestration/revenue/stats", params),

  // Global Config (Merged with RegionManager)
  getGlobalConfig: () => apiClient.get("/orchestration/config"),
};
