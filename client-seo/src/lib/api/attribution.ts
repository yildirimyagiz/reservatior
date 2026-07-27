import { getLocalizationHeaders } from './localization-helper';

export interface AttributionStats {
  attributedRevenue: number;
  attributionAccuracy: number;
  totalConversions: number;
  avgAttributionTime: number;
  capiMatchRate: number;
  offlineAttribution: number;
}

export interface AttributionChannel {
  name: string;
  revenue: number;
  conversions: number;
  matchRate: number;
  status: string;
}

export interface AttributionJourney {
  step: string;
  time: string;
  channel: string;
  status: string;
}

export interface OfflineConversion {
  id: string;
  property: string;
  value: number;
  source: string;
  date: string;
  status: string;
}

export const attributionApi = {
  getStats: async (orgId: string, timeRange: string, channel: string): Promise<AttributionStats> => {
    const res = await fetch(`/api/v1/attribution/dashboard?orgId=${orgId}&timeRange=${timeRange}&channel=${channel}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch attribution stats');
    return res.json();
  },

  getChannels: async (orgId: string): Promise<AttributionChannel[]> => {
    const res = await fetch(`/api/v1/attribution/channels?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch attribution channels');
    return res.json();
  },

  getJourney: async (orgId: string): Promise<AttributionJourney[]> => {
    const res = await fetch(`/api/v1/attribution/journey?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch attribution journey');
    return res.json();
  },

  getOfflineConversions: async (orgId: string): Promise<OfflineConversion[]> => {
    const res = await fetch(`/api/v1/attribution/offline?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch offline conversions');
    return res.json();
  },
};
