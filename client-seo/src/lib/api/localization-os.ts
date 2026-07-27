import { getLocalizationHeaders } from './localization-helper';

export const localizationOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/localization-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch localization OS dashboard stats');
    return res.json();
  },

  getCountryConfig: async (countryCode: string) => {
    const res = await fetch(`/api/v1/localization-os/countries/${countryCode}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch country config');
    return res.json();
  },

  getLanguageConfig: async (languageCode: string) => {
    const res = await fetch(`/api/v1/localization-os/languages/${languageCode}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch language config');
    return res.json();
  },

  getCurrencyConfig: async (currencyCode: string) => {
    const res = await fetch(`/api/v1/localization-os/currencies/${currencyCode}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch currency config');
    return res.json();
  },

  getLocalizedContent: async (key: string, language: string) => {
    const res = await fetch(`/api/v1/localization-os/content?key=${key}&language=${language}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch localized content');
    return res.json();
  },

  translateContent: async (key: string, targetLanguage: string, context?: string) => {
    const res = await fetch('/api/v1/localization-os/translate', {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ key, targetLanguage, context }),
    });
    if (!res.ok) throw new Error('Failed to translate content');
    return res.json();
  },

  autoTranslateMissingKeys: async (sourceLanguage: string, targetLanguages: string[]) => {
    const res = await fetch('/api/v1/localization-os/auto-translate', {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ sourceLanguage, targetLanguages }),
    });
    if (!res.ok) throw new Error('Failed to auto-translate missing keys');
    return res.json();
  },

  formatCurrency: async (amount: number, countryCode: string) => {
    const res = await fetch(`/api/v1/localization-os/format/currency?amount=${amount}&countryCode=${countryCode}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to format currency');
    return res.json();
  },

  formatDate: async (date: string, countryCode: string) => {
    const res = await fetch(`/api/v1/localization-os/format/date?date=${date}&countryCode=${countryCode}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to format date');
    return res.json();
  },

  formatNumber: async (number: number, countryCode: string) => {
    const res = await fetch(`/api/v1/localization-os/format/number?number=${number}&countryCode=${countryCode}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to format number');
    return res.json();
  },

  getRegionalPricing: async (countryCode: string, propertyType: string) => {
    const res = await fetch(`/api/v1/localization-os/regional-pricing?countryCode=${countryCode}&propertyType=${propertyType}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch regional pricing');
    return res.json();
  },

  calculateLocalizedPrice: async (basePrice: number, countryCode: string, propertyType?: string, date?: string) => {
    const params = new URLSearchParams({ basePrice: String(basePrice), countryCode });
    if (propertyType) params.append('propertyType', propertyType);
    if (date) params.append('date', date);
    const res = await fetch(`/api/v1/localization-os/calculate-price?${params}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to calculate localized price');
    return res.json();
  },

  getLegalRequirements: async (countryCode: string) => {
    const res = await fetch(`/api/v1/localization-os/legal-requirements?countryCode=${countryCode}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch legal requirements');
    return res.json();
  },

  getRentalRules: async (countryCode: string) => {
    const res = await fetch(`/api/v1/localization-os/rental-rules?countryCode=${countryCode}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch rental rules');
    return res.json();
  },

  getPaymentProviders: async (countryCode: string) => {
    const res = await fetch(`/api/v1/localization-os/payment-providers?countryCode=${countryCode}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch payment providers');
    return res.json();
  },

  getPropertyTypes: async (countryCode: string) => {
    const res = await fetch(`/api/v1/localization-os/property-types?countryCode=${countryCode}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch property types');
    return res.json();
  },

  isWorkingDay: async (date: string, countryCode: string) => {
    const res = await fetch(`/api/v1/localization-os/is-working-day?date=${date}&countryCode=${countryCode}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to check working day');
    return res.json();
  },

  getSEOMetadata: async (path: string, language: string, countryCode: string) => {
    const res = await fetch(`/api/v1/localization-os/seo-metadata?path=${path}&language=${language}&countryCode=${countryCode}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch SEO metadata');
    return res.json();
  },

  getLocalizedRecommendations: async (userId: string, countryCode: string, language: string) => {
    const res = await fetch(`/api/v1/localization-os/recommendations?userId=${userId}&countryCode=${countryCode}&language=${language}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch localized recommendations');
    return res.json();
  },

  createCountryConfig: async (config: any) => {
    const res = await fetch('/api/v1/localization-os/countries', {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify(config),
    });
    if (!res.ok) throw new Error('Failed to create country config');
    return res.json();
  },

  updateExchangeRate: async (currencyCode: string, rate: number) => {
    const res = await fetch(`/api/v1/localization-os/currencies/${currencyCode}/exchange-rate`, {
      method: 'PUT',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ rate }),
    });
    if (!res.ok) throw new Error('Failed to update exchange rate');
    return res.json();
  },

  getStatistics: async () => {
    const res = await fetch('/api/v1/localization-os/statistics', {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch statistics');
    return res.json();
  },

  getTranslationProgress: async (orgId: string) => {
    const res = await fetch(`/api/v1/localization-os/translation-progress?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch translation progress');
    return res.json();
  },

  getRegionalCoverage: async (orgId: string) => {
    const res = await fetch(`/api/v1/localization-os/regional-coverage?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch regional coverage');
    return res.json();
  },
};
