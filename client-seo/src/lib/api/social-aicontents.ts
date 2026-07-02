import apiClient from "./client";

export interface CreateSocialAIContentRequest {
  orgId: string;
  listingId?: string;
  contentType: string;
  prompt: string;
  generatedText: string;
  generatedHashtags: string[];
  model?: string;
  tokensUsed?: number;
  approved?: boolean;
  approvedByUserId?: string;
  approvedAt?: Date;
  editedText?: string;
}

export interface UpdateSocialAIContentRequest extends Partial<CreateSocialAIContentRequest> {}

export interface SocialAIContent {
  id: string;
  orgId: string;
  listingId?: string;
  contentType: string;
  prompt: string;
  generatedText: string;
  generatedHashtags: string[];
  model: string;
  tokensUsed?: number;
  approved: boolean;
  approvedByUserId?: string;
  approvedAt?: Date;
  editedText?: string;
  createdAt: Date;
}

export const socialAIContentsApi = {
  getAll: (params?: { orgId?: string; listingId?: string; contentType?: string }) =>
    apiClient.get("/social-aicontent", params),
  getById: (id: string) => apiClient.get(`/social-aicontent/${id}`),
  create: (data: CreateSocialAIContentRequest) => apiClient.post("/social-aicontent", data),
  update: (id: string, data: UpdateSocialAIContentRequest) => apiClient.patch(`/social-aicontent/${id}`, data),
  delete: (id: string) => apiClient.delete(`/social-aicontent/${id}`),
  getByOrg: (orgId: string) => apiClient.get("/social-aicontent", { orgId }),
  getByListing: (listingId: string) => apiClient.get("/social-aicontent", { listingId }),
  approve: (id: string, approvedByUserId: string) => apiClient.patch(`/social-aicontent/${id}`, { 
    approved: true, 
    approvedByUserId,
    approvedAt: new Date() 
  }),
};
