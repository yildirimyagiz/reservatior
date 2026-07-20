/**
 * Localization OS API Routes
 */

import { Elysia, t } from 'elysia';
import { localizationOSService } from '../services/localization-os';

export const localizationOSRoutes = new Elysia({ prefix: '/localization' })
  /**
   * GET /api/localization/countries/:code
   * Get country configuration
   */
  .get('/countries/:code', async ({ params, set }) => {
    try {
      const config = await localizationOSService.getCountryConfig(params.code);
      return config;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get country config' };
    }
  })

  /**
   * GET /api/localization/languages/:code
   * Get language configuration
   */
  .get('/languages/:code', async ({ params, set }) => {
    try {
      const config = await localizationOSService.getLanguageConfig(params.code);
      return config;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get language config' };
    }
  })

  /**
   * GET /api/localization/currencies/:code
   * Get currency configuration
   */
  .get('/currencies/:code', async ({ params, set }) => {
    try {
      const config = await localizationOSService.getCurrencyConfig(params.code);
      return config;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get currency config' };
    }
  })

  /**
   * GET /api/localization/content
   * Get localized content
   */
  .get('/content', async ({ query, set }) => {
    try {
      const content = await localizationOSService.getLocalizedContent(
        query.key,
        query.language
      );
      return { content };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get localized content' };
    }
  })

  /**
   * POST /api/localization/translate
   * Translate content
   */
  .post('/translate', async ({ body, set }) => {
    try {
      const translated = await localizationOSService.translateContent(
        body.key,
        body.targetLanguage,
        body.context
      );
      return { translated };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to translate content' };
    }
  }, {
    body: t.Object({
      key: t.String(),
      targetLanguage: t.String(),
      context: t.Optional(t.String())
    })
  })

  /**
   * POST /api/localization/auto-translate
   * Auto-translate missing keys
   */
  .post('/auto-translate', async ({ body, set }) => {
    try {
      await localizationOSService.autoTranslateMissingKeys(
        body.sourceLanguage,
        body.targetLanguages
      );
      return { success: true };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to auto-translate' };
    }
  }, {
    body: t.Object({
      sourceLanguage: t.String(),
      targetLanguages: t.Array(t.String())
    })
  })

  /**
   * GET /api/localization/format/currency
   * Format currency for country
   */
  .get('/format/currency', async ({ query, set }) => {
    try {
      const formatted = await localizationOSService.formatCurrency(
        Number(query.amount),
        query.countryCode
      );
      return { formatted };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to format currency' };
    }
  })

  /**
   * GET /api/localization/format/date
   * Format date for country
   */
  .get('/format/date', async ({ query, set }) => {
    try {
      const formatted = await localizationOSService.formatDate(
        new Date(query.date),
        query.countryCode
      );
      return { formatted };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to format date' };
    }
  })

  /**
   * GET /api/localization/format/number
   * Format number for country
   */
  .get('/format/number', async ({ query, set }) => {
    try {
      const formatted = await localizationOSService.formatNumber(
        Number(query.number),
        query.countryCode
      );
      return { formatted };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to format number' };
    }
  })

  /**
   * GET /api/localization/pricing
   * Get regional pricing
   */
  .get('/pricing', async ({ query, set }) => {
    try {
      const pricing = await localizationOSService.getRegionalPricing(
        query.countryCode,
        query.propertyType
      );
      return pricing;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get regional pricing' };
    }
  })

  /**
   * GET /api/localization/calculate-price
   * Calculate localized price
   */
  .get('/calculate-price', async ({ query, set }) => {
    try {
      const price = await localizationOSService.calculateLocalizedPrice(
        Number(query.basePrice),
        query.countryCode,
        query.propertyType,
        query.date ? new Date(query.date) : undefined
      );
      return { price };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to calculate localized price' };
    }
  })

  /**
   * GET /api/localization/legal-requirements
   * Get legal requirements for country
   */
  .get('/legal-requirements', async ({ query, set }) => {
    try {
      const requirements = await localizationOSService.getLegalRequirements(query.countryCode);
      return requirements;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get legal requirements' };
    }
  })

  /**
   * GET /api/localization/rental-rules
   * Get rental rules for country
   */
  .get('/rental-rules', async ({ query, set }) => {
    try {
      const rules = await localizationOSService.getRentalRules(query.countryCode);
      return rules;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get rental rules' };
    }
  })

  /**
   * GET /api/localization/payment-providers
   * Get payment providers for country
   */
  .get('/payment-providers', async ({ query, set }) => {
    try {
      const providers = await localizationOSService.getPaymentProviders(query.countryCode);
      return { providers };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get payment providers' };
    }
  })

  /**
   * GET /api/localization/property-types
   * Get property types for country
   */
  .get('/property-types', async ({ query, set }) => {
    try {
      const types = await localizationOSService.getPropertyTypes(query.countryCode);
      return { types };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get property types' };
    }
  })

  /**
   * GET /api/localization/is-working-day
   * Check if date is working day
   */
  .get('/is-working-day', async ({ query, set }) => {
    try {
      const isWorkingDay = await localizationOSService.isWorkingDay(
        new Date(query.date),
        query.countryCode
      );
      return { isWorkingDay };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to check working day' };
    }
  })

  /**
   * GET /api/localization/seo
   * Get localized SEO metadata
   */
  .get('/seo', async ({ query, set }) => {
    try {
      const metadata = await localizationOSService.getSEOMetadata(
        query.path,
        query.language,
        query.countryCode
      );
      return metadata;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get SEO metadata' };
    }
  })

  /**
   * GET /api/localization/recommendations
   * Get localized recommendations
   */
  .get('/recommendations', async ({ query, set }) => {
    try {
      const recommendations = await localizationOSService.getLocalizedRecommendations(
        query.userId,
        query.countryCode,
        query.language
      );
      return recommendations;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get recommendations' };
    }
  })

  /**
   * POST /api/localization/countries
   * Create country configuration
   */
  .post('/countries', async ({ body, set }) => {
    try {
      const config = await localizationOSService.createCountryConfig(body);
      return config;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to create country config' };
    }
  }, {
    body: t.Object({
      code: t.String(),
      name: t.String(),
      nativeName: t.String(),
      currency: t.String(),
      currencySymbol: t.String(),
      language: t.String(),
      timezone: t.String(),
      dateFormat: t.String(),
      numberFormat: t.String(),
      weekendDays: t.Array(t.Number()),
      workingDays: t.Array(t.Number()),
      taxRate: t.Optional(t.Number()),
      vatRate: t.Optional(t.Number()),
      legalRequirements: t.Record(t.String, t.Any()),
      rentalRules: t.Record(t.String, t.Any()),
      paymentProviders: t.Array(t.String()),
      propertyTypes: t.Array(t.String()),
      isActive: t.Boolean()
    })
  })

  /**
   * PUT /api/localization/exchange-rates
   * Update exchange rate
   */
  .put('/exchange-rates', async ({ body, set }) => {
    try {
      const updated = await localizationOSService.updateExchangeRate(
        body.currencyCode,
        body.rate
      );
      return updated;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to update exchange rate' };
    }
  }, {
    body: t.Object({
      currencyCode: t.String(),
      rate: t.Number()
    })
  })

  /**
   * GET /api/localization/statistics
   * Get localization statistics
   */
  .get('/statistics', async ({ set }) => {
    try {
      const stats = await localizationOSService.getStatistics();
      return stats;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get statistics' };
    }
  });
