import { getLocalizationHeaders } from './localization-helper';

export interface Consent {
  id: string;
  entityId: string;
  entityType: "USER" | "PROPERTY_PROSPECT" | "OWNER_PROFILE" | "AGENT_PROFILE" | "PROPERTY" | "ORGANIZATION";
  entityContext?: Record<string, unknown>;
  consentType: string;
  consentPurpose: string;
  consentChannel: string;
  status: "ACTIVE" | "REVOKED" | "EXPIRED" | "PENDING" | "DECLINED";
  grantedAt: string;
  revokedAt?: string;
  expiresAt?: string;
  consentMethod: string;
  gdprConsent: boolean;
  ccpaOptOut: boolean;
  kvkkConsent: boolean;
  emailConsent: boolean;
  phoneConsent: boolean;
  smsConsent: boolean;
  whatsappConsent: boolean;
  adsConsent: boolean;
  aiCommunicationConsent: boolean;
}

export interface ConsentStats {
  totalConsents: number;
  activeConsents: number;
  revokedConsents: number;
  pendingConsents: number;
  byEntityType: {
    user: number;
    propertyProspect: number;
    ownerProfile: number;
    agentProfile: number;
    property: number;
    organization: number;
  };
  byChannel: {
    email: number;
    sms: number;
    whatsapp: number;
    ads: number;
    aiCommunication: number;
  };
  gdprCompliant: number;
  ccpaOptOut: number;
  kvkkCompliant: number;
}

export const consentOSApi = {
  getStats: async (orgId: string): Promise<ConsentStats> => {
    const res = await fetch(`/api/v1/consent-os/stats?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch consent stats');
    return res.json();
  },

  getConsents: async (filters?: {
    entityType?: string;
    status?: string;
    channel?: string;
  }): Promise<Consent[]> => {
    const params = new URLSearchParams();
    if (filters?.entityType) params.append('entityType', filters.entityType);
    if (filters?.status) params.append('status', filters.status);
    if (filters?.channel) params.append('channel', filters.channel);
    
    const res = await fetch(`/api/v1/consent-os/consents?${params}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch consents');
    return res.json();
  },

  getConsent: async (id: string): Promise<Consent> => {
    const res = await fetch(`/api/v1/consent-os/consents/${id}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch consent');
    return res.json();
  },

  createConsent: async (data: Partial<Consent>): Promise<Consent> => {
    const res = await fetch('/api/v1/consent-os/consents', {
      method: 'POST',
      headers: {
        ...getLocalizationHeaders(),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    });
    if (!res.ok) throw new Error('Failed to create consent');
    return res.json();
  },

  revokeConsent: async (
    id: string,
    data: {
      revocationReason?: string;
      revocationMethod?: string;
    }
  ): Promise<Consent> => {
    const res = await fetch(`/api/v1/consent-os/consents/${id}/revoke`, {
      method: 'PATCH',
      headers: {
        ...getLocalizationHeaders(),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    });
    if (!res.ok) throw new Error('Failed to revoke consent');
    return res.json();
  },

  getConsentTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/consent-os/consent-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch consent trends');
    return res.json();
  },

  getComplianceDistribution: async (orgId: string) => {
    const res = await fetch(`/api/v1/consent-os/compliance-distribution?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch compliance distribution');
    return res.json();
  },
};
