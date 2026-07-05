export const listingOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/listing-os/dashboard?orgId=${orgId}`);
    if (!res.ok) {
      throw new Error("Failed to fetch listing OS dashboard stats");
    }
    const data = await res.json();
    return data;
  }
};
