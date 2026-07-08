export const bookingOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/booking-os/dashboard?orgId=${orgId}`);
    if (!res.ok) {
      throw new Error("Failed to fetch booking OS dashboard stats");
    }
    const data = await res.json();
    return data;
  },
  getLiveFeed: async (orgId: string) => {
    const res = await fetch(`/api/v1/booking-os/live-feed?orgId=${orgId}`);
    if (!res.ok) {
      throw new Error("Failed to fetch live feed");
    }
    const data = await res.json();
    return data;
  },
  getPricingData: async (orgId: string) => {
    const res = await fetch(`/api/v1/booking-os/pricing-engine?orgId=${orgId}`);
    if (!res.ok) {
      throw new Error("Failed to fetch pricing data");
    }
    const data = await res.json();
    return data;
  }
};
