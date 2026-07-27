import { getLocalizationHeaders } from './localization-helper';

export interface CorporateAccount {
  id: string;
  organizationId: string;
  accountType: 'CORPORATE_HOUSING' | 'MULTI_FAMILY' | 'BANK_REO' | 'PROPERTY_MANAGEMENT' | 'REAL_ESTATE_INVESTMENT';
  tier: string;
  whitelisted: boolean;
  priorityLevel: number;
  primaryContactName: string;
  primaryContactEmail: string;
  primaryContactPhone?: string;
  billingContactName?: string;
  billingContactEmail?: string;
  totalProperties: number;
  activeProperties: number;
  totalUnits: number;
  avgOccupancyRate: number;
  annualRevenue: number;
  apiEnabled: boolean;
  apiKey?: string;
  webhookUrl?: string;
  webhookSecret?: string;
  seattleMarketFocus: boolean;
  targetNeighborhoods: string[];
  createdAt: string;
  updatedAt: string;
}

export interface PortfolioBatch {
  id: string;
  corporateAccountId: string;
  batchName: string;
  batchType: string;
  status: 'PENDING' | 'PROCESSING' | 'COMPLETED' | 'FAILED' | 'PARTIALLY_COMPLETED';
  fileName: string;
  fileSize: number;
  fileType: 'csv' | 'xlsx' | 'json';
  fileUrl?: string;
  s3Key?: string;
  totalRows: number;
  processedRows: number;
  successfulRows: number;
  failedRows: number;
  skippedRows: number;
  processingStartedAt?: string;
  processingCompletedAt?: string;
  errorLog?: string;
  validationErrors?: any;
  normalizationStatus: 'PENDING' | 'NORMALIZING' | 'COMPLETED' | 'FAILED' | 'MANUAL_REVIEW';
  normalizedProperties: number;
  manualReviewRequired: number;
  createdAt: string;
  updatedAt: string;
}

export interface BulkInvitation {
  id: string;
  corporateAccountId: string;
  invitedEmail: string;
  invitedName: string;
  role: string;
  magicLinkToken: string;
  magicLinkExpiresAt: string;
  magicLinkUsedAt?: string;
  magicLinkUsedIp?: string;
  status: 'PENDING' | 'ACCEPTED' | 'EXPIRED' | 'REVOKED';
  invitationMessage?: string;
  customWelcomeText?: string;
  portfolioPreviewUrl?: string;
  seattlePilotCampaign: boolean;
  priorityAccess: boolean;
  sentAt: string;
  acceptedAt?: string;
  expiresAt: string;
}

export interface CorporateProperty {
  id: string;
  corporateAccountId: string;
  portfolioBatchId?: string;
  propertyId?: string;
  rawImportData: any;
  normalizationStatus: 'PENDING' | 'NORMALIZING' | 'COMPLETED' | 'FAILED' | 'MANUAL_REVIEW';
  normalizedAt?: string;
  normalizedBy?: string;
  propertyType?: string;
  furnishingStatus?: string;
  amenities: string[];
  seattleNeighborhood?: string;
  buildingName?: string;
  buildingType?: string;
  floorNumber?: number;
  unitNumber?: string;
  corporateRate?: number;
  longTermRate?: number;
  midTermRate?: number;
  minStayDuration?: number;
  maxStayDuration?: number;
  aiEstimatedValue?: number;
  aiEstimatedYield?: number;
  aiConfidenceScore?: number;
  aiValuationAt?: string;
  longTermYield?: number;
  midTermYield?: number;
  corporateYield?: number;
  yieldOpportunity?: string;
  createdAt: string;
  updatedAt: string;
}

export interface AIPitchDeck {
  id: string;
  corporateAccountId: string;
  deckName: string;
  deckType: string;
  executiveSummary: string;
  portfolioOverview: any;
  financialProjections: any;
  yieldAnalysis: any;
  marketComparison: any;
  seattleMarketInsights?: any;
  techTenantDemand?: any;
  neighborhoodAnalysis?: any;
  status: 'draft' | 'generated' | 'sent' | 'viewed';
  generatedAt: string;
  sentAt?: string;
  viewedAt?: string;
  deliveryMethod: string;
  deliveryEmail?: string;
}

export interface CorporateTenantMatch {
  id: string;
  corporateAccountId: string;
  corporatePropertyId: string;
  companyName: string;
  industry: string;
  employeeCount?: number;
  matchScore: number;
  matchReason: string[];
  estimatedContractValue?: number;
  contractDuration?: number;
  status: 'pending' | 'contacted' | 'negotiating' | 'signed' | 'expired';
  techCompany: boolean;
  amazonEmployee: boolean;
  microsoftEmployee: boolean;
  googleEmployee: boolean;
  metaEmployee: boolean;
  createdAt: string;
  updatedAt: string;
}

export const b2bBulkOnboardingApi = {
  // Corporate Account Management
  getCorporateAccounts: async (orgId: string): Promise<CorporateAccount[]> => {
    const res = await fetch(`/api/v1/b2b/corporate-accounts?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch corporate accounts');
    return res.json();
  },

  createCorporateAccount: async (data: Partial<CorporateAccount>): Promise<CorporateAccount> => {
    const res = await fetch('/api/v1/b2b/corporate-accounts', {
      method: 'POST',
      headers: {
        ...getLocalizationHeaders(),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    });
    if (!res.ok) throw new Error('Failed to create corporate account');
    return res.json();
  },

  updateCorporateAccount: async (id: string, data: Partial<CorporateAccount>): Promise<CorporateAccount> => {
    const res = await fetch(`/api/v1/b2b/corporate-accounts/${id}`, {
      method: 'PATCH',
      headers: {
        ...getLocalizationHeaders(),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    });
    if (!res.ok) throw new Error('Failed to update corporate account');
    return res.json();
  },

  // Portfolio Batch Management
  uploadPortfolioBatch: async (formData: FormData): Promise<PortfolioBatch> => {
    const res = await fetch('/api/v1/b2b/portfolio-batches/upload', {
      method: 'POST',
      headers: getLocalizationHeaders(),
      body: formData,
    });
    if (!res.ok) throw new Error('Failed to upload portfolio batch');
    return res.json();
  },

  getPortfolioBatches: async (corporateAccountId: string): Promise<PortfolioBatch[]> => {
    const res = await fetch(`/api/v1/b2b/portfolio-batches?corporateAccountId=${corporateAccountId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch portfolio batches');
    return res.json();
  },

  getPortfolioBatch: async (id: string): Promise<PortfolioBatch> => {
    const res = await fetch(`/api/v1/b2b/portfolio-batches/${id}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch portfolio batch');
    return res.json();
  },

  // Bulk Invitations
  createBulkInvitation: async (data: Partial<BulkInvitation>): Promise<BulkInvitation> => {
    const res = await fetch('/api/v1/b2b/bulk-invitations', {
      method: 'POST',
      headers: {
        ...getLocalizationHeaders(),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    });
    if (!res.ok) throw new Error('Failed to create bulk invitation');
    return res.json();
  },

  getBulkInvitations: async (corporateAccountId: string): Promise<BulkInvitation[]> => {
    const res = await fetch(`/api/v1/b2b/bulk-invitations?corporateAccountId=${corporateAccountId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch bulk invitations');
    return res.json();
  },

  validateMagicLink: async (token: string): Promise<{ valid: boolean; corporateAccount?: CorporateAccount }> => {
    const res = await fetch(`/api/v1/b2b/magic-link/validate?token=${token}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to validate magic link');
    return res.json();
  },

  // Corporate Properties
  getCorporateProperties: async (corporateAccountId: string, filters?: any): Promise<CorporateProperty[]> => {
    const queryParams = new URLSearchParams({ corporateAccountId, ...filters });
    const res = await fetch(`/api/v1/b2b/corporate-properties?${queryParams}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch corporate properties');
    return res.json();
  },

  // AI Pitch Deck
  generateAIPitchDeck: async (corporateAccountId: string, deckType: string): Promise<AIPitchDeck> => {
    const res = await fetch('/api/v1/b2b/ai-pitch-decks/generate', {
      method: 'POST',
      headers: {
        ...getLocalizationHeaders(),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ corporateAccountId, deckType }),
    });
    if (!res.ok) throw new Error('Failed to generate AI pitch deck');
    return res.json();
  },

  getAIPitchDecks: async (corporateAccountId: string): Promise<AIPitchDeck[]> => {
    const res = await fetch(`/api/v1/b2b/ai-pitch-decks?corporateAccountId=${corporateAccountId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch AI pitch decks');
    return res.json();
  },

  // Corporate Tenant Matching
  getCorporateTenantMatches: async (corporateAccountId: string): Promise<CorporateTenantMatch[]> => {
    const res = await fetch(`/api/v1/b2b/corporate-tenant-matches?corporateAccountId=${corporateAccountId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch corporate tenant matches');
    return res.json();
  },

  // Seattle Pilot Campaign
  getSeattlePilotStats: async (): Promise<{
    totalTargetedAccounts: number;
    acceptedInvitations: number;
    pendingInvitations: number;
    totalPropertiesImported: number;
    estimatedRevenue: number;
  }> => {
    const res = await fetch('/api/v1/b2b/seattle-pilot/stats', {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch Seattle pilot stats');
    return res.json();
  },
};
