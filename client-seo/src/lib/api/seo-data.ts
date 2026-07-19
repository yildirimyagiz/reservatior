import { apiClient } from "./client";

export interface PropertySEOData {
  propertyId: string;
  title: string;
  description: string;
  url: string;
  image?: string;
  price: number;
  currency: string;
  address: string;
  city: string;
  country: string;
  bedrooms?: number;
  bathrooms?: number;
  area?: number;
  estimatedRent: number;
  yieldRate: number;
  trustScore: number;
  occupancyRate: number;
  investmentGrade: string;
  jsonLd: any;
}

export interface InvestmentScore {
  propertyId: string;
  overallScore: number;
  yieldScore: number;
  locationScore: number;
  demandScore: number;
  riskScore: number;
  grade: string;
  factors: string[];
  recommendation: string;
}

export interface RentalYield {
  propertyId: string;
  grossYield: number;
  netYield: number;
  monthlyRent: number;
  annualRent: number;
  propertyValue: number;
  expenses: { label: string; amount: number }[];
  breakEvenMonths: number;
  cashOnCashReturn: number;
}

export const seoDataApi = {
  getPropertySEO: async (propertyId: string) => {
    return apiClient.get<PropertySEOData>(`/seo/property/${propertyId}`);
  },
  getInvestmentScore: async (propertyId: string) => {
    return apiClient.get<InvestmentScore>(`/seo/property/${propertyId}/investment-score`);
  },
  getRentalYield: async (propertyId: string) => {
    return apiClient.get<RentalYield>(`/seo/property/${propertyId}/rental-yield`);
  },
  getBulkSEO: async (propertyIds: string[]) => {
    return apiClient.post<PropertySEOData[]>("/seo/bulk", { propertyIds });
  },
};
