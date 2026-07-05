export const bookingOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/booking-os/dashboard?orgId=${orgId}`);
    if (!res.ok) {
      throw new Error("Failed to fetch booking OS dashboard stats");
    }
    const data = await res.json();
    return data;
  }
};
