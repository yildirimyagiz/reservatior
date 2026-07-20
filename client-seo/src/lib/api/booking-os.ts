import { getLocalizationHeaders } from './localization-helper';

export const bookingOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/booking-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) {
      throw new Error("Failed to fetch booking OS dashboard stats");
    }
    const data = await res.json();
    return data;
  },
  getLiveFeed: async (orgId: string) => {
    const res = await fetch(`/api/v1/booking-os/live-feed?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) {
      throw new Error("Failed to fetch live feed");
    }
    const data = await res.json();
    return data;
  },
  getPricingData: async (orgId: string) => {
    const res = await fetch(`/api/v1/booking-os/pricing-engine?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) {
      throw new Error("Failed to fetch pricing data");
    }
    const data = await res.json();
    return data;
  },

  // Notification OS integration
  sendBookingNotification: async (bookingId: string, type: string, userId: string) => {
    const res = await fetch(`/api/v1/booking-os/${bookingId}/notify`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ type, userId }),
    });
    if (!res.ok) throw new Error('Failed to send booking notification');
    return res.json();
  },

  // Analytics OS integration
  trackBookingMetric: async (bookingId: string, metricType: string, value: number) => {
    const res = await fetch(`/api/v1/booking-os/${bookingId}/metrics`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ metricType, value }),
    });
    if (!res.ok) throw new Error('Failed to track booking metric');
    return res.json();
  },

  // Document OS integration
  generateBookingDocument: async (bookingId: string, documentType: string) => {
    const res = await fetch(`/api/v1/booking-os/${bookingId}/documents`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ documentType }),
    });
    if (!res.ok) throw new Error('Failed to generate booking document');
    return res.json();
  },
};
