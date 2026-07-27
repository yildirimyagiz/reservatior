import { getLocalizationHeaders } from './localization-helper';

export interface DigitalTwinStats {
  totalTwins: number;
  activeSimulations: number;
  completedSimulations: number;
  avgAccuracy: number;
  syncStatus: number;
  aiInsights: number;
  spatialLayers: number;
  predictionAccuracy: number;
}

export interface DigitalTwin {
  id: string;
  name: string;
  type: 'Residential' | 'Commercial' | 'Land';
  status: 'Synced' | 'Syncing' | 'Error';
  accuracy: number;
  lastSync: string;
}

export interface SimulationResult {
  name: string;
  value: string;
  icon?: string;
  color?: string;
}

export interface CreateTwinData {
  name: string;
  type: 'Residential' | 'Commercial' | 'Land';
  [key: string]: unknown;
}

export const digitalTwinApi = {
  getStats: async (orgId: string): Promise<DigitalTwinStats> => {
    const res = await fetch(`/api/v1/digital-twin/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch digital twin stats');
    return res.json();
  },

  getActiveTwins: async (orgId: string): Promise<DigitalTwin[]> => {
    const res = await fetch(`/api/v1/digital-twin/active?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch active twins');
    return res.json();
  },

  getSimulationResults: async (orgId: string): Promise<SimulationResult[]> => {
    const res = await fetch(`/api/v1/digital-twin/simulations?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch simulation results');
    return res.json();
  },

  createTwin: async (data: CreateTwinData): Promise<DigitalTwin> => {
    const res = await fetch('/api/v1/digital-twin', {
      method: 'POST',
      headers: {
        ...getLocalizationHeaders(),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    });
    if (!res.ok) throw new Error('Failed to create digital twin');
    return res.json();
  },
};
