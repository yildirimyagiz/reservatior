import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export interface TaxRateInfo {
  country: string;
  countryCode: string;
  taxAuthority: string;
  taxType: string;
  standardRate: number;
  reducedRate?: number;
  notes?: string;
}

import { USA_TAX_RATES, EUROPE_TAX_RATES } from "./tax-data";

export const GLOBAL_TAX_RATES: Record<string, TaxRateInfo[]> = {
  TR: [
    { country: "Turkey", countryCode: "TR", taxAuthority: "GİB", taxType: "KDV", standardRate: 0.20, reducedRate: 0.10, notes: "KDV Standard rate updated to 20% in 2023." },
    { country: "Turkey", countryCode: "TR", taxAuthority: "Belediye", taxType: "Emlak", standardRate: 0.002, notes: "Property tax varies by city type." }
  ],
  AE: [
    { country: "UAE", countryCode: "AE", taxAuthority: "FTA", taxType: "VAT", standardRate: 0.05, notes: "Low tax environment." }
  ]
};

// Populate Europe
EUROPE_TAX_RATES.forEach(rate => {
  GLOBAL_TAX_RATES[rate.countryCode] = [rate];
});

// Populate USA States
USA_TAX_RATES.forEach(rate => {
  // Use US-XX format
  GLOBAL_TAX_RATES[rate.countryCode] = [rate];
});

// Also provide a general 'USA' lookup that returns the average or a list
GLOBAL_TAX_RATES["USA"] = [
  { country: "USA", countryCode: "US", taxAuthority: "IRS/State", taxType: "Sales Tax", standardRate: 0.07, notes: "Average state sales tax; varies significantly by state." }
];

export class GlobalTaxRegulationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.globalTaxRegulation, "globalTaxRegulation");
  }

  /**
   * Get default tax rates for a country
   */
  getDefaultRates(countryCode: string): TaxRateInfo[] {
    return GLOBAL_TAX_RATES[countryCode.toUpperCase()] || [];
  }

  /**
   * Get all supported countries with tax data
   */
  getSupportedCountries(): string[] {
    return Object.keys(GLOBAL_TAX_RATES);
  }

  /**
   * Calculate tax amount for a given transaction amount and country code
   */
  calculateTax(amount: number, countryCode: string): { total: number, tax: number, rate: number } {
    const rates = this.getDefaultRates(countryCode);
    const standardRate = rates.length > 0 ? rates[0].standardRate : 0;
    const tax = amount * standardRate;
    return {
      total: amount + tax,
      tax,
      rate: standardRate
    };
  }

  /**
   * Automatically provision tax regulations for a new property
   */
  async autoProvision(propertyId: string, orgId: string, countryCode: string) {
    const rates = this.getDefaultRates(countryCode);
    if (rates.length === 0) return;

    // Create a regulation for each default rate
    for (const rate of rates) {
      await prisma.globalTaxRegulation.create({
        data: {
          orgId,
          propertyId,
          taxAuthority: rate.taxAuthority,
          taxType: rate.taxType,
          taxRate: rate.standardRate,
          isAutomated: true,
          reportingInterval: "MONTHLY",
          config: {
            country: rate.country,
            isDefault: true,
            provisionedAt: new Date().toISOString()
          }
        }
      });
    }
  }
}

export const globalTaxRegulationService = new GlobalTaxRegulationService();
