export const agentOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/agent-os/dashboard?orgId=${orgId}`);
    if (!res.ok) throw new Error("Failed to fetch agent OS dashboard stats");
    return res.json();
  },
  getNetworkSignals: async (orgId: string) => {
    const res = await fetch(`/api/v1/agent-os/network-signals?orgId=${orgId}`);
    if (!res.ok) throw new Error("Failed to fetch network signals");
    return res.json();
  },
};
