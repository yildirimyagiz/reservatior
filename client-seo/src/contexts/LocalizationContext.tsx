'use client';

import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';

interface LocalizationContextType {
  countryCode: string;
  language: string;
  currency: string;
  timezone: string;
  setLocalization: (localization: {
    countryCode?: string;
    language?: string;
    currency?: string;
    timezone?: string;
  }) => void;
}

const LocalizationContext = createContext<LocalizationContextType | undefined>(undefined);

const DEFAULT_COUNTRY = 'US';
const DEFAULT_LANGUAGE = 'en';
const DEFAULT_CURRENCY = 'USD';
const DEFAULT_TIMEZONE = 'America/New_York';

export const LocalizationProvider = ({ children }: { children: ReactNode }) => {
  const [countryCode, setCountryCode] = useState(DEFAULT_COUNTRY);
  const [language, setLanguage] = useState(DEFAULT_LANGUAGE);
  const [currency, setCurrency] = useState(DEFAULT_CURRENCY);
  const [timezone, setTimezone] = useState(DEFAULT_TIMEZONE);

  // Load from localStorage on mount
  useEffect(() => {
    const savedCountryCode = localStorage.getItem('countryCode');
    const savedLanguage = localStorage.getItem('language');
    const savedCurrency = localStorage.getItem('currency');
    const savedTimezone = localStorage.getItem('timezone');

    if (savedCountryCode) setCountryCode(savedCountryCode);
    if (savedLanguage) setLanguage(savedLanguage);
    if (savedCurrency) setCurrency(savedCurrency);
    if (savedTimezone) setTimezone(savedTimezone);
    else {
      // Set default timezone from browser
      const browserTimezone = Intl.DateTimeFormat().resolvedOptions().timeZone;
      setTimezone(browserTimezone);
      localStorage.setItem('timezone', browserTimezone);
    }
  }, []);

  const setLocalization = (localization: {
    countryCode?: string;
    language?: string;
    currency?: string;
    timezone?: string;
  }) => {
    if (localization.countryCode) {
      setCountryCode(localization.countryCode);
      localStorage.setItem('countryCode', localization.countryCode);
    }
    if (localization.language) {
      setLanguage(localization.language);
      localStorage.setItem('language', localization.language);
    }
    if (localization.currency) {
      setCurrency(localization.currency);
      localStorage.setItem('currency', localization.currency);
    }
    if (localization.timezone) {
      setTimezone(localization.timezone);
      localStorage.setItem('timezone', localization.timezone);
    }
  };

  return (
    <LocalizationContext.Provider
      value={{
        countryCode,
        language,
        currency,
        timezone,
        setLocalization,
      }}
    >
      {children}
    </LocalizationContext.Provider>
  );
};

export const useLocalization = () => {
  const context = useContext(LocalizationContext);
  if (context === undefined) {
    throw new Error('useLocalization must be used within a LocalizationProvider');
  }
  return context;
};
