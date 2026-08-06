"use client";

import { createContext, useContext, useEffect, useState, ReactNode } from "react";
import { useLanguage, LANGUAGES } from "@/lib/languages";

interface LocalizationUpdate {
  countryCode?: string;
  currency?: string;
  language?: string;
}

interface LocalizationContextType {
  language: string;
  locale: string;
  dir: "ltr" | "rtl";
  currency: string;
  countryCode: string;
  setLocalization: (update: LocalizationUpdate) => void;
}

const LOCALE_MAP: Record<string, { countryCode: string; currency: string }> = {
  en: { countryCode: "US", currency: "USD" },
  tr: { countryCode: "TR", currency: "TRY" },
  ar: { countryCode: "SA", currency: "SAR" },
  es: { countryCode: "ES", currency: "EUR" },
  fr: { countryCode: "FR", currency: "EUR" },
  de: { countryCode: "DE", currency: "EUR" },
  ru: { countryCode: "RU", currency: "RUB" },
  pt: { countryCode: "PT", currency: "EUR" },
  zh: { countryCode: "CN", currency: "CNY" },
  ja: { countryCode: "JP", currency: "JPY" },
  ko: { countryCode: "KR", currency: "KRW" },
  it: { countryCode: "IT", currency: "EUR" },
  nl: { countryCode: "NL", currency: "EUR" },
  pl: { countryCode: "PL", currency: "PLN" },
  sv: { countryCode: "SE", currency: "SEK" },
  da: { countryCode: "DK", currency: "DKK" },
  fi: { countryCode: "FI", currency: "EUR" },
  el: { countryCode: "GR", currency: "EUR" },
  no: { countryCode: "NO", currency: "NOK" },
  hi: { countryCode: "IN", currency: "INR" },
};

const LocalizationContext = createContext<LocalizationContextType>({
  language: "en",
  locale: "en",
  dir: "ltr",
  currency: "USD",
  countryCode: "US",
  setLocalization: () => {},
});

export function LocalizationProvider({ children }: { children: ReactNode }) {
  const { currentLang } = useLanguage();
  const language = currentLang.code;
  const dir = currentLang.dir;

  useEffect(() => {
    const segments = window.location.pathname.split("/").filter(Boolean);
    const urlLocale = segments[0] || "en";
    const state = useLanguage.getState();
    if (LANGUAGES.some((l) => l.code === urlLocale) && state.currentLang.code !== urlLocale) {
      state.setLanguage(urlLocale);
    }
  }, []);

  useEffect(() => {
    const mapping = LOCALE_MAP[language] || LOCALE_MAP.en;
    try {
      if (!localStorage.getItem("countryCode")) localStorage.setItem("countryCode", mapping.countryCode);
      if (!localStorage.getItem("language")) localStorage.setItem("language", language || "en");
      if (!localStorage.getItem("currency")) localStorage.setItem("currency", mapping.currency);
      if (!localStorage.getItem("timezone")) localStorage.setItem("timezone", Intl.DateTimeFormat().resolvedOptions().timeZone);
    } catch {}
  }, [language]);

  const [countryCode, setCountryCode] = useState<string>(() => {
    if (typeof window !== "undefined") return localStorage.getItem("countryCode") || LOCALE_MAP[language]?.countryCode || "US";
    return LOCALE_MAP[language]?.countryCode || "US";
  });
  const [currency, setCurrency] = useState<string>(() => {
    if (typeof window !== "undefined") return localStorage.getItem("currency") || LOCALE_MAP[language]?.currency || "USD";
    return LOCALE_MAP[language]?.currency || "USD";
  });

  const setLocalization = (update: LocalizationUpdate) => {
    if (update.language) {
      useLanguage.getState().setLanguage(update.language);
      try {
        localStorage.setItem("language", update.language);
      } catch {}
    }
    if (update.countryCode) setCountryCode(update.countryCode);
    if (update.currency) setCurrency(update.currency);
    try {
      if (update.countryCode) localStorage.setItem("countryCode", update.countryCode);
      if (update.currency) localStorage.setItem("currency", update.currency);
    } catch {}
  };

  return (
    <LocalizationContext.Provider value={{ language, locale: language, dir, currency, countryCode, setLocalization }}>
      {children}
    </LocalizationContext.Provider>
  );
}

export function useLocalization() {
  return useContext(LocalizationContext);
}
