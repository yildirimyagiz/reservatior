import { getLocalizationHeaders } from './localization-helper';

export interface OSDashboardStats {
  kpis: Record<string, number>;
  chartData?: any;
  recentActivity?: { id: string; title: string; subtitle: string; value: string; timeAgo: string }[];
  alerts?: { type: 'warning' | 'success' | 'info'; title: string; message: string }[];
}

export const osDashboardApi = {
  getStats: async (osName: string, orgId: string): Promise<OSDashboardStats> => {
    const res = await fetch(`/api/v1/${osName}/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error(`Failed to fetch ${osName} dashboard stats`);
    return res.json();
  },
};

export interface OSKpiConfig {
  key: string;
  label: string;
  icon: string;
  color: string;
  format?: 'number' | 'currency' | 'percent' | 'decimal';
}

export type OSActionButton = {
  label: string;
  primary?: boolean;
  href?: string;
};
