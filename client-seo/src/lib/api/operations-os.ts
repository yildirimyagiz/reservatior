import { getLocalizationHeaders } from './localization-helper';

export const operationsOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/operations-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch operations OS dashboard stats');
    return res.json();
  },

  getTaskTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/operations-os/task-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch task trends');
    return res.json();
  },

  getTaskCategories: async (orgId: string) => {
    const res = await fetch(`/api/v1/operations-os/task-categories?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch task categories');
    return res.json();
  },
};
