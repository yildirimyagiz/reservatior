import { getLocalizationHeaders } from './localization-helper';

export const partnerOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/partner-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch partner OS dashboard stats');
    return res.json();
  },

  getPartnerTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/partner-os/partner-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch partner trends');
    return res.json();
  },

  getPartnerCategories: async (orgId: string) => {
    const res = await fetch(`/api/v1/partner-os/partner-categories?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch partner categories');
    return res.json();
  },
};
