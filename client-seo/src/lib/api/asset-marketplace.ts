import { apiClient } from "./client";

export interface AssetListing {
  propertyId: string;
  propertyName: string;
  address: string;
  city: string;
  country: string;
  price: number;
  currency: string;
  bedrooms: number;
  squareMeters: number;
  estimatedMonthlyRent: number;
  yieldRate: number;
  trustScore: number;
  certificateTier?: string;
  certificateStatus?: string;
  occupancyRate?: number;
  annualIncome: number;
  investmentGrade: string;
  images?: any;
  listingType: string;
  status: string;
  listedAt: string;
  sellerType: string;
  sellerName: string;
}

export interface MarketplaceFilters {
  city?: string;
  country?: string;
  minPrice?: number;
  maxPrice?: number;
  minBedrooms?: number;
  maxBedrooms?: number;
  minYield?: number;
  maxYield?: number;
  listingType?: string;
  certificateTier?: string;
  minTrustScore?: number;
  sortBy?: string;
  page?: number;
  limit?: number;
}

export interface MarketplaceSummary {
  totalListings: number;
  totalValue: number;
  averageYield: number;
  averageTrustScore: number;
  listingsByCity: { city: string; count: number }[];
  listingsByTier: { tier: string; count: number }[];
  priceRange: { min: number; max: number };
}

export interface InvestmentOpportunity {
  propertyId: string;
  propertyName: string;
  city: string;
  price: number;
  estimatedAnnualIncome: number;
  yieldRate: number;
  trustScore: number;
  certificateTier: string;
  riskLevel: string;
  recommendedFor: string[];
  highlights: string[];
}

export interface PropertyMarketData {
  listing: AssetListing;
  comparables: AssetListing[];
  marketTrends: {
    averagePriceInCity: number;
    averageYieldInCity: number;
    pricePerSqm: number;
  };
}

export const assetMarketplaceApi = {
  listAssets: async (filters?: MarketplaceFilters) => {
    const params: Record<string, string> = {};
    if (filters) {
      Object.entries(filters).forEach(([key, value]) => {
        if (value !== undefined && value !== null && value !== "") {
          params[key] = String(value);
        }
      });
    }
    return apiClient.get<{ data: AssetListing[]; total: number; page: number; limit: number; totalPages: number }>(
      "/asset-marketplace",
      params
    );
  },

  getSummary: async () => {
    return apiClient.get<MarketplaceSummary>("/asset-marketplace/summary");
  },

  getOpportunities: async (limit?: number) => {
    return apiClient.get<InvestmentOpportunity[]>("/asset-marketplace/opportunities", limit ? { limit: String(limit) } : undefined);
  },

  getPropertyMarketData: async (propertyId: string) => {
    return apiClient.get<PropertyMarketData>(`/asset-marketplace/property/${propertyId}`);
  },
};
