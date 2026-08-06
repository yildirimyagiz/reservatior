import { create } from "zustand";
import i18n from "@/i18n";

export type Language = {
  code: string;
  name: string;
  dir: "ltr" | "rtl";
  flag: string;
};

export const LANGUAGES: Language[] = [
  { code: "en", name: "English", dir: "ltr", flag: "🇺🇸" },
  { code: "es", name: "Español", dir: "ltr", flag: "🇪🇸" },
  { code: "fr", name: "Français", dir: "ltr", flag: "🇫🇷" },
  { code: "de", name: "Deutsch", dir: "ltr", flag: "🇩🇪" },
  { code: "tr", name: "Türkçe", dir: "ltr", flag: "🇹🇷" },
  { code: "ar", name: "العربية", dir: "rtl", flag: "🇸🇦" },
  { code: "zh", name: "中文", dir: "ltr", flag: "🇨🇳" },
  { code: "ja", name: "日本語", dir: "ltr", flag: "🇯🇵" },
  { code: "ko", name: "한국어", dir: "ltr", flag: "🇰🇷" },
  { code: "ru", name: "Русский", dir: "ltr", flag: "🇷🇺" },
  { code: "pt", name: "Português", dir: "ltr", flag: "🇵🇹" },
  { code: "it", name: "Italiano", dir: "ltr", flag: "🇮🇹" },
  { code: "nl", name: "Nederlands", dir: "ltr", flag: "🇳🇱" },
  { code: "pl", name: "Polski", dir: "ltr", flag: "🇵🇱" },
  { code: "sv", name: "Svenska", dir: "ltr", flag: "🇸🇪" },
  { code: "da", name: "Dansk", dir: "ltr", flag: "🇩🇰" },
  { code: "fi", name: "Suomi", dir: "ltr", flag: "🇫🇮" },
  { code: "el", name: "Ελληνικά", dir: "ltr", flag: "🇬🇷" },
  { code: "hi", name: "हिन्दी", dir: "ltr", flag: "🇮🇳" },
  { code: "nb", name: "Norsk", dir: "ltr", flag: "🇳🇴" },
];

type LanguageStore = {
  currentLang: Language;
  setLanguage: (code: string) => void;
  t: (key: string) => string;
};

const TRANSLATIONS: Record<string, Record<string, string>> = {
  en: {
    "public.nav.home": "Home",
    "public.nav.features": "Features",
    "public.nav.global_os": "Global OS",
    "public.nav.listings": "Listings",
    "public.nav.pricing": "Pricing",
    "public.nav.videos": "Videos",
    "public.nav.login": "Log in",
    "public.nav.signup": "Sign up",
    "public.cta.get_started": "Get Started",
    "nav.features": "Features",
    "nav.listings": "Listings",
    "nav.pricing": "Pricing",
    "nav.login": "Log in",
    "nav.getStarted": "Get Started",
    "nav.videos": "Videos",
    "nav.addListing": "Add Listing",
    "hero.new": "New: AI Video Walkthroughs",
    "hero.title": "The Virtual Stage for Next-Gen Real Estate",
    "heroSubtitle": "Transform photos into cinematic video tours instantly.",
    "cta.demo": "View Demo Stage",
    "cta.create": "Create Your Own",
  },
  tr: {
    "public.nav.home": "Ana sayfa",
    "public.nav.features": "Özellikler",
    "public.nav.global_os": "Global OS",
    "public.nav.listings": "İlanlar",
    "public.nav.pricing": "Fiyatlandırma",
    "public.nav.videos": "Videolar",
    "public.nav.login": "Giriş yap",
    "public.nav.signup": "Kayıt ol",
    "public.cta.get_started": "Başla",
    "nav.features": "Özellikler",
    "nav.listings": "İlanlar",
    "nav.pricing": "Fiyatlandırma",
    "nav.login": "Giriş Yap",
    "nav.getStarted": "Başlayın",
    "nav.videos": "Videolar",
    "nav.addListing": "İlan Ekle",
    "hero.new": "Yeni: Yapay Zeka Video Turları",
    "hero.title": "Yeni Nesil Emlak İçin Sanal Sahne",
    "heroSubtitle":
      "Fotoğrafları anında sinematik video turlarına dönüştürün.",
    "cta.demo": "Demo Sahneyi Gör",
    "cta.create": "Kendi Sahnene Oluştur",
  },
  ar: {
    "public.nav.home": "الرئيسية",
    "public.nav.features": "الميزات",
    "public.nav.global_os": "Global OS",
    "public.nav.listings": "العقارات",
    "public.nav.pricing": "التسعير",
    "public.nav.videos": "الفيديوهات",
    "public.nav.login": "تسجيل الدخول",
    "public.nav.signup": "إنشاء حساب",
    "public.cta.get_started": "ابدأ الآن",
    "nav.features": "الميزات",
    "nav.showcase": "العرض",
    "nav.pricing": "التسعير",
    "nav.login": "تسجيل الدخول",
    "nav.getStarted": "ابدأ الآن",
    "nav.videos": "الفيديوهات",
    "nav.addListing": "أضف عقاراً",
    "hero.new": "جديد: جولات فيديو بالذكاء الاصطناعي",
    "hero.title": "المنصة الافتراضية للجيل القادم من العقارات",
    "heroSubtitle": "حول الصور إلى جولات فيديو سينمائية فوراً.",
    "cta.demo": "شاهد العرض التجريبي",
    "cta.create": "أنشئ مسرحك الخاص",
  },
  // Fallbacks for others to English for this prototype
};

export const useLanguage = create<LanguageStore>((set, get) => ({
  currentLang: LANGUAGES[0],
  setLanguage: (code) => {
    const lang = LANGUAGES.find((l) => l.code === code);
    if (lang) {
      set({ currentLang: lang });
      document.documentElement.dir = lang.dir;
      document.documentElement.lang = lang.code;
      // Sync react-i18next so page content updates
      i18n.changeLanguage(code);
      // Persist for middleware (server-side locale detection)
      document.cookie = `NEXT_LOCALE=${code};path=/;max-age=31536000;SameSite=Lax`;
      // Force re-render by triggering a custom event
      window.dispatchEvent(new CustomEvent('languageChange', { detail: { code } }));
    }
  },
  t: (key) => {
    const { currentLang } = get();
    // Try to get from react-i18next instance if initialized and has the key
    if (i18n && i18n.isInitialized && i18n.exists(key)) {
      return i18n.t(key);
    }
    const dict = TRANSLATIONS[currentLang.code] || TRANSLATIONS["en"];
    return dict[key] || TRANSLATIONS["en"][key] || key;
  },
}));
