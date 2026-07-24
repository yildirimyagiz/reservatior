"use client";

import { createContext, useContext, useEffect, ReactNode } from "react";
import { useLanguage } from "@/lib/languages";

interface LocalizationContextType {
  language: string;
  locale: string;
  dir: "ltr" | "rtl";
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
  hi: { countryCode: "IN", currency: "INR" },
  id: { countryCode: "ID", currency: "IDR" },
};

const LocalizationContext = createContext<LocalizationContextType>({
  language: "en",
  locale: "en",
  dir: "ltr",
});

export function LocalizationProvider({ children }: { children: ReactNode }) {
  const { language } = useLanguage();
  const dir = language === "ar" ? "rtl" : "ltr";

  useEffect(() => {
    const mapping = LOCALE_MAP[language] || LOCALE_MAP.en;
    try {
      if (!localStorage.getItem("countryCode")) localStorage.setItem("countryCode", mapping.countryCode);
      if (!localStorage.getItem("language")) localStorage.setItem("language", language || "en");
      if (!localStorage.getItem("currency")) localStorage.setItem("currency", mapping.currency);
      if (!localStorage.getItem("timezone")) localStorage.setItem("timezone", Intl.DateTimeFormat().resolvedOptions().timeZone);
    } catch {}
  }, [language]);

  return (
    <LocalizationContext.Provider value={{ language, locale: language, dir }}>
      {children}
    </LocalizationContext.Provider>
  );
}

export function useLocalization() {
  return useContext(LocalizationContext);
}
