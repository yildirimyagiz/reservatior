import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import LanguageDetector from 'i18next-browser-languagedetector';

import arTranslations from '../locales/ar.json';
import daTranslations from '../locales/da.json';
import deTranslations from '../locales/de.json';
import enTranslations from '../locales/en.json';
import esTranslations from '../locales/es.json';
import fiTranslations from '../locales/fi.json';
import frTranslations from '../locales/fr.json';
import grTranslations from '../locales/gr.json';
import hiTranslations from '../locales/hi.json';
import itTranslations from '../locales/it.json';
import jaTranslations from '../locales/ja.json';
import koTranslations from '../locales/ko.json';
import nlTranslations from '../locales/nl.json';
import noTranslations from '../locales/no.json';
import plTranslations from '../locales/pl.json';
import ptTranslations from '../locales/pt.json';
import ruTranslations from '../locales/ru.json';
import seTranslations from '../locales/se.json';
import trTranslations from '../locales/tr.json';
import zhTranslations from '../locales/zh.json';

const resources = {
  ar: { translation: arTranslations },
  da: { translation: daTranslations },
  de: { translation: deTranslations },
  en: { translation: enTranslations },
  es: { translation: esTranslations },
  fi: { translation: fiTranslations },
  fr: { translation: frTranslations },
  gr: { translation: grTranslations },
  hi: { translation: hiTranslations },
  it: { translation: itTranslations },
  ja: { translation: jaTranslations },
  ko: { translation: koTranslations },
  nl: { translation: nlTranslations },
  no: { translation: noTranslations },
  pl: { translation: plTranslations },
  pt: { translation: ptTranslations },
  ru: { translation: ruTranslations },
  se: { translation: seTranslations },
  tr: { translation: trTranslations },
  'tr-TR': { translation: trTranslations },
  zh: { translation: zhTranslations }
};

i18n
  .use(LanguageDetector)
  .use(initReactI18next)
  .init({
    resources,
    fallbackLng: 'en',
    debug: false,
    keySeparator: false,
    nsSeparator: false,
    
    interpolation: {
      escapeValue: false
    },
    
    detection: {
      order: ['localStorage', 'navigator', 'htmlTag'],
      caches: ['localStorage']
    }
  });

export default i18n;

