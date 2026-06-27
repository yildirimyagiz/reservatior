import apiClient from "./client";

export interface CreateSocialAccountMetricRequest {
  orgId: string;
  socialAccountId: string;
  date: Date;
  followers?: number;
  following?: number;
  totalPosts?: number;
  totalReach?: number;
  totalImpressions?: number;
  totalLeads?: number;
  engagementRate?: number;
}

export interface UpdateSocialAccountMetricRequest extends Partial<CreateSocialAccountMetricRequest> {}

export interface SocialAccountMetric {
  id: string;
  orgId: string;
  socialAccountId: string;
  date: Date;
  followers: number;
  following: number;
  totalPosts: number;
  totalReach: number;
  totalImpressions: number;
  totalLeads: number;
  engagementRate: number;
  createdAt: Date;
}

export const socialAccountMetricsApi = {
  getAll: (params?: { orgId?: string; socialAccountId?: string }) =>
    apiClient.get("/social-accountmetric", params),
  getById: (id: string) => apiClient.get(`/social-accountmetric/${id}`),
  create: (data: CreateSocialAccountMetricRequest) => apiClient.post("/social-accountmetric", data),
  update: (id: string, data: UpdateSocialAccountMetricRequest) => apiClient.patch(`/social-accountmetric/${id}`, data),
  delete: (id: string) => apiClient.delete(`/social-accountmetric/${id}`),
  getByOrg: (orgId: string) => apiClient.get("/social-accountmetric", { orgId }),
  getBySocialAccount: (socialAccountId: string) => apiClient.get("/social-accountmetric", { socialAccountId }),
  getLatest: (socialAccountId: string) => apiClient.get("/social-accountmetric", { socialAccountId }),
};
