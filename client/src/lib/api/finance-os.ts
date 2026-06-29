export const financeOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/finance-os/dashboard?orgId=${orgId}`);
    if (!res.ok) {
      throw new Error("Failed to fetch dashboard stats");
    }
    const data = await res.json();
    return data;
  }
};
