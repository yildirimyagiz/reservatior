import { Helmet } from "react-helmet-async";
import { useTranslation } from "react-i18next";
import { Link, useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { useState, useEffect, useRef, useCallback, useMemo } from "react";
import { useQuery } from "@tanstack/react-query";
import { propertyApi, Property } from "@/lib/api/property";
import { useMapProvider } from "@/components/map/MapProvider";
import { Badge } from "@/components/ui/badge";
import { useRegionsStore } from "@/lib/store/regions-store";
import {
  ArrowRight, Play, Sparkles, Building2, Video, Globe2,
  Shield, BarChart3, Zap, CheckCircle2, PlayCircle,
  Bot, TrendingUp, Home as HomeIcon, ChevronRight,
  ChevronLeft, MapPin, Star, Users, Search, ChevronDown
} from "lucide-react";

/* ───── Animated Counter ───── */
function AnimatedCounter({ target, suffix = "" }: { target: number; suffix?: string }) {
  const [count, setCount] = useState(0);
  const ref = useRef<HTMLSpanElement>(null);
  useEffect(() => {
    const obs = new IntersectionObserver(([e]) => {
      if (e.isIntersecting) {
        let s = 0;
        const step = (ts: number) => { s = s || ts; const p = Math.min((ts - s) / 2000, 1); setCount(Math.floor(p * target)); if (p < 1) requestAnimationFrame(step); };
        requestAnimationFrame(step); obs.disconnect();
      }
    }, { threshold: 0.3 });
    if (ref.current) obs.observe(ref.current);
    return () => obs.disconnect();
  }, [target]);
  return <span ref={ref}>{count.toLocaleString()}{suffix}</span>;
}

/* ───── Fallback Slides for mapping ───── */
const FALLBACK_SLIDES = [
  { title: "The Glass Pavilion", location: "Malibu, California", price: "$28.5M", beds: 6, baths: 8, sqm: 1150,
    image: "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=1920&q=80",
    gradient: "from-blue-600/40 via-blue-500/20 to-sky-500/40", accent: "bg-blue-600", tag: "EXCLUSIVE LISTING" },
  { title: "Neo-Tokyo Cyber Loft", location: "Shinjuku, Tokyo", price: "$12.4M", beds: 3, baths: 3, sqm: 500,
    image: "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=1920&q=80",
    gradient: "from-violet-600/40 via-purple-500/20 to-fuchsia-500/40", accent: "bg-violet-600", tag: "SMART HOME" },
  { title: "Monolithic Concrete Dream", location: "Beverly Hills, CA", price: "$16.2M", beds: 4, baths: 6, sqm: 820,
    image: "https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=1920&q=80",
    gradient: "from-amber-500/40 via-orange-400/20 to-red-500/40", accent: "bg-amber-500", tag: "PENTHOUSE" },
  { title: "Alpine Crystal Chalet", location: "Zermatt, Switzerland", price: "$14.5M", beds: 5, baths: 4, sqm: 670,
    image: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=1920&q=80",
    gradient: "from-emerald-500/40 via-indigo-400/20 to-blue-500/40", accent: "bg-emerald-500", tag: "MOUNTAIN" },
];

export default function Home() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const { selectedRegion } = useRegionsStore();


  
  const [searchMode, setSearchMode] = useState<"STAYS" | "RENT" | "BUY" | "EXPERIENCES">("STAYS");
  const [searchLocation, setSearchLocation] = useState("");
  const [searchDate, setSearchDate] = useState("");
  const [searchGuests, setSearchGuests] = useState(1);
  const [searchPropertyType, setSearchPropertyType] = useState<string>("any");
  const [searchCondition, setSearchCondition] = useState<string>("any");
  
  const locationInputRef = useRef<HTMLInputElement>(null);
  const { provider, apiKey } = useMapProvider();

  useEffect(() => {
    if (provider === "google") {
      const initGoogleAutocomplete = () => {
        if (!locationInputRef.current || !(window as any).google?.maps?.places) return;
        
        const google = (window as any).google;
        const autocomplete = new google.maps.places.Autocomplete(locationInputRef.current, {
          types: ['(cities)'],
        });
        
        autocomplete.addListener("place_changed", () => {
          const place = autocomplete.getPlace();
          if (place && place.formatted_address) {
            setSearchLocation(place.formatted_address);
          } else if (place && place.name) {
            setSearchLocation(place.name);
          }
        });
      };

      if ((window as any).google?.maps?.places) {
        initGoogleAutocomplete();
        return;
      }

      const scriptId = "google-maps-places-script";
      let script = document.getElementById(scriptId) as HTMLScriptElement;

      if (!script) {
        script = document.createElement("script");
        script.id = scriptId;
        const key = apiKey.google || import.meta.env.VITE_GOOGLE_MAPS_API_KEY || "";
        script.src = `https://maps.googleapis.com/maps/api/js?key=${key}&libraries=places&loading=async`;
        script.async = true;
        script.defer = true;
        script.onload = initGoogleAutocomplete;
        document.head.appendChild(script);
      } else {
        script.addEventListener("load", initGoogleAutocomplete);
      }

      return () => {
        if (script) script.removeEventListener("load", initGoogleAutocomplete);
      };
    } else if (provider === "yandex") {
      const initYandexAutocomplete = () => {
        const ymaps = (window as any).ymaps;
        if (!locationInputRef.current || !ymaps) return;
        
        ymaps.ready(() => {
          if (!locationInputRef.current) return;
          const suggestView = new ymaps.SuggestView(locationInputRef.current);
          suggestView.events.add('select', (e: any) => {
            const item = e.get('item');
            if (item && item.value) {
              setSearchLocation(item.value);
            }
          });
        });
      };

      if ((window as any).ymaps) {
        initYandexAutocomplete();
        return;
      }

      const scriptId = "yandex-maps-script";
      let script = document.getElementById(scriptId) as HTMLScriptElement;

      if (!script) {
        script = document.createElement("script");
        script.id = scriptId;
        const key = apiKey.yandex || import.meta.env.VITE_YANDEX_MAPS_API_KEY || "";
        script.src = `https://api-maps.yandex.ru/2.1/?apikey=${key}&lang=en_US`;
        script.async = true;
        script.defer = true;
        script.onload = initYandexAutocomplete;
        document.head.appendChild(script);
      } else {
        script.addEventListener("load", initYandexAutocomplete);
      }

      return () => {
        if (script) script.removeEventListener("load", initYandexAutocomplete);
      };
    }
  }, [provider, apiKey]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    const params = new URLSearchParams();
    if (searchLocation) params.append("location", searchLocation);
    if (searchMode !== "BUY" && searchDate) params.append("date", searchDate);
    if (searchMode === "STAYS" && searchGuests > 1) params.append("guests", searchGuests.toString());
    if (searchPropertyType !== "any") params.append("propertyType", searchPropertyType);
    if (searchMode === "BUY" && searchCondition !== "any") params.append("condition", searchCondition);
    params.append("listingType", searchMode);
    
    navigate(`/property?${params.toString()}`);
  };

  const { data: rawResponse } = useQuery({
    queryKey: ["properties", "featured", selectedRegion?.countryCode],
    queryFn: () => propertyApi.getProperties(),
  });
  const response = rawResponse as any;

  const slides = useMemo(() => {
    if (!response?.data) return FALLBACK_SLIDES;
    return response.data.slice(0, 4).map((p: Property, i: number) => {
      const fallback = FALLBACK_SLIDES[i % FALLBACK_SLIDES.length];
      const rawImg = p.listings?.[0]?.pricingRules?.[0]?.discountRules?.image;
      const finalImage = (rawImg && typeof rawImg === 'string' && rawImg.length > 10) ? rawImg : fallback.image;
      
      return {
        ...fallback,
        title: p.name || fallback.title,
        location: p.address || fallback.location,
        price: p.price ? `$${Number(p.price).toLocaleString()}` : fallback.price,
        image: finalImage,
      };
    });
  }, [response]);

  const [current, setCurrent] = useState(0);
  const [heroLoaded, setHeroLoaded] = useState(false);
  useEffect(() => { setTimeout(() => setHeroLoaded(true), 100); }, []);

  // Auto-advance slider
  useEffect(() => { const iv = setInterval(() => setCurrent(c => (c + 1) % slides.length), 6000); return () => clearInterval(iv); }, [slides.length]);
  const prev = useCallback(() => setCurrent(c => (c - 1 + slides.length) % slides.length), [slides.length]);
  const next = useCallback(() => setCurrent(c => (c + 1) % slides.length), [slides.length]);

  const slide = slides[current] || slides[0];

  return (
    <>
      <Helmet>
        <title>Reservatior</title>
        <meta name="description" content="Instant AI valuations, cinematic video tours, and smart property analytics." />
      </Helmet>

      <div className="min-h-screen bg-background text-foreground overflow-x-hidden">

        {/* ══════ HERO WITH SLIDER ══════ */}
        <section className="relative min-h-[92vh] flex items-center overflow-hidden">
          {/* Slide Background */}
          {slides.map((s: any, i: number) => (
            <div key={i} 
                 className={`absolute inset-0 bg-black transition-opacity duration-1000 ${i === current ? "opacity-100 z-0" : "opacity-0 -z-10"}`}>
              <img src={s.image} alt={s.title} className="absolute inset-0 w-full h-full object-cover opacity-80" />
              <div className="absolute inset-0 bg-linear-to-b from-black/60 via-black/20 to-black/80" />
            </div>
          ))}

          <div className={`relative z-10 container mx-auto px-6 flex flex-col items-center justify-center min-h-[92vh] transition-all duration-1000 ${heroLoaded ? "opacity-100 translate-y-0" : "opacity-0 translate-y-8"}`}>
            
            <div className="w-full max-w-4xl flex flex-col items-center text-center space-y-8 mt-[-10vh]">
              


              <h1 className="text-5xl sm:text-6xl lg:text-7xl font-black tracking-tight leading-tight text-white drop-shadow-2xl">
                <span className="block">{t('home.hero.title1', 'Find Your')}</span>
                <span className="block bg-linear-to-r from-blue-300 to-blue-300 bg-clip-text text-transparent drop-shadow-md">
                  {t('home.hero.title2', 'Dream Home')}
                </span>
              </h1>

              <p className="text-lg sm:text-xl text-white/95 font-medium max-w-2xl leading-relaxed drop-shadow-lg">
                {t('home.hero.subtitle', 'Discover extraordinary properties worldwide with AI insights, immersive virtual tours, and enterprise-grade data.')}
              </p>

              {/* SEARCH TABS */}
              <div className="flex justify-center items-center gap-2 md:gap-4 mb-6 mt-6 z-20 relative bg-white/90 dark:bg-black/40 backdrop-blur-md p-1.5 rounded-full border border-black/5 dark:border-white/10 mx-auto w-fit shadow-sm">
                <button 
                  type="button"
                  onClick={() => setSearchMode("STAYS")}
                  className={`px-6 py-2 rounded-full text-sm md:text-base font-bold transition-all ${searchMode === "STAYS" ? "bg-blue-600 text-white shadow-lg" : "text-slate-600 hover:text-slate-900 hover:bg-black/5 dark:text-white/80 dark:hover:text-white dark:hover:bg-white/10"}`}
                >{t('home.search.mode_stays', 'Stays')}</button>
                <button 
                  type="button"
                  onClick={() => setSearchMode("RENT")}
                  className={`px-6 py-2 rounded-full text-sm md:text-base font-bold transition-all ${searchMode === "RENT" ? "bg-blue-600 text-white shadow-lg" : "text-slate-600 hover:text-slate-900 hover:bg-black/5 dark:text-white/80 dark:hover:text-white dark:hover:bg-white/10"}`}
                >{t('home.search.mode_rent', 'Rent')}</button>
                <button 
                  type="button"
                  onClick={() => setSearchMode("BUY")}
                  className={`px-6 py-2 rounded-full text-sm md:text-base font-bold transition-all ${searchMode === "BUY" ? "bg-blue-600 text-white shadow-lg" : "text-slate-600 hover:text-slate-900 hover:bg-black/5 dark:text-white/80 dark:hover:text-white dark:hover:bg-white/10"}`}
                >{t('home.search.mode_buy', 'Buy')}</button>
                <button 
                  type="button"
                  onClick={() => setSearchMode("EXPERIENCES")}
                  className={`px-6 py-2 rounded-full text-sm md:text-base font-bold transition-all ${searchMode === "EXPERIENCES" ? "bg-blue-600 text-white shadow-lg" : "text-slate-600 hover:text-slate-900 hover:bg-black/5 dark:text-white/80 dark:hover:text-white dark:hover:bg-white/10"}`}
                >{t('home.search.mode_experiences', 'Experiences')}</button>
              </div>

              {/* Glassmorphic Search Pill */}
              <form onSubmit={handleSearch} className="w-full max-w-5xl bg-background/95 dark:bg-black/60 backdrop-blur-3xl border border-border/50 p-2 rounded-3xl md:rounded-full flex flex-col md:flex-row items-center gap-2 shadow-[0_30px_60px_-15px_rgba(0,0,0,0.5)] relative z-20">
                {/* Where Segment */}
                <div className="flex-[1.5] px-6 py-2 w-full md:w-auto hover:bg-blue-50/50 dark:hover:bg-blue-900/20 rounded-full transition-colors text-left flex flex-col justify-center">
                  <label htmlFor="search-location" className="text-xs font-bold tracking-wider text-blue-600 dark:text-blue-400 mb-0.5 cursor-pointer">{t('home.search.where', 'Where')}</label>
                  <input 
                    id="search-location"
                    ref={locationInputRef}
                    type="text" 
                    value={searchLocation}
                    onChange={(e) => setSearchLocation(e.target.value)}
                    placeholder={t('home.search.where_hint', 'City, neighborhood, or address') as string}
                    className="bg-transparent border-none focus:outline-none focus:ring-0 text-sm text-foreground w-full p-0 m-0 placeholder:text-muted-foreground font-medium truncate"
                  />
                </div>
                <div className="hidden md:block w-px h-12 bg-border/50" />
                
                {/* When Segment - Hidden for BUY */}
                {searchMode !== "BUY" && (
                  <>
                    <div className="flex-1 px-6 py-2 w-full md:w-auto hover:bg-blue-50/50 dark:hover:bg-blue-900/20 rounded-full transition-colors text-left flex flex-col justify-center">
                      <label htmlFor="search-date" className="text-xs font-bold tracking-wider text-blue-600 dark:text-blue-400 mb-0.5 cursor-pointer">{t('home.search.when', 'When')}</label>
                      <input 
                        id="search-date"
                        type="date"
                        value={searchDate}
                        onChange={(e) => setSearchDate(e.target.value)}
                        className="bg-transparent border-none focus:outline-none focus:ring-0 text-sm text-foreground w-full p-0 m-0 placeholder:text-muted-foreground font-medium"
                      />
                    </div>
                    <div className="hidden md:block w-px h-12 bg-border/50" />
                  </>
                )}
                
                {/* Who Segment - Only for STAYS & EXPERIENCES */}
                {(searchMode === "STAYS" || searchMode === "EXPERIENCES") && (
                  <>
                    <div className="flex-1 px-6 py-2 w-full md:w-auto hover:bg-blue-50/50 dark:hover:bg-blue-900/20 rounded-full transition-colors text-left flex flex-col justify-center">
                      <label htmlFor="search-guests" className="text-xs font-bold tracking-wider text-blue-600 dark:text-blue-400 mb-0.5 cursor-pointer">{t('home.search.who', 'Who')}</label>
                      <div className="relative">
                        <select 
                          id="search-guests"
                          value={searchGuests}
                          onChange={(e) => setSearchGuests(Number(e.target.value))}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-sm text-foreground w-full p-0 m-0 font-medium cursor-pointer appearance-none pr-6"
                        >
                          <option value={1} className="bg-background text-foreground">{t('home.search.guest_1', '1 Guest')}</option>
                          <option value={2} className="bg-background text-foreground">{t('home.search.guest_2', '2 Guests')}</option>
                          <option value={3} className="bg-background text-foreground">{t('home.search.guest_3', '3 Guests')}</option>
                          <option value={4} className="bg-background text-foreground">{t('home.search.guest_4', '4+ Guests')}</option>
                        </select>
                        <ChevronDown className="absolute right-0 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground pointer-events-none" />
                      </div>
                    </div>
                    <div className="hidden md:block w-px h-12 bg-border/50" />
                  </>
                )}

                {/* Condition Segment - Only for BUY */}
                {searchMode === "BUY" && (
                  <>
                    <div className="flex-1 px-6 py-2 w-full md:w-auto hover:bg-blue-50/50 dark:hover:bg-blue-900/20 rounded-full transition-colors text-left flex flex-col justify-center">
                      <label htmlFor="search-condition" className="text-xs font-bold tracking-wider text-blue-600 dark:text-blue-400 mb-0.5 cursor-pointer">{t('home.search.condition', 'Condition')}</label>
                      <div className="relative">
                        <select 
                          id="search-condition"
                          value={searchCondition}
                          onChange={(e) => setSearchCondition(e.target.value)}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-sm text-foreground w-full p-0 m-0 font-medium cursor-pointer appearance-none truncate pr-6"
                        >
                          <option value="any" className="bg-background text-foreground">{t('home.search.cond_any', 'Any')}</option>
                          <option value="new_project" className="bg-background text-foreground">{t('home.search.cond_new', 'New Projects')}</option>
                          <option value="second_hand" className="bg-background text-foreground">{t('home.search.cond_second', 'Second Hand')}</option>
                        </select>
                        <ChevronDown className="absolute right-0 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground pointer-events-none" />
                      </div>
                    </div>
                    <div className="hidden md:block w-px h-12 bg-border/50" />
                  </>
                )}

                {/* Property Type Segment */}
                {searchMode !== "EXPERIENCES" && (
                <div className="flex-1 px-6 py-2 w-full md:w-auto hover:bg-blue-50/50 dark:hover:bg-blue-900/20 rounded-full transition-colors text-left flex flex-col justify-center">
                  <label htmlFor="search-property-type" className="text-xs font-bold tracking-wider text-blue-600 dark:text-blue-400 mb-0.5 cursor-pointer">{t('home.search.property_type', 'Property Type')}</label>
                  <div className="relative">
                    <select 
                      id="search-property-type"
                      value={searchPropertyType}
                      onChange={(e) => setSearchPropertyType(e.target.value)}
                      className="bg-transparent border-none focus:outline-none focus:ring-0 text-sm text-foreground w-full p-0 m-0 font-medium cursor-pointer appearance-none truncate pr-6"
                    >
                      <option value="any" className="bg-background text-foreground">{t('home.search.pt_any', 'Any')}</option>
                      {[
                        "DETACHED_HOUSE", "SEMI_DETACHED_HOUSE", "TERRACED_HOUSE", "TOWNHOUSE", 
                        "SINGLE_FAMILY", "MULTI_FAMILY", "BUNGALOW", "COTTAGE", "VILLA", 
                        "CABIN_TINY_HOUSE", "ADU_GUEST_HOUSE", "COMPOUND", "APARTMENT", 
                        "CONDO_APARTMENT", "FLAT_MAISONETTE", "STUDIO", "PENTHOUSE", "OFFICE", 
                        "RETAIL", "COMMERCIAL_SPACE", "COMMERCIAL"
                      ].map((pt) => {
                        const key = `client.property.types.${pt}`;
                        const translated = t(key);
                        const displayLabel = translated !== key ? translated : pt;
                        return (
                          <option key={pt} value={pt} className="bg-background text-foreground">
                            {displayLabel}
                          </option>
                        );
                      })}
                    </select>
                    <ChevronDown className="absolute right-0 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground pointer-events-none" />
                  </div>
                </div>
                )}

                {/* Search Buttons */}
                <div className="w-full md:w-auto mt-2 md:mt-0 flex gap-2">
                  <Button type="submit" className="flex-1 md:flex-none md:w-16 h-14 md:h-16 rounded-full bg-linear-to-br from-blue-600 to-blue-500 hover:from-blue-500 hover:to-blue-400 text-white shadow-xl shadow-blue-500/30 p-0 flex items-center justify-center transition-all hover:scale-105" title={t('home.search.button', 'Search') as string}>
                    <Search className="w-6 h-6" />
                    <span className="md:hidden ml-2 font-bold">{t('home.search.button', 'Search')}</span>
                  </Button>
                  <Button type="button" onClick={() => navigate('/ai-search')} className="flex-1 md:flex-none md:w-16 h-14 md:h-16 rounded-full bg-linear-to-br from-indigo-500 to-purple-600 hover:from-indigo-400 hover:to-purple-500 text-white shadow-xl shadow-indigo-500/30 p-0 flex items-center justify-center transition-all hover:scale-105 group" title={t('home.search.ai_search_tooltip', 'Search with AI') as string}>
                    <Sparkles className="w-6 h-6 group-hover:scale-110 transition-transform" />
                    <span className="md:hidden ml-2 font-bold">{t('home.search.ai_button', 'AI Search')}</span>
                  </Button>
                </div>
              </form>

              {/* Vibe Chips */}
              <div className="flex flex-wrap justify-center gap-3 pt-6">
                {[
                  { key: 'home.vibes.beachfront', default: '🏖️ Beachfront' },
                  { key: 'home.vibes.mansions', default: '🏛️ Mansions' },
                  { key: 'home.vibes.penthouses', default: '🏙️ Penthouses' },
                  { key: 'home.vibes.mountains', default: '⛰️ Mountains' },
                  { key: 'home.vibes.modern', default: '📐 Modern' }
                ].map(vibe => (
                  <Badge key={vibe.key} variant="outline" className="px-5 py-2.5 rounded-full border-border/30 bg-background/80 dark:bg-black/40 backdrop-blur-xl text-foreground hover:bg-primary hover:text-primary-foreground hover:border-primary transition-all cursor-pointer shadow-lg text-sm font-bold">
                    {t(vibe.key, vibe.default)}
                  </Badge>
                ))}
              </div>
            </div>

            {/* Slide Info & Controls (Bottom) */}
            <div className="absolute bottom-8 left-6 right-6 flex flex-col md:flex-row justify-between items-end md:items-center gap-6 pointer-events-none">
              
              <div className="flex items-center gap-4 bg-background/80 dark:bg-black/60 backdrop-blur-2xl border border-border/20 rounded-full p-2 pr-6 shadow-2xl pointer-events-auto">
                <div className="flex items-center justify-center w-12 h-12 rounded-full bg-primary/10">
                  <MapPin className="w-5 h-5 text-primary" />
                </div>
                <div>
                  <div className="text-foreground font-bold text-sm md:text-base leading-tight">{slide.title}</div>
                  <div className="text-muted-foreground text-xs md:text-sm font-medium">{slide.location} • {slide.price}</div>
                </div>
              </div>

              <div className="flex items-center gap-3 bg-background/80 dark:bg-black/60 backdrop-blur-2xl border border-border/20 rounded-full p-2 shadow-2xl pointer-events-auto">
                <button onClick={prev} className="w-10 h-10 rounded-full flex items-center justify-center hover:bg-muted transition-colors group">
                  <ChevronLeft className="w-5 h-5 text-foreground group-hover:-translate-x-0.5 transition-transform" />
                </button>
                <div className="flex gap-2 mx-1">
                  {slides.map((_: any, i: number) => (
                    <button key={i} onClick={() => setCurrent(i)}
                      className={`h-2 rounded-full transition-all duration-500 ${i === current ? "w-8 bg-primary" : "w-2 bg-muted-foreground/30 hover:bg-muted-foreground/60"}`} />
                  ))}
                </div>
                <button onClick={next} className="w-10 h-10 rounded-full flex items-center justify-center hover:bg-muted transition-colors group">
                  <ChevronRight className="w-5 h-5 text-foreground group-hover:translate-x-0.5 transition-transform" />
                </button>
              </div>
            </div>

          </div>
        </section>

        {/* ══════ STATS ══════ */}
        <section className="py-16 border-y border-border/50">
          <div className="container mx-auto px-6">
            <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
              {[
                { value: 50000, suffix: "+", label: t("home.stats.managed_properties", "Managed Properties"), icon: Building2 },
                { value: 12000, suffix: "+", label: t("home.stats.active_users", "Active Users"), icon: Users },
                { value: 98, suffix: "%", label: t("home.stats.satisfaction", "Satisfaction"), icon: Star },
                { value: 94, suffix: "%", label: t("home.stats.ai_accuracy", "AI Accuracy"), icon: Bot },
              ].map((s, i) => (
                <div key={i} className="text-center space-y-2">
                  <s.icon className="w-6 h-6 mx-auto text-primary/60" />
                  <div className="text-3xl font-black text-foreground"><AnimatedCounter target={s.value} suffix={s.suffix} /></div>
                  <div className="text-xs text-muted-foreground font-medium tracking-wider">{s.label}</div>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* ══════ FEATURES BENTO ══════ */}
        <section className="py-24">
          <div className="container mx-auto px-6">
            <div className="text-center mb-16 space-y-3">
              <Badge className="bg-primary/10 text-primary border-primary/20 px-4 py-1 rounded-full text-xs font-semibold tracking-wider">
                {t("home.features.badge", "Platform Features")}
              </Badge>
              <h2 className="text-3xl lg:text-4xl font-black text-foreground">
                {t("home.features.title1", "Everything")} <span className="text-primary">{t("home.features.title2", "In One Platform")}</span>
              </h2>
              <p className="text-muted-foreground max-w-xl mx-auto">{t("home.features.subtitle", "Transform property management completely with our AI-powered tools")}</p>
            </div>

            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
              {[
                { icon: Bot, title: t("home.features.valuation.title", "AI Valuation Engine"), desc: t("home.features.valuation.desc", "Instant property valuations and market forecasting with 94% accuracy"), color: "text-blue-500" },
                { icon: Video, title: t("home.features.video.title", "Cinematic Video Tours"), desc: t("home.features.video.desc", "Turn your photos into professional real estate videos with AI"), color: "text-violet-500" },
                { icon: BarChart3, title: t("home.features.analytics.title", "Real-time Analytics"), desc: t("home.features.analytics.desc", "Portfolio performance, revenue tracking, and trend analysis"), color: "text-emerald-500" },
                { icon: Shield, title: t("home.features.blockchain.title", "Blockchain Verification"), desc: t("home.features.blockchain.desc", "Prevent fraud with title and contract verification"), color: "text-amber-500" },
                { icon: Globe2, title: t("home.features.distribution.title", "Global Distribution"), desc: t("home.features.distribution.desc", "Multi-language listing infrastructure published instantly in 150+ countries"), color: "text-blue-500" },
                { icon: Zap, title: t("home.features.automation.title", "Smart Automation"), desc: t("home.features.automation.desc", "Automate pricing, booking, and communication processes"), color: "text-rose-500" },
              ].map((f, i) => (
                <div key={i} className="group p-7 rounded-2xl bg-card border border-border/50 hover:border-primary/20 hover:shadow-lg transition-all duration-300 hover:-translate-y-1">
                  <div className={`w-11 h-11 rounded-xl bg-muted flex items-center justify-center mb-4 ${f.color} group-hover:scale-110 transition-transform`}>
                    <f.icon className="w-5 h-5" />
                  </div>
                  <h3 className="text-base font-bold text-foreground mb-2">{f.title}</h3>
                  <p className="text-sm text-muted-foreground leading-relaxed">{f.desc}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* ══════ VIDEO SHOWCASE ══════ */}
        <section className="py-24 bg-muted/30">
          <div className="container mx-auto px-6">
            <div className="grid lg:grid-cols-2 gap-14 items-center">
              <div className="space-y-6">
                <Badge className="bg-violet-500/10 text-violet-600 dark:text-violet-400 border-violet-500/20 px-4 py-1 rounded-full text-xs font-semibold tracking-wider">
                  {t("home.video.badge", "Video Platform")}
                </Badge>
                <h2 className="text-3xl lg:text-4xl font-black text-foreground leading-tight">
                  {t("home.video.title1", "From Photos")}<br /><span className="text-violet-600 dark:text-violet-400">{t("home.video.title2", "To Cinematic Videos")}</span>
                </h2>
                <p className="text-muted-foreground text-lg leading-relaxed">
                  {t("home.video.subtitle", "Our AI video engine transforms your real estate photos into professional cinematic tours in seconds.")}
                </p>
                <div className="space-y-3">
                  {[
                    t("home.video.feature1", "Smart scene sequencing and transitions"), 
                    t("home.video.feature2", "Multi-language AI voiceover support"), 
                    t("home.video.feature3", "Region-specific style templates"), 
                    t("home.video.feature4", "Automatic motion and parallax effects")
                  ].map((item, i) => (
                    <div key={i} className="flex items-center gap-3 text-muted-foreground text-sm">
                      <CheckCircle2 className="w-4 h-4 text-violet-500 shrink-0" /><span>{item}</span>
                    </div>
                  ))}
                </div>
                <Link to="/videos">
                  <Button className="bg-violet-600 hover:bg-violet-500 text-white px-6 h-11 rounded-xl font-semibold group mt-2">
                    {t("home.video.cta", "Explore Video Platform")} <ArrowRight className="ml-2 w-4 h-4 group-hover:translate-x-1 transition-transform" />
                  </Button>
                </Link>
              </div>
              {/* Video Preview */}
              <div className="relative rounded-2xl overflow-hidden border border-border/50 bg-linear-to-br from-violet-500/20 via-purple-500/10 to-blue-500/20 aspect-video shadow-xl">
                <div className="absolute inset-0 flex items-center justify-center">
                  <div className="w-20 h-20 rounded-full bg-white/20 dark:bg-white/10 backdrop-blur-md flex items-center justify-center border border-white/30 cursor-pointer hover:scale-110 transition-transform">
                    <Play className="w-8 h-8 text-foreground ml-1" />
                  </div>
                </div>
                <div className="absolute bottom-0 left-0 right-0 p-5 bg-linear-to-t from-background/80 to-transparent">
                  <p className="font-semibold text-foreground text-sm">{t("home.video.preview.title", "Burj Khalifa Residences — Virtual Tour")}</p>
                  <p className="text-muted-foreground text-xs">{t("home.video.preview.desc", "Reservatior AI Studio • 2.4M views")}</p>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* ══════ HOW IT WORKS ══════ */}
        <section className="py-24">
          <div className="container mx-auto px-6">
            <div className="text-center mb-16 space-y-3">
              <h2 className="text-3xl lg:text-4xl font-black text-foreground">
                {t("home.steps.title1", "Get Started in")} <span className="text-primary">{t("home.steps.title2", "3 Steps")}</span>
              </h2>
            </div>
            <div className="grid md:grid-cols-3 gap-6 max-w-4xl mx-auto">
              {[
                { step: "01", title: t("home.steps.step1.title", "Add Your Property"), desc: t("home.steps.step1.desc", "Upload property details and photos. AI auto-fills the details."), icon: HomeIcon },
                { step: "02", title: t("home.steps.step2.title", "Let AI Analyze"), desc: t("home.steps.step2.desc", "AI performs valuation, pricing, and market analysis."), icon: Sparkles },
                { step: "03", title: t("home.steps.step3.title", "Publish & Earn"), desc: t("home.steps.step3.desc", "Publish your listings in 150+ countries and manage bookings."), icon: TrendingUp },
              ].map((s, i) => (
                <div key={i} className="relative group p-7 rounded-2xl bg-card border border-border/50 hover:border-primary/20 hover:shadow-md transition-all text-center space-y-4">
                  <div className="text-5xl font-black text-muted/80 absolute top-3 right-5">{s.step}</div>
                  <div className="w-14 h-14 rounded-2xl bg-primary/10 flex items-center justify-center mx-auto text-primary">
                    <s.icon className="w-6 h-6" />
                  </div>
                  <h3 className="text-lg font-bold text-foreground">{s.title}</h3>
                  <p className="text-sm text-muted-foreground">{s.desc}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* ══════ CTA ══════ */}
        <section className="py-24">
          <div className="container mx-auto px-6">
            <div className="relative max-w-3xl mx-auto rounded-3xl overflow-hidden">
              <div className="absolute inset-0 bg-linear-to-r from-blue-600 via-violet-600 to-blue-600" />
              <div className="relative z-10 p-12 md:p-16 text-center space-y-6">
                <h2 className="text-3xl md:text-4xl font-black text-white">{t("home.cta.title", "Ready to Transform Your Real Estate Business?")}</h2>
                <p className="text-white/70 max-w-md mx-auto">{t("home.cta.subtitle", "Join thousands of professionals and experience the difference of AI-powered real estate management.")}</p>
                <div className="flex flex-wrap justify-center gap-4">
                  <Link to="/auth/signup"><Button size="lg" className="bg-white text-slate-900 hover:bg-white/90 px-8 h-13 font-bold rounded-2xl shadow-xl">{t("home.cta.button1", "Start Free Trial")}</Button></Link>
                  <Link to="/explore"><Button size="lg" variant="outline" className="border-white/30 text-white hover:bg-white/10 px-8 h-13 font-semibold rounded-2xl">{t("home.cta.button2", "Explore Features")}</Button></Link>
                </div>
                <p className="text-white/40 text-sm">{t("home.cta.guarantee", "No credit card required • Instant setup • Cancel anytime")}</p>
              </div>
            </div>
          </div>
        </section>
        
        {/* ══════ FLOATING AI BUTTON ══════ */}
        <Link to="/ai-search" className="fixed bottom-6 right-6 z-50 group flex items-center gap-3 bg-white dark:bg-neutral-900/90 backdrop-blur-xl p-2 pr-6 rounded-full shadow-2xl border border-indigo-500/20 hover:scale-105 transition-all duration-300">
          <div className="w-12 h-12 rounded-full bg-linear-to-br from-indigo-600 to-purple-600 flex items-center justify-center shadow-lg shadow-indigo-500/40">
            <Sparkles className="w-5 h-5 text-white animate-pulse" />
          </div>
          <div className="flex flex-col">
            <span className="text-[10px] font-black text-indigo-600 dark:text-indigo-400 tracking-widest uppercase">YENİ</span>
            <span className="text-sm font-bold text-foreground">Reservatior AI'ı Dene</span>
          </div>
        </Link>
      </div>
    </>
  );
}
