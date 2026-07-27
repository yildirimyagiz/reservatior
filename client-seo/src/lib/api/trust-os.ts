import { getLocalizationHeaders } from './localization-helper';

export const trustOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/trust-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch trust OS dashboard stats');
    return res.json();
  },

  getVerificationTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/trust-os/verification-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch verification trends');
    return res.json();
  },

  getTrustScoreDistribution: async (orgId: string) => {
    const res = await fetch(`/api/v1/trust-os/trust-score-distribution?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch trust score distribution');
    return res.json();
  },
};
