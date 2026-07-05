import { create } from "zustand";

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
  { code: "fa", name: "فارسی", dir: "rtl", flag: "🇮🇷" },
  { code: "zh", name: "中文", dir: "ltr", flag: "🇨🇳" },
  { code: "ja", name: "日本語", dir: "ltr", flag: "🇯🇵" },
  { code: "ko", name: "한국어", dir: "ltr", flag: "🇰🇷" },
  { code: "ru", name: "Русский", dir: "ltr", flag: "🇷🇺" },
  { code: "pt", name: "Português", dir: "ltr", flag: "🇵🇹" },
  { code: "it", name: "Italiano", dir: "ltr", flag: "🇮🇹" },
  { code: "nl", name: "Nederlands", dir: "ltr", flag: "🇳🇱" },
  { code: "pl", name: "Polski", dir: "ltr", flag: "🇵🇱" },
  { code: "sv", name: "Svenska", dir: "ltr", flag: "🇸🇪" },
  { code: "hi", name: "हिन्दी", dir: "ltr", flag: "🇮🇳" },
  { code: "id", name: "Bahasa Indonesia", dir: "ltr", flag: "🇮🇩" },
  { code: "vi", name: "Tiếng Việt", dir: "ltr", flag: "🇻🇳" },
  { code: "th", name: "ไทย", dir: "ltr", flag: "🇹🇭" },
];

type LanguageStore = {
  currentLang: Language;
  setLanguage: (code: string) => void;
  t: (key: string) => string;
};

const TRANSLATIONS: Record<string, Record<string, string>> = {
  en: {
    "nav.features": "Features",
    "nav.showcase": "Listings",
    "nav.pricing": "Pricing",
    "nav.login": "Log in",
    "nav.Get Started": "Get Started",
    "hero.new": "New: AI Video Walkthroughs",
    "hero.title": "The Virtual Stage for Next-Gen Real Estate",
    "heroSubtitle": "Transform photos into cinematic video tours instantly.",
    "cta.demo": "View Demo Stage",
    "cta.create": "Create Your Own",
  },
  tr: {
    "nav.features": "Özellikler",
    "nav.showcase": "Vitrin",
    "nav.pricing": "Fiyatlandırma",
    "nav.login": "Giriş Yap",
    "nav.Get Started": "Başlayın",
    "hero.new": "Yeni: Yapay Zeka Video Turları",
    "hero.title": "Yeni Nesil Emlak İçin Sanal Sahne",
    "heroSubtitle": "Fotoğrafları anında sinematik video turlarına dönüştürün.",
    "cta.demo": "Demo Sahneyi Gör",
    "cta.create": "Kendi Sahnene Oluştur",
  },
  ar: {
    "nav.features": "الميزات",
    "nav.showcase": "العرض",
    "nav.pricing": "التسعير",
    "nav.login": "تسجيل الدخول",
    "nav.Get Started": "ابدأ الآن",
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
      // Update document direction for RTL support
      document.documentElement.dir = lang.dir;
      document.documentElement.lang = lang.code;
    }
  },
  t: (key) => {
    const { currentLang } = get();
    const dict = TRANSLATIONS[currentLang.code] || TRANSLATIONS["en"];
    return dict[key] || TRANSLATIONS["en"][key] || key;
  },
}));
