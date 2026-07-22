"use client";

import { createContext, useContext, ReactNode } from "react";
import { useLanguage } from "@/lib/languages";

interface LocalizationContextType {
  language: string;
  locale: string;
  dir: "ltr" | "rtl";
}

const LocalizationContext = createContext<LocalizationContextType>({
  language: "en",
  locale: "en",
  dir: "ltr",
});

export function LocalizationProvider({ children }: { children: ReactNode }) {
  const { language } = useLanguage();
  const dir = language === "ar" ? "rtl" : "ltr";
  return (
    <LocalizationContext.Provider value={{ language, locale: language, dir }}>
      {children}
    </LocalizationContext.Provider>
  );
}

export function useLocalization() {
  return useContext(LocalizationContext);
}
