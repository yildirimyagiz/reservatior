import { apiClient } from "./client";

export interface TaxRate {
  countryCode: string;
  taxType: string;
  rate: number;
  taxAuthority: string;
  reportingFrequency: "Monthly" | "Quarterly" | "Annual";
}

export interface TaxCalculationResult {
  amount: number;
  rate: number;
  tax: number;
  total: number;
  country: string;
}

export const globalTaxApi = {
  getCountries: () => apiClient.get<string[]>("/global-tax-regulation/countries"),
  getDefaultRates: (countryCode: string) => apiClient.get<TaxRate[]>(`/global-tax-regulation/defaults/${countryCode}`),
  calculateTax: (amount: number, countryCode: string) => 
    apiClient.get<TaxCalculationResult>(`/global-tax-regulation/calculate`, { amount, countryCode }),
  getRecords: (params?: any) => apiClient.get<any[]>("/tax-records", params),
};
