import apiClient from "./client";

export interface CreateSocialAutomationRuleRequest {
  orgId: string;
  socialAccountId: string;
  name: string;
  triggerType: string;
  keywords: string[];
  action: string;
  aiPromptTemplate?: string;
  assignToUserId?: string;
  isActive?: boolean;
  priority?: number;
}

export interface UpdateSocialAutomationRuleRequest extends Partial<CreateSocialAutomationRuleRequest> {}

export interface SocialAutomationRule {
  id: string;
  orgId: string;
  socialAccountId: string;
  name: string;
  triggerType: string;
  keywords: string[];
  action: string;
  aiPromptTemplate?: string;
  assignToUserId?: string;
  isActive: boolean;
  priority: number;
  createdAt: Date;
  updatedAt: Date;
}

export const socialAutomationRulesApi = {
  getAll: (params?: { orgId?: string; socialAccountId?: string; isActive?: boolean }) =>
    apiClient.get("/social-automationrule", params),
  getById: (id: string) => apiClient.get(`/social-automationrule/${id}`),
  create: (data: CreateSocialAutomationRuleRequest) => apiClient.post("/social-automationrule", data),
  update: (id: string, data: UpdateSocialAutomationRuleRequest) => apiClient.patch(`/social-automationrule/${id}`, data),
  delete: (id: string) => apiClient.delete(`/social-automationrule/${id}`),
  getByOrg: (orgId: string) => apiClient.get("/social-automationrule", { orgId }),
  getBySocialAccount: (socialAccountId: string) => apiClient.get("/social-automationrule", { socialAccountId }),
  toggleActive: (id: string, isActive: boolean) => apiClient.patch(`/social-automationrule/${id}`, { isActive }),
};
