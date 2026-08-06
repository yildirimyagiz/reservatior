import * as fs from 'fs';
import * as path from 'path';

export interface RegionalConfig {
  countryCode: string; // ISO 3166-1 alpha-2 (TR, AE, US, UK, ES, FR, SA, QA)
  countryName: string;
  currency: string;
  currencySymbol: string;
  phoneCode: string;
  languageCode: string; // Default lang
  supportedLanguages: string[];
  taxRate: number; // e.g., 0.20 for 20%
  taxName: string; // VAT, KDV, Sales Tax
  baseCommission: number;
  maxLeasePeriodMonths: number;
  addressFormat: {
    adminLevel1: string; // State, City, Emirate
    adminLevel2: string; // County, District, Area
    zipCodeRequired: boolean;
  };
  aiServices: {
    videoGenEnabled: boolean;
    brochureGenEnabled: boolean;
    legalReviewEnabled: boolean;
  };
  propertyTypes: string[];
  databaseSchema: string; // e.g., schema_ae.prisma
}

export class RegionManager {
  private static config: Record<string, RegionalConfig> = {};
  private static configFile = path.join(process.cwd(), 'regions-config.json');

  static {
    this.loadConfig();
  }

  private static loadConfig() {
    try {
      const data = fs.readFileSync(this.configFile, 'utf8');
      this.config = JSON.parse(data);
    } catch (e) {
      console.error('Error loading regions config:', e);
      // Fallback or empty
    }
  }

  static getRegion(countryCode: string): RegionalConfig | undefined {
    return this.config[countryCode.toUpperCase()];
  }

  static getAllRegions(): RegionalConfig[] {
    return Object.values(this.config);
  }

  /**
   * Calculate local tax
   */
  static calculateTax(amount: number, countryCode: string): number {
    const region = this.getRegion(countryCode);
    if (!region) return 0;
    return amount * region.taxRate;
  }

  /**
   * Determine if a specific AI service is legally allowed or enabled in the region
   */
  static isAiServiceEnabled(service: keyof RegionalConfig['aiServices'], countryCode: string): boolean {
    const region = this.getRegion(countryCode);
    return region?.aiServices[service] ?? false;
  }
}
