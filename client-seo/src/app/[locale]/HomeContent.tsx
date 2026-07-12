"use client";

import Image from "next/image";
import { useTranslation } from "react-i18next";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { useState, useEffect, useRef, useCallback, useMemo } from "react";
import { useQuery } from "@tanstack/react-query";
import { propertyApi, Property } from "@/lib/api/property";
import { useMapProvider } from "@/components/map/MapProvider";
import { useRegionsStore } from "@/lib/store/regions-store";
import { GetCountries, GetAllCities } from "react-country-state-city";
import {
  Sparkles, Search, MapPin, ChevronRight, ChevronLeft, Menu, X, 
  ArrowRight, ShieldCheck, Key, Compass, Star, ChevronDown, Monitor, Watch, Gem, CheckCircle2
} from "lucide-react";
import { motion, AnimatePresence, useScroll, useTransform } from "framer-motion";
import { AppHeader } from "@/components/layout/AppHeader";
import { AIChatModal } from "@/components/home/AIChatModal";
import { SupportChatModal } from "@/components/home/SupportChatModal";
import { City } from "react-country-state-city/dist/esm/types";

/* ───── Fallback Slides for Hero & Properties ───── */
const FALLBACK_SLIDES = [
  { title: "The Glass Pavilion", location: "Malibu, California", price: "$28.5M", beds: 6, baths: 8, sqm: 1150, image: "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=1920&q=80", tag: "EXCLUSIVE" },
  { title: "Alpine Crystal Chalet", location: "Zermatt, Switzerland", price: "$14.5M", beds: 5, baths: 4, sqm: 670, image: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=1920&q=80", tag: "RETREAT" },
  { title: "Neo-Tokyo Cyber Loft", location: "Shinjuku, Tokyo", price: "$12.4M", beds: 3, baths: 3, sqm: 500, image: "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=1920&q=80", tag: "SMART HOME" },
  { title: "Monolithic Concrete Dream", location: "Beverly Hills, CA", price: "$16.2M", beds: 4, baths: 6, sqm: 820, image: "https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=1920&q=80", tag: "PENTHOUSE" },
];

const NAV_ITEMS = [
  { labelKey: "client.src.properties", defaultLabel: "Properties", href: "/property" },
  { labelKey: "client.src.explore", defaultLabel: "Explore", href: "/explore", badge: "NEW" },
  { labelKey: "client.src.pricing", defaultLabel: "Pricing", href: "/pricing" },
  { labelKey: "client.src.ai_studio", defaultLabel: "AI Studio", href: "/client/ai/studio" },
  { labelKey: "client.src.contact", defaultLabel: "Contact", href: "/contact" },
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

export function HomeContent({ initialProperties = [] }: { initialProperties?: any[] }) {
  const { t } = useTranslation();
  const router = useRouter();
  const { selectedRegion } = useRegionsStore();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [scrolled, setScrolled] = useState(false);
  const [aiModalOpen, setAiModalOpen] = useState(false);
  const [supportModalOpen, setSupportModalOpen] = useState(false);

  // Search State
  const [searchMode, setSearchMode] = useState<"STAYS" | "EXPERIENCES" | "BUY">("STAYS");
  const [searchLocation, setSearchLocation] = useState("");
  const [searchDate, setSearchDate] = useState("");
  const [searchGuests, setSearchGuests] = useState(1);
  const [selectedCountry, setSelectedCountry] = useState<string>("TR");
  const [countries, setCountries] = useState<any[]>([]);
  const [locationSuggestions, setLocationSuggestions] = useState<any[]>([]);
  const [showLocationSuggestions, setShowLocationSuggestions] = useState(false);
  const [showCountryDropdown, setShowCountryDropdown] = useState(false);

  const locationInputRef = useRef<HTMLInputElement>(null);
  const { provider, apiKey } = useMapProvider();
  const { scrollY } = useScroll();
  const heroOpacity = useTransform(scrollY, [0, 600], [1, 0]);

  useEffect(() => {
    const handleScroll = () => setScrolled(window.scrollY > 50);
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  // Load countries
  useEffect(() => {
    const loadCountries = async () => {
      try {
        const allCountries = await GetCountries();
        setCountries(allCountries); // Load all countries
      } catch (error) {
        console.error('Error loading countries:', error);
      }
    };
    loadCountries();
  }, []);

  // Load cities for autocomplete based on selected country
  useEffect(() => {
    const loadCities = async () => {
      try {
        const cities = await GetAllCities(selectedCountry);
        setLocationSuggestions(cities.slice(0, 50)); // Load first 50 cities
      } catch (error) {
        console.error('Error loading cities:', error);
      }
    };
    loadCities();
  }, [selectedCountry]);

  useEffect(() => {
    if (provider === "google") {
      const initGoogleAutocomplete = () => {
        if (!locationInputRef.current || !(window as any).google?.maps?.places) return;
        const autocomplete = new (window as any).google.maps.places.Autocomplete(locationInputRef.current, { types: ['(cities)'] });
        autocomplete.addListener("place_changed", () => {
          const place = autocomplete.getPlace();
          if (place && place.formatted_address) setSearchLocation(place.formatted_address);
          else if (place && place.name) setSearchLocation(place.name);
        });
      };
      if ((window as any).google?.maps?.places) { initGoogleAutocomplete(); return; }
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
  }, [provider, apiKey]);

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
  const response = rawResponse as any;

  const slides = useMemo(() => {
    if (!response?.data) return FALLBACK_SLIDES;
    return response.data.slice(0, 4).map((p: Property, i: number) => {
      const fallback = FALLBACK_SLIDES[i % FALLBACK_SLIDES.length];
      const rawImg = p.listings?.[0]?.pricingRules?.[0]?.discountRules?.image;
      const finalImage = (rawImg && typeof rawImg === 'string' && rawImg.length > 10) ? rawImg : fallback.image;
      return { ...fallback, title: p.name || fallback.title, location: p.address || fallback.location, price: p.price ? `$${Number(p.price).toLocaleString()}` : fallback.price, image: finalImage };
    });
  }, [response]);

  const [currentSlide, setCurrentSlide] = useState(0);
  useEffect(() => { const iv = setInterval(() => setCurrentSlide(c => (c + 1) % slides.length), 6000); return () => clearInterval(iv); }, [slides.length]);
  const slide = slides[currentSlide] || slides[0];

  return (
    <div className="min-h-screen bg-background text-foreground overflow-x-hidden selection:bg-black selection:text-white dark:selection:bg-white dark:selection:text-black">
      <AppHeader />

      {/* ══════ EDGE-TO-EDGE HERO ══════ */}
      <section className="relative h-[100svh] w-full flex flex-col justify-end pb-12 md:pb-24 pt-32 overflow-hidden bg-black">
        {slides.map((s: any, i: number) => (
          <motion.div key={i} style={{ opacity: heroOpacity }} className={`absolute inset-0 transition-opacity duration-1000 ease-in-out ${i === currentSlide ? "opacity-100 z-0" : "opacity-0 -z-10"}`}>
            <Image src={s.image} alt={s.title} fill sizes="100vw" className="object-cover transform scale-105 animate-[slow-pan_20s_ease-in-out_infinite]" priority={i === 0} />
            <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-black/40" />
          </motion.div>
        ))}

        <div className="relative z-10 w-full max-w-[1800px] mx-auto px-6 md:px-12 flex flex-col items-center justify-center h-full gap-12 mt-16">
          <motion.div initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 1, delay: 0.2 }} className="text-center w-full">
            <h1 className="text-6xl sm:text-7xl lg:text-[7rem] font-black tracking-tighter leading-[0.9] text-white drop-shadow-2xl mb-6" suppressHydrationWarning>
              {t('home.hero.title1', { defaultValue: 'Discover' })} <br />
              <span className="text-transparent bg-clip-text bg-gradient-to-r from-white via-white/80 to-white/40">
                {t('home.hero.title2', { defaultValue: 'Extraordinary.' })}
              </span>
            </h1>
            <p className="text-xl md:text-2xl font-medium text-white/80 max-w-2xl mx-auto tracking-wide font-serif italic">
              {t('home.hero.subtitle', { defaultValue: 'Curated luxury homes, exceptional experiences, and seamless intelligent management.' })}
            </p>
          </motion.div>

          {/* FLOATING SEARCH PILL */}
          <motion.div initial={{ opacity: 0, y: 40 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 1, delay: 0.5 }} className="w-full max-w-4xl mx-auto">
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

            {/* Search Input Bar */}
            <form onSubmit={handleSearch} className="bg-white dark:bg-[#111] p-3 rounded-full flex flex-col md:flex-row items-center gap-2 shadow-[0_40px_80px_-20px_rgba(0,0,0,0.5)] relative">
              {/* Country Selector */}
              <div className="relative px-4 py-3 hover:bg-slate-50 dark:hover:bg-white/5 rounded-full transition-colors group">
                <button
                  type="button"
                  onClick={() => setShowCountryDropdown(!showCountryDropdown)}
                  className="flex items-center gap-2 text-sm font-bold text-slate-900 dark:text-white"
                >
                  <span>{countries.find(c => c.isoCode === selectedCountry)?.name || 'Turkey'}</span>
                  <ChevronDown className="w-4 h-4" />
                </button>
                {showCountryDropdown && (
                  <div className="absolute top-full left-0 right-0 mt-2 bg-white dark:bg-[#111] rounded-2xl shadow-2xl border border-slate-200 dark:border-white/10 z-50 max-h-60 overflow-y-auto">
                    {countries.map((country) => (
                      <button
                        key={country.isoCode}
                        type="button"
                        onClick={() => {
                          setSelectedCountry(country.isoCode);
                          setShowCountryDropdown(false);
                        }}
                        className="w-full px-4 py-2 text-left hover:bg-slate-50 dark:hover:bg-white/5 transition-colors text-sm font-medium text-slate-900 dark:text-white"
                      >
                        {country.name}
                      </button>
                    ))}
                  </div>
                )}
              </div>

              <div className="hidden md:block w-[1px] h-10 bg-slate-200 dark:bg-white/10" />

              <div className="flex-[1.5] px-6 py-3 w-full hover:bg-slate-50 dark:hover:bg-white/5 rounded-full transition-colors group cursor-text relative">
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
                  className="bg-transparent border-none focus:outline-none focus:ring-0 text-base font-bold text-slate-900 dark:text-white w-full p-0 placeholder:font-medium placeholder:text-slate-300" 
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
              
              <div className="hidden md:block w-[1px] h-10 bg-slate-200 dark:bg-white/10" />

              {searchMode !== "BUY" && (
                <>
                  <div className="flex-1 px-6 py-3 w-full hover:bg-slate-50 dark:hover:bg-white/5 rounded-full transition-colors group">
                    <label className="text-[10px] font-black uppercase tracking-widest text-slate-500 dark:text-slate-400 block mb-1">{t('home.search.dates', { defaultValue: 'Dates' })}</label>
                    <input type="date" value={searchDate} onChange={(e) => setSearchDate(e.target.value)}
                      className="bg-transparent border-none focus:outline-none focus:ring-0 text-base font-bold text-slate-900 dark:text-white w-full p-0" />
                  </div>
                  <div className="hidden md:block w-[1px] h-10 bg-slate-200 dark:bg-white/10" />
                </>
              )}

              {searchMode !== "BUY" && (
                <div className="flex-1 px-6 py-3 w-full hover:bg-slate-50 dark:hover:bg-white/5 rounded-full transition-colors group relative">
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
                <Button type="submit" className="w-full md:w-16 h-14 rounded-full bg-black hover:bg-slate-800 dark:bg-white dark:hover:bg-slate-200 dark:text-black text-white shadow-xl transition-all flex items-center justify-center shrink-0">
                  <Search className="w-6 h-6" />
                </Button>
                <Button 
                  type="button" 
                  onClick={() => setAiModalOpen(true)} 
                  className="w-full md:w-16 h-14 rounded-full bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white shadow-xl transition-all flex items-center justify-center shrink-0"
                  title="AI Search"
                >
                  <Sparkles className="w-6 h-6 animate-pulse" />
                </Button>
              </div>
            </form>
          </motion.div>
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
            <Button variant="outline" className="hidden md:flex rounded-full font-bold h-12 px-6">
              {t("home.curated.view_all", { defaultValue: "View All Collection" })}
              <ArrowRight className="w-4 h-4 ml-2" />
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
      <section className="py-32 bg-[#050505] text-white overflow-hidden relative">
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
              <p className="text-xl text-white/60 mb-10 font-medium max-w-lg leading-relaxed">
                {t("home.ecosystem.desc", { defaultValue: "A complete ecosystem powered by AI. From smart locks to loyalty programs, manage everything from one beautiful dashboard." })}
              </p>
              
              <div className="space-y-6">
                {[
                  { icon: Monitor, title: "Smart Home Integration", desc: "Control thermostats, locks, and sensors remotely." },
                  { icon: Gem, title: "Loyalty & Rewards", desc: "Keep guests coming back with automated perks." },
                  { icon: ShieldCheck, title: "Automated Verifications", desc: "Identity checks and secure payment escrow." },
                ].map((feature, i) => (
                  <div key={i} className="flex gap-4">
                    <div className="w-12 h-12 rounded-2xl bg-white/10 flex items-center justify-center shrink-0 border border-white/10">
                      <feature.icon className="w-6 h-6 text-white" />
                    </div>
                    <div>
                      <h4 className="text-lg font-bold">{feature.title}</h4>
                      <p className="text-white/50 text-sm">{feature.desc}</p>
                    </div>
                  </div>
                ))}
              </div>

              <Button className="mt-12 rounded-full h-14 px-8 bg-white text-black hover:bg-white/90 font-bold text-base transition-all hover:scale-105">
                {t("home.ecosystem.cta", { defaultValue: "Explore The Platform" })}
              </Button>
            </motion.div>

            <motion.div initial={{ opacity: 0, scale: 0.95 }} whileInView={{ opacity: 1, scale: 1 }} viewport={{ once: true }}
              className="relative aspect-square md:aspect-auto md:h-[700px] w-full rounded-[3rem] border border-white/10 bg-gradient-to-br from-white/5 to-transparent overflow-hidden shadow-2xl flex items-center justify-center p-8">
              {/* Abstract Representation of OS Dashboard */}
              <div className="w-full h-full rounded-2xl border border-white/10 bg-black/40 backdrop-blur-xl shadow-2xl p-6 flex flex-col gap-4">
                <div className="flex justify-between items-center pb-4 border-b border-white/10">
                  <div className="w-32 h-6 rounded-full bg-white/20 animate-pulse" />
                  <div className="w-10 h-10 rounded-full bg-indigo-500/50 flex items-center justify-center"><CheckCircle2 className="w-5 h-5 text-white" /></div>
                </div>
                <div className="grid grid-cols-2 gap-4 flex-1">
                  <div className="bg-white/5 rounded-xl border border-white/5 p-4 flex flex-col justify-end"><div className="w-3/4 h-4 bg-white/20 rounded mb-2" /><div className="w-1/2 h-8 bg-white/40 rounded" /></div>
                  <div className="bg-white/5 rounded-xl border border-white/5 p-4 flex flex-col justify-end"><div className="w-3/4 h-4 bg-white/20 rounded mb-2" /><div className="w-1/2 h-8 bg-white/40 rounded" /></div>
                </div>
                <div className="h-32 bg-gradient-to-r from-indigo-500/20 to-purple-500/20 rounded-xl border border-white/5 flex items-center justify-center">
                  <Sparkles className="w-8 h-8 text-white/50" />
                </div>
              </div>
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
function BentoCard({ prop, className, large = false }: { prop: any; className?: string; large?: boolean }) {
  const { t } = useTranslation();
  if (!prop) return null;
  return (
    <Link href={`/properties/${prop.id || "#"}`} className={`group relative rounded-3xl overflow-hidden block ${className}`}>
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
