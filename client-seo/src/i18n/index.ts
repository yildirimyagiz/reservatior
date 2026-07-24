import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import HttpBackend from 'i18next-http-backend';

// ──────────────────────────────────────────────────────────────────────────────
// HTTP Backend kullanarak locale dosyalarını Webpack bundle'ından tamamen çıkarıyoruz.
// Dynamic import() kullanmak Webpack'in tüm locales/*.json dosyalarını chunk
// haritasına eklemesine neden olur → 1600+ modül, 7-10s derleme.
// HTTP backend ile bu dosyalar /public/locales/ üzerinden servis edilir,
// Webpack hiç görmez → 200-400 modül, <2s derleme.
// ──────────────────────────────────────────────────────────────────────────────

const isBrowser = typeof window !== 'undefined';

const SUPPORTED_LOCALES = new Set(['en','tr','ar','es','fr','de','ru','pt','zh','ja','ko','it','nl','pl','sv','da','fi','el','hi','id','gr','se','no']);

function getLocaleFromUrl(): string {
  if (!isBrowser) {
    try {
      const { headers } = require('next/headers');
      const hdrs = headers();
      const nextUrl = hdrs.get('x-next-url') || '';
      if (nextUrl) {
        const segments = nextUrl.split('/').filter(Boolean);
        const first = segments[0] || 'en';
        if (SUPPORTED_LOCALES.has(first)) return first;
      }
    } catch {}
    return 'en';
  }
  const segments = window.location.pathname.split('/').filter(Boolean);
  const first = segments[0] || 'en';
  return SUPPORTED_LOCALES.has(first) ? first : 'en';
}

const FILE_MAP: Record<string, string> = {
  el: 'gr',
  sv: 'se',
};

const lng = getLocaleFromUrl();

if (!i18n.isInitialized) {
  i18n
    .use(HttpBackend)
    .use(initReactI18next)
    .init({
      lng,
      fallbackLng: 'en',
      debug: false,
      keySeparator: false,
      nsSeparator: false,
      interpolation: { escapeValue: false },
      backend: {
        loadPath: (lngs: string[]) => {
          const lang = lngs[0];
          const file = FILE_MAP[lang] ?? lang;
          if (!isBrowser) {
            return `${typeof window !== 'undefined' ? '' : (process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com')}/locales/${file}.json`;
          }
          return `/locales/${file}.json`;
        },
      },
    });
}

export default i18n;
