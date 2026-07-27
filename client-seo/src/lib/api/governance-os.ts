import { getLocalizationHeaders } from './localization-helper';

export const governanceOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/governance-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch governance OS dashboard stats');
    return res.json();
  },

  getComplianceTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/governance-os/compliance-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch compliance trends');
    return res.json();
  },

  getRiskAssessment: async (orgId: string) => {
    const res = await fetch(`/api/v1/governance-os/risk-assessment?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch risk assessment');
    return res.json();
  },
};
