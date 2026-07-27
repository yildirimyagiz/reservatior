import { getLocalizationHeaders } from './localization-helper';

export interface PropertyProspect {
  id: string;
  externalListingId?: string;
  propertyFingerprint: string;
  source: string;
  sourceListingId: string;
  ingestionDate: string;
  acquisitionScore: number;
  valuationScore: number;
  ownerConfidence: number;
  marketOpportunityScore: number;
  overallPriority: number;
  opportunityTier: "LOW_POTENTIAL" | "MONITOR" | "HIGH_POTENTIAL" | "PREMIUM";
  acquisitionUrgency: "LOW" | "MEDIUM" | "HIGH" | "IMMEDIATE";
  ownershipStatus: string;
  complianceStatus: string;
  aiAnalyzed: boolean;
  identifiedOwner: boolean;
  identifiedAgent: boolean;
  valuationReady: boolean;
  optedIn: boolean;
  propertyClaimed: boolean;
  fraudFlagged: boolean;
}

export interface ProspectStats {
  totalProspects: number;
  analyzedProspects: number;
  opportunityDistribution: {
    lowPotential: number;
    monitor: number;
    highPotential: number;
    premium: number;
  };
  urgencyDistribution: {
    low: number;
    medium: number;
    high: number;
    immediate: number;
  };
  avgAcquisitionScore: number;
  avgValuationScore: number;
  avgOwnerConfidence: number;
  avgMarketOpportunityScore: number;
}

export const prospectIntelligenceApi = {
  getStats: async (orgId: string): Promise<ProspectStats> => {
    const res = await fetch(`/api/v1/prospect-intelligence/stats?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch prospect stats');
    return res.json();
  },

  getProspects: async (filters?: {
    opportunityTier?: string;
    acquisitionUrgency?: string;
    minScore?: number;
  }): Promise<PropertyProspect[]> => {
    const params = new URLSearchParams();
    if (filters?.opportunityTier) params.append('opportunityTier', filters.opportunityTier);
    if (filters?.acquisitionUrgency) params.append('acquisitionUrgency', filters.acquisitionUrgency);
    if (filters?.minScore) params.append('minScore', filters.minScore.toString());
    
    const res = await fetch(`/api/v1/prospect-intelligence/prospects?${params}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch prospects');
    return res.json();
  },

  getProspect: async (id: string): Promise<PropertyProspect> => {
    const res = await fetch(`/api/v1/prospect-intelligence/prospects/${id}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch prospect');
    return res.json();
  },

  updateProspectScore: async (
    id: string,
    scores: {
      acquisitionScore?: number;
      valuationScore?: number;
      ownerConfidence?: number;
      marketOpportunityScore?: number;
    }
  ): Promise<PropertyProspect> => {
    const res = await fetch(`/api/v1/prospect-intelligence/prospects/${id}/score`, {
      method: 'PATCH',
      headers: {
        ...getLocalizationHeaders(),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(scores),
    });
    if (!res.ok) throw new Error('Failed to update prospect score');
    return res.json();
  },
};
