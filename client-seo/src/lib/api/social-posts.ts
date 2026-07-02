import apiClient from "./client";

export interface CreateSocialPostRequest {
  orgId: string;
  socialAccountId: string;
  listingId?: string;
  campaignId?: string;
  createdByUserId?: string;
  aiGenerationId?: string;
  platform: string;
  postType: string;
  status?: string;
  content: string;
  mediaUrls: string[];
  hashtags: string[];
  externalPostId?: string;
  externalPostUrl?: string;
  scheduledAt?: Date;
  publishedAt?: Date;
  failureReason?: string;
}

export interface UpdateSocialPostRequest extends Partial<CreateSocialPostRequest> {}

export interface SocialPost {
  id: string;
  orgId: string;
  socialAccountId: string;
  listingId?: string;
  campaignId?: string;
  createdByUserId?: string;
  aiGenerationId?: string;
  platform: string;
  postType: string;
  status: string;
  content: string;
  mediaUrls: string[];
  hashtags: string[];
  externalPostId?: string;
  externalPostUrl?: string;
  scheduledAt?: Date;
  publishedAt?: Date;
  failureReason?: string;
  reach: number;
  impressions: number;
  likes: number;
  comments: number;
  shares: number;
  clicks: number;
  leads: number;
  createdAt: Date;
  updatedAt: Date;
}

export const socialPostsApi = {
  getAll: (params?: { orgId?: string; socialAccountId?: string; status?: string }) =>
    apiClient.get("/social-post", params),
  getById: (id: string) => apiClient.get(`/social-post/${id}`),
  create: (data: CreateSocialPostRequest) => apiClient.post("/social-post", data),
  update: (id: string, data: UpdateSocialPostRequest) => apiClient.patch(`/social-post/${id}`, data),
  delete: (id: string) => apiClient.delete(`/social-post/${id}`),
  getByOrg: (orgId: string) => apiClient.get("/social-post", { orgId }),
  getBySocialAccount: (socialAccountId: string) => apiClient.get("/social-post", { socialAccountId }),
  getByListing: (listingId: string) => apiClient.get("/social-post", { listingId }),
};
