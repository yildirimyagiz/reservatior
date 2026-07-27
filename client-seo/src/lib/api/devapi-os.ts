import { getLocalizationHeaders } from './localization-helper';

export const devapiOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/devapi-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch Dev API OS dashboard stats');
    return res.json();
  },

  getApiUsageTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/devapi-os/api-usage-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch API usage trends');
    return res.json();
  },

  getEndpointDistribution: async (orgId: string) => {
    const res = await fetch(`/api/v1/devapi-os/endpoint-distribution?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch endpoint distribution');
    return res.json();
  },
};
