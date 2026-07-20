/**
 * Localization OS Service
 * Enterprise localization platform for multi-country support
 */

import { prisma } from '../lib/prisma';
import { eventBus } from '../core/events/event-bus';
import { GeminiService } from './gemini';

export interface CountryConfig {
  id: string;
  code: string; // ISO 3166-1 alpha-2
  name: string;
  nativeName: string;
  currency: string;
  currencySymbol: string;
  language: string;
  timezone: string;
  dateFormat: string;
  numberFormat: string;
  weekendDays: any; // Json type in schema
  workingDays: any; // Json type in schema
  taxRate: number | null;
  vatRate: number | null;
  legalRequirements: any; // Json type in schema
  rentalRules: any; // Json type in schema
  paymentProviders: any; // Json type in schema
  propertyTypes: any; // Json type in schema
  isActive: boolean;
}

export interface LanguageConfig {
  id: string;
  code: string; // ISO 639-1
  name: string;
  nativeName: string;
  isActive: boolean;
}

export interface CurrencyConfig {
  id: string;
  code: string; // ISO 4217
  symbol: string;
  name: string;
  exchangeRate: number;
  isActive: boolean;
}

export interface RegionalPricing {
  id: string;
  countryCode: string;
  propertyType: string;
  basePrice: number;
  adjustment: number;
  season: string | null;
  effectiveFrom: Date;
  effectiveTo: Date | null;
  listingId: string | null;
  propertyId: string | null;
  bookingId: string | null;
  createdAt: Date;
  updatedAt: Date;
}

export interface LocalizedContent {
  id: string;
  key: string;
  language: string;
  content: string;
  translatedBy?: string; // 'ai' | 'manual'
  confidence?: number;
  createdAt: Date;
  updatedAt: Date;
}

class LocalizationOSService {
  private cache: Map<string, any> = new Map();

  /**
   * Get country configuration
   */
  async getCountryConfig(countryCode: string): Promise<CountryConfig | null> {
    const cacheKey = `country_${countryCode}`;
    if (this.cache.has(cacheKey)) {
      return this.cache.get(cacheKey);
    }

    const config = await prisma.countryConfig.findUnique({
      where: { code: countryCode }
    });

    if (config) {
      this.cache.set(cacheKey, config);
    }

    return config;
  }

  /**
   * Get language configuration
   */
  async getLanguageConfig(languageCode: string): Promise<LanguageConfig | null> {
    const cacheKey = `language_${languageCode}`;
    if (this.cache.has(cacheKey)) {
      return this.cache.get(cacheKey);
    }

    const config = await prisma.languageConfig.findUnique({
      where: { code: languageCode }
    });

    if (config) {
      this.cache.set(cacheKey, config);
    }

    return config;
  }

  /**
   * Get currency configuration
   */
  async getCurrencyConfig(currencyCode: string): Promise<CurrencyConfig | null> {
    const cacheKey = `currency_${currencyCode}`;
    if (this.cache.has(cacheKey)) {
      return this.cache.get(cacheKey);
    }

    const config = await prisma.currencyConfig.findUnique({
      where: { code: currencyCode }
    });

    if (config) {
      this.cache.set(cacheKey, config);
    }

    return config;
  }

  /**
   * Get localized content
   */
  async getLocalizedContent(key: string, language: string): Promise<string | null> {
    const cacheKey = `content_${key}_${language}`;
    if (this.cache.has(cacheKey)) {
      return this.cache.get(cacheKey);
    }

    const content = await prisma.localizedContent.findUnique({
      where: {
        key_language: {
          key,
          language
        }
      }
    });

    if (content) {
      this.cache.set(cacheKey, content.content);
      return content.content;
    }

    // Fallback to English if not found
    if (language !== 'en') {
      return this.getLocalizedContent(key, 'en');
    }

    return null;
  }

  /**
   * Translate content using AI
   */
  async translateContent(key: string, targetLanguage: string, context?: string): Promise<string> {
    // Get source content (English)
    const sourceContent = await this.getLocalizedContent(key, 'en');
    if (!sourceContent) {
      throw new Error(`Source content not found for key: ${key}`);
    }

    try {
      const prompt = `
        Translate the following content to ${targetLanguage}:
        
        Source: ${sourceContent}
        Context: ${context || 'General platform content'}
        
        Guidelines:
        - Maintain the same tone and style
        - Keep any placeholders like {{variable}} unchanged
        - Ensure cultural appropriateness
        - Use natural, native phrasing
        
        Return ONLY the translated text, no explanations.
      `;

      const translated = await GeminiService.processHubSearch(prompt, { role: 'ADMIN' });
      
      // Save translation
      await prisma.localizedContent.upsert({
        where: {
          key_language: {
            key,
            language: targetLanguage
          }
        },
        create: {
          key,
          language: targetLanguage,
          content: translated,
          translatedBy: 'ai',
          confidence: 0.9
        },
        update: {
          content: translated,
          translatedBy: 'ai',
          confidence: 0.9,
          updatedAt: new Date()
        }
      });

      // Invalidate cache
      this.cache.delete(`content_${key}_${targetLanguage}`);

      await eventBus.publish('localization.translated', { key, language: targetLanguage }, 'LocalizationOS');

      return translated;
    } catch (error) {
      console.error('Translation failed:', error);
      return sourceContent; // Fallback to source
    }
  }

  /**
   * Auto-translate missing keys
   */
  async autoTranslateMissingKeys(sourceLanguage: string, targetLanguages: string[]) {
    const missingTranslations = await prisma.localizedContent.findMany({
      where: {
        language: sourceLanguage
      }
    });

    for (const targetLanguage of targetLanguages) {
      for (const content of missingTranslations) {
        const existing = await prisma.localizedContent.findUnique({
          where: {
            key_language: {
              key: content.key,
              language: targetLanguage
            }
          }
        });

        if (!existing) {
          await this.translateContent(content.key, targetLanguage);
        }
      }
    }
  }

  /**
   * Format currency for country
   */
  async formatCurrency(amount: number, countryCode: string): Promise<string> {
    const countryConfig = await this.getCountryConfig(countryCode);
    if (!countryConfig) {
      return `${amount}`;
    }

    const currencyConfig = await this.getCurrencyConfig(countryConfig.currency);
    if (!currencyConfig) {
      return `${amount}`;
    }

    // Format based on locale
    const locale = `${countryConfig.language}-${countryCode}`;
    return new Intl.NumberFormat(locale, {
      style: 'currency',
      currency: currencyConfig.code
    }).format(amount);
  }

  /**
   * Format date for country
   */
  async formatDate(date: Date, countryCode: string): Promise<string> {
    const countryConfig = await this.getCountryConfig(countryCode);
    if (!countryConfig) {
      return date.toLocaleDateString();
    }

    const locale = `${countryConfig.language}-${countryCode}`;
    return new Intl.DateTimeFormat(locale, {
      dateStyle: 'medium'
    }).format(date);
  }

  /**
   * Format number for country
   */
  async formatNumber(number: number, countryCode: string): Promise<string> {
    const countryConfig = await this.getCountryConfig(countryCode);
    if (!countryConfig) {
      return number.toLocaleString();
    }

    const locale = `${countryConfig.language}-${countryCode}`;
    return new Intl.NumberFormat(locale).format(number);
  }

  /**
   * Get regional pricing
   */
  async getRegionalPricing(countryCode: string, propertyType: string): Promise<RegionalPricing | null> {
    return prisma.regionalPricing.findFirst({
      where: {
        countryCode,
        propertyType
      }
    });
  }

  /**
   * Calculate localized price
   */
  async calculateLocalizedPrice(basePrice: number, countryCode: string, propertyType?: string, date?: Date): Promise<number> {
    const countryConfig = await this.getCountryConfig(countryCode);
    if (!countryConfig) return basePrice;

    let price = basePrice;

    // Apply tax/VAT if applicable
    if (countryConfig.taxRate) {
      price *= (1 + countryConfig.taxRate / 100);
    }

    if (countryConfig.vatRate) {
      price *= (1 + countryConfig.vatRate / 100);
    }

    // Apply seasonal adjustments if property type specified
    if (propertyType && date) {
      const regionalPricing = await this.getRegionalPricing(countryCode, propertyType);
      if (regionalPricing) {
        const season = this.getSeason(date);
        if (regionalPricing.season === season) {
          price *= regionalPricing.adjustment;
        }
      }
    }

    return Math.round(price * 100) / 100;
  }

  /**
   * Get country-specific legal requirements
   */
  async getLegalRequirements(countryCode: string): Promise<Record<string, any>> {
    const countryConfig = await this.getCountryConfig(countryCode);
    if (!countryConfig) return {};

    return countryConfig.legalRequirements;
  }

  /**
   * Get country-specific rental rules
   */
  async getRentalRules(countryCode: string): Promise<Record<string, any>> {
    const countryConfig = await this.getCountryConfig(countryCode);
    if (!countryConfig) return {};

    return countryConfig.rentalRules;
  }

  /**
   * Get supported payment providers for country
   */
  async getPaymentProviders(countryCode: string): Promise<string[]> {
    const countryConfig = await this.getCountryConfig(countryCode);
    if (!countryConfig) return [];

    return countryConfig.paymentProviders;
  }

  /**
   * Get supported property types for country
   */
  async getPropertyTypes(countryCode: string): Promise<string[]> {
    const countryConfig = await this.getCountryConfig(countryCode);
    if (!countryConfig) return [];

    return countryConfig.propertyTypes;
  }

  /**
   * Check if date is working day for country
   */
  async isWorkingDay(date: Date, countryCode: string): Promise<boolean> {
    const countryConfig = await this.getCountryConfig(countryCode);
    if (!countryConfig) {
      // Default to Mon-Fri
      const day = date.getDay();
      return day >= 1 && day <= 5;
    }

    return countryConfig.workingDays.includes(date.getDay());
  }

  /**
   * Get localized SEO metadata
   */
  async getSEOMetadata(path: string, language: string, countryCode: string): Promise<{
    title: string;
    description: string;
    keywords: string[];
  }> {
    const cacheKey = `seo_${path}_${language}_${countryCode}`;
    if (this.cache.has(cacheKey)) {
      return this.cache.get(cacheKey);
    }

    // Generate AI-powered SEO content
    try {
      const prompt = `
        Generate SEO metadata for a real estate platform page:
        
        Path: ${path}
        Language: ${language}
        Country: ${countryCode}
        
        Generate:
        1. Title (50-60 chars, SEO optimized)
        2. Description (150-160 chars, compelling)
        3. Keywords (5-10 relevant keywords)
        
        Return as JSON: { title: string, description: string, keywords: string[] }
      `;

      const metadata = await GeminiService.processHubSearch(prompt, { role: 'ADMIN' });
      const parsed = JSON.parse(metadata);

      this.cache.set(cacheKey, parsed);
      return parsed;
    } catch (error) {
      console.error('SEO metadata generation failed:', error);
      return {
        title: 'Reservatior - Real Estate Platform',
        description: 'Find your perfect property with Reservatior',
        keywords: ['real estate', 'rentals', 'property']
      };
    }
  }

  /**
   * Get localized AI recommendations
   */
  async getLocalizedRecommendations(
    userId: string,
    countryCode: string,
    language: string
  ): Promise<Array<{
    type: string;
    title: string;
    description: string;
    action: string;
  }>> {
    const countryConfig = await this.getCountryConfig(countryCode);
    if (!countryConfig) return [];

    // Generate region-specific recommendations
    try {
      const prompt = `
        Generate localized real estate recommendations for:
        Country: ${countryCode}
        Language: ${language}
        
        Consider:
        - Local market trends
        - Cultural preferences
        - Legal requirements
        - Popular property types
        
        Generate 3-5 recommendations with:
        - type: property_type | price_range | location | amenity
        - title: localized title
        - description: localized description
        - action: localized call-to-action
        
        Return as JSON array.
      `;

      const recommendations = await GeminiService.processHubSearch(prompt, { role: 'ADMIN' });
      return JSON.parse(recommendations);
    } catch (error) {
      console.error('Localized recommendations generation failed:', error);
      return [];
    }
  }

  /**
   * Create country configuration
   */
  async createCountryConfig(config: Omit<CountryConfig, 'id'>) {
    const created = await prisma.countryConfig.create({
      data: config
    });

    await eventBus.publish('localization.country_created', created, 'LocalizationOS');

    return created;
  }

  /**
   * Update exchange rate
   */
  async updateExchangeRate(currencyCode: string, rate: number) {
    const updated = await prisma.currencyConfig.update({
      where: { code: currencyCode },
      data: { exchangeRate: rate }
    });

    // Invalidate cache
    this.cache.delete(`currency_${currencyCode}`);

    await eventBus.publish('localization.exchange_rate_updated', { currencyCode, rate }, 'LocalizationOS');

    return updated;
  }

  /**
   * Get season from date
   */
  private getSeason(date: Date): string {
    const month = date.getMonth();
    
    if (month >= 2 && month <= 4) return 'spring';
    if (month >= 5 && month <= 7) return 'summer';
    if (month >= 8 && month <= 10) return 'autumn';
    return 'winter';
  }

  /**
   * Clear cache
   */
  clearCache(pattern?: string) {
    if (pattern) {
      for (const key of this.cache.keys()) {
        if (key.includes(pattern)) {
          this.cache.delete(key);
        }
      }
    } else {
      this.cache.clear();
    }
  }

  /**
   * Get localization statistics
   */
  async getStatistics(): Promise<{
    totalCountries: number;
    totalLanguages: number;
    totalCurrencies: number;
    translationCompletion: Record<string, number>;
  }> {
    const [countries, languages, currencies] = await Promise.all([
      prisma.countryConfig.count({ where: { isActive: true } }),
      prisma.languageConfig.count({ where: { isActive: true } }),
      prisma.currencyConfig.count({ where: { isActive: true } })
    ]);

    // Calculate translation completion based on localized content
    const languageConfigs = await prisma.languageConfig.findMany({
      where: { isActive: true }
    });

    const totalKeys = await prisma.localizedContent.count({
      where: { language: 'en' }
    });

    const translationCompletion: Record<string, number> = {};
    for (const lang of languageConfigs) {
      const translatedCount = await prisma.localizedContent.count({
        where: { language: lang.code }
      });
      translationCompletion[lang.code] = totalKeys > 0 ? (translatedCount / totalKeys) * 100 : 0;
    }

    return {
      totalCountries: countries,
      totalLanguages: languages,
      totalCurrencies: currencies,
      translationCompletion
    };
  }
}

export const localizationOSService = new LocalizationOSService();
