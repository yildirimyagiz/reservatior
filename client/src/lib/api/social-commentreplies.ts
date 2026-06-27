import apiClient from "./client";

export interface CreateSocialCommentReplyRequest {
  orgId: string;
  inboundMessageId: string;
  postId?: string;
  replyText: string;
  replySource: string;
  aiContentId?: string;
  repliedByUserId?: string;
  externalReplyId?: string;
  sentAt?: Date;
  failureReason?: string;
}

export interface UpdateSocialCommentReplyRequest extends Partial<CreateSocialCommentReplyRequest> {}

export interface SocialCommentReply {
  id: string;
  orgId: string;
  inboundMessageId: string;
  postId?: string;
  replyText: string;
  replySource: string;
  aiContentId?: string;
  repliedByUserId?: string;
  externalReplyId?: string;
  sentAt?: Date;
  failureReason?: string;
  createdAt: Date;
}

export const socialCommentRepliesApi = {
  getAll: (params?: { orgId?: string; postId?: string }) =>
    apiClient.get("/social-commentreply", params),
  getById: (id: string) => apiClient.get(`/social-commentreply/${id}`),
  create: (data: CreateSocialCommentReplyRequest) => apiClient.post("/social-commentreply", data),
  update: (id: string, data: UpdateSocialCommentReplyRequest) => apiClient.patch(`/social-commentreply/${id}`, data),
  delete: (id: string) => apiClient.delete(`/social-commentreply/${id}`),
  getByOrg: (orgId: string) => apiClient.get("/social-commentreply", { orgId }),
  getByPost: (postId: string) => apiClient.get("/social-commentreply", { postId }),
};
