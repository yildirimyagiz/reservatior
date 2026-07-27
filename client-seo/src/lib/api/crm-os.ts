import { getLocalizationHeaders } from './localization-helper';

export const crmOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/crm-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch CRM OS dashboard stats');
    return res.json();
  },

  getPipelineOverview: async (orgId: string) => {
    const res = await fetch(`/api/v1/crm-os/pipeline-overview?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch pipeline overview');
    return res.json();
  },

  getDealSources: async (orgId: string) => {
    const res = await fetch(`/api/v1/crm-os/deal-sources?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch deal sources');
    return res.json();
  },
};
