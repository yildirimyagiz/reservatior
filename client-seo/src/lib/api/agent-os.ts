import { getLocalizationHeaders } from './localization-helper';

export const agentOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/agent-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error("Failed to fetch agent OS dashboard stats");
    return res.json();
  },
  getNetworkSignals: async (orgId: string) => {
    const res = await fetch(`/api/v1/agent-os/network-signals?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error("Failed to fetch network signals");
    return res.json();
  },
  getVacancyAlerts: async (orgId?: string) => {
    const params = orgId ? `?orgId=${orgId}` : "";
    const res = await fetch(`/api/v1/agent-os/vacancy-alerts${params}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error("Failed to fetch vacancy alerts");
    return res.json();
  },

  // Notification OS integration
  sendAgentNotification: async (agentId: string, type: string, userId: string) => {
    const res = await fetch(`/api/v1/agent-os/${agentId}/notify`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ type, userId }),
    });
    if (!res.ok) throw new Error('Failed to send agent notification');
    return res.json();
  },

  // Analytics OS integration
  trackAgentMetric: async (agentId: string, metricType: string, value: number) => {
    const res = await fetch(`/api/v1/agent-os/${agentId}/metrics`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ metricType, value }),
    });
    if (!res.ok) throw new Error('Failed to track agent metric');
    return res.json();
  },

  // Identity OS integration
  updateAgentPermissions: async (agentId: string, permissions: string[]) => {
    const res = await fetch(`/api/v1/agent-os/${agentId}/permissions`, {
      method: 'PUT',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ permissions }),
    });
    if (!res.ok) throw new Error('Failed to update agent permissions');
    return res.json();
  },
};
