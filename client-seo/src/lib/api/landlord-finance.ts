import { getLocalizationHeaders } from './localization-helper';

export interface LandlordPortfolio {
  id: string;
  type?: string;
  financialProfile?: {
    occupancyRate: number;
    paymentHealth: number;
    riskScore: number;
    riskLevel: string;
    propertyCount: number;
    totalRevenue: number;
  };
}

export const landlordFinanceApi = {
  listLandlords: async (orgId: string): Promise<{ success: boolean; data: LandlordPortfolio[] }> => {
    const res = await fetch(`/api/v1/landlord-finance?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch landlord entities');
    return res.json();
  },

  getPortfolioHealth: async (landlordId: string) => {
    const res = await fetch(`/api/v1/landlord-finance/portfolio/${landlordId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch portfolio health');
    return res.json();
  },

  refreshProfile: async (landlordId: string, orgId: string) => {
    const res = await fetch(`/api/v1/landlord-finance/profile/${landlordId}?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to refresh landlord profile');
    return res.json();
  },
};
