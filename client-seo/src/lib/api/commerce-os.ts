import { getLocalizationHeaders } from './localization-helper';

export const commerceOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/commerce-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch commerce OS dashboard stats');
    return res.json();
  },

  getSalesTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/commerce-os/sales-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch sales trends');
    return res.json();
  },

  getProductCategories: async (orgId: string) => {
    const res = await fetch(`/api/v1/commerce-os/product-categories?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch product categories');
    return res.json();
  },
};
