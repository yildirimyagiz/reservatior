import { apiClient } from "./client";

export interface REOProperty {
  id: string;
  orgId: string;
  propertyId: string;
  portfolioId: string;
  status: string;
  propertyType: string;
  loanId: string;
  borrowerName: string;
  originalLoanAmount: number;
  outstandingBalance: number;
  asIsValue: number;
  afterRepairValue: number;
  estimatedRepairCost: number;
  lastAppraisalDate: string;
  appraisalCompany: string;
  assetManagerId: string;
  propertyManagerId: string;
  maintenanceVendorId: string;
  carryingCost: number;
  insuranceCost: number;
  taxLiability: number;
  acquiredAt: string;
  listedAt: string;
  soldAt: string;
  targetDisposalDate: string;
  dispositionStrategy: string;
  expectedRecoveryRate: number;
  metadata: Record<string, any>;
  createdAt: string;
  updatedAt: string;
}

export interface InstitutionalPortfolio {
  id: string;
  orgId: string;
  name: string;
  description: string;
  portfolioType: string;
  strategy: string;
  targetReturn: number;
  totalValue: number;
  totalProperties: number;
  totalLoans: number;
  averageRecoveryRate: number;
  status: string;
  managerId: string;
  startDate: string;
  endDate: string;
  metadata: Record<string, any>;
  createdAt: string;
  updatedAt: string;
}

export interface PortfolioHolding {
  id: string;
  portfolioId: string;
  reoPropertyId: string;
  allocatedAmount: number;
  entryValue: number;
  currentValue: number;
  exitStrategy: string;
  acquiredAt: string;
  metadata: Record<string, any>;
  createdAt: string;
  updatedAt: string;
}

export const reoPortfolioApi = {
  getAllPortfolios: (params?: { orgId?: string; status?: string; page?: number; limit?: number }) =>
    apiClient.get<{ data: InstitutionalPortfolio[]; total: number }>("/institutional-portfolios", params),

  getPortfolioById: (id: string) =>
    apiClient.get<{ data: InstitutionalPortfolio }>(`/institutional-portfolios/${id}`),

  createPortfolio: (data: {
    orgId: string;
    name: string;
    description?: string;
    portfolioType: string;
    strategy?: string;
    targetReturn?: number;
    managerId?: string;
    metadata?: Record<string, any>;
  }) =>
    apiClient.post<{ data: InstitutionalPortfolio }>("/institutional-portfolios", data),

  updatePortfolio: (id: string, data: Partial<InstitutionalPortfolio>) =>
    apiClient.patch<{ data: InstitutionalPortfolio }>(`/institutional-portfolios/${id}`, data),

  getPortfolioMetrics: (id: string) =>
    apiClient.get<{ data: Record<string, any> }>(`/institutional-portfolios/${id}/metrics`),

  getAllProperties: (params?: { orgId?: string; portfolioId?: string; status?: string; page?: number; limit?: number }) =>
    apiClient.get<{ data: REOProperty[]; total: number }>("/reo-properties", params),

  getPropertyById: (id: string) =>
    apiClient.get<{ data: REOProperty }>(`/reo-properties/${id}`),

  createProperty: (data: {
    orgId: string;
    portfolioId: string;
    propertyId: string;
    propertyType: string;
    loanId?: string;
    borrowerName?: string;
    originalLoanAmount?: number;
    outstandingBalance?: number;
    asIsValue?: number;
    afterRepairValue?: number;
    estimatedRepairCost?: number;
    assetManagerId?: string;
    propertyManagerId?: string;
    dispositionStrategy?: string;
    metadata?: Record<string, any>;
  }) =>
    apiClient.post<{ data: REOProperty }>("/reo-properties", data),

  updateProperty: (id: string, data: Partial<REOProperty>) =>
    apiClient.patch<{ data: REOProperty }>(`/reo-properties/${id}`, data),

  addHolding: (portfolioId: string, data: {
    reoPropertyId: string;
    allocatedAmount: number;
    entryValue: number;
    exitStrategy?: string;
    metadata?: Record<string, any>;
  }) =>
    apiClient.post<{ data: PortfolioHolding }>(`/institutional-portfolios/${portfolioId}/holdings`, data),

  removeHolding: (portfolioId: string, holdingId: string) =>
    apiClient.delete(`/institutional-portfolios/${portfolioId}/holdings/${holdingId}`),
};
