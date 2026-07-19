"use client";

import Image from "next/image";
import { useTranslation } from "react-i18next";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { useState, useEffect, useRef, useMemo, useCallback } from "react";
import { useQuery } from "@tanstack/react-query";
import { propertyApi, Property } from "@/lib/api/property";
import { useMapProvider } from "@/components/map/MapProvider";
import { useRegionsStore } from "@/lib/store/regions-store";
import type { Country, City } from "react-country-state-city/dist/umd/types";
import {
  Sparkles, Search, MapPin, ChevronRight, ChevronLeft, 
  ArrowRight, ShieldCheck, ChevronDown, Monitor, Gem, CheckCircle2, Mouse
} from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import dynamic from "next/dynamic";
import { AppHeader } from "@/components/layout/AppHeader";
const AIChatModal = dynamic(() => import("@/components/home/AIChatModal").then(m => m.AIChatModal), { ssr: false });
const SupportChatModal = dynamic(() => import("@/components/home/SupportChatModal").then(m => m.SupportChatModal), { ssr: false });

// Supported countries based on Prisma configurations in server/config
const SUPPORTED_COUNTRIES = [
  "AE", "AR", "AU", "BR", "CA", "CN", "DE", "ES", "FR", "GB", "IN", 
  "IT", "JP", "KR", "MX", "MY", "NL", "NZ", "SA", "SG", "TH", "TR", "US"
];

/* ───── Fallback Slides for Hero & Properties ───── */
const FALLBACK_SLIDES = [
  { title: "Hayat City", location: "Bağcılar, Mahmutbey", price: "50% Down Payment", beds: "1+1 to 3+1", baths: "1 Block", sqm: "6,500 m²", image: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=1920&q=80", tag: "NEW LAUNCH" },
  { title: "Özak Dragos", location: "Maltepe, Istanbul", price: "Islands & Sea View", beds: "1+1 to 3+1", baths: "5 Blocks", sqm: "16,000 m²", image: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=1920&q=80", tag: "SEA VIEW" },
  { title: "Büyükyalı Istanbul", location: "Zeytinburnu, Kennedy Ave", price: "Ready to Deliver", beds: "2+1 to 5.5+1", baths: "14 Blocks", sqm: "111,000 m²", image: "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=1920&q=80", tag: "READY TO MOVE" },
  { title: "Özak Duyu Göktürk", location: "Göktürk, Belgrade Forest", price: "Forest View", beds: "1+1 to 4.5+1", baths: "5 Blocks", sqm: "12,000 m²", image: "https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=1920&q=80", tag: "FOREST VIEW" },
];



const VIBES = [
  { icon: "🏖️", name: "Beachfront", count: "1,204" },
  { icon: "🏔️", name: "Mountains", count: "853" },
  { icon: "🏛️", name: "Mansions", count: "432" },
  { icon: "🏙️", name: "Penthouses", count: "921" },
  { icon: "🌲", name: "Cabins", count: "3,105" },
  { icon: "🏰", name: "Castles", count: "89" },
  { icon: "🏝️", name: "Islands", count: "42" },
  { icon: "📐", name: "Modern", count: "5,602" },
];

function EcosystemPreview() {
  const [activeTab, setActiveTab] = useState(0);

  useEffect(() => {
    const timer = setInterval(() => {
      setActiveTab((prev) => (prev + 1) % 3);
    }, 4000);
    return () => clearInterval(timer);
  }, []);

  const tabs = [
    {
      id: "smart-home",
      icon: <Monitor className="w-5 h-5 text-indigo-500 dark:text-indigo-400" />,
      title: "Smart Home",
      content: (
        <div className="flex flex-col gap-4 h-full justify-center">
          <div className="flex justify-between items-center bg-muted/50 rounded-2xl p-5 border border-border hover:bg-muted transition-colors">
            <div>
              <div className="text-muted-foreground text-sm font-medium mb-1">Master Bedroom Temp</div>
              <div className="text-3xl font-black text-foreground">22.5°C</div>
            </div>
            <div className="w-14 h-14 rounded-full bg-indigo-500/10 flex items-center justify-center">
              <Sparkles className="w-7 h-7 text-indigo-500 dark:text-indigo-400" />
            </div>
          </div>
          <div className="flex justify-between items-center bg-muted/50 rounded-2xl p-5 border border-border hover:bg-muted transition-colors">
            <div>
              <div className="text-muted-foreground text-sm font-medium mb-1">Smart Lock Status</div>
              <div className="text-2xl font-bold text-emerald-500 dark:text-emerald-400">Secured & Armed</div>
            </div>
            <div className="w-14 h-14 rounded-full bg-emerald-500/10 flex items-center justify-center">
              <CheckCircle2 className="w-7 h-7 text-emerald-500 dark:text-emerald-400" />
            </div>
          </div>
        </div>
      )
    },
    {
      id: "loyalty",
      icon: <Gem className="w-5 h-5 text-purple-500 dark:text-purple-400" />,
      title: "Rewards",
      content: (
        <div className="flex flex-col gap-4 h-full justify-center">
          <div className="text-center">
            <div className="inline-flex items-center justify-center w-20 h-20 rounded-full bg-gradient-to-br from-purple-500/10 to-pink-500/10 mb-6 border border-purple-500/20 shadow-[0_0_30px_rgba(168,85,247,0.15)]">
              <Gem className="w-10 h-10 text-purple-500 dark:text-purple-400" />
            </div>
            <h3 className="text-5xl font-black text-foreground mb-2">12,450</h3>
            <p className="text-muted-foreground font-medium">Reward Points Available</p>
          </div>
          <div className="bg-gradient-to-r from-purple-500/10 to-pink-500/10 rounded-2xl p-4 border border-purple-500/20 mt-6 text-center shadow-inner">
            <span className="text-sm font-black tracking-widest text-purple-600 dark:text-purple-400">GOLD TIER UNLOCKED</span>
          </div>
        </div>
      )
    },
    {
      id: "verifications",
      icon: <ShieldCheck className="w-5 h-5 text-emerald-500 dark:text-emerald-400" />,
      title: "Security",
      content: (
        <div className="flex flex-col gap-4 h-full justify-center">
          {[
            { label: "Biometric Identity Check", status: "Verified", color: "text-emerald-500 dark:text-emerald-400", bg: "bg-emerald-500/5 border-emerald-500/20" },
            { label: "Credit Score Analysis", status: "Excellent", color: "text-emerald-500 dark:text-emerald-400", bg: "bg-emerald-500/5 border-emerald-500/20" },
            { label: "Payment Escrow Account", status: "Secured", color: "text-indigo-500 dark:text-indigo-400", bg: "bg-indigo-500/5 border-indigo-500/20" },
          ].map((item, i) => (
            <motion.div key={i} initial={{ opacity: 0, x: 20 }} animate={{ opacity: 1, x: 0 }} transition={{ delay: i * 0.15 }}
              className={`flex justify-between items-center p-5 rounded-2xl border ${item.bg}`}>
              <span className="text-foreground/80 font-medium">{item.label}</span>
              <span className={`font-bold ${item.color}`}>{item.status}</span>
            </motion.div>
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
          <motion.div
            key={activeTab}
            initial={{ opacity: 0, y: 20, scale: 0.95 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: -20, scale: 0.95 }}
            transition={{ duration: 0.4, ease: "easeOut" }}
            className="absolute inset-0 flex flex-col justify-center"
          >
            {tabs[activeTab].content}
          </motion.div>
        </AnimatePresence>
      </div>
      
      {/* Footer metric */}
      <div className="h-24 bg-gradient-to-r from-indigo-500/15 via-purple-500/15 to-transparent rounded-2xl border border-border flex items-center justify-between p-6">
        <div>
          <div className="text-muted-foreground font-medium mb-1.5">Global System Status</div>
          <div className="text-foreground font-bold flex items-center gap-3 text-lg">
            <div className="w-3 h-3 rounded-full bg-emerald-500 animate-pulse shadow-[0_0_10px_rgba(16,185,129,0.8)]" />
            All Modules Operational
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
  const [aiModalOpen, setAiModalOpen] = useState(false);
  const [supportModalOpen, setSupportModalOpen] = useState(false);
  const [heroRevealed, setHeroRevealed] = useState(false);

  // Search State
  const [searchMode, setSearchMode] = useState<"STAYS" | "EXPERIENCES" | "BUY">("STAYS");
  const [searchLocation, setSearchLocation] = useState("");
  const [searchDate, setSearchDate] = useState("");
  const [searchGuests, setSearchGuests] = useState(1);
  const [selectedCountry, setSelectedCountry] = useState<string>("TR");
  const [countries, setCountries] = useState<Country[]>([]);
  const [locationSuggestions, setLocationSuggestions] = useState<City[]>([]);
  const [showLocationSuggestions, setShowLocationSuggestions] = useState(false);
  const [showCountryDropdown, setShowCountryDropdown] = useState(false);
  const [countrySearch, setCountrySearch] = useState("");

  const [videoMounted, setVideoMounted] = useState(false);
  useEffect(() => { setVideoMounted(true); }, []);

  const locationInputRef = useRef<HTMLInputElement>(null);
  const { provider, apiKey } = useMapProvider();
  const [heroOpacity, setHeroOpacity] = useState(1);

  useEffect(() => {
    const handleScroll = () => {
      const scrollY = window.scrollY;
      const opacity = Math.max(0, 1 - scrollY / 600);
      setHeroOpacity(opacity);
      if (scrollY > 10 && !heroRevealed) setHeroRevealed(true);
    };
    window.addEventListener("scroll", handleScroll, { passive: true });
    return () => window.removeEventListener("scroll", handleScroll);
  }, [heroRevealed]);

  // Cinematic reveal timer
  useEffect(() => {
    const timer = setTimeout(() => setHeroRevealed(true), 2500);
    return () => clearTimeout(timer);
  }, []);

  // Load countries (dynamic import to reduce initial bundle)
  useEffect(() => {
    const loadCountries = async () => {
      try {
        const { GetCountries } = await import("react-country-state-city");
        const allCountries = await GetCountries("/country-data");
        const supported = allCountries.filter((c: Country) => SUPPORTED_COUNTRIES.includes(c.iso2));
        setCountries(supported);
      } catch (error) {
        console.error('Error loading countries:', error);
      }
    };
    loadCountries();
  }, []);

  // Load cities for autocomplete based on selected country (dynamic import)
  useEffect(() => {
    const loadCities = async () => {
      try {
        const { GetAllCities } = await import("react-country-state-city");
        const cities = await GetAllCities("/country-data");
        setLocationSuggestions(cities.slice(0, 50));
      } catch (error) {
        console.error('Error loading cities:', error);
      }
    };
    loadCities();
  }, [selectedCountry]);

  useEffect(() => {
    if (provider === "google") {
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
      return () => { if (script) script.removeEventListener("load", initGoogleAutocomplete); };
    }
  }, [provider, apiKey, selectedCountry]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    const params = new URLSearchParams();
    if (searchLocation) params.append("location", searchLocation);
    if (searchMode !== "BUY" && searchDate) params.append("date", searchDate);
    if (searchMode === "STAYS" && searchGuests > 1) params.append("guests", searchGuests.toString());
    params.append("listingType", searchMode);
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
      return { ...fallback, title: p.name || fallback.title, location: p.address || fallback.location, price: p.price ? `$${Number(p.price).toLocaleString()}` : fallback.price, image: finalImage };
    });
  }, [response]);

  const [currentSlide, setCurrentSlide] = useState(0);
  useEffect(() => { const iv = setInterval(() => setCurrentSlide(c => (c + 1) % Math.max(slides.length, 4)), 6000); return () => clearInterval(iv); }, [slides.length]);
  const slide = slides[currentSlide] || slides[0];

  const bgVideo = useMemo(() => {
    const videos = ["/videos/ozak-bg.mp4", "/videos/ozak-dragos-bg.mp4", "/videos/ozak-buyukyali-bg.mp4", "/videos/ozak-duyu-bg.mp4"];
    return videos[currentSlide % videos.length];
  }, [currentSlide]);

  return (
    <div className="min-h-screen bg-background text-foreground overflow-x-hidden selection:bg-black selection:text-white dark:selection:bg-white dark:selection:text-black">
      <AppHeader />

      {/* ══════ CINEMATIC HERO ══════ */}
      <section className="relative h-[100svh] w-full flex flex-col overflow-hidden bg-black always-dark">
        {/* Video Background */}
        <div style={{ opacity: heroOpacity }} className="absolute inset-0 z-0">
            <video
              autoPlay
              loop
              muted
              playsInline
              width="1920"
              height="1080"
              poster="/videos/poster.webp"
              onLoadedMetadata={(e) => { e.currentTarget.currentTime = 2; }}
              className="w-full h-full object-cover"
              style={{ opacity: videoMounted ? 1 : 0, transform: 'scale(1.05)', transition: 'opacity 1.5s ease-out' }}
            >
              <source src={`${bgVideo}#t=2`} type="video/mp4" />
            </video>
          <div className="absolute inset-0 bg-gradient-to-t from-black/90 via-black/30 to-black/50" />
        </div>

        {/* ─── FAZ 1: LOGO + SCROLL ICON ─── */}
        <div
          style={{ opacity: heroRevealed ? 0 : 1, pointerEvents: heroRevealed ? 'none' : 'auto', transition: 'opacity 0.8s ease' }}
          className="absolute inset-0 z-20 flex flex-col items-center justify-center"
        >
          <motion.div
            initial={{ opacity: 0, scale: 0.8 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ duration: 1.2, ease: "easeOut" }}
            className="text-center"
          >
            <h1 className="text-6xl md:text-8xl font-black text-transparent bg-clip-text bg-gradient-to-br from-white via-slate-100 to-slate-400 tracking-tighter drop-shadow-[0_0_20px_rgba(255,255,255,0.4)]">
              Reservatior
            </h1>
            <p className="text-white/50 text-sm md:text-base font-medium tracking-[0.3em] uppercase mt-4">
              {t("home.hero.tagline", { defaultValue: "Global Luxury Real Estate OS" })}
            </p>
          </motion.div>
          <motion.div
            animate={{ y: [0, 8, 0] }}
            transition={{ duration: 2, repeat: Infinity, ease: "easeInOut" }}
            className="absolute bottom-12 flex flex-col items-center gap-3 cursor-pointer"
            onClick={() => setHeroRevealed(true)}
          >
            <Mouse className="w-6 h-6 text-white/60" />
            <span className="text-white/40 text-[10px] font-bold tracking-[0.3em] uppercase">
              {t("home.hero.scroll", { defaultValue: "Scroll to explore" })}
            </span>
          </motion.div>
        </div>

        {/* ─── FAZ 2 & 3: SEARCH + PROJECT INFO ─── */}
        <div className="relative z-10 w-full max-w-[1800px] mx-auto px-6 md:px-12 flex flex-col justify-end h-full pb-12 md:pb-20 min-h-[300px]">

          {/* FLOATING SEARCH PILL */}
          <div
            style={{ opacity: heroRevealed ? 1 : 0, transform: heroRevealed ? 'translateY(0)' : 'translateY(60px)', transition: 'all 0.9s cubic-bezier(0.22, 1, 0.36, 1)', pointerEvents: heroRevealed ? 'auto' : 'none' }}
            className="w-full max-w-4xl mx-auto mb-12"
          >
                {/* Search Tabs */}
                <div className="flex justify-center items-center gap-6 mb-4">
                  {(["STAYS", "EXPERIENCES", "BUY"] as const).map(mode => (
                    <button key={mode} onClick={() => setSearchMode(mode)}
                      className={`relative text-sm font-bold tracking-widest uppercase transition-all duration-300 ${searchMode === mode ? "text-white" : "text-white/50 hover:text-white/80"}`}>
                      {t(`home.search.mode_${mode.toLowerCase()}`, { defaultValue: mode })}
                      {searchMode === mode && <motion.div layoutId="searchTabIndicator" className="absolute -bottom-2 left-0 right-0 h-0.5 bg-white rounded-full" />}
                    </button>
                  ))}
                </div>

                {/* Search Input Bar — Glassmorphism */}
                <form onSubmit={handleSearch} className="bg-white/90 dark:bg-black/40 backdrop-blur-3xl p-3 rounded-full flex flex-col md:flex-row items-center gap-2 shadow-[0_40px_100px_-20px_rgba(0,0,0,0.8),inset_0_1px_1px_rgba(255,255,255,0.4)] border border-white/50 dark:border-white/20 relative">
                  {/* Country Selector */}
                  <div className="relative px-4 py-3 hover:bg-white/50 dark:hover:bg-white/5 rounded-full transition-colors group">
                    <button
                      type="button"
                      onClick={() => setShowCountryDropdown(!showCountryDropdown)}
                      className="flex items-center gap-2 text-sm font-bold text-slate-900 dark:text-white"
                    >
                      <span>{countries.find(c => c.iso2 === selectedCountry)?.name || 'Turkey'}</span>
                      <ChevronDown className="w-4 h-4" />
                    </button>
                    {showCountryDropdown && (
                      <div className="absolute top-full left-0 mt-2 bg-white dark:bg-[#111] rounded-2xl shadow-2xl border border-slate-200 dark:border-white/10 z-50 w-64 max-h-80 overflow-hidden flex flex-col">
                        <div className="p-3 border-b border-slate-100 dark:border-white/10">
                          <div className="relative">
                            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                            <input
                              type="text"
                              placeholder={t('home.search.country_search', { defaultValue: 'Search country...' }) as string}
                              value={countrySearch}
                              onChange={(e) => setCountrySearch(e.target.value)}
                              className="w-full bg-slate-50 dark:bg-white/5 border-none rounded-xl py-2 pl-9 pr-4 text-sm font-medium focus:ring-2 focus:ring-black dark:focus:ring-white outline-none"
                              onClick={(e) => e.stopPropagation()}
                            />
                          </div>
                        </div>
                        <div className="overflow-y-auto flex-1 py-2">
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
                                className="w-full px-4 py-2 text-left hover:bg-slate-50 dark:hover:bg-white/5 transition-colors text-sm font-medium text-slate-900 dark:text-white flex items-center justify-between"
                              >
                                <span>{country.name}</span>
                                {selectedCountry === country.iso2 && <CheckCircle2 className="w-4 h-4 text-black dark:text-white" />}
                              </button>
                            ))}
                          {countries.filter(c => c.name.toLowerCase().includes(countrySearch.toLowerCase())).length === 0 && (
                            <div className="px-4 py-3 text-sm text-slate-500 text-center">
                              {t('home.search.no_country_found', { defaultValue: 'No country found' })}
                            </div>
                          )}
                        </div>
                      </div>
                    )}
                  </div>

                  <div className="hidden md:block w-[1px] h-10 bg-slate-300/50 dark:bg-white/10" />

                  <div className="flex-[1.5] px-6 py-3 w-full hover:bg-white/50 dark:hover:bg-white/5 rounded-full transition-colors group cursor-text relative">
                    <label className="text-[10px] font-black uppercase tracking-widest text-slate-500 dark:text-slate-400 block mb-1">{t('home.search.where', { defaultValue: 'Location' })}</label>
                    <input 
                      ref={locationInputRef} 
                      type="text" 
                      value={searchLocation} 
                      onChange={(e) => {
                        setSearchLocation(e.target.value);
                        setShowLocationSuggestions(e.target.value.length > 0);
                      }}
                      onFocus={() => setShowLocationSuggestions(searchLocation.length > 0)}
                      onBlur={() => setTimeout(() => setShowLocationSuggestions(false), 200)}
                      placeholder={t('home.search.where_hint', { defaultValue: 'Search destinations' }) as string}
                      className="bg-transparent border-none focus:outline-none focus:ring-0 text-base font-bold text-slate-900 dark:text-white w-full p-0 placeholder:font-medium placeholder:text-slate-400" 
                    />
                    {showLocationSuggestions && locationSuggestions.length > 0 && (
                      <div className="absolute top-full left-0 right-0 mt-2 bg-white dark:bg-[#111] rounded-2xl shadow-2xl border border-slate-200 dark:border-white/10 z-50 max-h-60 overflow-y-auto">
                        {locationSuggestions
                          .filter(city => city.name.toLowerCase().includes(searchLocation.toLowerCase()))
                          .slice(0, 10)
                          .map((city, index) => (
                            <button
                              key={index}
                              type="button"
                              onClick={() => {
                                setSearchLocation(city.name);
                                setShowLocationSuggestions(false);
                              }}
                              className="w-full px-6 py-3 text-left hover:bg-slate-50 dark:hover:bg-white/5 transition-colors flex items-center gap-3"
                            >
                              <MapPin className="w-4 h-4 text-slate-400" />
                              <span className="text-sm font-medium text-slate-900 dark:text-white">{city.name}</span>
                            </button>
                          ))}
                      </div>
                    )}
                  </div>
                  
                  <div className="hidden md:block w-[1px] h-10 bg-slate-300/50 dark:bg-white/10" />

                  {searchMode !== "BUY" && (
                    <>
                      <div className="flex-1 px-6 py-3 w-full hover:bg-white/50 dark:hover:bg-white/5 rounded-full transition-colors group">
                        <label className="text-[10px] font-black uppercase tracking-widest text-slate-500 dark:text-slate-400 block mb-1">{t('home.search.dates', { defaultValue: 'Dates' })}</label>
                        <input type="date" value={searchDate} onChange={(e) => setSearchDate(e.target.value)}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-base font-bold text-slate-900 dark:text-white w-full p-0" />
                      </div>
                      <div className="hidden md:block w-[1px] h-10 bg-slate-300/50 dark:bg-white/10" />
                    </>
                  )}

                  {searchMode !== "BUY" && (
                    <div className="flex-1 px-6 py-3 w-full hover:bg-white/50 dark:hover:bg-white/5 rounded-full transition-colors group relative">
                      <label className="text-[10px] font-black uppercase tracking-widest text-slate-500 dark:text-slate-400 block mb-1">{t('home.search.who', { defaultValue: 'Guests' })}</label>
                      <select value={searchGuests} onChange={(e) => setSearchGuests(Number(e.target.value))}
                        className="bg-transparent border-none focus:outline-none focus:ring-0 text-base font-bold text-slate-900 dark:text-white w-full p-0 cursor-pointer appearance-none">
                        <option value={1}>{t('home.search.guest_1', { defaultValue: '1 Guest' })}</option>
                        <option value={2}>{t('home.search.guest_2', { defaultValue: '2 Guests' })}</option>
                        <option value={3}>{t('home.search.guest_3', { defaultValue: '3 Guests' })}</option>
                        <option value={4}>{t('home.search.guest_4', { defaultValue: '4+ Guests' })}</option>
                      </select>
                      <ChevronDown className="absolute right-6 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 pointer-events-none" />
                    </div>
                  )}

                  <div className="flex gap-2 w-full md:w-auto">
                    <Button type="submit" className="w-full md:w-16 h-14 rounded-full bg-gradient-to-br from-slate-900 to-black hover:from-slate-800 hover:to-slate-900 dark:from-slate-100 dark:to-white dark:hover:from-slate-200 dark:hover:to-slate-100 dark:text-black text-white shadow-[0_0_20px_rgba(0,0,0,0.4)] border border-slate-700/50 dark:border-white/10 transition-all flex items-center justify-center shrink-0">
                      <Search className="w-6 h-6" />
                    </Button>
                    <Button 
                      type="button" 
                      onClick={() => setAiModalOpen(true)} 
                      className="w-full md:w-16 h-14 rounded-full bg-gradient-to-r from-blue-500 via-indigo-500 to-purple-600 hover:from-blue-400 hover:via-indigo-400 hover:to-purple-500 text-white shadow-[0_0_30px_rgba(99,102,241,0.6)] border border-white/20 transition-all flex items-center justify-center shrink-0 group"
                      title="AI Search"
                    >
                      <Sparkles className="w-6 h-6 animate-pulse group-hover:scale-110 transition-transform" />
                    </Button>
                  </div>
                </form>
              </div>

          {/* PROJECT INFO + SLIDE CONTROLS */}
          <div
            style={{ opacity: heroRevealed ? 1 : 0, transform: heroRevealed ? 'translateY(0)' : 'translateY(30px)', transition: 'all 0.8s cubic-bezier(0.22, 1, 0.36, 1) 0.4s', pointerEvents: heroRevealed ? 'auto' : 'none' }}
            className="w-full max-w-5xl mx-auto"
          >
                <div className="flex items-end justify-between gap-6">
                  {/* Left: Project Info */}
                  <div className="flex-1 min-w-0">
                    {/* Tag */}
                    <motion.span
                      key={`tag-${currentSlide}`}
                      initial={{ opacity: 0, x: -20 }}
                      animate={{ opacity: 1, x: 0 }}
                      className="inline-block px-4 py-1.5 bg-gradient-to-r from-blue-500/20 to-purple-500/20 backdrop-blur-md border border-white/30 text-white text-[10px] font-black uppercase tracking-[0.2em] rounded-full mb-4 shadow-[0_0_15px_rgba(59,130,246,0.5)]"
                    >
                      {slide.tag}
                    </motion.span>

                    {/* Project Name */}
                    <AnimatePresence mode="wait">
                      <motion.h2
                        key={`title-${currentSlide}`}
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        exit={{ opacity: 0, y: -20 }}
                        transition={{ duration: 0.5 }}
                        className="text-4xl md:text-6xl font-black text-transparent bg-clip-text bg-gradient-to-r from-white to-slate-300 tracking-tight leading-none mb-2 drop-shadow-lg"
                      >
                        {slide.title}
                      </motion.h2>
                    </AnimatePresence>

                    {/* Location */}
                    <motion.div
                      key={`loc-${currentSlide}`}
                      initial={{ opacity: 0 }}
                      animate={{ opacity: 1 }}
                      transition={{ delay: 0.2 }}
                      className="flex items-center gap-2 text-white/70 font-medium text-sm mb-4"
                    >
                      <MapPin className="w-4 h-4" />
                      <span>{slide.location}</span>
                    </motion.div>

                    {/* Specs */}
                    <div className="flex items-center gap-3 flex-wrap">
                      {[slide.beds, slide.baths, slide.sqm].map((spec, i) => (
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
                        className="w-12 h-12 rounded-full bg-white/10 backdrop-blur-md border border-white/20 flex items-center justify-center hover:bg-white/20 transition-all"
                      >
                        <ChevronLeft className="w-5 h-5 text-white" />
                      </button>
                      <button
                        onClick={() => setCurrentSlide(c => (c + 1) % slides.length)}
                        className="w-12 h-12 rounded-full bg-white/10 backdrop-blur-md border border-white/20 flex items-center justify-center hover:bg-white/20 transition-all"
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
                      className={`h-1.5 rounded-full transition-all duration-500 ${
                        i === currentSlide ? "w-8 bg-white" : "w-3 bg-white/30 hover:bg-white/50"
                      }`}
                    />
                  ))}
                </div>
              </div>
        </div>
      </section>

      {/* ══════ VIBES / CATEGORIES (HORIZONTAL SCROLL) ══════ */}
      <section className="py-12 border-b border-border bg-background">
        <div className="max-w-[1800px] mx-auto px-6 md:px-12 flex gap-8 overflow-x-auto no-scrollbar snap-x pb-4">
          {VIBES.map((vibe, i) => (
            <motion.div key={i} initial={{ opacity: 0, y: 20 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ delay: i * 0.05 }}
              className="flex flex-col items-center gap-3 min-w-[80px] cursor-pointer group snap-start">
              <div className="text-3xl grayscale opacity-60 group-hover:grayscale-0 group-hover:opacity-100 transition-all duration-300 group-hover:-translate-y-1">
                {vibe.icon}
              </div>
              <span className="text-xs font-bold tracking-wide text-muted-foreground group-hover:text-foreground transition-colors uppercase">
                {vibe.name}
              </span>
            </motion.div>
          ))}
        </div>
      </section>

      {/* ══════ BENTO GRID (FEATURED) ══════ */}
      <section className="py-24 bg-background">
        <div className="max-w-[1800px] mx-auto px-6 md:px-12">
          <motion.div initial={{ opacity: 0, y: 20 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} className="flex justify-between items-end mb-16">
            <div>
              <h2 className="text-4xl md:text-5xl font-black tracking-tight mb-4">{t("home.curated.title", { defaultValue: "Curated Collections" })}</h2>
              <p className="text-lg text-muted-foreground max-w-xl font-medium">{t("home.curated.subtitle", { defaultValue: "Handpicked properties that redefine luxury living and smart hospitality." })}</p>
            </div>
            <Button variant="outline" className="hidden md:flex rounded-full font-bold h-12 px-6" asChild>
              <Link href="/client/property">
                {t("home.curated.view_all", { defaultValue: "View All Collection" })}
                <ArrowRight className="w-4 h-4 ml-2" />
              </Link>
            </Button>
          </motion.div>

          <div className="grid grid-cols-1 md:grid-cols-4 gap-4 md:h-[600px]">
            {/* Bento Block 1 (Large) */}
            <BentoCard prop={slides[0]} className="md:col-span-2 md:row-span-2" large />
            {/* Bento Block 2 (Top Right) */}
            <BentoCard prop={slides[1]} className="md:col-span-2 md:row-span-1" />
            {/* Bento Block 3 & 4 (Bottom Right) */}
            <BentoCard prop={slides[2]} className="md:col-span-1 md:row-span-1" />
            <BentoCard prop={slides[3]} className="md:col-span-1 md:row-span-1" />
          </div>
        </div>
      </section>

      {/* ══════ ECOSYSTEM (HOSPITALITY OS) ══════ */}
      <section className="py-32 bg-[#050505] text-white overflow-hidden relative always-dark">
        <div className="absolute top-0 right-0 w-[800px] h-[800px] bg-indigo-500/10 rounded-full blur-[120px] pointer-events-none" />
        <div className="max-w-[1800px] mx-auto px-6 md:px-12 relative z-10">
          <div className="grid lg:grid-cols-2 gap-16 items-center">
            <motion.div initial={{ opacity: 0, x: -40 }} whileInView={{ opacity: 1, x: 0 }} viewport={{ once: true }}>
              <span className="text-indigo-400 font-black tracking-widest uppercase text-sm mb-4 block">
                {t("home.ecosystem.badge", { defaultValue: "Hospitality OS" })}
              </span>
              <h2 className="text-4xl md:text-6xl font-black tracking-tighter leading-tight mb-6">
                {t("home.ecosystem.title", { defaultValue: "More Than Just Bookings." })}
              </h2>
              <p className="text-xl text-muted-foreground mb-10 font-medium max-w-lg leading-relaxed">
                {t("home.ecosystem.desc", { defaultValue: "A complete ecosystem powered by AI. From smart locks to loyalty programs, manage everything from one beautiful dashboard." })}
              </p>
              
              <div className="space-y-6">
                {[
                  { icon: Monitor, title: "Smart Home Integration", desc: "Control thermostats, locks, and sensors remotely." },
                  { icon: Gem, title: "Loyalty & Rewards", desc: "Keep guests coming back with automated perks." },
                  { icon: ShieldCheck, title: "Automated Verifications", desc: "Identity checks and secure payment escrow." },
                ].map((feature, i) => (
                  <div key={i} className="flex gap-4">
                    <div className="w-12 h-12 rounded-2xl bg-muted/50 flex items-center justify-center shrink-0 border border-border">
                      <feature.icon className="w-6 h-6 text-foreground" />
                    </div>
                    <div>
                      <h4 className="text-lg font-bold text-foreground">{feature.title}</h4>
                      <p className="text-muted-foreground text-sm">{feature.desc}</p>
                    </div>
                  </div>
                ))}
              </div>

              <Button className="mt-12 rounded-full h-14 px-8 bg-primary text-primary-foreground hover:bg-primary/90 font-bold text-base transition-all hover:scale-105" asChild>
                <Link href="/admin/dashboard">
                  {t("home.ecosystem.cta", { defaultValue: "Explore The Platform" })}
                </Link>
              </Button>
            </motion.div>

            <motion.div initial={{ opacity: 0, scale: 0.95 }} whileInView={{ opacity: 1, scale: 1 }} viewport={{ once: true }}
              className="relative aspect-square md:aspect-auto md:h-[700px] w-full rounded-[3rem] border border-border bg-gradient-to-br from-muted/30 to-transparent overflow-hidden shadow-2xl flex items-center justify-center p-4 md:p-8">
              <EcosystemPreview />
            </motion.div>
          </div>
        </div>
      </section>

      {/* ══════ FOOTER (Minimal Premium) ══════ */}
      <footer className="bg-background pt-24 pb-12 border-t border-border">
        <div className="max-w-[1800px] mx-auto px-6 md:px-12">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-12 mb-16">
            <div className="md:col-span-1">
              <span className="text-2xl font-black tracking-tight mb-6 block">{t("_locale_.homecontent.auto_ext_2")}</span>
              <p className="text-muted-foreground text-sm font-medium max-w-xs leading-relaxed">
                {t("footer.desc", { defaultValue: "The ultimate operating system for modern luxury real estate, experiences, and property management." })}
              </p>
            </div>
            <div>
              <h4 className="font-bold mb-6 uppercase tracking-widest text-xs text-foreground/50">{t("footer.company", { defaultValue: "Company" })}</h4>
              <ul className="space-y-4">
                <li><Link href="/about" className="font-semibold text-muted-foreground hover:text-foreground">{t("_locale_.homecontent.auto_ext_3")}</Link></li>
                <li><Link href="/careers" className="font-semibold text-muted-foreground hover:text-foreground">{t("_locale_.homecontent.auto_ext_4")}</Link></li>
                <li><Link href="/investors" className="font-semibold text-muted-foreground hover:text-foreground">{t("_locale_.homecontent.auto_ext_5")}</Link></li>
              </ul>
            </div>
            <div>
              <h4 className="font-bold mb-6 uppercase tracking-widest text-xs text-foreground/50">{t("footer.platform", { defaultValue: "Platform" })}</h4>
              <ul className="space-y-4">
                <li><Link href="/properties" className="font-semibold text-muted-foreground hover:text-foreground">{t("_locale_.homecontent.auto_ext_6")}</Link></li>
                <li><Link href="/client/experiences" className="font-semibold text-muted-foreground hover:text-foreground">{t("_locale_.homecontent.auto_ext_7")}</Link></li>
                <li><Link href="/client/ai/studio" className="font-semibold text-muted-foreground hover:text-foreground">{t("_locale_.homecontent.auto_ext_8")}</Link></li>
              </ul>
            </div>
            <div>
              <h4 className="font-bold mb-6 uppercase tracking-widest text-xs text-foreground/50">{t("footer.legal", { defaultValue: "Legal" })}</h4>
              <ul className="space-y-4">
                <li><Link href="/client/terms" className="font-semibold text-muted-foreground hover:text-foreground">{t("_locale_.homecontent.auto_ext_9")}</Link></li>
                <li><Link href="/client/privacy" className="font-semibold text-muted-foreground hover:text-foreground">{t("_locale_.homecontent.auto_ext_10")}</Link></li>
                <li><Link href="/client/trust-center" className="font-semibold text-muted-foreground hover:text-foreground">{t("_locale_.homecontent.auto_ext_11")}</Link></li>
              </ul>
            </div>
          </div>
          <div className="border-t border-border pt-8 flex flex-col md:flex-row justify-between items-center gap-4 text-xs font-bold text-muted-foreground">
            <p>© {new Date().getFullYear()} {t("_locale_.homecontent.auto_ext_12")}</p>
            <div className="flex gap-6">
              <span className="hover:text-foreground cursor-pointer transition-colors">{t("_locale_.homecontent.auto_ext_13")}</span>
              <span className="hover:text-foreground cursor-pointer transition-colors">{t("_locale_.homecontent.auto_ext_14")}</span>
              <span className="hover:text-foreground cursor-pointer transition-colors">{t("_locale_.homecontent.auto_ext_15")}</span>
            </div>
          </div>
        </div>
      </footer>
      
      <AIChatModal isOpen={aiModalOpen} onClose={() => setAiModalOpen(false)} />
      <SupportChatModal isOpen={supportModalOpen} onClose={() => setSupportModalOpen(false)} />
      
      {/* Floating Support Button */}
      <button
        onClick={() => setSupportModalOpen(true)}
        className="fixed bottom-6 right-6 z-50 w-14 h-14 bg-gradient-to-br from-blue-500 to-cyan-500 rounded-full shadow-2xl flex items-center justify-center hover:scale-110 transition-transform"
      >
        <Sparkles className="w-6 h-6 text-white" />
      </button>
    </div>
  );
}

/* ───── Bento Card Component ───── */
function BentoCard({ prop, className, large = false }: { prop: { id?: string; image: string; title: string; location: string; price: string; tag?: string; beds?: string; baths?: string }; className?: string; large?: boolean }) {
  const { t } = useTranslation();
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
          <div className="flex items-center gap-4 text-white font-bold text-sm">
            <span>{prop.beds} {t("_locale_.homecontent.auto_ext_16")}</span>
            <span className="w-1 h-1 bg-white/50 rounded-full" />
            <span>{prop.baths} {t("_locale_.homecontent.auto_ext_17")}</span>
          </div>
          <span className={`${large ? "text-2xl" : "text-xl"} font-black text-white bg-white/10 px-4 py-2 rounded-xl backdrop-blur-md`}>{prop.price}</span>
        </div>
      </div>
    </Link>
  );
}

export default HomeContent;
