import { getLocalizationHeaders } from './localization-helper';

export const adsOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/ads-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch ads OS dashboard stats');
    return res.json();
  },

  getCampaignPerformance: async (orgId: string) => {
    const res = await fetch(`/api/v1/ads-os/campaign-performance?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch campaign performance');
    return res.json();
  },

  getAdSpendDistribution: async (orgId: string) => {
    const res = await fetch(`/api/v1/ads-os/ad-spend-distribution?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch ad spend distribution');
    return res.json();
  },
};
