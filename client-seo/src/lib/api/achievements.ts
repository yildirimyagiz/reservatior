import { apiClient } from "./client";

export interface Achievement {
  id: string;
  orgId: string;
  userId?: string;
  agentId?: string;
  teamId?: string;
  title: string;
  description: string;
  type: "SALES" | "LISTINGS" | "CLIENT_SATISFACTION" | "RESPONSE_TIME" | "CONVERSION_RATE" | "REVENUE" | "PROPERTIES_SOLD" | "DEALS_CLOSED" | "CUSTOM" | "COMPLIANCE" | "AUDIT_COMPLETED" | "POLICY_APPROVED" | "INVESTMENT_MADE" | "ROI_ACHIEVED" | "PORTFOLIO_GROWTH" | "TASK_COMPLETED" | "EFFICIENCY_TARGET" | "PROCESS_OPTIMIZED" | "PARTNER_ACQUIRED" | "PARTNERSHIP_RENEWED" | "PARTNER_REVENUE_TARGET" | "THREAT_BLOCKED" | "INCIDENT_RESOLVED" | "SECURITY_COMPLIANCE" | "VERIFICATION_COMPLETED" | "TRUST_SCORE_ACHIEVED" | "CAMPAIGN_SUCCESS" | "CONVERSION_TARGET" | "ADS_ROI_TARGET" | "MODEL_ACCURACY" | "PREDICTION_SUCCESS" | "INSIGHT_GENERATED" | "ORDER_COMPLETED" | "COMMERCE_REVENUE_TARGET" | "COMMERCE_CUSTOMER_SATISFACTION" | "LEAD_CONVERTED" | "PIPELINE_TARGET" | "CUSTOMER_ACQUIRED" | "API_USAGE_TARGET" | "KEY_ISSUED" | "INTEGRATION_COMPLETED" | "ANALYTICS_VIEWED" | "INSIGHT_GENERATED_ANALYTICS" | "REPORT_GENERATED" | "BOOKING_COMPLETED" | "OCCUPANCY_TARGET" | "REVENUE_TARGET_BOOKING" | "DOCUMENT_PROCESSED" | "COMPLIANCE_CHECKED" | "DOCUMENT_APPROVED" | "IDENTITY_VERIFIED" | "KYC_COMPLETED" | "IDENTITY_APPROVED" | "LOCALIZATION_COMPLETED" | "TRANSLATION_DONE" | "CURRENCY_CONVERTED" | "NOTIFICATION_SENT" | "NOTIFICATION_OPENED" | "NOTIFICATION_CLICKED" | "USER_REGISTERED" | "USER_ACTIVE" | "USER_ENGAGED" | "LISTING_PUBLISHED" | "LISTING_VIEWED" | "LISTING_INQUIRED" | "FINANCE_TARGET" | "BUDGET_MET" | "EXPENSES_OPTIMIZED" | "PROFIT_ACHIEVED" | "CONSENT_GRANTED" | "CONSENT_MANAGED" | "PRIVACY_COMPLIANCE" | "GDPR_COMPLIANT";
  category: string;
  value: number;
  unit: string;
  targetValue?: number;
  achievedAt?: string;
  expiresAt?: string;
  status: "PENDING" | "ACHIEVED" | "EXPIRED" | "CANCELLED";
  badge?: {
    id: string;
    name: string;
    icon: string;
    color: string;
  };
  rewards?: Array<{
    id: string;
    name: string;
    description: string;
    value: number;
    type: "BONUS" | "COMMISSION" | "POINTS" | "RECOGNITION";
  }>;
  createdAt: string;
  updatedAt: string;
  user?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
  agent?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
  team?: {
    id: string;
    name: string;
  };
}

export const achievementsApi = {
  // Get all achievements
  getAll: async (orgId: string): Promise<Achievement[]> => {
    const response = await apiClient.get<Achievement[]>(`/organizations/${orgId}/achievements`);
    return response;
  },

  // Get achievement by ID
  getById: async (orgId: string, id: string): Promise<Achievement> => {
    const response = await apiClient.get<Achievement>(`/organizations/${orgId}/achievements/${id}`);
    return response;
  },

  // Create new achievement
  create: async (orgId: string, data: Omit<Achievement, 'id' | 'createdAt' | 'updatedAt' | 'user' | 'agent' | 'team'>): Promise<Achievement> => {
    const response = await apiClient.post<Achievement>(`/organizations/${orgId}/achievements`, data);
    return response;
  },

  // Update achievement
  update: async (orgId: string, id: string, data: Partial<Achievement>): Promise<Achievement> => {
    const response = await apiClient.put<Achievement>(`/organizations/${orgId}/achievements/${id}`, data);
    return response;
  },

  // Delete achievement
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/achievements/${id}`);
  },

  // Get achievements by user
  getByUser: async (orgId: string, userId: string): Promise<Achievement[]> => {
    const response = await apiClient.get<Achievement[]>(`/organizations/${orgId}/users/${userId}/achievements`);
    return response;
  },

  // Get achievements by agent
  getByAgent: async (orgId: string, agentId: string): Promise<Achievement[]> => {
    const response = await apiClient.get<Achievement[]>(`/organizations/${orgId}/agents/${agentId}/achievements`);
    return response;
  },

  // Get achievements by team
  getByTeam: async (orgId: string, teamId: string): Promise<Achievement[]> => {
    const response = await apiClient.get<Achievement[]>(`/organizations/${orgId}/teams/${teamId}/achievements`);
    return response;
  },

  // Update achievement status
  updateStatus: async (orgId: string, id: string, status: Achievement['status']): Promise<Achievement> => {
    const response = await apiClient.patch<Achievement>(`/organizations/${orgId}/achievements/${id}/status`, { status });
    return response;
  },

  // Award achievement
  award: async (orgId: string, id: string, data: {
    userId?: string;
    agentId?: string;
    teamId?: string;
    awardedAt: string;
    notes?: string;
  }): Promise<Achievement> => {
    const response = await apiClient.post<Achievement>(`/organizations/${orgId}/achievements/${id}/award`, data);
    return response;
  },

  // Get achievement statistics
  getStatistics: async (orgId: string): Promise<{
    total: number;
    pending: number;
    achieved: number;
    expired: number;
    cancelled: number;
    byType: Record<string, number>;
    byCategory: Record<string, number>;
    topPerformers: Array<{
      userId?: string;
      agentId?: string;
      name: string;
      achievementCount: number;
      totalValue: number;
    }>;
  }> => {
    const response = await apiClient.get<{
      total: number;
      pending: number;
      achieved: number;
      expired: number;
      cancelled: number;
      byType: Record<string, number>;
      byCategory: Record<string, number>;
      topPerformers: Array<{
        userId?: string;
        agentId?: string;
        name: string;
        achievementCount: number;
        totalValue: number;
      }>;
    }>(`/organizations/${orgId}/achievements/statistics`);
    return response;
  },

  // Get achievement templates
  getTemplates: async (orgId: string): Promise<Array<{
    id: string;
    name: string;
    description: string;
    type: Achievement['type'];
    category: string;
    defaultValue: number;
    unit: string;
    badge?: {
      name: string;
      icon: string;
      color: string;
    };
  }>> => {
    const response = await apiClient.get<Array<{
      id: string;
      name: string;
      description: string;
      type: Achievement['type'];
      category: string;
      defaultValue: number;
      unit: string;
      badge?: {
        name: string;
        icon: string;
        color: string;
      };
    }>>(`/organizations/${orgId}/achievements/templates`);
    return response;
  },

  // Bulk award achievements
  bulkAward: async (orgId: string, data: Array<{
    achievementId: string;
    userId?: string;
    agentId?: string;
    teamId?: string;
    awardedAt: string;
    notes?: string;
  }>): Promise<Achievement[]> => {
    const response = await apiClient.post<Achievement[]>(`/organizations/${orgId}/achievements/bulk-award`, data);
    return response;
  },

  // Generate achievement report
  generateReport: async (orgId: string, options: {
    type?: Achievement['type'];
    category?: string;
    userId?: string;
    agentId?: string;
    teamId?: string;
    status?: Achievement['status'];
    startDate?: string;
    endDate?: string;
    format: "PDF" | "EXCEL" | "CSV";
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/achievements/report`, options, {
      responseType: 'blob'
    });
    return response;
  },
};
