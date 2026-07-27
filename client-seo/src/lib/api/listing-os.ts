import { getLocalizationHeaders } from './localization-helper';

export const listingOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/listing-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) {
      throw new Error("Failed to fetch listing OS dashboard stats");
    }
    const data = await res.json();
    return data;
  },

  // Notification OS integration
  sendListingNotification: async (listingId: string, type: string, userId: string) => {
    const res = await fetch(`/api/v1/listing-os/${listingId}/notify`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ type, userId }),
    });
    if (!res.ok) throw new Error('Failed to send listing notification');
    return res.json();
  },

  // Analytics OS integration
  trackListingMetric: async (listingId: string, metricType: string, value: number) => {
    const res = await fetch(`/api/v1/listing-os/${listingId}/metrics`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ metricType, value }),
    });
    if (!res.ok) throw new Error('Failed to track listing metric');
    return res.json();
  },

  // Document OS integration
  generateListingDocument: async (listingId: string, documentType: string) => {
    const res = await fetch(`/api/v1/listing-os/${listingId}/documents`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ documentType }),
    });
    if (!res.ok) throw new Error('Failed to generate listing document');
    return res.json();
  },

  // Localization OS integration
  getLocalizedPrice: async (listingId: string, countryCode: string) => {
    const res = await fetch(`/api/v1/listing-os/${listingId}/localized-price?countryCode=${countryCode}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to get localized price');
    return res.json();
  },

  getListingTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/listing-os/listing-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch listing trends');
    return res.json();
  },

  getViewAnalytics: async (orgId: string) => {
    const res = await fetch(`/api/v1/listing-os/view-analytics?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch view analytics');
    return res.json();
  },
};
