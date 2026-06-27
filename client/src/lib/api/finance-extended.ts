import { apiClient } from "./client";

export const financeExtendedApi = {
  // Commission Rules
  getCommissionRules: (params?: { providerId?: string; ruleType?: string }) =>
    apiClient.get("/finance/commission-rules", params),
  getCommissionRuleById: (id: string) => apiClient.get(`/finance/commission-rules/${id}`),
  createCommissionRule: (data: any) => apiClient.post("/finance/commission-rules", data),
  updateCommissionRule: (id: string, data: any) => apiClient.patch(`/finance/commission-rules/${id}`, data),
  deleteCommissionRule: (id: string) => apiClient.delete(`/finance/commission-rules/${id}`),

  // Earnings
  getEarnings: (params?: { orgId?: string; userId?: string; type?: string; isActive?: boolean }) =>
    apiClient.get("/finance/earnings", params),
  getEarningById: (id: string) => apiClient.get(`/finance/earnings/${id}`),
  createEarning: (data: any) => apiClient.post("/finance/earnings", data),
  updateEarning: (id: string, data: any) => apiClient.patch(`/finance/earnings/${id}`, data),
  deleteEarning: (id: string) => apiClient.delete(`/finance/earnings/${id}`),

  // User Financial Profiles
  getUserFinancialProfiles: (params?: { userId?: string }) =>
    apiClient.get("/finance/user-financial-profiles", params),
  getUserFinancialProfileById: (id: string) => apiClient.get(`/finance/user-financial-profiles/${id}`),
  createUserFinancialProfile: (data: any) => apiClient.post("/finance/user-financial-profiles", data),
  updateUserFinancialProfile: (id: string, data: any) => apiClient.patch(`/finance/user-financial-profiles/${id}`, data),
  deleteUserFinancialProfile: (id: string) => apiClient.delete(`/finance/user-financial-profiles/${id}`),

  // Recommendations
  getRecommendations: (params?: { profileId?: string; orgId?: string; listingId?: string }) =>
    apiClient.get("/finance/recommendations", params),
  createRecommendation: (data: any) => apiClient.post("/finance/recommendations", data),
  deleteRecommendation: (id: string) => apiClient.delete(`/finance/recommendations/${id}`),

  // Security Deposits
  getSecurityDeposits: (params?: { orgId?: string; leaseId?: string; protectionStatus?: string }) =>
    apiClient.get("/finance/security-deposits", params),
  getSecurityDepositById: (id: string) => apiClient.get(`/finance/security-deposits/${id}`),
  createSecurityDeposit: (data: any) => apiClient.post("/finance/security-deposits", data),
  updateSecurityDeposit: (id: string, data: any) => apiClient.patch(`/finance/security-deposits/${id}`, data),
};
