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

// Eski/alternatif dil kodlarını güncel locale dosyalarına eşle (kaldırılan diller)
const FILE_MAP: Record<string, string> = {
  gr: 'el',
  no: 'nb',
  se: 'sv',
  fa: 'en',
  id: 'en',
  vi: 'en',
  th: 'en',
};

// Server (SSR) her zaman 'en' ile render eder; istemci tarafında hydration'dan
// sonra LocalizationContext, URL'deki locale'e (ör. /tr) geçiş yapar.
// Böylece sunucu HTML'i ile istemcinin ilk render'ı eşleşir ve hydration
// hataları (text/placeholder mismatch) oluşmaz.
const lng = 'en';

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

// Hydration'dan sonra LocalizationContext URL locale'ine geçtiğinde veya doğrudan admin paneline
// dil kodu olmadan girildiğinde anında doğru dilin servis edilmesini sağlar.
if (isBrowser) {
  const firstSegment = window.location.pathname.split('/').filter(Boolean)[0];
  if (firstSegment && /^[a-z]{2}$/.test(firstSegment)) {
    if (firstSegment !== 'en') {
      i18n.changeLanguage(firstSegment);
    }
  } else {
    // /admin/... gibi rotalara dil prefixi olmaksızın girildiyse hafızadan veya doğrudan 'tr' seç:
    const savedLang = localStorage.getItem("reservatior_lang") || localStorage.getItem("language") || localStorage.getItem("i18nextLng") || "tr";
    if (savedLang && savedLang !== "en") {
      i18n.changeLanguage(savedLang);
    }
  }
}

export default i18n;
