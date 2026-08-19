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
// Lazy-loaded to avoid bundling 1.7 MB react-country-state-city in the main chunk
const loadCountryCityData = () => import("react-country-state-city");
interface Country { iso2: string; name: string; id?: number; }
interface City { name: string; id?: number; latitude?: string; longitude?: string; countryCode?: string; }
import {
  Sparkles, Search, MapPin, ChevronRight, ChevronLeft,
  ArrowRight, ChevronDown, SlidersHorizontal, Mouse, CheckCircle2
} from "lucide-react";
import { Footer } from "@/components/layout/Footer";
import { m, useScroll, useTransform, AnimatePresence } from "framer-motion";
import { AppHeader } from "@/components/layout/AppHeader";
import dynamic from 'next/dynamic';
import { t } from "i18next";

const AIChatModal = dynamic(() => import('@/components/home/AIChatModal').then(mod => mod.AIChatModal), { ssr: false });
const SupportChatModal = dynamic(() => import('@/components/home/SupportChatModal').then(mod => mod.SupportChatModal), { ssr: false });
const AdvancedFilterModal = dynamic(() => import('@/components/home/AdvancedFilterModal').then(mod => mod.AdvancedFilterModal), { ssr: false });

const EcosystemSection = dynamic(() => import('@/components/home/EcosystemSection'), {
  loading: () => <div className="w-full py-32" />,
});
const InvestmentSection = dynamic(() => import('@/components/home/InvestmentSection'), {
  loading: () => <div className="w-full py-24" />,
});
const GlobalOSSection = dynamic(() => import('@/components/home/GlobalOSSection'), {
  loading: () => <div className="w-full py-20" />,
});

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
  const getFallbackSlides = (t: (key: string) => string) => [
    { id: "prop_hayat_city_mahmutbey", title: "Hayat City Mahmutbey", location: "Bağcılar, Mahmutbey", price: t("home.slides.hayat_price"), beds: "1+1 - 3+1", baths: "2 - 3", sqm: "6,500 m²", areaVal: 6500, image: "/videos/istanbul/Bağcılar/Mahmutbey/Projeler/Hayat City Mahmutbey/A 2+1/hayat-city-2-1a-BX7WI.webp", tag: t("home.slides.hayat_tag"), video: "ozak-bg" },
    { id: "prop_buyukyali_istanbul", title: "Büyükyalı İstanbul", location: "Zeytinburnu, Sahil Yolu", price: t("home.slides.buyukyali_price"), beds: "2+1 - 5.5+1", baths: "2 - 5", sqm: "111,000 m²", areaVal: 111000, image: "/videos/istanbul/Zeytinburnu/Büyükyalı/cover.jpg", tag: t("home.slides.buyukyali_tag"), video: "ozak-buyukyali-bg" },
    { id: "prop_avrupa_konutlari_gunesli", title: "Avrupa Konutları Güneşli", location: "Güneşli, Bağcılar", price: t("home.slides.gunesli_price"), beds: "1+1 - 5+1", baths: "2 - 5", sqm: "6,500 m²", areaVal: 6500, image: "/videos/istanbul/Bağcılar/Projeler/Avrupa Konutları Güneşli/cover-exterior.jpeg", tag: t("home.slides.gunesli_tag"), video: "ozak-dragos-bg" },
    { id: "prop_ozak_gokturk_doa", title: "Özak Göktürk Doa", location: "Göktürk, Belgrad Ormanı", price: t("home.slides.gokturk_price"), beds: "3+1 - 5.5+2", baths: "2 - 5", sqm: "12,000 m²", areaVal: 12000, image: "/videos/istanbul/Eyüp/Göktürk/cover.jpg", tag: t("home.slides.gokturk_tag"), video: "ozak-duyu-bg" },
    { id: "prop_almond_garden_acibadem", title: "The Almond Garden Acıbadem", location: "Ünalan, Üsküdar", price: t("home.slides.almond_price"), beds: "1+1 - 3+2", baths: "2 - 4", sqm: "32,000 m²", areaVal: 32000, image: "/videos/istanbul/Üsküdar/THE ALMOND GARDEN - ACIBADEM/cover-exterior.jpeg", tag: t("home.slides.almond_tag"), video: "ozak-bg" },
    { id: "prop_delta_bahcelievler", title: "Delta Bahçelievler", location: "Bahçelievler Merkez, İstanbul", price: t("home.slides.delta_price"), beds: "1+1 - 5+1", baths: "1 - 3", sqm: "8,500 m²", areaVal: 8500, image: "/videos/istanbul/Bağcılar/Projeler/Avrupa Konutları Güneşli/cover-exterior.jpeg", tag: t("home.slides.delta_tag"), video: "ozak-dragos-bg" },
  ];

  // Real project cover images served from /videos/istanbul (matched by property name)
  const PROJECT_COVERS: Record<string, string> = {
    "Hayat City": "/videos/istanbul/Bağcılar/Mahmutbey/Projeler/Hayat City Mahmutbey/A 2+1/hayat-city-2-1a-BX7WI.webp",
    "Avrupa Konutları Güneşli": "/videos/istanbul/Bağcılar/Projeler/Avrupa Konutları Güneşli/cover-exterior.jpeg",
    "Büyükyalı": "/videos/istanbul/Zeytinburnu/Büyükyalı/cover.jpg",
    "Göktürk": "/videos/istanbul/Eyüp/Göktürk/cover.jpg",
    "Almond": "/videos/istanbul/Üsküdar/THE ALMOND GARDEN - ACIBADEM/cover-exterior.jpeg",
  };

  const PROJECT_VIDEOS: Record<string, string> = {
    "Hayat City": "ozak-bg",
    "Avrupa Konutları Güneşli": "ozak-dragos-bg",
    "Büyükyalı": "ozak-buyukyali-bg",
    "Göktürk": "ozak-duyu-bg",
    "Almond": "ozak-bg",
    "Delta": "ozak-dragos-bg"
  };

  const PROJECT_TITLES: Record<string, string> = {
    "Hayat City": "Hayat City Mahmutbey",
    "Avrupa Konutları Güneşli": "Avrupa Konutları Güneşli",
    "Büyükyalı": "Büyükyalı İstanbul",
    "Göktürk": "Özak Göktürk Doa",
    "Almond": "The Almond Garden Acıbadem",
    "Delta": "Delta Bahçelievler"
  };



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
// Role config will be inside the component to use useTranslation hooks.

export function HomeContent({ initialProperties = [] }: { initialProperties?: Record<string, unknown>[] }) {
  const { t } = useTranslation();
  const router = useRouter();
  const { selectedRegion } = useRegionsStore();
  const { currency, locale } = useLocalization();
  const [aiModalOpen, setAiModalOpen] = useState(false);
  const [supportModalOpen, setSupportModalOpen] = useState(false);
  const [heroRevealed, setHeroRevealed] = useState(false);
  const [userRole, setUserRole] = useState<string>("UNKNOWN");
  
  const ROLE_CONFIG: Record<string, any> = {
    UNKNOWN: {
      heroSupporting: t("reos.roles.UNKNOWN.heroSupporting", { defaultValue: "Select your role to explore the Real Estate Operating System." }),
      primaryCTA: t("reos.roles.UNKNOWN.primaryCTA", { defaultValue: "Select Role" }),
      features: []
    },
    OWNER: {
      heroSupporting: t("reos.roles.OWNER.heroSupporting", { defaultValue: "Turn your property into an intelligently managed asset." }),
      primaryCTA: t("reos.roles.OWNER.primaryCTA", { defaultValue: "Evaluate My Property" }),
      features: ["Property Intelligence", "Legal & Policy Checks", "Revenue Options", "Transaction Control"]
    },
    AGENT: {
      heroSupporting: t("reos.roles.AGENT.heroSupporting", { defaultValue: "Turn every lead into a connected transaction." }),
      primaryCTA: t("reos.roles.AGENT.primaryCTA", { defaultValue: "Build My Pipeline" }),
      features: ["Lead Intelligence", "Property Verification", "Deal Workspace", "Commission Automation", "Network Distribution"]
    },
    OPERATOR: {
      heroSupporting: t("reos.roles.OPERATOR.heroSupporting", { defaultValue: "Operate properties through one intelligent workspace." }),
      primaryCTA: t("reos.roles.OPERATOR.primaryCTA", { defaultValue: "Operate My Portfolio" }),
      features: ["Portfolio Operations", "Lease & Stay Management", "Payments & Escrow", "Compliance Workflows", "Automation"]
    },
    INVESTOR: {
      heroSupporting: t("reos.roles.INVESTOR.heroSupporting", { defaultValue: "Discover opportunities. Model the economics. Execute with confidence." }),
      primaryCTA: t("reos.roles.INVESTOR.primaryCTA", { defaultValue: "Explore Investment Opportunities" }),
      features: ["Opportunity Discovery", "Investment Analytics", "Risk Intelligence", "Digital Due Diligence", "Transaction Workflow"]
    },
    TENANT: {
      heroSupporting: t("reos.roles.TENANT.heroSupporting", { defaultValue: "Find a home with a clearer path to move-in." }),
      primaryCTA: t("reos.roles.TENANT.primaryCTA", { defaultValue: "Find a Home" }),
      features: ["Verified property information", "Eligibility-aware discovery", "Digital application", "Identity verification"]
    },
    GUEST: {
      heroSupporting: t("reos.roles.GUEST.heroSupporting", { defaultValue: "Discover stays with connected booking and secure operations." }),
      primaryCTA: t("reos.roles.GUEST.primaryCTA", { defaultValue: "Find a Stay" }),
      features: ["Availability", "Anti-double-booking controls", "Secure payments", "Guest verification"]
    },
    DEVELOPER: {
      heroSupporting: t("reos.roles.DEVELOPER.heroSupporting", { defaultValue: "Bring developments from project to market through one operating layer." }),
      primaryCTA: t("reos.roles.DEVELOPER.primaryCTA", { defaultValue: "List a Development" }),
      features: ["Project Distribution", "Investor Matching", "Digital Project Data", "Partner Network"]
    },
    CORPORATE: {
      heroSupporting: t("reos.roles.CORPORATE.heroSupporting", { defaultValue: "Manage corporate housing and real estate needs through one platform." }),
      primaryCTA: t("reos.roles.CORPORATE.primaryCTA", { defaultValue: "Explore Corporate Solutions" }),
      features: ["Corporate housing discovery", "Employee/tenant workflows", "Master lease workflows", "Portfolio management"]
    }
  };
  
  const roleData = ROLE_CONFIG[userRole];

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
    const timer = setTimeout(() => setHeroRevealed(true), 250);
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
      const { default: GeminiClient } = await import("@/lib/ai/gemini-client");
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
    if (!response?.data || response.data.length === 0) return getFallbackSlides(t);
    return response.data.map((prop: any, i: number) => {
      const fallback = getFallbackSlides(t)[i % getFallbackSlides(t).length];
      
      if (!prop.name) return fallback;

      const rawImg = prop.photos?.[0]?.url || prop.listings?.[0]?.pricingRules?.[0]?.discountRules?.image;
      const coverKey = Object.keys(PROJECT_COVERS).find((k) => String(prop.name || "").includes(k));
      const coverImg = coverKey ? PROJECT_COVERS[coverKey] : null;

      const videoKey = Object.keys(PROJECT_VIDEOS).find((k) => String(prop.name || "").includes(k));
      const finalVideo = videoKey ? PROJECT_VIDEOS[videoKey] : (fallback as any).video;

      const titleKey = Object.keys(PROJECT_TITLES).find((k) => String(prop.name || "").includes(k));
      const finalTitle = titleKey ? PROJECT_TITLES[titleKey] : (prop.name || fallback.title);
      
      const genericPlaceholders = [
        "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&q=80&w=800",
        "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&q=80&w=800",
        "https://images.unsplash.com/photo-1600607687931-cebf5871f58a?auto=format&fit=crop&q=80&w=800",
        "https://images.unsplash.com/photo-1600566753086-00f18efc2291?auto=format&fit=crop&q=80&w=800"
      ];
      
      const finalImage = coverImg || ((rawImg && typeof rawImg === "string" && rawImg.length > 10) ? rawImg : genericPlaceholders[i % genericPlaceholders.length]);
      
      const locationStr = [prop.address, prop.city, prop.stateCode || prop.state, prop.country].filter(Boolean).join(", ");
      
      return { 
        ...fallback, 
        id: String(prop.id || ""), 
        title: finalTitle, 
        location: locationStr || fallback.location, 
        price: prop.price ? formatCurrency(Number(prop.price), currency, locale) : fallback.price, 
        image: finalImage,
        video: finalVideo
      };
    });
  }, [response, currency, locale, t]);

  const [currentSlide, setCurrentSlide] = useState(0);
  useEffect(() => { const iv = setInterval(() => setCurrentSlide(c => (c + 1) % Math.max(slides.length, 4)), 6000); return () => clearInterval(iv); }, [slides.length]);
  const slide = slides[currentSlide] || slides[0];

  const bgVideo = useMemo(() => {
    return slide?.video || "ozak-bg";
  }, [slide]);

  return (
    <div className="min-h-screen bg-background text-foreground overflow-x-hidden selection:bg-black selection:text-white dark:selection:bg-card dark:selection:text-black">
      <AppHeader />

      {/* ══════ CINEMATIC HERO ══════ */}
      <section className="relative h-[100svh] w-full flex flex-col overflow-hidden bg-black always-dark">
        {/* Video Background */}
        <m.div style={{ opacity: heroOpacity }} className="absolute inset-0 z-0">
          <img
            src="/videos/poster.webp"
            alt=""
            fetchPriority="high"
            decoding="async"
            className="absolute inset-0 w-full h-full object-cover"
          />
          <AnimatePresence mode="wait">
            <m.video
              key={bgVideo}
              autoPlay
              loop
              muted
              playsInline
              preload="metadata"
              aria-hidden="true"
              tabIndex={-1}
              poster="/videos/poster.webp"
              onLoadedMetadata={(e) => { e.currentTarget.currentTime = 2; }}
              initial={{ opacity: 0, scale: 1.1 }}
              animate={{ opacity: 1, scale: 1.05 }}
              exit={{ opacity: 0 }}
              transition={{ duration: 0.8, ease: "easeOut" }}
              className="w-full h-full object-cover"
            >
              <source src={`/videos/${bgVideo}.mp4`} type="video/mp4" />
              <source src={`/videos/webm/${bgVideo}.webm`} type="video/webm" />
              <source src={`/videos/webm/${bgVideo}-low.webm`} type="video/webm" />
              <track kind="captions" srcLang="tr" label="Türkçe" default src="/videos/webm/captions.vtt" />
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
                initial={{ opacity: 1, scale: 1 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ duration: 0.5, ease: "easeOut" }}
                className="text-center w-full"
              >
                <h1 className="text-5xl md:text-8xl font-black text-transparent bg-clip-text bg-gradient-to-br from-white via-slate-100 to-slate-400 tracking-tighter drop-shadow-[0_0_20px_rgba(255,255,255,0.4)]">
                  {t("reos.hero.headline", { defaultValue: "Real Estate, Operated." })}
                </h1>
                <p className="text-white/90 text-base md:text-lg font-medium max-w-3xl mx-auto mt-6 leading-relaxed">
                  {t("reos.hero.subheadline", { defaultValue: "REOS connects property discovery, verification, intelligence, transactions, finance and operations into one real estate operating system." })}
                </p>

                {/* Role Selector UI */}
                <div className="mt-8 flex flex-col items-center">
                  <p className="text-white/60 text-sm mb-4 uppercase tracking-widest">{t("reos.hero.roleSelectorText", { defaultValue: "What brings you to Reservatior?" })}</p>
                  <div className="flex flex-wrap justify-center gap-3 max-w-4xl mx-auto">
                    {["OWNER", "AGENT", "OPERATOR", "INVESTOR", "TENANT", "GUEST", "DEVELOPER", "CORPORATE"].map((role) => (
                      <button
                        key={role}
                        onClick={() => setUserRole(role)}
                        className={`px-4 py-2 rounded-full text-sm font-bold tracking-wider transition-all border ${
                          userRole === role 
                            ? "bg-white text-black border-white shadow-[0_0_15px_rgba(255,255,255,0.5)] scale-105" 
                            : "bg-black/40 text-white/70 border-white/20 hover:bg-white/10 hover:text-white"
                        }`}
                      >
                        I&apos;m an {role === "TENANT" || role === "GUEST" ? "Explorer" : role.charAt(0) + role.slice(1).toLowerCase()}
                      </button>
                    ))}
                  </div>
                  
                  {/* Dynamic Role Content */}
                  {userRole !== "UNKNOWN" && (
                    <m.div 
                      initial={{ opacity: 0, y: 10 }}
                      animate={{ opacity: 1, y: 0 }}
                      className="mt-8 bg-black/60 backdrop-blur-md border border-white/10 rounded-2xl p-6 max-w-3xl mx-auto"
                    >
                      <h3 className="text-xl md:text-2xl font-bold text-white mb-2">{roleData.heroSupporting}</h3>
                      <div className="flex flex-wrap justify-center gap-2 mb-6 mt-4">
                        {roleData.features.map((feat: string, idx: number) => (
                          <span key={idx} className="bg-white/10 text-white/80 px-3 py-1 text-xs rounded-full">{feat}</span>
                        ))}
                      </div>
                      <Button className="bg-white text-black hover:bg-slate-200 rounded-full px-8 py-6 text-lg font-bold">
                        {roleData.primaryCTA}
                      </Button>
                    </m.div>
                  )}
                </div>
              </m.div>

              {/* Scroll Down Indicator */}
              <m.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 0.6, duration: 0.8 }}
                className="absolute bottom-12 flex flex-col items-center gap-3 cursor-pointer px-6 py-4"
                role="button"
                tabIndex={0}
                aria-label={t("home.hero.scroll", { defaultValue: "Keşfetmek için kaydırın" })}
                onClick={() => setHeroRevealed(true)}
              >
                <m.div
                  animate={{ y: [0, 8, 0] }}
                  transition={{ duration: 2, repeat: Infinity, ease: "easeInOut" }}
                >
                  <Mouse className="w-6 h-6 text-white/70" />
                </m.div>
                <span className="text-white/70 text-[10px] font-bold tracking-[0.3em] uppercase">
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
                transition={{ duration: 0.5, ease: [0.22, 1, 0.36, 1] }}
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
                    <label id="country-select-label" className="text-[10px] font-black uppercase tracking-wider text-muted-foreground block mb-0.5">{t("home.search.country")}</label>
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
                    <label htmlFor="search-location" className="text-[10px] font-black uppercase tracking-wider text-muted-foreground block mb-0.5">{t("home.search.location")}</label>
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
                      placeholder={t("home.search.location_hint")}
                      className="bg-transparent border-none focus:outline-none focus:ring-0 text-sm md:text-base font-extrabold text-neutral-900 dark:text-white w-full p-0 placeholder:font-semibold placeholder:text-muted-foreground truncate" 
                    />
                    
                    {/* AI Suggestions & Loading Indicator */}
                    {isAiLoading && (
                      <div className="absolute top-full left-0 right-0 mt-3 p-3 bg-card dark:bg-[#14151a] rounded-2xl shadow-2xl border border-brand/40 z-[110] flex items-center gap-2 text-xs font-bold text-brand">
                        <Sparkles className="w-4 h-4 animate-spin text-brand" />
                        <span>{t("home.search.ai_loading")}</span>
                      </div>
                    )}
                    {showAiSuggestions && !isAiLoading && aiSuggestions.length > 0 && (
                      <div className="absolute top-full left-0 right-0 mt-3 bg-card dark:bg-[#14151a] rounded-2xl shadow-2xl border border-brand/40 z-[110] max-h-60 overflow-y-auto">
                        <div className="px-4 py-2.5 bg-brand/10 border-b border-brand/20 flex items-center gap-2">
                          <Sparkles className="w-4 h-4 text-brand" />
                          <span className="text-xs font-bold text-brand uppercase tracking-wider">{t("home.search.ai_suggestions")}</span>
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
                    <label htmlFor="search-rooms" className="text-[10px] font-black uppercase tracking-wider text-indigo-600 dark:text-indigo-400 block mb-0.5">{t("home.search.rooms_type")}</label>
                    <select id="search-rooms" value={searchRooms} onChange={(e) => setSearchRooms(e.target.value)}
                      className="bg-transparent border-none focus:outline-none focus:ring-0 text-xs md:text-sm font-extrabold text-neutral-900 dark:text-white w-full p-0 cursor-pointer appearance-none truncate pr-6">
                      <option value="all" className="bg-white dark:bg-[#14151a]">{t("home.search.rooms_all")}</option>
                      <option value="1+0" className="bg-white dark:bg-[#14151a]">1+0</option>
                      <option value="1+1" className="bg-white dark:bg-[#14151a]">1+1</option>
                      <option value="2+1" className="bg-white dark:bg-[#14151a]">2+1</option>
                      <option value="3+1" className="bg-white dark:bg-[#14151a]">3+1</option>
                      <option value="4+1" className="bg-white dark:bg-[#14151a]">4+1</option>
                      <option value="5+1" className="bg-white dark:bg-[#14151a]">{t("home.search.rooms_5plus")}</option>
                      <option value="villa" className="bg-white dark:bg-[#14151a]">{t("home.search.rooms_villa")}</option>
                      <option value="penthouse" className="bg-white dark:bg-[#14151a]">{t("home.search.rooms_penthouse")}</option>
                      <option value="land" className="bg-white dark:bg-[#14151a]">{t("home.search.rooms_land")}</option>
                    </select>
                    <ChevronDown className="absolute right-3 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-muted-foreground pointer-events-none" />
                  </div>
                  
                  <div className="hidden md:block w-[1px] h-8 bg-black/10 dark:bg-white/10 shrink-0" />

                  {/* 4 & 5. STAY & RENT MODE FIELDS */}
                  {(searchMode === "STAY" || searchMode === "RENT") && (
                    <>
                      <div className="flex-1 min-w-[140px] px-4 py-2 hover:bg-black/5 dark:hover:bg-white/5 rounded-2xl md:rounded-full transition-colors">
                        <label htmlFor="search-date" className="text-[10px] font-black uppercase tracking-wider text-emerald-600 dark:text-emerald-400 block mb-0.5">{t("home.search.date_assurance")}</label>
                        <input type="date" id="search-date" value={searchDate} onChange={(e) => setSearchDate(e.target.value)}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-xs md:text-sm font-extrabold text-neutral-900 dark:text-white w-full p-0" />
                      </div>
                      <div className="hidden md:block w-[1px] h-8 bg-black/10 dark:bg-white/10 shrink-0" />
                      <div className="flex-1 min-w-[130px] px-4 py-2 hover:bg-black/5 dark:hover:bg-white/5 rounded-2xl md:rounded-full transition-colors relative">
                        <label htmlFor="search-guests" className="text-[10px] font-black uppercase tracking-wider text-muted-foreground block mb-0.5">{t("home.search.guests")}</label>
                        <select id="search-guests" value={searchGuests} onChange={(e) => setSearchGuests(Number(e.target.value))}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-xs md:text-sm font-extrabold text-neutral-900 dark:text-white w-full p-0 cursor-pointer appearance-none pr-5 truncate">
                          <option value={1} className="bg-white dark:bg-[#14151a]">{t("home.search.guest_1")}</option>
                          <option value={2} className="bg-white dark:bg-[#14151a]">{t("home.search.guest_2")}</option>
                          <option value={3} className="bg-white dark:bg-[#14151a]">{t("home.search.guest_3")}</option>
                          <option value={4} className="bg-white dark:bg-[#14151a]">{t("home.search.guest_4")}</option>
                        </select>
                        <ChevronDown className="absolute right-3 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-muted-foreground pointer-events-none" />
                      </div>
                    </>
                  )}

                  {/* BUY MODE FIELDS */}
                  {searchMode === "BUY" && (
                    <>
                      <div className="flex-1 min-w-[150px] px-4 py-2 hover:bg-black/5 dark:hover:bg-white/5 rounded-2xl md:rounded-full transition-colors relative">
                        <label htmlFor="buy-budget" className="text-[10px] font-black uppercase tracking-wider text-amber-600 dark:text-amber-400 block mb-0.5">{t("home.search.budget")}</label>
                        <select id="buy-budget" value={buyBudget} onChange={(e) => setBuyBudget(e.target.value)}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-xs md:text-sm font-extrabold text-neutral-900 dark:text-white w-full p-0 cursor-pointer appearance-none truncate pr-6">
                          <option value="all" className="bg-white dark:bg-[#14151a]">{t("home.search.budget_all")}</option>
                          <option value="250k-500k" className="bg-white dark:bg-[#14151a]">{t("home.search.budget_mortgage")}</option>
                          <option value="500k-1m" className="bg-white dark:bg-[#14151a]">{t("home.search.budget_citizenship")}</option>
                        </select>
                        <ChevronDown className="absolute right-3 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-muted-foreground pointer-events-none" />
                      </div>
                      <div className="hidden md:block w-[1px] h-8 bg-black/10 dark:bg-white/10 shrink-0" />
                      <div className="flex-1 min-w-[150px] px-4 py-2 hover:bg-black/5 dark:hover:bg-white/5 rounded-2xl md:rounded-full transition-colors relative">
                        <label htmlFor="buy-compliance" className="text-[10px] font-black uppercase tracking-wider text-indigo-600 dark:text-indigo-400 block mb-0.5">{t("home.search.compliance")}</label>
                        <select id="buy-compliance" value={buyCompliance} onChange={(e) => setBuyCompliance(e.target.value)}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-xs md:text-sm font-extrabold text-neutral-900 dark:text-white w-full p-0 cursor-pointer appearance-none truncate pr-6">
                          <option value="citizenship" className="bg-white dark:bg-[#14151a]">{t("home.search.compliance_turkish")}</option>
                          <option value="golden-visa" className="bg-white dark:bg-[#14151a]">{t("home.search.compliance_dubai")}</option>
                          <option value="mortgage" className="bg-white dark:bg-[#14151a]">{t("home.search.compliance_mortgage")}</option>
                        </select>
                        <ChevronDown className="absolute right-3 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-muted-foreground pointer-events-none" />
                      </div>
                    </>
                  )}

                  {/* INVEST MODE FIELDS */}
                  {searchMode === "INVEST" && (
                    <>
                      <div className="flex-1 min-w-[150px] px-4 py-2 hover:bg-black/5 dark:hover:bg-white/5 rounded-2xl md:rounded-full transition-colors relative">
                        <label htmlFor="invest-roi" className="text-[10px] font-black uppercase tracking-wider text-emerald-600 dark:text-emerald-400 block mb-0.5">{t("home.search.roi_target")}</label>
                        <select id="invest-roi" value={investRoi} onChange={(e) => setInvestRoi(e.target.value)}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-xs md:text-sm font-extrabold text-neutral-900 dark:text-white w-full p-0 cursor-pointer appearance-none truncate pr-6">
                          <option value="8-10" className="bg-white dark:bg-[#14151a]">{t("home.search.roi_yield")}</option>
                          <option value="12-plus" className="bg-white dark:bg-[#14151a]">{t("home.search.roi_capital")}</option>
                        </select>
                        <ChevronDown className="absolute right-3 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-muted-foreground pointer-events-none" />
                      </div>
                      <div className="hidden md:block w-[1px] h-8 bg-black/10 dark:bg-white/10 shrink-0" />
                      <div className="flex-1 min-w-[140px] px-4 py-2 hover:bg-black/5 dark:hover:bg-white/5 rounded-2xl md:rounded-full transition-colors relative">
                        <label htmlFor="invest-model" className="text-[10px] font-black uppercase tracking-wider text-purple-600 dark:text-purple-400 block mb-0.5">{t("home.search.management")}</label>
                        <select id="invest-model" value={investModel} onChange={(e) => setInvestModel(e.target.value)}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-xs md:text-sm font-extrabold text-neutral-900 dark:text-white w-full p-0 cursor-pointer appearance-none truncate pr-6">
                          <option value="partner-os" className="bg-white dark:bg-[#14151a]">{t("home.search.mgmt_partner")}</option>
                          <option value="safestay" className="bg-white dark:bg-[#14151a]">{t("home.search.mgmt_escrow")}</option>
                        </select>
                        <ChevronDown className="absolute right-3 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-muted-foreground pointer-events-none" />
                      </div>
                    </>
                  )}

                  {/* Primary Submit Button */}
                  <Button 
                    type="submit" 
                    aria-label={t("home.search.button")} 
                    className="w-full md:w-auto px-7 h-14 md:h-12 rounded-[2rem] bg-gradient-to-r from-slate-900 via-black to-slate-900 dark:from-white dark:to-neutral-200 dark:text-black text-white hover:opacity-90 font-black text-sm tracking-wider shadow-lg flex items-center justify-center gap-2 transition-all active:scale-95 shrink-0 ml-auto"
                  >
                    <Search className="w-5 h-5 stroke-[2.5]" />
                    <span>{t("home.search.button")}</span>
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
                    <span>{t("home.search.advanced_filters")}</span>
                    <span className="text-[10px] font-extrabold text-purple-300 bg-purple-500/20 px-2 py-0.5 rounded-full border border-purple-500/30">{t("home.search.filters_tags")}</span>
                  </button>

                  <button
                    type="button"
                    onClick={() => setAiModalOpen(true)}
                    className="group px-5 py-2 rounded-full bg-black/60 hover:bg-black/80 dark:bg-[#14151a]/90 dark:hover:bg-[#1f2129] backdrop-blur-md border border-white/25 hover:border-cyan-400 text-white font-extrabold text-xs tracking-wide uppercase flex items-center gap-2.5 shadow-xl transition-all duration-300 hover:scale-[1.02]"
                  >
                    <div className="w-5 h-5 rounded-full bg-gradient-to-tr from-blue-500 via-indigo-500 to-cyan-400 flex items-center justify-center text-white shadow-[0_0_12px_rgba(6,182,212,0.8)] animate-pulse group-hover:scale-110 transition-transform">
                      <Sparkles className="w-3 h-3" />
                    </div>
                    <span>{t("home.search.explore_ai")}</span>
                    <span className="text-[10px] font-extrabold text-cyan-300 bg-cyan-500/20 px-2 py-0.5 rounded-full border border-cyan-500/30">{t("home.search.neural_match")}</span>
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
                transition={{ duration: 0.5, delay: 0.15, ease: [0.22, 1, 0.36, 1] }}
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
                      {slide.tag && t(`home.search.slide.${slide.tag}`, { defaultValue: slide.tag })}
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
                      {[slide.beds, `${slide.baths} ${t("home.search.bath_unit")}`, formatAreaByCountry(slide.areaVal || slide.sqm, selectedCountry)].map((spec, i) => (
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
                      {slide.price && t(`home.search.slide.${slide.price}`, { defaultValue: slide.price })}
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
                    <h3 className="font-extrabold text-base text-foreground tracking-tight">{t("home.curated.collection", { vibe: t(vibe.name) })}</h3>
                    <span className="text-xs px-2 py-0.5 bg-indigo-500/15 text-indigo-600 dark:text-indigo-400 font-bold rounded-full">{t(vibe.badge)}</span>
                    <span className="text-xs font-semibold text-muted-foreground">• {vibe.count} {t("home.curated.active_listings")}</span>
                  </div>
                  <p className="text-xs sm:text-sm font-medium text-muted-foreground">{t(vibe.desc)}</p>
                </div>
              </div>
              <Button 
                onClick={() => router.push(`/property?vibe=${vibe.englishName.toLowerCase()}`)}
                className="w-full sm:w-auto rounded-full bg-indigo-600 hover:bg-indigo-700 text-white font-bold px-6 py-5 shadow-lg shadow-indigo-500/25 shrink-0 transition-all hover:scale-105"
              >
                <span>{t("home.curated.view_all_vibe", { vibe: t(vibe.name) })}</span>
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

      {/* ══════ ECOSYSTEM & INVESTMENT & GLOBAL OS — lazy layout calculation ══════ */}
      <div className="cv-auto">
        <EcosystemSection />
        <InvestmentSection />
        <GlobalOSSection />
      </div>

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
    <Link href={prop.id ? `/client/property/${prop.id}` : "#"} className={`group relative rounded-3xl overflow-hidden block always-dark h-[350px] md:h-full w-full ${className}`}>
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
