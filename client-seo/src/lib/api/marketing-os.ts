import { getLocalizationHeaders } from './localization-helper';

export interface CampaignAutomationRule {
  id: string;
  orgId: string;
  name: string;
  description?: string;
  status: "ACTIVE" | "PAUSED" | "DISABLED" | "ARCHIVED";
  triggerType: string;
  triggerConditions: Record<string, unknown>;
  targetEntityType: string;
  targetFilters?: Record<string, unknown>;
  campaignType: string;
  campaignObjective: string;
  budget?: number;
  duration?: number;
  googleAdsEnabled: boolean;
  metaAdsEnabled: boolean;
  tiktokAdsEnabled: boolean;
  autoGenerateCreative: boolean;
  creativeTemplate?: Record<string, unknown>;
  autoBuildAudience: boolean;
  audienceCriteria?: Record<string, unknown>;
  executionDelay?: number;
  executionFrequency?: string;
  requireConsent: boolean;
  consentType?: string;
  minConversionRate?: number;
  maxCostPerAcquisition?: number;
  totalCampaignsGenerated: number;
  totalSpend: number;
  totalConversions: number;
  createdAt: string;
  updatedAt: string;
  lastExecutedAt?: string;
}

export interface CampaignRuleStats {
  totalRules: number;
  activeRules: number;
  pausedRules: number;
  totalCampaignsGenerated: number;
  totalSpend: number;
  totalConversions: number;
  avgConversionRate: number;
  avgCostPerAcquisition: number;
}

export const marketingOSApi = {
  getStats: async (orgId: string): Promise<CampaignRuleStats> => {
    const res = await fetch(`/api/v1/marketing-os/stats?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch marketing stats');
    return res.json();
  },

  getRules: async (filters?: {
    status?: string;
    triggerType?: string;
  }): Promise<CampaignAutomationRule[]> => {
    const params = new URLSearchParams();
    if (filters?.status) params.append('status', filters.status);
    if (filters?.triggerType) params.append('triggerType', filters.triggerType);
    
    const res = await fetch(`/api/v1/marketing-os/rules?${params}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch campaign rules');
    return res.json();
  },

  getRule: async (id: string): Promise<CampaignAutomationRule> => {
    const res = await fetch(`/api/v1/marketing-os/rules/${id}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch campaign rule');
    return res.json();
  },

  createRule: async (data: Partial<CampaignAutomationRule>): Promise<CampaignAutomationRule> => {
    const res = await fetch('/api/v1/marketing-os/rules', {
      method: 'POST',
      headers: {
        ...getLocalizationHeaders(),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    });
    if (!res.ok) throw new Error('Failed to create campaign rule');
    return res.json();
  },

  updateRule: async (id: string, data: Partial<CampaignAutomationRule>): Promise<CampaignAutomationRule> => {
    const res = await fetch(`/api/v1/marketing-os/rules/${id}`, {
      method: 'PATCH',
      headers: {
        ...getLocalizationHeaders(),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    });
    if (!res.ok) throw new Error('Failed to update campaign rule');
    return res.json();
  },

  updateRuleStatus: async (id: string, status: string): Promise<CampaignAutomationRule> => {
    const res = await fetch(`/api/v1/marketing-os/rules/${id}/status`, {
      method: 'PATCH',
      headers: {
        ...getLocalizationHeaders(),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ status }),
    });
    if (!res.ok) throw new Error('Failed to update rule status');
    return res.json();
  },

  getCampaignTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/marketing-os/campaign-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch campaign trends');
    return res.json();
  },

  getAutomationDistribution: async (orgId: string) => {
    const res = await fetch(`/api/v1/marketing-os/automation-distribution?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch automation distribution');
    return res.json();
  },
};
