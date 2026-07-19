import { apiClient } from "./client";

export interface IncomeReadyCertificate {
  id: string;
  orgId: string;
  propertyId: string;
  propertyName: string;
  tier: string;
  status: string;
  certificateNumber: string;
  moveInReady: boolean;
  incomeReady: boolean;
  investmentReady: boolean;
  trustScore: number;
  annualIncome: number;
  occupancyRate: number;
  maintenanceScore: number;
  complianceStatus: string;
  monthsRented: number;
  totalIncome: number;
  averageMonthlyRent: number;
  yieldRate: number;
  furnishedBy?: string;
  furnitureValue?: number;
  issuedAt: string;
  expiresAt?: string;
  metadata?: any;
  createdAt: string;
  updatedAt: string;
}

export interface CertificateCreate {
  propertyId: string;
  propertyName: string;
  tier: string;
}

export const certificatesApi = {
  getAll: async (params?: any) => {
    return apiClient.get<IncomeReadyCertificate[]>("/certificates", params);
  },
  getById: async (id: string) => {
    return apiClient.get<IncomeReadyCertificate>(`/certificates/${id}`);
  },
  verify: async (certificateNumber: string) => {
    return apiClient.get<IncomeReadyCertificate>(`/certificates/verify/${certificateNumber}`);
  },
  issue: async (data: CertificateCreate) => {
    return apiClient.post<IncomeReadyCertificate>("/certificates", data);
  },
  upgradeTier: async (id: string, tier: string) => {
    return apiClient.patch<IncomeReadyCertificate>(`/certificates/${id}/upgrade`, { tier });
  },
  getByProperty: async (propertyId: string) => {
    return apiClient.get<IncomeReadyCertificate[]>(`/certificates/property/${propertyId}`);
  },
  delete: async (id: string) => {
    return apiClient.delete(`/certificates/${id}`);
  },
};
