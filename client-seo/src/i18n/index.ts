import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import HttpBackend from 'i18next-http-backend';
import type { InitOptions } from 'i18next';

// ──────────────────────────────────────────────────────────────────────────────
// HTTP Backend kullanarak locale dosyalarını Webpack bundle'ından tamamen çıkarıyoruz.
// Dynamic import() kullanmak Webpack'in tüm locales/*.json dosyalarını chunk
// haritasına eklemesine neden olur → 1600+ modül, 7-10s derleme.
// HTTP backend ile bu dosyalar /public/locales/ üzerinden servis edilir,
// Webpack hiç görmez → 200-400 modül, <2s derleme.
// ──────────────────────────────────────────────────────────────────────────────

const isBrowser = typeof window !== 'undefined';

// Next.js App Router, server component (RSC) ve client component graflarını AYRI
// webpack chunk'larına derler. `@/i18n` her iki grafa da import edildiğinden her
// biri kendi i18next örneğini oluşturur; server-preload'ın doldurduğu kaynaklar
// (RSC grafi) client grafinın useTranslation()'ına ulaşmazdı. Tek process/browser
// içinde globalThis paylaşıldığından, tüm grafların AYNI i18next örneğini
// kullanmasını sağlamak için global tekil (singleton) kullanıyoruz.
const GLOBAL_KEY = '__RESERVATIOR_I18N__';
const g = globalThis as unknown as Record<string, unknown>;

if (!g[GLOBAL_KEY]) {
  g[GLOBAL_KEY] = i18n;
}
const sharedI18n = g[GLOBAL_KEY] as typeof i18n;

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

// initReactI18next bağlaması her grafta (her module kopyasında) çalışmalı; aksi
// halde o grafların useTranslation()'ı bağlanmamış ayrı bir i18next kullanır.
sharedI18n.use(initReactI18next);

// Client tarafında locale dosyalarını /public/locales/*.json üzerinden yükleyen
// HTTP backend plugin'ini kaydet. use(HttpBackend) yapılmadığında init'teki
// backend.loadPath seçeneği işlemez; i18next boş resource store ile başlar ve
// tüm t() çağrıları ham anahtarı döndürür (CSS uppercase class'larıyla birleşince
// HOME.SEARCH.COUNTRY gibi büyük anahtar görünümü oluşur). Server tarafında
// resource'lar server-preload ile dosya sisteminden yüklendiği için backend
// sadece tarayıcıda kaydedilir.
if (isBrowser) {
  sharedI18n.use(HttpBackend);
}

if (!sharedI18n.isInitialized) {
  if (!isBrowser) {
    // Sunucu tarafı: HttpBackend ile HTTP isteği yapılmaz. Public URL üzerinden
    // yapılan istek nginx → web döngüsüne girip SSR'ı asılabilir (504'e yol açar).
    // Locale kaynakları src/i18n/server-preload.ts tarafından dosya sisteminden
    // senkron yüklenir. SSR her zaman 'en' render eder (hydration eşleşmesi için).
    sharedI18n.init({
      lng: 'en',
      fallbackLng: 'en',
      debug: false,
      keySeparator: false,
      nsSeparator: false,
      interpolation: { escapeValue: false },
      initImmediate: false,
    } as InitOptions);
  } else {
    sharedI18n.init({
      lng,
      fallbackLng: 'en',
      debug: false,
      keySeparator: false,
      nsSeparator: false,
      interpolation: { escapeValue: false },
      backend: {
        loadPath: (lngs: string[]) => `/locales/${FILE_MAP[lngs[0]] ?? lngs[0]}.json`,
      },
    });
  }
}

// Hydration'dan sonra LocalizationContext URL locale'ine geçtiğinde veya doğrudan admin paneline
// dil kodu olmadan girildiğinde anında doğru dilin servis edilmesini sağlar.
if (isBrowser) {
  const firstSegment = window.location.pathname.split('/').filter(Boolean)[0];
  if (firstSegment && /^[a-z]{2}$/.test(firstSegment)) {
    if (firstSegment !== 'en') {
      sharedI18n.changeLanguage(firstSegment);
    }
  } else {
    // /admin/... gibi rotalara dil prefixi olmaksızın girildiyse hafızadan veya doğrudan 'tr' seç:
    const savedLang = localStorage.getItem("reservatior_lang") || localStorage.getItem("language") || localStorage.getItem("i18nextLng") || "tr";
    if (savedLang && savedLang !== "en") {
      sharedI18n.changeLanguage(savedLang);
    }
  }
}

export default sharedI18n;
