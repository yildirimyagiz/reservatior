import { getLocalizationHeaders } from './localization-helper';

export const aiOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/ai-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch AI OS dashboard stats');
    return res.json();
  },

  getPredictionTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/ai-os/prediction-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch prediction trends');
    return res.json();
  },

  getModelPerformance: async (orgId: string) => {
    const res = await fetch(`/api/v1/ai-os/model-performance?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch model performance');
    return res.json();
  },
};
