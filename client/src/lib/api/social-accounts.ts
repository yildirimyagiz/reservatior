import apiClient from "./client";

export interface CreateSocialAccountRequest {
  orgId: string;
  platform: string;
  accountId: string;
  accountName?: string;
  accessToken: string;
  accessTokenExpiry?: Date;
  wabaId?: string;
  phoneNumberId?: string;
  pageId?: string;
  igUserId?: string;
  webhookSecret?: string;
  isActive?: boolean;
  lastSyncAt?: Date;
}

export interface UpdateSocialAccountRequest extends Partial<CreateSocialAccountRequest> {}

export interface SocialAccount {
  id: string;
  orgId: string;
  platform: string;
  accountId: string;
  accountName?: string;
  accessToken: string;
  accessTokenExpiry?: Date;
  wabaId?: string;
  phoneNumberId?: string;
  pageId?: string;
  igUserId?: string;
  webhookSecret?: string;
  isActive: boolean;
  lastSyncAt?: Date;
  createdAt: Date;
  updatedAt: Date;
}

export const socialAccountsApi = {
  getAll: (params?: { orgId?: string; platform?: string }) =>
    apiClient.get("/social-account", params),
  getById: (id: string) => apiClient.get(`/social-account/${id}`),
  create: (data: CreateSocialAccountRequest) => apiClient.post("/social-account", data),
  update: (id: string, data: UpdateSocialAccountRequest) => apiClient.patch(`/social-account/${id}`, data),
  delete: (id: string) => apiClient.delete(`/social-account/${id}`),
  getByOrg: (orgId: string) => apiClient.get("/social-account", { orgId }),
  getByPlatform: (platform: string) => apiClient.get("/social-account", { platform }),
};
