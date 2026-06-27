import { apiClient } from "./client";

export interface TenantApplication {
  id: string;
  propertyId: string;
  listingId?: string;
  applicantId: string;
  status: 'PENDING' | 'UNDER_REVIEW' | 'APPROVED' | 'REJECTED';
  submittedAt: string;
  reviewedAt?: string;
  reviewedBy?: string;
  applicationData: any;
  creditScore?: number;
  incomeVerified: boolean;
  backgroundCheck: boolean;
  organizationId?: string;
  applicant?: {
    firstName: string;
    lastName: string;
    email: string;
  };
  listing?: {
    title: string;
  };
  // Behavior tracking fields
  searchHistory?: string[];
  viewedProperties?: string[];
  preferredPriceRange?: { min: number; max: number };
  preferredLocations?: string[];
  propertyTypes?: string[];
  moveInDate?: string;
  leaseDuration?: number;
  pets?: boolean;
  smoking?: boolean;
  // Lead scoring
  leadScore?: number;
  engagementLevel?: 'LOW' | 'MEDIUM' | 'HIGH';
  lastActivity?: string;
  applicationCount?: number;
  // Landlord matching
  matchedLandlords?: string[];
  landlordNotificationsSent?: number;
  landlordResponseRate?: number;
  // UI helper fields (flattened from applicationData or relations)
  applicantName?: string;
  email?: string;
  propertyName?: string;
  income?: number;
  employmentStatus?: string;
}

export interface CreateTenantApplicationRequest {
  orgId: string;
  listingId: string;
  firstName: string;
  lastName: string;
  email?: string;
  phone?: string;
  status?: string;
  monthlyIncome?: number;
  employmentStatus?: string;
  moveInDate?: string;
  notes?: string;
  // Behavior tracking
  searchHistory?: string[];
  viewedProperties?: string[];
  preferredPriceRange?: { min: number; max: number };
  preferredLocations?: string[];
  propertyTypes?: string[];
  leaseDuration?: number;
  pets?: boolean;
  smoking?: boolean;
}

export const tenantApplicationsApi = {
  getAll: (params?: { page?: number; limit?: number; orgId?: string; listingId?: string; status?: string; search?: string }) =>
    apiClient.get<{ data: TenantApplication[]; total: number }>("/cx/tenant-applications", params),

  getById: (id: string) =>
    apiClient.get<{ data: TenantApplication }>(`/cx/tenant-applications/${id}`),

  create: (data: CreateTenantApplicationRequest) =>
    apiClient.post<{ data: TenantApplication }>("/cx/tenant-applications", data),

  update: (id: string, data: Partial<CreateTenantApplicationRequest>) =>
    apiClient.patch<{ data: TenantApplication }>(`/cx/tenant-applications/${id}`, data),

  delete: (id: string) =>
    apiClient.delete(`/cx/tenant-applications/${id}`, { data: { tags: [] } }),

  getStats: () =>
    apiClient.get<any>("/cx/tenant-applications/stats"),

  // Lead scoring and matching
  calculateLeadScore: (id: string) =>
    apiClient.post<{ data: { leadScore: number; engagementLevel: string } }>(`/cx/tenant-applications/${id}/calculate-score`, {}),

  matchWithLandlords: (id: string) =>
    apiClient.post<{ data: { matchedLandlords: string[] } }>(`/cx/tenant-applications/${id}/match-landlords`, {}),

  sendToLandlords: (id: string, landlordIds: string[]) =>
    apiClient.post<{ data: { sent: number } }>(`/cx/tenant-applications/${id}/notify-landlords`, { landlordIds }),

  getBehaviorAnalytics: (id: string) =>
    apiClient.get<{ data: any }>(`/cx/tenant-applications/${id}/behavior-analytics`),
};
