// Get localization headers for API requests
export const getLocalizationHeaders = () => {
  if (typeof window !== 'undefined') {
    const countryCode = localStorage.getItem('countryCode') || 'US';
    const language = localStorage.getItem('language') || 'en';
    const currency = localStorage.getItem('currency') || 'USD';
    const timezone = localStorage.getItem('timezone') || Intl.DateTimeFormat().resolvedOptions().timeZone;
    
    return {
      'x-country-code': countryCode,
      'x-language': language,
      'x-currency': currency,
      'x-timezone': timezone,
    };
  }
  
  return {
    'x-country-code': 'US',
    'x-language': 'en',
    'x-currency': 'USD',
    'x-timezone': 'America/New_York',
  };
};
