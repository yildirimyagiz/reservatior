import { apiClient } from "./api/client";

export interface RegionalConfig {
  countryCode: string;
  countryName: string;
  currency: string;
  currencySymbol: string;
  phoneCode: string;
  languageCode: string;
  supportedLanguages: string[];
  taxRate: number;
  taxName: string;
  baseCommission: number;
  maxLeasePeriodMonths: number;
  addressFormat: {
    adminLevel1: string;
    adminLevel2: string;
    zipCodeRequired: boolean;
  };
  aiServices: {
    videoGenEnabled: boolean;
    brochureGenEnabled: boolean;
    legalReviewEnabled: boolean;
  };
  propertyTypes: string[];
  databaseSchema: string;
}

export const fetchRegions = async (): Promise<RegionalConfig[]> => {
  const res = await apiClient.get<any>('/config/regions');
  return res.regions;
};

export const fetchRegion = async (countryCode: string): Promise<RegionalConfig> => {
  const res = await apiClient.get<any>(`/config/regions/${countryCode}`);
  return res.region;
};
