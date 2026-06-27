import apiClient from "./client";

export interface CreateSocialInboundMessageRequest {
  orgId: string;
  socialAccountId: string;
  postId?: string;
  externalMessageId: string;
  externalSenderId: string;
  senderName?: string;
  senderProfileUrl?: string;
  channel: string;
  messageText: string;
  mediaUrls: string[];
  sentiment?: string;
  intent?: string;
  status?: string;
  isLeadConverted?: boolean;
  leadId?: string;
  chatSessionId?: string;
  receivedAt: Date;
}

export interface UpdateSocialInboundMessageRequest extends Partial<CreateSocialInboundMessageRequest> {}

export interface SocialInboundMessage {
  id: string;
  orgId: string;
  socialAccountId: string;
  postId?: string;
  externalMessageId: string;
  externalSenderId: string;
  senderName?: string;
  senderProfileUrl?: string;
  channel: string;
  messageText: string;
  mediaUrls: string[];
  sentiment?: string;
  intent?: string;
  status: string;
  isLeadConverted: boolean;
  leadId?: string;
  chatSessionId?: string;
  receivedAt: Date;
  createdAt: Date;
}

export const socialInboundMessagesApi = {
  getAll: (params?: { orgId?: string; socialAccountId?: string; status?: string }) =>
    apiClient.get("/social-inboundmessage", params),
  getById: (id: string) => apiClient.get(`/social-inboundmessage/${id}`),
  create: (data: CreateSocialInboundMessageRequest) => apiClient.post("/social-inboundmessage", data),
  update: (id: string, data: UpdateSocialInboundMessageRequest) => apiClient.patch(`/social-inboundmessage/${id}`, data),
  delete: (id: string) => apiClient.delete(`/social-inboundmessage/${id}`),
  getByOrg: (orgId: string) => apiClient.get("/social-inboundmessage", { orgId }),
  getBySocialAccount: (socialAccountId: string) => apiClient.get("/social-inboundmessage", { socialAccountId }),
  getByPost: (postId: string) => apiClient.get("/social-inboundmessage", { postId }),
  convertToLead: (id: string, leadId: string) => apiClient.patch(`/social-inboundmessage/${id}`, { 
    isLeadConverted: true, 
    leadId,
    status: "LEAD_CREATED" 
  }),
};
