import { getLocalizationHeaders } from './localization-helper';

export const investmentOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/investment-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch investment OS dashboard stats');
    return res.json();
  },

  getInvestmentTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/investment-os/investment-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch investment trends');
    return res.json();
  },

  getPortfolioDistribution: async (orgId: string) => {
    const res = await fetch(`/api/v1/investment-os/portfolio-distribution?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch portfolio distribution');
    return res.json();
  },
};
