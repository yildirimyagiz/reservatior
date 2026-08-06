import { apiClient } from "./client";

export interface ComplianceRule {
  id: string;
  country: string;
  category: string;
  title: string;
  description: string;
  isActive: boolean;
  severity: "INFO" | "WARNING" | "ERROR" | "CRITICAL";
  metadata?: any;
  createdAt: string;
  updatedAt: string;
}

export interface ComplianceCheck {
  id: string;
  ruleId: string;
  entityType: string;
  entityId: string;
  passed: boolean;
  severity: string;
  message: string;
  recommendation?: string;
  metadata?: any;
  checkedAt: string;
}

export const complianceOSApi = {
  // Get active rules for country
  getActiveRules: async (country: string): Promise<ComplianceRule[]> => {
    const response = await apiClient.get<ComplianceRule[]>(`/api/v1/compliance-os/rules/${country}`);
    return response;
  },

  // Check rental compliance
  checkCompliance: async (entityId: string, entityType: string): Promise<ComplianceCheck[]> => {
    const response = await apiClient.post<ComplianceCheck[]>(`/api/v1/compliance-os/check`, {
      entityId,
      entityType,
    });
    return response;
  },

  // Create rule
  createRule: async (data: Omit<ComplianceRule, 'id' | 'createdAt' | 'updatedAt'>): Promise<ComplianceRule> => {
    const response = await apiClient.post<ComplianceRule>(`/api/v1/compliance-os/rules`, data);
    return response;
  },

  // Update rule
  updateRule: async (id: string, data: Partial<ComplianceRule>): Promise<ComplianceRule> => {
    const response = await apiClient.put<ComplianceRule>(`/api/v1/compliance-os/rules/${id}`, data);
    return response;
  },

  // Delete rule
  deleteRule: async (id: string): Promise<void> => {
    await apiClient.delete(`/api/v1/compliance-os/rules/${id}`);
  },

  // Get compliance dashboard
  getDashboard: async (orgId?: string): Promise<any> => {
    const response = await apiClient.get(`/api/v1/compliance-os/dashboard`, {
      params: { orgId },
    });
    return response;
  },
};
