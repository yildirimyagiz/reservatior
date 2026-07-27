import { getLocalizationHeaders } from './localization-helper';

export interface GeospatialStats {
  totalProperties: number;
  avgYield: number;
  demandScore: number;
  appreciationRate: number;
  activeRegions: number;
  dataPoints: number;
}

export interface RegionalData {
  region: string;
  countries: number;
  avgYield: number;
  demand: number;
  appreciation: number;
}

export interface MicroLocationInsight {
  location: string;
  yield: number;
  demand: string;
  trend: string;
  factors: string[];
}

export const geospatialApi = {
  getStats: async (orgId: string, heatmap: string, region: string): Promise<GeospatialStats> => {
    const res = await fetch(`/api/v1/geospatial/dashboard?orgId=${orgId}&heatmap=${heatmap}&region=${region}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch geospatial stats');
    return res.json();
  },

  getRegionalData: async (orgId: string): Promise<RegionalData[]> => {
    const res = await fetch(`/api/v1/geospatial/regions?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch regional data');
    return res.json();
  },

  getMicroLocationInsights: async (orgId: string): Promise<MicroLocationInsight[]> => {
    const res = await fetch(`/api/v1/geospatial/insights?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch micro-location insights');
    return res.json();
  },
};
