import { getLocalizationHeaders } from './localization-helper';

export const securityOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/security-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch security OS dashboard stats');
    return res.json();
  },

  getThreatTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/security-os/threat-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch threat trends');
    return res.json();
  },

  getSecurityEvents: async (orgId: string) => {
    const res = await fetch(`/api/v1/security-os/security-events?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch security events');
    return res.json();
  },
};
