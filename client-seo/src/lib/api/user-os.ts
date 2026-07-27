import { getLocalizationHeaders } from './localization-helper';

export const userOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/user-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch user OS dashboard stats');
    return res.json();
  },

  getUserTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/user-os/user-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch user trends');
    return res.json();
  },

  getUserActivity: async (orgId: string) => {
    const res = await fetch(`/api/v1/user-os/user-activity?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch user activity');
    return res.json();
  },
};
