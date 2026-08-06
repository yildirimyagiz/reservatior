"use client";

import Image from "next/image";
import { useTranslation } from "react-i18next";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { useState, useEffect, useRef, useMemo } from "react";
import { useQuery } from "@tanstack/react-query";
import { propertyApi, Property } from "@/lib/api/property";
import { useMapProvider } from "@/components/map/MapProvider";
import { useRegionsStore } from "@/lib/store/regions-store";
import { useLocalization } from "@/contexts/LocalizationContext";
import { formatCurrency } from "@/lib/utils/localization";
import GeminiClient from "@/lib/ai/gemini-client";
// Lazy-loaded to avoid bundling 1.7 MB react-country-state-city in the main chunk
const loadCountryCityData = () => import("react-country-state-city");
interface Country { iso2: string; name: string; id?: number; }
interface City { name: string; id?: number; latitude?: string; longitude?: string; countryCode?: string; }
import {
  Sparkles, Search, MapPin, ChevronRight, ChevronLeft, 
  ArrowRight, ShieldCheck, ChevronDown, Monitor, Gem, CheckCircle2, Mouse,
  Globe, SlidersHorizontal
} from "lucide-react";
import { Footer } from "@/components/layout/Footer";
import { m, useScroll, useTransform, AnimatePresence } from "framer-motion";
import { AppHeader } from "@/components/layout/AppHeader";
import { InvestmentWidget } from "@/components/investment/InvestmentWidget";
import dynamic from 'next/dynamic';

const AIChatModal = dynamic(() => import('@/components/home/AIChatModal').then(mod => mod.AIChatModal), { ssr: false });
const SupportChatModal = dynamic(() => import('@/components/home/SupportChatModal').then(mod => mod.SupportChatModal), { ssr: false });
const AdvancedFilterModal = dynamic(() => import('@/components/home/AdvancedFilterModal').then(mod => mod.AdvancedFilterModal), { ssr: false });

// Supported countries based on Prisma configurations in server/config
const SUPPORTED_COUNTRIES = [
  "AE", "AR", "AU", "BR", "CA", "CN", "DE", "ES", "FR", "GB", "IN", 
  "IT", "JP", "KR", "MX", "MY", "NL", "NZ", "SA", "SG", "TH", "TR", "US"
];

/* ───── Multi-Country Area Formatting Engine (m² vs sq ft) ───── */
const IMPERIAL_AREA_COUNTRIES = ["US", "GB", "CA", "IN", "MY"];
export function formatAreaByCountry(areaVal: number | string | undefined, countryIso: string = "TR"): string {
  if (!areaVal) return "";
  const strVal = areaVal.toString();
  const num = typeof areaVal === "number" ? areaVal : parseFloat(strVal.replace(/[^0-9.]/g, ""));
  if (isNaN(num)) return strVal;
  
  const iso = (countryIso || "TR").toUpperCase().trim();
  if (IMPERIAL_AREA_COUNTRIES.includes(iso)) {
    const sqFt = Math.round(num * 10.7639);
    return `${new Intl.NumberFormat("en-US").format(sqFt)} sq ft`;
  } else if (iso === "AE") {
    // Dubai / BAE Standard: Küresel yatırımcılar için çift formatta sunum
    const sqFt = Math.round(num * 10.7639);
    return `${new Intl.NumberFormat("tr-TR").format(num)} m² (${new Intl.NumberFormat("en-US").format(sqFt)} sq ft)`;
  }
  return `${new Intl.NumberFormat("tr-TR").format(num)} m²`;
}

/* ───── Fallback Slides for Hero & Properties ───── */
const FALLBACK_SLIDES = [
  { title: "Hayat City", location: "Bağcılar, Mahmutbey", price: "%50 Peşinat Fırsatı", beds: "1+1 - 3+1", baths: "2 - 3 Banyo", sqm: "6,500 m²", areaVal: 6500, image: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=1920&q=80", tag: "YENİ PROJE" },
  { title: "Özak Dragos", location: "Maltepe, İstanbul", price: "Adalar & Deniz Manzaralı", beds: "1+1 - 3+1", baths: "2 - 4 Banyo", sqm: "16,000 m²", areaVal: 16000, image: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=1920&q=80", tag: "DENİZ MANZARALI" },
  { title: "Büyükyalı İstanbul", location: "Zeytinburnu, Sahil Yolu", price: "Hemen Teslim", beds: "2+1 - 5.5+1", baths: "2 - 5 Banyo", sqm: "111,000 m²", areaVal: 111000, image: "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=1920&q=80", tag: "OTURUMA HAZIR" },
  { title: "Özak Duyu Göktürk", location: "Göktürk, Belgrad Ormanı", price: "Orman Manzaralı", beds: "1+1 - 4.5+1", baths: "2 - 4 Banyo", sqm: "12,000 m²", areaVal: 12000, image: "https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=1920&q=80", tag: "DOĞA İÇİNDE" },
];



/* ───── Country-specific Property Vibes ───── */
// Map locale codes to region codes for country-specific vibes
const LOCALE_TO_REGION: Record<string, string> = {
  'tr': 'TR',
  'en': 'USA',
};

interface Vibe {
  icon: string;
  name: string;
  englishName: string;
  count: string;
  desc: string;
  badge: string;
}

// Turkey-specific vibes (Türkçe terminoloji)
const TURKEY_VIBES: Vibe[] = [
  { icon: "🏖️", name: "home.vibes.yazlik", englishName: "yazlik", count: "1,204", desc: "home.vibes.yazlik_desc", badge: "home.vibes.yazlik_badge" },
  { icon: "⛰️", name: "home.vibes.dag_evi", englishName: "dag_evi", count: "853", desc: "home.vibes.dag_evi_desc", badge: "home.vibes.dag_evi_badge" },
  { icon: "🏛️", name: "home.vibes.kosk", englishName: "kosk", count: "432", desc: "home.vibes.kosk_desc", badge: "home.vibes.kosk_badge" },
  { icon: "🏙️", name: "home.vibes.dubleks", englishName: "dubleks", count: "921", desc: "home.vibes.dubleks_desc", badge: "home.vibes.dubleks_badge" },
  { icon: "🌲", name: "home.vibes.mustakil", englishName: "mustakil", count: "3,105", desc: "home.vibes.mustakil_desc", badge: "home.vibes.mustakil_badge" },
  { icon: "🏰", name: "home.vibes.yali", englishName: "yali", count: "89", desc: "home.vibes.yali_desc", badge: "home.vibes.yali_badge" },
  { icon: "🏝️", name: "home.vibes.ada", englishName: "ada", count: "42", desc: "home.vibes.ada_desc", badge: "home.vibes.ada_badge" },
  { icon: "📐", name: "home.vibes.rezidans", englishName: "rezidans", count: "5,602", desc: "home.vibes.rezidans_desc", badge: "home.vibes.rezidans_badge" },
];

// USA/International vibes (English terminology)
const USA_VIBES: Vibe[] = [
  { icon: "🏖️", name: "home.vibes.beachfront", englishName: "beachfront", count: "1,204", desc: "home.vibes.beachfront_desc", badge: "home.vibes.beachfront_badge" },
  { icon: "🏔️", name: "home.vibes.mountains", englishName: "mountains", count: "853", desc: "home.vibes.mountains_desc", badge: "home.vibes.mountains_badge" },
  { icon: "🏛️", name: "home.vibes.mansions", englishName: "mansions", count: "432", desc: "home.vibes.mansions_desc", badge: "home.vibes.mansions_badge" },
  { icon: "🏙️", name: "home.vibes.penthouses", englishName: "penthouses", count: "921", desc: "home.vibes.penthouses_desc", badge: "home.vibes.penthouses_badge" },
  { icon: "🌲", name: "home.vibes.cabins", englishName: "cabins", count: "3,105", desc: "home.vibes.cabins_desc", badge: "home.vibes.cabins_badge" },
  { icon: "🏰", name: "home.vibes.castles", englishName: "castles", count: "89", desc: "home.vibes.castles_desc", badge: "home.vibes.castles_badge" },
  { icon: "🏝️", name: "home.vibes.islands", englishName: "islands", count: "42", desc: "home.vibes.islands_desc", badge: "home.vibes.islands_badge" },
  { icon: "📐", name: "home.vibes.modern", englishName: "modern", count: "5,602", desc: "home.vibes.modern_desc", badge: "home.vibes.modern_badge" },
];

// Helper to get vibes based on locale
function getVibesForLocale(currentLocale: string): Vibe[] {
  const region = LOCALE_TO_REGION[currentLocale] || 'USA';
  return region === 'TR' ? TURKEY_VIBES : USA_VIBES;
}

function EcosystemPreview() {
  const { t } = useTranslation();
  const { currency, locale } = useLocalization();
  const [activeTab, setActiveTab] = useState(0);

  useEffect(() => {
    const timer = setInterval(() => {
      setActiveTab((prev) => (prev + 1) % 3);
    }, 4000);
    return () => clearInterval(timer);
  }, []);

  const tabs = [
    {
      id: "agent-os",
      icon: <Monitor className="w-5 h-5 text-brand dark:text-brand" />,
      title: "Danışman & Ofis OS",
      content: (
        <div className="flex flex-col gap-4 h-full justify-center">
          <div className="flex justify-between items-center bg-muted/50 rounded-2xl p-5 border border-border hover:bg-muted transition-colors">
            <div>
              <div className="text-muted-foreground text-sm font-medium mb-1">Komisyon Paylaşım Oranı (Danışman / Ofis)</div>
              <div className="text-3xl font-black text-foreground">%70 / %30</div>
            </div>
            <div className="w-14 h-14 rounded-full bg-brand/10 flex items-center justify-center">
              <Sparkles className="w-7 h-7 text-brand dark:text-brand" />
            </div>
          </div>
          <div className="flex justify-between items-center bg-muted/50 rounded-2xl p-5 border border-border hover:bg-muted transition-colors">
            <div>
              <div className="text-muted-foreground text-sm font-medium mb-1">Ortaklık Ağı Aylık Pasif Gelir</div>
              <div className="text-2xl font-bold text-success dark:text-success">{formatCurrency(12450, currency, locale)} / ay</div>
            </div>
            <div className="w-14 h-14 rounded-full bg-success/10 flex items-center justify-center">
              <CheckCircle2 className="w-7 h-7 text-success dark:text-success" />
            </div>
          </div>
        </div>
      )
    },
    {
      id: "fintech",
      icon: <Gem className="w-5 h-5 text-brand dark:text-brand" />,
      title: "FinTech (%0 Kesinti)",
      content: (
        <div className="flex flex-col gap-4 h-full justify-center">
          <div className="text-center">
            <div className="inline-flex items-center justify-center w-20 h-20 rounded-full bg-gradient-to-br from-brand/10 to-pink-500/10 mb-6 border border-brand/20 shadow-[0_0_30px_hsl(var(--brand)/0.2)]">
              <ShieldCheck className="w-10 h-10 text-brand dark:text-brand" />
            </div>
            <span className="text-4xl font-black text-foreground mb-2 block">%0 Komisyon Kesintisi</span>
            <p className="text-muted-foreground font-medium">Açık Bankacılık & A2A Doğrudan Ödeme Entegrasyonu ile</p>
          </div>
          <div className="bg-gradient-to-r from-brand/10 to-pink-500/10 rounded-2xl p-4 border border-brand/20 mt-6 text-center shadow-inner">
            <span className="text-sm font-black tracking-widest text-brand dark:text-brand">21 GÜNLÜK ESCROW (GÜVENCE HESABI) GÜVENCESİ</span>
          </div>
        </div>
      )
    },
    {
      id: "ai-studio",
      icon: <Mouse className="w-5 h-5 text-success dark:text-success" />,
      title: "Yapay Zeka Stüdyosu",
      content: (
        <div className="flex flex-col gap-4 h-full justify-center">
          {[
            { label: "Yapay Zeka Destekli Mülk Eşleştirme", status: "Aktif Motor", color: "text-success dark:text-success", bg: "bg-success/5 border-success/20" },
            { label: "Otomatik İlan Tanıtım Metni Oluşturma", status: "Oluşturuldu", color: "text-success dark:text-success", bg: "bg-success/5 border-success/20" },
            { label: "Akıllı Evrak ve Tapu Sorgulama (RAG)", status: "Nöral Ağ Devrede", color: "text-brand dark:text-brand", bg: "bg-brand/5 border-brand/20" },
          ].map((item, i) => (
            <m.div key={i} initial={{ opacity: 0, x: 20 }} animate={{ opacity: 1, x: 0 }} transition={{ delay: i * 0.15 }}
              className={`flex justify-between items-center p-5 rounded-2xl border ${item.bg}`}>
              <span className="text-foreground/80 font-medium">{item.label}</span>
              <span className={`font-bold ${item.color}`}>{item.status}</span>
            </m.div>
          ))}
        </div>
      )
    }
  ];

  return (
    <div className="w-full h-full rounded-[2rem] border border-border bg-card/80 backdrop-blur-2xl shadow-2xl p-8 flex flex-col gap-8">
      {/* Header */}
      <div className="flex justify-between items-center pb-6 border-b border-border">
        <div className="flex gap-3 bg-muted/50 p-1.5 rounded-full border border-border">
          {tabs.map((tab, i) => (
            <button
              key={tab.id}
              onClick={() => setActiveTab(i)}
              aria-label={t(`home.tab_${tab.id}`, { defaultValue: tab.title })}
              className={`px-5 py-2.5 rounded-full text-sm font-bold transition-all flex items-center gap-2 ${
                activeTab === i ? 'bg-background text-foreground shadow-sm' : 'bg-transparent text-muted-foreground hover:text-foreground'
              }`}
            >
              {tab.icon}
              <span className="hidden sm:inline">{tab.title}</span>
            </button>
          ))}
        </div>
      </div>
      
      {/* Content area with AnimatePresence */}
      <div className="flex-1 relative overflow-hidden min-h-[250px]">
        <AnimatePresence mode="wait">
          <m.div
            key={activeTab}
            initial={{ opacity: 0, y: 20, scale: 0.95 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: -20, scale: 0.95 }}
            transition={{ duration: 0.4, ease: "easeOut" }}
            className="absolute inset-0 flex flex-col justify-center"
          >
            {tabs[activeTab].content}
          </m.div>
        </AnimatePresence>
      </div>
      
      {/* Footer metric */}
      <div className="h-24 bg-gradient-to-r from-brand/15 via-brand/15 to-transparent rounded-2xl border border-border flex items-center justify-between p-6">
        <div>
          <div className="text-muted-foreground font-medium mb-1.5">Global Operasyonel Sistem Durumu</div>
          <div className="text-foreground font-bold flex items-center gap-3 text-lg">
            <div className="w-3 h-3 rounded-full bg-success animate-pulse shadow-[0_0_10px_rgba(16,185,129,0.8)]" />
            Tüm FinTech, Güvenlik ve AI Modülleri 7/24 Devrede
          </div>
        </div>
        <Sparkles className="w-8 h-8 text-muted-foreground/30" />
      </div>
    </div>
  );
}

export function HomeContent({ initialProperties = [] }: { initialProperties?: Record<string, unknown>[] }) {
  const { t } = useTranslation();
  const router = useRouter();
  const { selectedRegion } = useRegionsStore();
  const { currency, locale } = useLocalization();
  const [aiModalOpen, setAiModalOpen] = useState(false);
  const [supportModalOpen, setSupportModalOpen] = useState(false);
  const [heroRevealed, setHeroRevealed] = useState(false);

  // Get country-specific vibes based on locale
  const [vibes, setVibes] = useState(getVibesForLocale(locale));

  // Update vibes when locale changes
  useEffect(() => {
    setVibes(getVibesForLocale(locale));
    // Reset selected vibe to first vibe of new locale
    setSelectedVibe(getVibesForLocale(locale)[0].englishName);
  }, [locale]);

  // Search State
  const [advancedFilterOpen, setAdvancedFilterOpen] = useState(false);
  const [searchRooms, setSearchRooms] = useState<string>("all");
  const [selectedVibe, setSelectedVibe] = useState<string>(getVibesForLocale(locale)[0].englishName);
  const [searchMode, setSearchMode] = useState<"STAY" | "BUY" | "RENT" | "INVEST">("STAY");
  const [buyBudget, setBuyBudget] = useState<string>("all");
  const [buyCompliance, setBuyCompliance] = useState<string>("citizenship");
  const [investRoi, setInvestRoi] = useState<string>("8-10");
  const [investModel, setInvestModel] = useState<string>("partner-os");
  const [searchLocation, setSearchLocation] = useState("");
  const [searchDate, setSearchDate] = useState("");
  const [searchGuests, setSearchGuests] = useState(1);
  const [selectedCountry, setSelectedCountry] = useState<string>("TR");
  const [countries, setCountries] = useState<Country[]>([]);
  const [locationSuggestions, setLocationSuggestions] = useState<City[]>([]);
  const [showLocationSuggestions, setShowLocationSuggestions] = useState(false);
  const [showCountryDropdown, setShowCountryDropdown] = useState(false);
  const [countrySearch, setCountrySearch] = useState("");
  const [aiSuggestions, setAiSuggestions] = useState<{ text: string; type: string; confidence: number }[]>([]);
  const [showAiSuggestions, setShowAiSuggestions] = useState(false);
  const [isAiLoading, setIsAiLoading] = useState(false);

  const locationInputRef = useRef<HTMLInputElement>(null);
  const { provider, apiKey } = useMapProvider();
  const { scrollY } = useScroll();
  const heroOpacity = useTransform(scrollY, [0, 600], [1, 0]);
  const [googleMapsLoaded, setGoogleMapsLoaded] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      // Also trigger reveal on scroll
      if (window.scrollY > 10 && !heroRevealed) setHeroRevealed(true);
    };
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, [heroRevealed]);

  // Cinematic reveal timer
  useEffect(() => {
    const timer = setTimeout(() => setHeroRevealed(true), 2500);
    return () => clearTimeout(timer);
  }, []);

  // Load countries only when country dropdown is opened (lazy-loaded to avoid 1.7 MB bundle in main chunk)
  useEffect(() => {
    if (!showCountryDropdown || countries.length > 0) return;
    const loadCountries = async () => {
      try {
        const folderUrl = typeof window !== 'undefined' ? `${window.location.origin}/country-data` : "/country-data";
        const { GetCountries } = await loadCountryCityData();
        const allCountries = await GetCountries(folderUrl);
        const supported = allCountries.filter((c: Country) => SUPPORTED_COUNTRIES.includes(c.iso2));
        setCountries(supported);
      } catch (error) {
        console.error('Error loading countries:', error);
      }
    };
    loadCountries();
  }, [showCountryDropdown, countries.length]);

  // Load cities for autocomplete based on selected country (lazy-loaded, only when location input is focused)
  useEffect(() => {
    const loadCities = async () => {
      try {
        const folderUrl = typeof window !== 'undefined' ? `${window.location.origin}/country-data` : "/country-data";
        const { GetAllCities } = await loadCountryCityData();
        const cities = await GetAllCities(folderUrl);
        setLocationSuggestions(cities.slice(0, 50));
      } catch (error) {
        console.error('Error loading cities:', error);
      }
    };
    loadCities();
  }, [selectedCountry]);

  const loadGoogleMapsAutocomplete = () => {
    if (googleMapsLoaded || provider !== "google") return;
    setGoogleMapsLoaded(true);
    const initGoogleAutocomplete = () => {
      const googleWindow = window as unknown as { google?: { maps?: { places?: { Autocomplete: new (element: HTMLElement, options: Record<string, unknown>) => { addListener: (event: string, callback: () => void) => void } } } } };
      if (!locationInputRef.current || !googleWindow.google?.maps?.places) return;
      const autocomplete = new googleWindow.google.maps.places.Autocomplete(locationInputRef.current, { 
        types: ['(cities)'],
        componentRestrictions: { country: selectedCountry.toLowerCase() }
      });
      (autocomplete as { addListener: (event: string, callback: () => void) => void }).addListener("place_changed", () => {
        const place = (autocomplete as unknown as { getPlace: () => { formatted_address?: string; name?: string } }).getPlace();
        if (place && place.formatted_address) setSearchLocation(place.formatted_address);
        else if (place && place.name) setSearchLocation(place.name);
      });
    };
    const googleWindow = window as unknown as { google?: { maps?: { places?: unknown } } };
    if (googleWindow.google?.maps?.places) { initGoogleAutocomplete(); return; }
    const scriptId = "google-maps-places-script";
    let script = document.getElementById(scriptId) as HTMLScriptElement;
    if (!script) {
      script = document.createElement("script");
      script.id = scriptId;
      script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey.google || process.env.NEXT_PUBLIC_GOOGLE_MAPS_API_KEY || ""}&libraries=places&loading=async`;
      script.async = true; script.defer = true;
      script.onload = initGoogleAutocomplete;
      document.head.appendChild(script);
    } else script.addEventListener("load", initGoogleAutocomplete);
  };

  // AI-powered search suggestions
  const handleAiSuggestions = async (input: string) => {
    if (input.length < 3) {
      setAiSuggestions([]);
      setShowAiSuggestions(false);
      return;
    }

    setIsAiLoading(true);
    try {
      const suggestions = await GeminiClient.getSearchSuggestions(input);
      setAiSuggestions(suggestions);
      setShowAiSuggestions(suggestions.length > 0);
    } catch (error) {
      console.error('AI suggestions error:', error);
      setAiSuggestions([]);
    } finally {
      setIsAiLoading(false);
    }
  };

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    const params = new URLSearchParams();
    if (searchLocation) params.append("location", searchLocation);
    if (searchRooms !== "all") params.append("rooms", searchRooms);
    if ((searchMode === "STAY" || searchMode === "RENT") && searchDate) params.append("date", searchDate);
    if ((searchMode === "STAY" || searchMode === "RENT") && searchGuests > 1) params.append("guests", searchGuests.toString());
    if (searchMode === "BUY") {
      if (buyBudget !== "all") params.append("budget", buyBudget);
      params.append("compliance", buyCompliance);
    }
    if (searchMode === "INVEST") {
      params.append("targetRoi", investRoi);
      params.append("management", investModel);
    }
    params.append("listingType", searchMode === "STAY" ? "RENT" : searchMode);
    router.push(`/property?${params.toString()}`);
  };

  const { data: rawResponse } = useQuery({
    queryKey: ["properties", "featured", selectedRegion?.countryCode],
    queryFn: () => propertyApi.getProperties(),
    initialData: initialProperties.length > 0 ? { data: initialProperties } : undefined,
  });
  const response = rawResponse as { data?: Property[] } | null;

  const slides = useMemo(() => {
    if (!response?.data || response.data.length === 0) return FALLBACK_SLIDES;
    return response.data.slice(0, 4).map((p: Property, i: number) => {
      const fallback = FALLBACK_SLIDES[i % FALLBACK_SLIDES.length];
      const rawImg = p.listings?.[0]?.pricingRules?.[0]?.discountRules?.image;
      const finalImage = (rawImg && typeof rawImg === 'string' && rawImg.length > 10) ? rawImg : fallback.image;
      return { ...fallback, title: p.name || fallback.title, location: p.address || fallback.location, price: p.price ? formatCurrency(Number(p.price), currency, locale) : fallback.price, image: finalImage };
    });
  }, [response, currency, locale]);

  const [currentSlide, setCurrentSlide] = useState(0);
  useEffect(() => { const iv = setInterval(() => setCurrentSlide(c => (c + 1) % Math.max(slides.length, 4)), 6000); return () => clearInterval(iv); }, [slides.length]);
  const slide = slides[currentSlide] || slides[0];

  const bgVideo = useMemo(() => {
    const videos = ["ozak-bg", "ozak-dragos-bg", "ozak-buyukyali-bg", "ozak-duyu-bg"];
    return videos[currentSlide % videos.length];
  }, [currentSlide]);

  return (
    <div className="min-h-screen bg-background text-foreground overflow-x-hidden selection:bg-black selection:text-white dark:selection:bg-card dark:selection:text-black">
      <AppHeader />

      {/* ══════ CINEMATIC HERO ══════ */}
      <section className="relative h-[100svh] w-full flex flex-col overflow-hidden bg-black always-dark">
        {/* Video Background */}
        <m.div style={{ opacity: heroOpacity }} className="absolute inset-0 z-0">
          <AnimatePresence mode="wait">
            <m.video
              key={bgVideo}
              autoPlay
              loop
              muted
              playsInline
              preload="metadata"
              poster="/videos/poster.webp"
              onLoadedMetadata={(e) => { e.currentTarget.currentTime = 2; }}
              initial={{ opacity: 0, scale: 1.1 }}
              animate={{ opacity: 1, scale: 1.05 }}
              exit={{ opacity: 0 }}
              transition={{ duration: 1.5, ease: "easeOut" }}
              className="w-full h-full object-cover"
            >
              <source src={`/videos/webm/${bgVideo}-low.webm`} type="video/webm" />
              <source src={`/videos/webm/${bgVideo}.webm`} type="video/webm" />
              <source src={`/videos/${bgVideo}.mp4`} type="video/mp4" />
            </m.video>
          </AnimatePresence>
          <div className="absolute inset-0 bg-gradient-to-t from-black/90 via-black/30 to-black/50" />
        </m.div>

        {/* ─── FAZ 1: LOGO + SCROLL ICON (Başlangıç) ─── */}
        <AnimatePresence>
          {!heroRevealed && (
            <m.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0, y: -30 }}
              transition={{ duration: 0.8 }}
              className="absolute inset-0 z-20 flex flex-col items-center justify-center"
            >
              {/* Logo */}
              <m.div
                initial={{ opacity: 0, scale: 0.8 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ duration: 1.2, ease: "easeOut" }}
                className="text-center"
              >
                <h1 className="text-7xl md:text-9xl font-black text-transparent bg-clip-text bg-gradient-to-br from-white via-slate-100 to-slate-400 tracking-tighter drop-shadow-[0_0_20px_rgba(255,255,255,0.4)]">
                  Reservatior
                </h1>
                <p className="text-white/50 text-sm md:text-base font-medium tracking-[0.3em] uppercase mt-4">
                  {t("home.hero.tagline", { defaultValue: "Yeni Nesil Gayrimenkul İşletim Sistemi" })}
                </p>
              </m.div>

              {/* Scroll Down Indicator */}
              <m.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 1.5, duration: 1 }}
                className="absolute bottom-12 flex flex-col items-center gap-3 cursor-pointer"
                role="button"
                tabIndex={0}
                aria-label={t("home.hero.scroll", { defaultValue: "Keşfetmek için kaydırın" })}
                onClick={() => setHeroRevealed(true)}
              >
                <m.div
                  animate={{ y: [0, 8, 0] }}
                  transition={{ duration: 2, repeat: Infinity, ease: "easeInOut" }}
                >
                  <Mouse className="w-6 h-6 text-white/60" />
                </m.div>
                <span className="text-white/40 text-[10px] font-bold tracking-[0.3em] uppercase">
                  {t("home.hero.scroll", { defaultValue: "Keşfetmek için kaydırın" })}
                </span>
              </m.div>
            </m.div>
          )}
        </AnimatePresence>

        {/* ─── FAZ 2 & 3: SEARCH + PROJECT INFO (Reveal sonrası) ─── */}
        <div className="relative z-10 w-full max-w-[1800px] mx-auto px-6 md:px-12 flex flex-col justify-end h-full pb-12 md:pb-20">

          {/* FLOATING SEARCH PILL (Faz 2) */}
          <AnimatePresence>
            {heroRevealed && (
              <m.div
                initial={{ opacity: 0, y: 60 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.9, ease: [0.22, 1, 0.36, 1] }}
                className="w-full max-w-6xl mx-auto mb-10 relative z-[100]"
              >
                {/* Search Tabs */}
                <div className="flex justify-center items-center gap-2 sm:gap-4 mb-5 flex-wrap">
                  {["STAY", "BUY", "RENT", "INVEST"].map((mode) => (
                    <button
                      key={mode}
                      onClick={() => setSearchMode(mode as "STAY" | "BUY" | "RENT" | "INVEST")}
                      className={`relative px-5 py-2.5 rounded-full font-extrabold text-xs sm:text-sm tracking-widest uppercase transition-all flex items-center gap-2 shadow-sm
                        ${searchMode === mode 
                          ? "bg-white/20 dark:bg-white/15 text-white border border-white/40 shadow-[0_0_20px_rgba(255,255,255,0.25)] backdrop-blur-md scale-105" 
                          : "bg-black/30 dark:bg-black/50 text-white/70 hover:text-white hover:bg-black/50 border border-white/10"}`}
                    >
                      {mode === "STAY" && <span className="text-emerald-400 text-base">🛡️</span>}
                      {mode === "BUY" && <span className="text-amber-400 text-base">🏛️</span>}
                      {mode === "INVEST" && <span className="text-indigo-400 text-base">📈</span>}
                      {mode === "RENT" && <span className="text-purple-400 text-base">🔑</span>}
                      <span>{t(`home.search.modes.${mode.toLowerCase()}`, { defaultValue: mode })}</span>
                    </button>
                  ))}
                </div>

                {/* Search Input Bar — Sleek Glassmorphism Engine */}
                <form onSubmit={handleSearch} className="bg-white/95 dark:bg-[#0c0d12]/95 backdrop-blur-3xl p-2.5 md:p-3 rounded-[2.5rem] grid grid-cols-1 md:flex md:items-center gap-2 md:gap-1 shadow-[0_30px_100px_-15px_rgba(0,0,0,0.85),inset_0_1px_1px_rgba(255,255,255,0.4)] border border-white/50 dark:border-white/15 relative">
                  
                  {/* 1. Country Selector */}
                  <div className="relative px-4 py-2 hover:bg-black/5 dark:hover:bg-white/5 rounded-2xl md:rounded-full transition-colors shrink-0">
                    <label id="country-select-label" className="text-[10px] font-black uppercase tracking-wider text-muted-foreground block mb-0.5">ÜLKE</label>
                    <button
                      type="button"
                      onClick={() => setShowCountryDropdown(!showCountryDropdown)}
                      aria-labelledby="country-select-label"
                      aria-expanded={showCountryDropdown}
                      className="flex items-center gap-2 text-sm font-extrabold text-neutral-900 dark:text-white min-w-[75px]"
                    >
                      <span>{countries.find(c => c.iso2 === selectedCountry)?.name || 'Turkey'}</span>
                      <ChevronDown className="w-3.5 h-3.5 opacity-70" />
                    </button>
                    {showCountryDropdown && (
                      <div className="absolute top-full left-0 mt-3 bg-card dark:bg-[#14151a] rounded-2xl shadow-2xl border border-border dark:border-white/10 z-[110] w-64 max-h-80 overflow-hidden flex flex-col">
                        <div className="p-3 border-b border-border dark:border-white/10">
                          <div className="relative">
                            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                            <input
                              type="text"
                              aria-label={t('home.search.country_search', { defaultValue: 'Ülke ara...' }) as string}
                              placeholder={t('home.search.country_search', { defaultValue: 'Ülke ara...' }) as string}
                              value={countrySearch}
                              onChange={(e) => setCountrySearch(e.target.value)}
                              className="w-full bg-muted dark:bg-white/5 border-none rounded-xl py-2 pl-9 pr-4 text-sm font-medium focus:ring-2 focus:ring-primary outline-none text-foreground"
                              onClick={(e) => e.stopPropagation()}
                            />
                          </div>
                        </div>
                        <div className="overflow-y-auto flex-1 py-1">
                          {countries
                            .filter(c => c.name.toLowerCase().includes(countrySearch.toLowerCase()))
                            .map((country) => (
                              <button
                                key={country.iso2}
                                type="button"
                                onClick={() => {
                                  setSelectedCountry(country.iso2);
                                  setShowCountryDropdown(false);
                                  setCountrySearch("");
                                }}
                                className="w-full px-4 py-2.5 text-left hover:bg-muted dark:hover:bg-white/5 transition-colors text-sm font-medium text-muted-foreground dark:text-white flex items-center justify-between"
                              >
                                <span>{country.name}</span>
                                {selectedCountry === country.iso2 && <CheckCircle2 className="w-4 h-4 text-emerald-500" />}
                              </button>
                            ))}
                        </div>
                      </div>
                    )}
                  </div>

                  <div className="hidden md:block w-[1px] h-8 bg-black/10 dark:bg-white/10 shrink-0" />

                  {/* 2. Location Input */}
                  <div className="flex-1 min-w-[160px] px-4 py-2 hover:bg-black/5 dark:hover:bg-white/5 rounded-2xl md:rounded-full transition-colors relative">
                    <label htmlFor="search-location" className="text-[10px] font-black uppercase tracking-wider text-muted-foreground block mb-0.5">LOKASYON</label>
                    <input 
                      ref={locationInputRef} 
                      type="text" 
                      id="search-location"
                      value={searchLocation} 
                      onChange={(e) => {
                        setSearchLocation(e.target.value);
                        setShowLocationSuggestions(e.target.value.length > 0);
                        handleAiSuggestions(e.target.value);
                      }}
                      onFocus={() => { setShowLocationSuggestions(searchLocation.length > 0); loadGoogleMapsAutocomplete(); }}
                      onBlur={() => setTimeout(() => setShowLocationSuggestions(false), 200)}
                      placeholder="Şehir, ilçe veya mülk adı..."
                      className="bg-transparent border-none focus:outline-none focus:ring-0 text-sm md:text-base font-extrabold text-neutral-900 dark:text-white w-full p-0 placeholder:font-semibold placeholder:text-muted-foreground truncate" 
                    />
                    
                    {/* AI Suggestions & Loading Indicator */}
                    {isAiLoading && (
                      <div className="absolute top-full left-0 right-0 mt-3 p-3 bg-card dark:bg-[#14151a] rounded-2xl shadow-2xl border border-brand/40 z-[110] flex items-center gap-2 text-xs font-bold text-brand">
                        <Sparkles className="w-4 h-4 animate-spin text-brand" />
                        <span>Akıllı AI Asistanı Konum & Mülk Önerilerini Hazırlıyor...</span>
                      </div>
                    )}
                    {showAiSuggestions && !isAiLoading && aiSuggestions.length > 0 && (
                      <div className="absolute top-full left-0 right-0 mt-3 bg-card dark:bg-[#14151a] rounded-2xl shadow-2xl border border-brand/40 z-[110] max-h-60 overflow-y-auto">
                        <div className="px-4 py-2.5 bg-brand/10 border-b border-brand/20 flex items-center gap-2">
                          <Sparkles className="w-4 h-4 text-brand" />
                          <span className="text-xs font-bold text-brand uppercase tracking-wider">AI Akıllı Öneriler</span>
                        </div>
                        {aiSuggestions.map((suggestion, index) => (
                          <button
                            key={index}
                            type="button"
                            onClick={() => {
                              setSearchLocation(suggestion.text);
                              setShowAiSuggestions(false);
                            }}
                            className="w-full px-5 py-3 text-left hover:bg-brand/10 transition-colors flex items-center justify-between text-sm"
                          >
                            <span className="font-semibold text-foreground">{suggestion.text}</span>
                            <span className="text-[10px] px-2 py-0.5 bg-brand/20 text-brand rounded-full font-bold uppercase">{suggestion.type}</span>
                          </button>
                        ))}
                      </div>
                    )}
                    
                    {/* Location Suggestions */}
                    {showLocationSuggestions && locationSuggestions.length > 0 && !showAiSuggestions && (
                      <div className="absolute top-full left-0 right-0 mt-3 bg-card dark:bg-[#14151a] rounded-2xl shadow-2xl border border-border dark:border-white/10 z-[110] max-h-60 overflow-y-auto">
                        {locationSuggestions
                          .filter(city => city.name.toLowerCase().includes(searchLocation.toLowerCase()))
                          .slice(0, 8)
                          .map((city, index) => (
                            <button
                              key={index}
                              type="button"
                              onClick={() => {
                                setSearchLocation(city.name);
                                setShowLocationSuggestions(false);
                              }}
                              className="w-full px-5 py-3 text-left hover:bg-muted dark:hover:bg-white/5 transition-colors flex items-center gap-3 text-sm font-semibold text-foreground"
                            >
                              <MapPin className="w-4 h-4 text-primary" />
                              <span>{city.name}</span>
                            </button>
                          ))}
                      </div>
                    )}
                  </div>
                  
                  <div className="hidden md:block w-[1px] h-8 bg-black/10 dark:bg-white/10 shrink-0" />

                  {/* 3. Universal Property Type */}
                  <div className="flex-1 min-w-[150px] px-4 py-2 hover:bg-black/5 dark:hover:bg-white/5 rounded-2xl md:rounded-full transition-colors relative">
                    <label htmlFor="search-rooms" className="text-[10px] font-black uppercase tracking-wider text-indigo-600 dark:text-indigo-400 block mb-0.5">ODA SAYISI & TİP</label>
                    <select id="search-rooms" value={searchRooms} onChange={(e) => setSearchRooms(e.target.value)}
                      className="bg-transparent border-none focus:outline-none focus:ring-0 text-xs md:text-sm font-extrabold text-neutral-900 dark:text-white w-full p-0 cursor-pointer appearance-none truncate pr-6">
                      <option value="all" className="bg-white dark:bg-[#14151a]">Tüm Oda Sayıları</option>
                      <option value="1+0" className="bg-white dark:bg-[#14151a]">1+0</option>
                      <option value="1+1" className="bg-white dark:bg-[#14151a]">1+1</option>
                      <option value="2+1" className="bg-white dark:bg-[#14151a]">2+1</option>
                      <option value="3+1" className="bg-white dark:bg-[#14151a]">3+1</option>
                      <option value="4+1" className="bg-white dark:bg-[#14151a]">4+1</option>
                      <option value="5+1" className="bg-white dark:bg-[#14151a]">5+1 ve üzeri</option>
                      <option value="villa" className="bg-white dark:bg-[#14151a]">Villa / Müstakil</option>
                      <option value="penthouse" className="bg-white dark:bg-[#14151a]">Penthouse</option>
                      <option value="land" className="bg-white dark:bg-[#14151a]">Arsa / Arazi</option>
                    </select>
                    <ChevronDown className="absolute right-3 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-muted-foreground pointer-events-none" />
                  </div>
                  
                  <div className="hidden md:block w-[1px] h-8 bg-black/10 dark:bg-white/10 shrink-0" />

                  {/* 4 & 5. STAY & RENT MODE FIELDS */}
                  {(searchMode === "STAY" || searchMode === "RENT") && (
                    <>
                      <div className="flex-1 min-w-[140px] px-4 py-2 hover:bg-black/5 dark:hover:bg-white/5 rounded-2xl md:rounded-full transition-colors">
                        <label htmlFor="search-date" className="text-[10px] font-black uppercase tracking-wider text-emerald-600 dark:text-emerald-400 block mb-0.5">TARİH & GÜVENCE</label>
                        <input type="date" id="search-date" value={searchDate} onChange={(e) => setSearchDate(e.target.value)}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-xs md:text-sm font-extrabold text-neutral-900 dark:text-white w-full p-0" />
                      </div>
                      <div className="hidden md:block w-[1px] h-8 bg-black/10 dark:bg-white/10 shrink-0" />
                      <div className="flex-1 min-w-[130px] px-4 py-2 hover:bg-black/5 dark:hover:bg-white/5 rounded-2xl md:rounded-full transition-colors relative">
                        <label htmlFor="search-guests" className="text-[10px] font-black uppercase tracking-wider text-muted-foreground block mb-0.5">KONUK SAYISI</label>
                        <select id="search-guests" value={searchGuests} onChange={(e) => setSearchGuests(Number(e.target.value))}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-xs md:text-sm font-extrabold text-neutral-900 dark:text-white w-full p-0 cursor-pointer appearance-none pr-5 truncate">
                          <option value={1} className="bg-white dark:bg-[#14151a]">1 Konuk</option>
                          <option value={2} className="bg-white dark:bg-[#14151a]">2 Konuk (Aile)</option>
                          <option value={3} className="bg-white dark:bg-[#14151a]">3 Konuk</option>
                          <option value={4} className="bg-white dark:bg-[#14151a]">4+ Konuk (VİP Villa)</option>
                        </select>
                        <ChevronDown className="absolute right-3 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-muted-foreground pointer-events-none" />
                      </div>
                    </>
                  )}

                  {/* BUY MODE FIELDS */}
                  {searchMode === "BUY" && (
                    <>
                      <div className="flex-1 min-w-[150px] px-4 py-2 hover:bg-black/5 dark:hover:bg-white/5 rounded-2xl md:rounded-full transition-colors relative">
                        <label htmlFor="buy-budget" className="text-[10px] font-black uppercase tracking-wider text-amber-600 dark:text-amber-400 block mb-0.5">BÜTÇE ARALIĞI</label>
                        <select id="buy-budget" value={buyBudget} onChange={(e) => setBuyBudget(e.target.value)}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-xs md:text-sm font-extrabold text-neutral-900 dark:text-white w-full p-0 cursor-pointer appearance-none truncate pr-6">
                          <option value="all" className="bg-white dark:bg-[#14151a]">Tüm Bütçeler</option>
                          <option value="250k-500k" className="bg-white dark:bg-[#14151a]">$250k - $500k (Mortgage Uygun)</option>
                          <option value="500k-1m" className="bg-white dark:bg-[#14151a]">$500k - $1M+ (Vatandaşlık Uygun)</option>
                        </select>
                        <ChevronDown className="absolute right-3 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-muted-foreground pointer-events-none" />
                      </div>
                      <div className="hidden md:block w-[1px] h-8 bg-black/10 dark:bg-white/10 shrink-0" />
                      <div className="flex-1 min-w-[150px] px-4 py-2 hover:bg-black/5 dark:hover:bg-white/5 rounded-2xl md:rounded-full transition-colors relative">
                        <label htmlFor="buy-compliance" className="text-[10px] font-black uppercase tracking-wider text-indigo-600 dark:text-indigo-400 block mb-0.5">YASAL UYGUNLUK</label>
                        <select id="buy-compliance" value={buyCompliance} onChange={(e) => setBuyCompliance(e.target.value)}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-xs md:text-sm font-extrabold text-neutral-900 dark:text-white w-full p-0 cursor-pointer appearance-none truncate pr-6">
                          <option value="citizenship" className="bg-white dark:bg-[#14151a]">🇹🇷 $400k+ Türk Vatandaşlığı</option>
                          <option value="golden-visa" className="bg-white dark:bg-[#14151a]">🇦🇪 10 Yılık Dubai Golden Visa</option>
                          <option value="mortgage" className="bg-white dark:bg-[#14151a]">🏛️ Banka Kredisine Uygun (SPK)</option>
                        </select>
                        <ChevronDown className="absolute right-3 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-muted-foreground pointer-events-none" />
                      </div>
                    </>
                  )}

                  {/* INVEST MODE FIELDS */}
                  {searchMode === "INVEST" && (
                    <>
                      <div className="flex-1 min-w-[150px] px-4 py-2 hover:bg-black/5 dark:hover:bg-white/5 rounded-2xl md:rounded-full transition-colors relative">
                        <label htmlFor="invest-roi" className="text-[10px] font-black uppercase tracking-wider text-emerald-600 dark:text-emerald-400 block mb-0.5">HEDEF GETİRİ (ROI)</label>
                        <select id="invest-roi" value={investRoi} onChange={(e) => setInvestRoi(e.target.value)}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-xs md:text-sm font-extrabold text-neutral-900 dark:text-white w-full p-0 cursor-pointer appearance-none truncate pr-6">
                          <option value="8-10" className="bg-white dark:bg-[#14151a]">%8 - %10 Döviz Endeksli Kira</option>
                          <option value="12-plus" className="bg-white dark:bg-[#14151a]">%12+ Sermaye Değerleme (Off-plan)</option>
                        </select>
                        <ChevronDown className="absolute right-3 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-muted-foreground pointer-events-none" />
                      </div>
                      <div className="hidden md:block w-[1px] h-8 bg-black/10 dark:bg-white/10 shrink-0" />
                      <div className="flex-1 min-w-[140px] px-4 py-2 hover:bg-black/5 dark:hover:bg-white/5 rounded-2xl md:rounded-full transition-colors relative">
                        <label htmlFor="invest-model" className="text-[10px] font-black uppercase tracking-wider text-purple-600 dark:text-purple-400 block mb-0.5">YÖNETİM MODELİ</label>
                        <select id="invest-model" value={investModel} onChange={(e) => setInvestModel(e.target.value)}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-xs md:text-sm font-extrabold text-neutral-900 dark:text-white w-full p-0 cursor-pointer appearance-none truncate pr-6">
                          <option value="partner-os" className="bg-white dark:bg-[#14151a]">Partner OS Anahtar Teslim</option>
                          <option value="safestay" className="bg-white dark:bg-[#14151a]">SafeStay™ Escrow Havuzu</option>
                        </select>
                        <ChevronDown className="absolute right-3 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-muted-foreground pointer-events-none" />
                      </div>
                    </>
                  )}

                  {/* Primary Submit Button */}
                  <Button 
                    type="submit" 
                    aria-label="Ara" 
                    className="w-full md:w-auto px-7 h-14 md:h-12 rounded-[2rem] bg-gradient-to-r from-slate-900 via-black to-slate-900 dark:from-white dark:to-neutral-200 dark:text-black text-white hover:opacity-90 font-black text-sm tracking-wider shadow-lg flex items-center justify-center gap-2 transition-all active:scale-95 shrink-0 ml-auto"
                  >
                    <Search className="w-5 h-5 stroke-[2.5]" />
                    <span>ARA</span>
                  </Button>
                </form>

                {/* TWO-TIER ACTION BAR: Advanced Filters & AI Assistant */}
                <div className="mt-3.5 flex flex-wrap items-center justify-center gap-3 px-2">
                  <button
                    type="button"
                    onClick={() => setAdvancedFilterOpen(true)}
                    className="group px-5 py-2 rounded-full bg-black/60 hover:bg-black/80 dark:bg-[#14151a]/90 dark:hover:bg-[#1f2129] backdrop-blur-md border border-white/25 hover:border-purple-400 text-white font-extrabold text-xs tracking-wide uppercase flex items-center gap-2.5 shadow-xl transition-all duration-300 hover:scale-[1.02]"
                  >
                    <div className="w-5 h-5 rounded-full bg-gradient-to-tr from-purple-600 to-pink-500 flex items-center justify-center text-white shadow-sm group-hover:rotate-180 transition-transform duration-500">
                      <SlidersHorizontal className="w-3 h-3" />
                    </div>
                    <span>Ülkeye ve Moda Özel Gelişmiş Filtreler</span>
                    <span className="text-[10px] font-extrabold text-purple-300 bg-purple-500/20 px-2 py-0.5 rounded-full border border-purple-500/30">Tapu, Kredi, ROI</span>
                  </button>

                  <button
                    type="button"
                    onClick={() => setAiModalOpen(true)}
                    className="group px-5 py-2 rounded-full bg-black/60 hover:bg-black/80 dark:bg-[#14151a]/90 dark:hover:bg-[#1f2129] backdrop-blur-md border border-white/25 hover:border-cyan-400 text-white font-extrabold text-xs tracking-wide uppercase flex items-center gap-2.5 shadow-xl transition-all duration-300 hover:scale-[1.02]"
                  >
                    <div className="w-5 h-5 rounded-full bg-gradient-to-tr from-blue-500 via-indigo-500 to-cyan-400 flex items-center justify-center text-white shadow-[0_0_12px_rgba(6,182,212,0.8)] animate-pulse group-hover:scale-110 transition-transform">
                      <Sparkles className="w-3 h-3" />
                    </div>
                    <span>Yapay Zeka (AI) Asistanı ile Keşfet</span>
                    <span className="text-[10px] font-extrabold text-cyan-300 bg-cyan-500/20 px-2 py-0.5 rounded-full border border-cyan-500/30">Nöral Eşleştirme</span>
                  </button>
                </div>
              </m.div>
            )}
          </AnimatePresence>

          {/* PROJECT INFO + SLIDE CONTROLS (Faz 3) */}
          <AnimatePresence>
            {heroRevealed && (
              <m.div
                initial={{ opacity: 0, y: 30 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.8, delay: 0.4, ease: [0.22, 1, 0.36, 1] }}
                className="w-full relative z-10"
              >
                <div className="flex items-end justify-between gap-6">
                  {/* Left: Project Info */}
                  <div className="flex-1 min-w-0">
                    {/* Tag */}
                    <m.span
                      key={`tag-${currentSlide}`}
                      initial={{ opacity: 0, x: -20 }}
                      animate={{ opacity: 1, x: 0 }}
                      className="inline-block px-4 py-1.5 bg-gradient-to-r from-blue-500/20 to-brand/20 backdrop-blur-md border border-white/30 text-white text-[10px] font-black uppercase tracking-[0.2em] rounded-full mb-4 shadow-[0_0_15px_rgba(59,130,246,0.5)]"
                    >
                      {slide.tag}
                    </m.span>

                    {/* Project Name */}
                    <AnimatePresence mode="wait">
                      <m.h2
                        key={`title-${currentSlide}`}
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        exit={{ opacity: 0, y: -20 }}
                        transition={{ duration: 0.5 }}
                        className="text-4xl md:text-6xl font-black text-transparent bg-clip-text bg-gradient-to-r from-white to-slate-300 tracking-tight leading-none mb-2 drop-shadow-lg"
                      >
                        {slide.title}
                      </m.h2>
                    </AnimatePresence>

                    {/* Location */}
                    <m.div
                      key={`loc-${currentSlide}`}
                      initial={{ opacity: 0 }}
                      animate={{ opacity: 1 }}
                      transition={{ delay: 0.2 }}
                      className="flex items-center gap-2 text-white/70 font-medium text-sm mb-4"
                    >
                      <MapPin className="w-4 h-4" />
                      <span>{slide.location}</span>
                    </m.div>

                    {/* Specs */}
                    <div className="flex items-center gap-3 flex-wrap">
                      {[slide.beds, slide.baths, formatAreaByCountry(slide.areaVal || slide.sqm, selectedCountry)].map((spec, i) => (
                        <span key={i} className="px-3 py-1.5 bg-white/10 backdrop-blur-sm border border-white/10 text-white text-xs font-bold rounded-full">
                          {spec}
                        </span>
                      ))}
                    </div>
                  </div>

                  {/* Right: Price + Navigation */}
                  <div className="hidden md:flex flex-col items-end gap-4">
                    {/* Price */}
                    <span className="text-2xl font-black text-white bg-gradient-to-br from-white/20 to-white/5 backdrop-blur-xl px-6 py-3 rounded-3xl border border-white/30 shadow-[0_8px_30px_rgb(0,0,0,0.3)]">
                      {slide.price}
                    </span>

                    {/* Navigation Arrows */}
                    <div className="flex items-center gap-3">
                      <button
                        onClick={() => setCurrentSlide(c => (c - 1 + slides.length) % slides.length)}
                        aria-label={t('home.carousel.prev', { defaultValue: 'Previous slide' })}
                        className="w-12 h-12 min-w-[48px] min-h-[48px] rounded-full bg-white/10 backdrop-blur-md border border-white/20 flex items-center justify-center hover:bg-white/20 transition-all"
                      >
                        <ChevronLeft className="w-5 h-5 text-white" />
                      </button>
                      <button
                        onClick={() => setCurrentSlide(c => (c + 1) % slides.length)}
                        aria-label={t('home.carousel.next', { defaultValue: 'Next slide' })}
                        className="w-12 h-12 min-w-[48px] min-h-[48px] rounded-full bg-white/10 backdrop-blur-md border border-white/20 flex items-center justify-center hover:bg-white/20 transition-all"
                      >
                        <ChevronRight className="w-5 h-5 text-white" />
                      </button>
                    </div>
                  </div>
                </div>

                {/* Slide Indicators (Dots) */}
                <div className="flex items-center justify-center gap-2 mt-8">
                  {slides.map((_: unknown, i: number) => (
                    <button
                      key={i}
                      onClick={() => setCurrentSlide(i)}
                      aria-label={t('home.carousel.go_to_slide', { defaultValue: `Go to slide ${i + 1}` })}
                      className={`h-1.5 min-h-[48px] min-w-[48px] flex items-center justify-center transition-all duration-500 rounded-full ${
                        i === currentSlide ? "w-8 bg-card" : "w-3 bg-white/30 hover:bg-white/50"
                      }`}
                    />
                  ))}
                </div>
              </m.div>
            )}
          </AnimatePresence>
        </div>
      </section>

      {/* ══════ VIBES / CATEGORIES (HORIZONTAL SCROLL & INTERACTIVE BAR) ══════ */}
      <section className="py-10 border-b border-border bg-background">
        <div className="max-w-[1800px] mx-auto px-6 md:px-12">
          <div className="flex gap-6 sm:gap-10 overflow-x-auto no-scrollbar snap-x pb-4 pt-2">
            {vibes.map((vibe, i) => {
              const isActive = selectedVibe === vibe.englishName;
              return (
                <m.div key={i} initial={{ opacity: 0, y: 20 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: i * 0.05 }}
                  onClick={() => {
                    if (isActive) {
                      router.push(`/property?vibe=${vibe.englishName.toLowerCase()}`);
                    } else {
                      setSelectedVibe(vibe.englishName);
                    }
                  }}
                  className={`flex flex-col items-center gap-2 min-w-[85px] sm:min-w-[100px] cursor-pointer group snap-start pb-3 border-b-2 transition-all ${
                    isActive ? "border-foreground text-foreground scale-105" : "border-transparent text-muted-foreground hover:border-muted hover:text-foreground"
                  }`}>
                  <div className={`text-3xl sm:text-4xl transition-all duration-300 group-hover:-translate-y-1 ${isActive ? "grayscale-0 scale-110 drop-shadow-md" : "grayscale opacity-60 group-hover:grayscale-0 group-hover:opacity-100"}`}>
                    {vibe.icon}
                  </div>
                  <div className="text-center">
                    <span className={`text-xs font-bold tracking-wide transition-colors uppercase block ${isActive ? "text-indigo-600 dark:text-indigo-400 font-black" : ""}`}>
                      {t(vibe.name)}
                    </span>
                    <span className="text-[10px] opacity-60 font-semibold">{vibe.count}</span>
                  </div>
                </m.div>
              );
            })}
          </div>

          {/* Selected Vibe Action Ribbon */}
          {vibes.map((vibe) => vibe.englishName === selectedVibe && (
            <m.div 
              key={vibe.englishName}
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3 }}
              className="mt-6 p-4 md:p-5 rounded-3xl bg-muted/40 dark:bg-white/5 border border-border flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 shadow-sm"
            >
              <div className="flex items-center gap-3 md:gap-4">
                <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-indigo-500/20 to-purple-500/20 border border-indigo-500/30 flex items-center justify-center text-2xl shrink-0">
                  {vibe.icon}
                </div>
                <div>
                  <div className="flex items-center gap-2 flex-wrap mb-1">
                    <h3 className="font-extrabold text-base text-foreground tracking-tight">{t(vibe.name)} Koleksiyonu</h3>
                    <span className="text-xs px-2 py-0.5 bg-indigo-500/15 text-indigo-600 dark:text-indigo-400 font-bold rounded-full">{t(vibe.badge)}</span>
                    <span className="text-xs font-semibold text-muted-foreground">• {vibe.count} Aktif İlan</span>
                  </div>
                  <p className="text-xs sm:text-sm font-medium text-muted-foreground">{t(vibe.desc)}</p>
                </div>
              </div>
              <Button 
                onClick={() => router.push(`/property?vibe=${vibe.englishName.toLowerCase()}`)}
                className="w-full sm:w-auto rounded-full bg-indigo-600 hover:bg-indigo-700 text-white font-bold px-6 py-5 shadow-lg shadow-indigo-500/25 shrink-0 transition-all hover:scale-105"
              >
                <span>Tüm {t(vibe.name)} İlanlarını Gör</span>
                <ArrowRight className="w-4 h-4 ml-2" />
              </Button>
            </m.div>
          ))}
        </div>
      </section>

      {/* ══════ BENTO GRID (FEATURED) ══════ */}
      <section className="py-24 bg-background">
        <div className="max-w-[1800px] mx-auto px-6 md:px-12">
          <m.div initial={{ opacity: 0, y: 20 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} className="flex justify-between items-end mb-16">
            <div>
              <h2 className="text-4xl md:text-5xl font-black tracking-tight mb-4">{t("home.curated.title", { defaultValue: "Seçilmiş Mülk Koleksiyonu" })}</h2>
              <p className="text-lg text-muted-foreground max-w-xl font-medium">{t("home.curated.subtitle", { defaultValue: "Akıllı konfor, yüksek yatırım değeri ve üst düzey yaşam standartları sunan özel gayrimenkul seçkisi." })}</p>
            </div>
            <Button variant="outline" className="hidden md:flex rounded-full font-bold h-12 px-6" asChild>
              <Link href="/client/property">
                {t("home.curated.view_all", { defaultValue: "Tüm Koleksiyonu İncele" })}
                <ArrowRight className="w-4 h-4 ml-2" />
              </Link>
            </Button>
          </m.div>

          <div className="grid grid-cols-1 md:grid-cols-4 gap-4 md:h-[600px]">
            {/* Bento Block 1 (Large) */}
            <BentoCard prop={slides[0]} countryCode={selectedCountry} className="md:col-span-2 md:row-span-2" large />
            {/* Bento Block 2 (Top Right) */}
            <BentoCard prop={slides[1]} countryCode={selectedCountry} className="md:col-span-2 md:row-span-1" />
            {/* Bento Block 3 & 4 (Bottom Right) */}
            <BentoCard prop={slides[2]} countryCode={selectedCountry} className="md:col-span-1 md:row-span-1" />
            <BentoCard prop={slides[3]} countryCode={selectedCountry} className="md:col-span-1 md:row-span-1" />
          </div>
        </div>
      </section>

      {/* ══════ ECOSYSTEM (HOSPITALITY OS) ══════ */}
      <section className="py-32 bg-background text-foreground overflow-hidden relative">
        <div className="absolute top-0 right-0 w-[800px] h-[800px] bg-brand/10 rounded-full blur-[120px] pointer-events-none" />
        <div className="max-w-[1800px] mx-auto px-6 md:px-12 relative z-10">
          <div className="grid lg:grid-cols-2 gap-16 items-center">
            <m.div initial={{ opacity: 0, x: -40 }} whileInView={{ opacity: 1, x: 0 }} viewport={{ once: true }}>
              <span className="text-brand font-black tracking-widest uppercase text-sm mb-4 block">
                {t("home.ecosystem.badge", { defaultValue: "Emlak Teknolojisi & OS" })}
              </span>
              <h2 className="text-4xl md:text-6xl font-black tracking-tighter leading-tight mb-6">
                {t("home.ecosystem.title", { defaultValue: "Danışmanlar ve Mülk Yöneticileri İçin İşletim Sistemi." })}
              </h2>
              <p className="text-xl text-muted-foreground mb-10 font-medium max-w-lg leading-relaxed">
                {t("home.ecosystem.desc", { defaultValue: "FinTech ve yapay zeka entegre gayrimenkul ekosistemi. Komisyonsuz Açık Bankacılık transferlerinden pasif gelir ortaklık ağlarına kadar, emlak işinizi ve portföyünüzü tek bir kontrol merkezinden yönetin." })}
              </p>
              
              <div className="space-y-6">
                {[
                  { icon: Monitor, title: "Danışman İşletim Sistemi (OS)", desc: "Komisyon paylaşım planlarını, sözleşme süreçlerini ve ofis içi operasyonları tam otomatikleştirin." },
                  { icon: Gem, title: "%0 Kesintili Finans Altyapısı", desc: "Açık bankacılık (A2A) transferleri ve 21 günlük Escrow depozito güvence mekanizması ile doğrudan tahsilat yapın." },
                  { icon: ShieldCheck, title: "Akıllı Yapay Zeka Stüdyosu", desc: "Anlam odaklı nöral arama motoru ile doğru alıcıyı bulun ve portföyünüze özel ilan pazarlama materyalleri hazırlayın." },
                ].map((feature, i) => (
                  <div key={i} className="flex gap-4">
                    <div className="w-12 h-12 rounded-2xl bg-muted/50 flex items-center justify-center shrink-0 border border-border">
                      <feature.icon className="w-6 h-6 text-foreground" />
                    </div>
                    <div>
                      <h3 className="text-lg font-bold text-foreground">{feature.title}</h3>
                      <p className="text-muted-foreground text-sm">{feature.desc}</p>
                    </div>
                  </div>
                ))}
              </div>

              <Button className="mt-12 rounded-full h-14 px-8 bg-primary text-primary-foreground hover:bg-primary/90 font-bold text-base transition-all hover:scale-105" asChild>
                <Link href="/admin/dashboard">
                  {t("home.ecosystem.cta", { defaultValue: "Platform Özelliklerini Keşfet" })}
                </Link>
              </Button>
            </m.div>

            <m.div initial={{ opacity: 0, scale: 0.95 }} whileInView={{ opacity: 1, scale: 1 }} viewport={{ once: true }}
              className="relative aspect-square md:aspect-auto md:h-[700px] w-full rounded-[3rem] border border-border bg-gradient-to-br from-muted/30 to-transparent overflow-hidden shadow-2xl flex items-center justify-center p-4 md:p-8">
              <EcosystemPreview />
            </m.div>
          </div>
        </div>
      </section>

      {/* ══════ INVESTMENT INTELLIGENCE ══════ */}
      <section className="py-24">
        <InvestmentWidget />
      </section>

      {/* ══════ GLOBAL HYBRID RENTAL OS PROMOTION ══════ */}
      <section className="py-20 px-6 md:px-12">
        <m.div
          initial={{ opacity: 0, y: 40 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.7 }}
          className="max-w-[1400px] mx-auto relative overflow-hidden rounded-[2rem] bg-gradient-to-br from-emerald-950/80 via-slate-900/90 to-blue-950/80 border border-emerald-500/20 p-10 md:p-16"
        >
          {/* Background decoration */}
          <div className="absolute top-0 right-0 w-96 h-96 bg-emerald-500/10 blur-[120px] rounded-full pointer-events-none" />
          <div className="absolute bottom-0 left-0 w-64 h-64 bg-blue-500/10 blur-[100px] rounded-full pointer-events-none" />

          <div className="relative z-10 grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            {/* Left — Text */}
            <div>
              <div className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-emerald-500/10 border border-emerald-500/20 mb-6">
                <Globe className="w-4 h-4 text-emerald-400" />
                <span className="text-xs font-bold text-emerald-400 tracking-widest uppercase">
                  {t("home.global_os_badge", "Global Operasyon Ağı")}
                </span>
                <span className="px-1.5 py-0.5 rounded-full bg-emerald-500/20 text-emerald-300 text-[9px] font-bold">YENİ</span>
              </div>
              <h2 className="text-3xl md:text-5xl font-black tracking-tighter text-white leading-[1.1] mb-4">
                {t("home.global_os_title_1", "Tek Platform.")}{" "}
                <span className="bg-gradient-to-r from-emerald-400 via-blue-400 to-purple-400 bg-clip-text text-transparent">
                  {t("home.global_os_title_2", "23 Ülkedeki Operasyonlar.")}
                </span>
              </h2>
              <p className="text-sm md:text-base text-slate-400 leading-relaxed mb-8 max-w-lg">
                {t("home.global_os_desc", "Kısa dönem tatil konaklaması, kurumsal konaklama ve rezidans operasyonlarınızı dünya genelinde tek ekrandan yönetin. Yapay zeka destekli ülkeye özel vergi optimizasyonu, yasal uygunluk kontrolü ve akıllı gelir analiz motoru.")}
              </p>
              <Link href="/global-os">
                <Button className="bg-emerald-500 hover:bg-emerald-600 text-white font-bold px-8 py-5 text-sm rounded-2xl gap-2">
                  {t("home.global_os_cta", "Global Platformu İncele")}
                  <ArrowRight className="w-4 h-4" />
                </Button>
              </Link>
            </div>

            {/* Right — Stats Grid */}
            <div className="grid grid-cols-2 gap-3">
              {[
                { value: "0%", label: t("home.global_os_s1", "Komisyon Kesintisi"), color: "border-emerald-500/30 bg-emerald-500/5", icon: "💸" },
                { value: "10", label: t("home.global_os_s2", "Gelir Kademesi"), color: "border-amber-500/30 bg-amber-500/5", icon: "🔗" },
                { value: "15+", label: t("home.global_os_s3", "Akıllı AI Asistanı"), color: "border-purple-500/30 bg-purple-500/5", icon: "🧠" },
                { value: "21", label: t("home.global_os_s4", "Günlük Escrow"), color: "border-blue-500/30 bg-blue-500/5", icon: "🏦" },
                { value: "100%", label: t("home.global_os_s5", "Doğrudan Ödeme (A2A)"), color: "border-cyan-500/30 bg-cyan-500/5", icon: "⚡" },
                { value: "24/7", label: t("home.global_os_s6", "Kesintisiz Arama"), color: "border-rose-500/30 bg-rose-500/5", icon: "🔍" },
              ].map((s) => (
                <div key={s.label} className={`rounded-2xl border ${s.color} p-4 flex items-center gap-3`}>
                  <div className="text-2xl">{s.icon}</div>
                  <div>
                    <div className="text-2xl font-black text-white">{s.value}</div>
                    <div className="text-[10px] text-slate-500 font-medium">{s.label}</div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </m.div>
      </section>

      {/* ══════ FOOTER (Minimal Premium) ══════ */}
      <Footer />
      
      <AIChatModal isOpen={aiModalOpen} onClose={() => setAiModalOpen(false)} />
      <SupportChatModal isOpen={supportModalOpen} onClose={() => setSupportModalOpen(false)} />
      <AdvancedFilterModal isOpen={advancedFilterOpen} onClose={() => setAdvancedFilterOpen(false)} searchMode={searchMode} selectedCountry={selectedCountry} />
      
      {/* Floating Support Button */}
      <button
        onClick={() => setSupportModalOpen(true)}
        aria-label={t('home.support.open_chat', { defaultValue: 'Open support chat' })}
        className="fixed bottom-6 right-6 z-50 w-14 h-14 min-w-[48px] min-h-[48px] bg-gradient-to-br from-blue-500 to-cyan-500 rounded-full shadow-2xl flex items-center justify-center hover:scale-110 transition-transform"
      >
        <Sparkles className="w-6 h-6 text-white" />
      </button>
    </div>
  );
}

/* ───── Bento Card Component ───── */
function BentoCard({ prop, countryCode = "TR", className, large = false }: { prop: { id?: string; image: string; title: string; location: string; price: string; tag?: string; beds?: string; baths?: string; sqm?: string; sqft?: string; areaVal?: number }; countryCode?: string; className?: string; large?: boolean }) {
  if (!prop) return null;
  return (
    <Link href={`/properties/${prop.id || "#"}`} className={`group relative rounded-3xl overflow-hidden block always-dark h-[350px] md:h-full w-full ${className}`}>
      <Image src={prop.image} alt={prop.title} fill sizes="(max-width: 768px) 100vw, 50vw" className="object-cover transition-transform duration-1000 group-hover:scale-105" />
      <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-black/10 transition-opacity duration-500 group-hover:opacity-80" />
      
      {/* Tag */}
      <div className="absolute top-6 left-6">
        <span className="px-3 py-1 bg-white/20 backdrop-blur-md border border-white/20 text-white text-xs font-black uppercase tracking-widest rounded-full">
          {prop.tag || "FEATURED"}
        </span>
      </div>
      
      {/* Content */}
      <div className="absolute bottom-0 left-0 w-full p-6 md:p-8 flex flex-col justify-end">
        <h3 className={`${large ? "text-3xl md:text-5xl mb-3" : "text-xl md:text-2xl mb-2"} font-black text-white leading-tight`}>{prop.title}</h3>
        <div className="flex items-center gap-2 text-white/80 font-medium mb-4">
          <MapPin className="w-4 h-4" /> {prop.location}
        </div>
        
        <div className="flex items-center justify-between mt-auto">
          <div className="flex items-center gap-3 text-white/90 font-semibold text-xs md:text-sm">
            <span>{prop.beds}</span>
            {prop.baths && (
              <>
                <span className="w-1.5 h-1.5 bg-white/60 rounded-full" />
                <span>{prop.baths}</span>
              </>
            )}
            {(prop.areaVal || prop.sqm || prop.sqft) && (
              <>
                <span className="w-1.5 h-1.5 bg-white/60 rounded-full" />
                <span>{formatAreaByCountry(prop.areaVal || prop.sqm || prop.sqft, countryCode)}</span>
              </>
            )}
          </div>
          <span className={`${large ? "text-2xl" : "text-xl"} font-black text-white bg-white/10 px-4 py-2 rounded-xl backdrop-blur-md`}>{prop.price}</span>
        </div>
      </div>
    </Link>
  );
}

export default HomeContent;
