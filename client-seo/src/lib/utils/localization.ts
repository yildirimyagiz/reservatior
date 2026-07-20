// Get localization context from localStorage or defaults
export const getLocalizationContext = () => {
  if (typeof window !== 'undefined') {
    return {
      countryCode: localStorage.getItem('countryCode') || 'US',
      language: localStorage.getItem('language') || 'en',
      currency: localStorage.getItem('currency') || 'USD',
      timezone: localStorage.getItem('timezone') || Intl.DateTimeFormat().resolvedOptions().timeZone,
    };
  }
  return {
    countryCode: 'US',
    language: 'en',
    currency: 'USD',
    timezone: 'America/New_York',
  };
};

// Set localization context
export const setLocalizationContext = (context: {
  countryCode?: string;
  language?: string;
  currency?: string;
  timezone?: string;
}) => {
  if (typeof window !== 'undefined') {
    if (context.countryCode) localStorage.setItem('countryCode', context.countryCode);
    if (context.language) localStorage.setItem('language', context.language);
    if (context.currency) localStorage.setItem('currency', context.currency);
    if (context.timezone) localStorage.setItem('timezone', context.timezone);
  }
};

// Format currency based on locale
export const formatCurrency = (amount: number, currency?: string, language?: string): string => {
  const context = getLocalizationContext();
  const currencyCode = currency || context.currency;
  const locale = language || context.language;
  
  return new Intl.NumberFormat(locale, {
    style: 'currency',
    currency: currencyCode,
  }).format(amount);
};

// Format number based on locale
export const formatNumber = (value: number, language?: string): string => {
  const context = getLocalizationContext();
  const locale = language || context.language;
  
  return new Intl.NumberFormat(locale).format(value);
};

// Format date based on locale and timezone
export const formatDate = (date: Date | string, language?: string, timezone?: string): string => {
  const context = getLocalizationContext();
  const locale = language || context.language;
  const tz = timezone || context.timezone;
  
  return new Intl.DateTimeFormat(locale, {
    timeZone: tz,
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  }).format(new Date(date));
};

// Format date and time based on locale and timezone
export const formatDateTime = (date: Date | string, language?: string, timezone?: string): string => {
  const context = getLocalizationContext();
  const locale = language || context.language;
  const tz = timezone || context.timezone;
  
  return new Intl.DateTimeFormat(locale, {
    timeZone: tz,
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  }).format(new Date(date));
};

// Format percentage based on locale
export const formatPercentage = (value: number, language?: string): string => {
  const context = getLocalizationContext();
  const locale = language || context.language;
  
  return new Intl.NumberFormat(locale, {
    style: 'percent',
    minimumFractionDigits: 1,
    maximumFractionDigits: 2,
  }).format(value / 100);
};
