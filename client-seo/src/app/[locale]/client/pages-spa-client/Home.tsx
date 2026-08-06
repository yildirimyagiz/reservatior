"use client";

import { Helmet } from "react-helmet-async";
import { FAQPageSchema } from "@/components/seo/SchemaScript";
import { useTranslation } from "react-i18next";
import { Link, useNavigate } from "@/lib/react-router-shim";
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
  ChevronLeft, MapPin, Star, Users, Search, ChevronDown,
  Send, Mic, Bed, Bath, X, Paperclip
} from "lucide-react";
import Image from "next/image";

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
    gradient: "from-brand/40 via-blue-500/20 to-sky-500/40", accent: "bg-blue-600", tag: "EXCLUSIVE LISTING" },
  { title: "Neo-Tokyo Cyber Loft", location: "Shinjuku, Tokyo", price: "$12.4M", beds: 3, baths: 3, sqm: 500,
    image: "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=1920&q=80",
    gradient: "from-violet-600/40 via-brand/20 to-fuchsia-500/40", accent: "bg-violet-600", tag: "SMART HOME" },
  { title: "Monolithic Concrete Dream", location: "Beverly Hills, CA", price: "$16.2M", beds: 4, baths: 6, sqm: 820,
    image: "https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=1920&q=80",
    gradient: "from-amber-500/40 via-orange-400/20 to-red-500/40", accent: "bg-amber-500", tag: "PENTHOUSE" },
  { title: "Alpine Crystal Chalet", location: "Zermatt, Switzerland", price: "$14.5M", beds: 5, baths: 4, sqm: 670,
    image: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=1920&q=80",
    gradient: "from-blue-500/40 via-brand/20 to-blue-500/40", accent: "bg-success", tag: "MOUNTAIN" },
];

export default function Home() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const { selectedRegion } = useRegionsStore();

  // AI Search State
  const [showAIChat, setShowAIChat] = useState(false);
  const [aiMessages, setAiMessages] = useState<{ id: string; role: "user" | "ai"; text: string; properties?: { image: string; title: string; price: string; location: string; beds: string; baths: string }[] }[]>([]);
  const [aiInput, setAiInput] = useState("");
  const [aiIsLoading, setAiIsLoading] = useState(false);
  const aiMessagesEndRef = useRef<HTMLDivElement>(null);

  // Support Chat State
  const [showSupportChat, setShowSupportChat] = useState(false);
  const [supportMessages, setSupportMessages] = useState<{ id: string; role: "user" | "support" | "ai"; text: string; attachments?: string[] }[]>([]);
  const [supportInput, setSupportInput] = useState("");
  const [supportIsLoading, setSupportIsLoading] = useState(false);
  const [attachments, setAttachments] = useState<string[]>([]);
  const supportMessagesEndRef = useRef<HTMLDivElement>(null);

  // Traditional Search State
  const [searchMode, setSearchMode] = useState<"STAYS" | "RENT" | "BUY" | "EXPERIENCES">("STAYS");
  const [searchLocation, setSearchLocation] = useState("");
  const [searchDate, setSearchDate] = useState("");
  const [searchGuests, setSearchGuests] = useState(1);
  const [searchPropertyType, setSearchPropertyType] = useState<string>("any");
  const [searchCondition, setSearchCondition] = useState<string>("any");

  const locationInputRef = useRef<HTMLInputElement>(null);
  const { provider, apiKey } = useMapProvider();

  // AI Search Functions
  const scrollToBottom = () => {
    aiMessagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToBottom();
  }, [aiMessages, aiIsLoading]);

  const handleAISend = async () => {
    if (!aiInput.trim() || aiIsLoading) return;

    const userMessage = { id: Date.now().toString(), role: "user" as const, text: aiInput };
    setAiMessages((prev) => [...prev, userMessage]);
    setAiInput("");
    setAiIsLoading(true);

    try {
      const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000";
      const response = await fetch(`${API_URL}/ai-search`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ query: userMessage.text })
      });

      const data = await response.json();

      if (data.error) throw new Error(data.error);

      setAiMessages((prev) => [...prev, {
        id: (Date.now() + 1).toString(),
        role: "ai",
        text: data.text,
        properties: data.properties?.length > 0 ? data.properties : undefined
      }]);
    } catch {
      setAiMessages((prev) => [...prev, { id: Date.now().toString(), role: "ai", text: t("client.src.connection_error_please_try_again") }]);
    } finally {
      setAiIsLoading(false);
    }
  };

  // Support Chat Functions
  const scrollToSupportBottom = () => {
    supportMessagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToSupportBottom();
  }, [supportMessages]);

  const handleSupportSend = async () => {
    if (!supportInput.trim() && attachments.length === 0) return;

    const userMessage = { 
      id: Date.now().toString(), 
      role: "user" as const, 
      text: supportInput,
      attachments: attachments.length > 0 ? attachments : undefined
    };
    setSupportMessages((prev) => [...prev, userMessage]);
    setSupportInput("");
    setAttachments([]);
    setSupportIsLoading(true);

    // AI Support Suggestion
    try {
      const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000";
      const response = await fetch(`${API_URL}/api/v1/ticket/ai-suggest`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ message: userMessage.text, attachments: userMessage.attachments })
      });

      const data = await response.json();

      setSupportMessages((prev) => [...prev, {
        id: (Date.now() + 1).toString(),
        role: "ai",
        text: data.suggestion || "Sorununuzu anladım. Size yardımcı olmak için bir destek talebi oluşturuluyor...",
      }]);

      // Create ticket if needed
      if (data.createTicket) {
        const ticketResponse = await fetch(`${API_URL}/api/v1/ticket`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            subject: data.subject || "Destek Talebi",
            description: userMessage.text,
            priority: data.priority || "MEDIUM"
          })
        });
        const ticketData = await ticketResponse.json();

        setSupportMessages((prev) => [...prev, {
          id: (Date.now() + 2).toString(),
          role: "support",
          text: `Talebiniz oluşturuldu. Ticket ID: ${ticketData.id}. En kısa sürede size dönüş yapacağız.`
        }]);
      }
    } catch {
      setSupportMessages((prev) => [...prev, {
        id: (Date.now() + 1).toString(),
        role: "support",
        text: "Şu anda bağlantı sorunu yaşıyoruz. Lütfen daha sonra tekrar deneyin veya destek@reservatior.com adresine e-posta gönderin."
      }]);
    } finally {
      setSupportIsLoading(false);
    }
  };

  const handleFileUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (!files || files.length === 0) return;

    const file = files[0];
    const formData = new FormData();
    formData.append("file", file);

    try {
      const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000";
      const response = await fetch(`${API_URL}/api/v1/ticket/upload`, {
        method: "POST",
        body: formData
      });

      const data = await response.json();
      setAttachments(prev => [...prev, data.url]);
    } catch {
      console.error("Dosya yüklenirken hata oluştu");
    }
  };

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
        const key = apiKey.google || process.env.NEXT_PUBLIC_GOOGLE_MAPS_API_KEY || "";
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
        const key = apiKey.yandex || process.env.NEXT_PUBLIC_YANDEX_MAPS_API_KEY || "";
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
        <title>Reservatior - AI-Powered Real Estate Platform | Property Management</title>
        <meta name="description" content="Reservatior is the premium platform for direct bookings, AI-powered property valuations, cinematic video tours, and smart property management. Better prices, direct from owners." />
        <meta property="og:title" content="Reservatior - AI-Powered Real Estate Platform" />
        <meta property="og:description" content="Premium platform for direct bookings, AI valuations, and smart property management. Better prices, direct from owners." />
        <meta property="og:type" content="website" />
        <meta property="og:url" content={window.location.href} />
        <meta property="og:image" content="https://reservatior.com/og-image.svg" />
        <meta name="twitter:card" content="summary_large_image" />
        <meta name="twitter:title" content="Reservatior - AI-Powered Real Estate Platform" />
        <meta name="twitter:description" content="Premium platform for direct bookings, AI valuations, and smart property management." />
        <link rel="canonical" href={window.location.href} />
      </Helmet>

      <div className="min-h-screen bg-background text-foreground overflow-x-hidden">

        {/* ══════ HERO WITH SLIDER ══════ */}
        <section className="relative min-h-[92vh] flex items-center overflow-hidden">
          {/* Slide Background */}
          {slides.map((s: any, i: number) => (
            <div key={i} 
                 className={`absolute inset-0 bg-black transition-opacity duration-1000 ${i === current ? "opacity-100 z-0" : "opacity-0 -z-10"}`}>
              <Image src={s.image} alt={s.title} fill className="object-cover opacity-80" loading="lazy" sizes="100vw" />
              <div className="absolute inset-0 bg-gradient-to-b from-black/60 via-black/20 to-black/80" />
            </div>
          ))}

          <div className={`relative z-10 container mx-auto px-6 flex flex-col items-center justify-center min-h-[92vh] transition-all duration-1000 ${heroLoaded ? "opacity-100 translate-y-0" : "opacity-0 translate-y-8"}`}>
            
            <div className="w-full max-w-4xl flex flex-col items-center text-center space-y-8 mt-[-10vh]">
              


              <h1 className="text-5xl sm:text-6xl lg:text-7xl font-black tracking-tight leading-tight text-white drop-shadow-2xl">
                <span className="block">{t('home.hero.title1', 'Find Your')}</span>
                <span className="block bg-gradient-to-r from-blue-300 to-blue-300 bg-clip-text text-transparent drop-shadow-md">
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
                  className={`px-6 py-2 rounded-full text-sm md:text-base font-bold transition-all ${searchMode === "STAYS" ? "bg-blue-600 text-white shadow-lg" : "text-muted-foreground hover:text-foreground hover:bg-black/5 dark:text-white/80 dark:hover:text-white dark:hover:bg-white/10"}`}
                >{t('home.search.mode_stays', 'Booking')}</button>
                <button 
                  type="button"
                  onClick={() => setSearchMode("RENT")}
                  className={`px-6 py-2 rounded-full text-sm md:text-base font-bold transition-all ${searchMode === "RENT" ? "bg-blue-600 text-white shadow-lg" : "text-muted-foreground hover:text-foreground hover:bg-black/5 dark:text-white/80 dark:hover:text-white dark:hover:bg-white/10"}`}
                >{t('home.search.mode_rent', 'Rent')}</button>
                <button 
                  type="button"
                  onClick={() => setSearchMode("BUY")}
                  className={`px-6 py-2 rounded-full text-sm md:text-base font-bold transition-all ${searchMode === "BUY" ? "bg-blue-600 text-white shadow-lg" : "text-muted-foreground hover:text-foreground hover:bg-black/5 dark:text-white/80 dark:hover:text-white dark:hover:bg-white/10"}`}
                >{t('home.search.mode_buy', 'For Rent / For Sale')}</button>
                <button 
                  type="button"
                  onClick={() => setSearchMode("EXPERIENCES")}
                  className={`px-6 py-2 rounded-full text-sm md:text-base font-bold transition-all ${searchMode === "EXPERIENCES" ? "bg-blue-600 text-white shadow-lg" : "text-muted-foreground hover:text-foreground hover:bg-black/5 dark:text-white/80 dark:hover:text-white dark:hover:bg-white/10"}`}
                >{t('home.search.mode_experiences', 'Experiences')}</button>
              </div>

              {/* Glassmorphic Search Pill */}
              <form onSubmit={handleSearch} className="w-full max-w-5xl bg-background/95 dark:bg-black/60 backdrop-blur-3xl border border-border/50 p-2 rounded-3xl md:rounded-full flex flex-col md:flex-row items-center gap-2 shadow-[0_30px_60px_-15px_rgba(0,0,0,0.5)] relative z-20">
                {/* Where Segment */}
                <div className="flex-[1.5] px-6 py-2 w-full md:w-auto hover:bg-brand/10/50 dark:hover:bg-blue-900/20 rounded-full transition-colors text-left flex flex-col justify-center">
                  <label htmlFor="search-location" className="text-xs font-bold tracking-wider text-brand dark:text-brand mb-0.5 cursor-pointer">{t('home.search.where', 'Where')}</label>
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
                    <div className="flex-1 px-6 py-2 w-full md:w-auto hover:bg-brand/10/50 dark:hover:bg-blue-900/20 rounded-full transition-colors text-left flex flex-col justify-center">
                      <label htmlFor="search-date" className="text-xs font-bold tracking-wider text-brand dark:text-brand mb-0.5 cursor-pointer">{t('home.search.dates', 'Dates')}</label>
                      <input 
                        id="search-date"
                        type="date"
                        value={searchDate}
                        onChange={(e) => setSearchDate(e.target.value)}
                        placeholder={t('home.search.dates_hint', 'dd.mm.yyyy') as string}
                        className="bg-transparent border-none focus:outline-none focus:ring-0 text-sm text-foreground w-full p-0 m-0 placeholder:text-muted-foreground font-medium"
                      />
                    </div>
                    <div className="hidden md:block w-px h-12 bg-border/50" />
                  </>
                )}
                
                {/* Who Segment - Only for STAYS & EXPERIENCES */}
                {(searchMode === "STAYS" || searchMode === "EXPERIENCES") && (
                  <>
                    <div className="flex-1 px-6 py-2 w-full md:w-auto hover:bg-brand/10/50 dark:hover:bg-blue-900/20 rounded-full transition-colors text-left flex flex-col justify-center">
                      <label htmlFor="search-guests" className="text-xs font-bold tracking-wider text-brand dark:text-brand mb-0.5 cursor-pointer">{t('home.search.who', 'Who')}</label>
                      <div className="relative">
                        <select 
                          id="search-guests"
                          value={searchGuests}
                          onChange={(e) => setSearchGuests(Number(e.target.value))}
                          className="bg-transparent border-none focus:outline-none focus:ring-0 text-sm text-foreground w-full p-0 m-0 font-medium cursor-pointer appearance-none pr-6"
                        >
                          <option value={1} className="bg-background text-foreground">{t('home.search.guest_1', 'Guest 1')}</option>
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
                    <div className="flex-1 px-6 py-2 w-full md:w-auto hover:bg-brand/10/50 dark:hover:bg-blue-900/20 rounded-full transition-colors text-left flex flex-col justify-center">
                      <label htmlFor="search-condition" className="text-xs font-bold tracking-wider text-brand dark:text-brand mb-0.5 cursor-pointer">{t('home.search.condition', 'Condition')}</label>
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
                <div className="flex-1 px-6 py-2 w-full md:w-auto hover:bg-brand/10/50 dark:hover:bg-blue-900/20 rounded-full transition-colors text-left flex flex-col justify-center">
                  <label htmlFor="search-property-type" className="text-xs font-bold tracking-wider text-brand dark:text-brand mb-0.5 cursor-pointer">{t('home.search.property_type', 'Property Type')}</label>
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
                  <Button type="submit" className="flex-1 md:flex-none md:w-16 h-14 md:h-16 rounded-full bg-gradient-to-br from-brand to-blue-500 hover:from-blue-500 hover:to-blue-400 text-white shadow-xl shadow-blue-500/30 p-0 flex items-center justify-center transition-all hover:scale-105" title={t('home.search.button', 'Search') as string}>
                    <Search className="w-6 h-6" />
                    <span className="md:hidden ml-2 font-bold">{t('home.search.button', 'Search')}</span>
                  </Button>
                  <Button type="button" onClick={() => setShowAIChat(true)} className="flex-1 md:flex-none md:w-auto px-6 h-14 md:h-16 rounded-full bg-gradient-to-br from-brand to-brand hover:from-brand hover:to-brand text-white shadow-xl shadow-indigo-500/30 flex items-center justify-center gap-2 transition-all hover:scale-105 group" title={t('home.search.ai_search_tooltip', 'Search with AI') as string}>
                    <Sparkles className="w-5 h-5 group-hover:scale-110 transition-transform" />
                    <span className="text-xs font-black uppercase tracking-widest">{t('home.search.search_with_ai', 'Search With Ai')}</span>
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
                <button onClick={prev} aria-label="Previous slide" className="w-10 h-10 rounded-full flex items-center justify-center hover:bg-muted transition-colors group">
                  <ChevronLeft className="w-5 h-5 text-foreground group-hover:-translate-x-0.5 transition-transform" />
                </button>
                <div className="flex gap-2 mx-1">
                  {slides.map((_: any, i: number) => (
                    <button key={i} onClick={() => setCurrent(i)} aria-label={`Go to slide ${i + 1}`}
                      className={`h-2 rounded-full transition-all duration-500 ${i === current ? "w-8 bg-primary" : "w-2 bg-muted-foreground/30 hover:bg-muted-foreground/60"}`} />
                  ))}
                </div>
                <button onClick={next} aria-label="Next slide" className="w-10 h-10 rounded-full flex items-center justify-center hover:bg-muted transition-colors group">
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
                { icon: Bot, title: t("home.features.valuation.title", "AI Valuation Engine"), desc: t("home.features.valuation.desc", "Instant property valuations and market forecasting with 94% accuracy"), color: "text-brand" },
                { icon: Video, title: t("home.features.video.title", "Cinematic Video Tours"), desc: t("home.features.video.desc", "Turn your photos into professional real estate videos with AI"), color: "text-violet-500" },
                { icon: BarChart3, title: t("home.features.analytics.title", "Real-time Analytics"), desc: t("home.features.analytics.desc", "Portfolio performance, revenue tracking, and trend analysis"), color: "text-success" },
                { icon: Shield, title: t("home.features.blockchain.title", "Blockchain Verification"), desc: t("home.features.blockchain.desc", "Prevent fraud with title and contract verification"), color: "text-amber-500" },
                { icon: Globe2, title: t("home.features.distribution.title", "Global Distribution"), desc: t("home.features.distribution.desc", "Multi-language listing infrastructure published instantly in 150+ countries"), color: "text-brand" },
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
              <div className="relative rounded-2xl overflow-hidden border border-border/50 bg-gradient-to-br from-violet-500/20 via-brand/10 to-blue-500/20 aspect-video shadow-xl">
                <div className="absolute inset-0 flex items-center justify-center">
                  <div className="w-20 h-20 rounded-full bg-white/20 dark:bg-white/10 backdrop-blur-md flex items-center justify-center border border-white/30 cursor-pointer hover:scale-110 transition-transform">
                    <Play className="w-8 h-8 text-foreground ml-1" />
                  </div>
                </div>
                <div className="absolute bottom-0 left-0 right-0 p-5 bg-gradient-to-t from-background/80 to-transparent">
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
              <div className="absolute inset-0 bg-gradient-to-r from-brand via-violet-600 to-brand" />
              <div className="relative z-10 p-12 md:p-16 text-center space-y-6">
                <h2 className="text-3xl md:text-4xl font-black text-white">{t("home.cta.title", "Ready to Transform Your Real Estate Business?")}</h2>
                <p className="text-white/70 max-w-md mx-auto">{t("home.cta.subtitle", "Join thousands of professionals and experience the difference of AI-powered real estate management.")}</p>
                <div className="flex flex-wrap justify-center gap-4">
                  <Link to="/auth/signup"><Button size="lg" className="bg-card text-foreground hover:bg-white/90 px-8 h-13 font-bold rounded-2xl shadow-xl">{t("home.cta.button1", "Start Free Trial")}</Button></Link>
                  <Link to="/explore"><Button size="lg" variant="outline" className="border-white/30 text-white hover:bg-white/10 px-8 h-13 font-semibold rounded-2xl">{t("home.cta.button2", "Explore Features")}</Button></Link>
                </div>
                <p className="text-white/40 text-sm">{t("home.cta.guarantee", "No credit card required • Instant setup • Cancel anytime")}</p>
              </div>
            </div>
          </div>
        </section>
        
        {/* ══════ FLOATING SUPPORT BUTTON ══════ */}
        <button onClick={() => setShowSupportChat(true)} className="fixed bottom-6 right-6 z-50 group flex items-center gap-3 bg-card dark:bg-neutral-900/90 backdrop-blur-xl p-2 pr-6 rounded-full shadow-2xl border border-blue-500/20 hover:scale-105 transition-all duration-300">
          <div className="w-12 h-12 rounded-full bg-gradient-to-br from-blue-500 to-cyan-500 flex items-center justify-center shadow-lg shadow-blue-500/40">
            <Bot className="w-5 h-5 text-white animate-pulse" />
          </div>
          <div className="flex flex-col">
            <span className="text-[10px] font-black text-brand dark:text-brand tracking-widest uppercase">SUPPORT</span>
            <span className="text-sm font-bold text-foreground">Live Help</span>
          </div>
        </button>

        {/* ══════ AI CHAT MODAL ══════ */}
        {showAIChat && (
          <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-neutral-900/40 dark:bg-black/60 backdrop-blur-sm">
            <div className="w-full max-w-4xl h-[85vh] bg-[#fafafa] dark:bg-[#0a0a0c] rounded-3xl shadow-2xl overflow-hidden relative flex flex-col border border-white/60 dark:border-border">
              {/* Header */}
              <div className="flex-none p-6 flex justify-between items-center border-b border-white/40 dark:border-border/40 bg-white/30 dark:bg-background/30 backdrop-blur-xl">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-brand to-brand flex items-center justify-center shadow-lg shadow-indigo-500/30">
                    <Sparkles className="w-5 h-5 text-white" />
                  </div>
                  <span className="font-bold text-2xl tracking-tight bg-clip-text text-transparent bg-gradient-to-r from-brand to-neutral-800 dark:from-white dark:to-slate-300">
                    Reservatior AI
                  </span>
                </div>
                <button onClick={() => setShowAIChat(false)} aria-label="Close AI chat" className="p-2 rounded-full hover:bg-neutral-200 dark:hover:bg-muted transition-colors">
                  <X className="w-6 h-6 text-neutral-600 dark:text-muted-foreground" />
                </button>
              </div>

              {/* Chat Area */}
              <div className="flex-1 overflow-y-auto p-4 md:p-8 scroll-smooth">
                <div className="max-w-4xl mx-auto space-y-8 pb-10">
                  {aiMessages.length === 0 && (
                    <div className="flex flex-col items-center justify-center h-[40vh] text-center space-y-8">
                      <div className="relative group">
                        <div className="absolute -inset-4 bg-gradient-to-r from-brand to-brand rounded-full blur-xl opacity-30 group-hover:opacity-50 transition duration-1000 animate-pulse" />
                        <div className="relative w-20 h-20 bg-white/80 dark:bg-background/80 backdrop-blur-xl border border-white/60 dark:border-border/60 rounded-3xl flex items-center justify-center shadow-2xl">
                          <Sparkles className="w-10 h-10 text-brand dark:text-brand" />
                        </div>
                      </div>

                      <div className="space-y-4">
                        <h1 className="text-5xl md:text-6xl font-extrabold tracking-tight text-neutral-900 dark:text-white drop-shadow-sm">
                          {t("client.src.what_kind_of_place_are_you_looking_for").split(" ")[0]} <span className="text-transparent bg-clip-text bg-gradient-to-r from-brand to-brand dark:from-brand dark:to-brand">{t("client.src.what_kind_of_place_are_you_looking_for").split(" ").slice(1).join(" ")}</span>
                        </h1>
                        <p className="text-neutral-500 dark:text-muted-foreground text-xl max-w-2xl mx-auto font-medium">
                          {t("client.src.dont_bother_with_filters_describe_your_dream_home")}
                        </p>
                      </div>

                      <div className="flex flex-wrap justify-center gap-3 mt-8 max-w-3xl">
                        {[t("client.src.suggestion_1"), t("client.src.suggestion_2"), t("client.src.suggestion_3"), t("client.src.suggestion_4")].map((suggestion) => (
                          <button
                            key={suggestion}
                            onClick={() => setAiInput(suggestion)}
                            className="px-5 py-3 bg-white/60 dark:bg-muted/40 backdrop-blur-md border border-white dark:border-border hover:border-brand/30 dark:hover:border-brand/50 rounded-2xl text-sm font-semibold text-neutral-700 dark:text-muted-foreground hover:text-brand dark:hover:text-brand hover:bg-white/90 dark:hover:bg-muted/80 hover:shadow-lg hover:shadow-indigo-500/10 dark:hover:shadow-indigo-500/5 transition-all active:scale-95"
                          >
                            {suggestion}
                          </button>
                        ))}
                      </div>
                    </div>
                  )}

                  {aiMessages.map((msg) => (
                    <div key={msg.id} className={`flex flex-col ${msg.role === "user" ? "items-end" : "items-start"}`}>
                      <div className={`
                        max-w-[85%] md:max-w-[70%] rounded-4xl p-5 px-6 shadow-sm
                        ${msg.role === "user"
                          ? "bg-gradient-to-br from-brand to-brand text-white rounded-br-md shadow-indigo-500/20"
                          : "bg-white/80 dark:bg-muted/60 backdrop-blur-xl border border-white/80 dark:border-border/80 text-neutral-800 dark:text-foreground rounded-bl-md shadow-neutral-200/50 dark:shadow-none"}
                      `}>
                        <p className="leading-relaxed whitespace-pre-wrap font-medium text-[15px]">{msg.text}</p>
                      </div>

                      {/* Render Properties if AI suggested any */}
                      {msg.properties && (
                        <div className="mt-6 flex flex-col md:flex-row gap-5 w-full max-w-4xl overflow-x-auto pb-6 pt-2 pl-2 snap-x">
                          {msg.properties.map((prop, idx) => (
                            <div key={idx} className="flex-none w-80 bg-white/70 dark:bg-background/70 backdrop-blur-xl border border-white/80 dark:border-border/80 rounded-4xl overflow-hidden group cursor-pointer shadow-xl shadow-neutral-200/40 dark:shadow-none hover:shadow-2xl hover:shadow-indigo-500/20 dark:hover:shadow-indigo-500/10 transition-all hover:-translate-y-1 snap-center">
                              <div className="h-48 overflow-hidden relative m-2 rounded-3xl">
                                <Image src={prop.image} alt={prop.title} fill className="object-cover group-hover:scale-105 transition-transform duration-700 ease-out" loading="lazy" sizes="(max-width: 768px) 100vw, 400px" />
                                <div className="absolute top-3 right-3 px-3 py-1.5 bg-black/40 backdrop-blur-md rounded-full text-white text-sm font-bold border border-white/20">
                                  {prop.price}
                                </div>
                              </div>
                              <div className="p-5 pt-3">
                                <h2 className="font-bold text-lg text-neutral-900 dark:text-white truncate mb-2 group-hover:text-brand dark:group-hover:text-brand transition-colors">{prop.title}</h2>
                                <div className="flex items-center gap-1.5 text-neutral-500 dark:text-muted-foreground mb-4 text-sm font-medium">
                                  <MapPin className="w-4 h-4 text-brand dark:text-brand" />
                                  <span className="truncate">{prop.location}</span>
                                </div>

                                <div className="h-px w-full bg-gradient-to-r from-transparent via-neutral-200 dark:via-slate-700 to-transparent mb-4" />

                                <div className="flex items-center justify-between text-neutral-600 dark:text-muted-foreground text-sm font-semibold">
                                  <div className="flex gap-4">
                                    <span className="flex items-center gap-1.5 bg-neutral-100/80 dark:bg-muted/80 px-2.5 py-1 rounded-lg"><Bed className="w-4 h-4 text-neutral-400 dark:text-muted-foreground"/> {prop.beds}</span>
                                    <span className="flex items-center gap-1.5 bg-neutral-100/80 dark:bg-muted/80 px-2.5 py-1 rounded-lg"><Bath className="w-4 h-4 text-neutral-400 dark:text-muted-foreground"/> {prop.baths}</span>
                                  </div>
                                  <button aria-label="Go to property" className="w-8 h-8 rounded-full bg-brand/10 dark:bg-brand/30 text-brand dark:text-brand flex items-center justify-center group-hover:bg-brand dark:group-hover:bg-brand/100 group-hover:text-white transition-colors">
                                    <ArrowRight className="w-4 h-4" />
                                  </button>
                                </div>
                              </div>
                            </div>
                          ))}
                        </div>
                      )}
                    </div>
                  ))}

                  {aiIsLoading && (
                    <div className="flex items-start">
                      <div className="bg-white/80 dark:bg-muted/60 backdrop-blur-xl border border-white/80 dark:border-border/80 rounded-4xl rounded-bl-md p-5 px-6 flex items-center gap-2 shadow-sm dark:shadow-none">
                        <div className="flex gap-1.5">
                          <div className="w-2.5 h-2.5 bg-brand rounded-full animate-bounce" />
                          <div className="w-2.5 h-2.5 bg-brand/100 rounded-full animate-bounce delay-150" />
                          <div className="w-2.5 h-2.5 bg-brand rounded-full animate-bounce delay-300" />
                        </div>
                      </div>
                    </div>
                  )}
                  <div ref={aiMessagesEndRef} className="h-4" />
                </div>
              </div>

              {/* Floating Input Area */}
              <div className="flex-none p-4 md:p-8 bg-gradient-to-t from-[#fafafa] via-[#fafafa]/80 dark:from-[#0a0a0c] dark:via-[#0a0a0c]/80 to-transparent">
                <div className="max-w-4xl mx-auto relative group">
                  <div className="absolute -inset-2 bg-gradient-to-r from-brand/20 to-brand/20 rounded-[2.5rem] blur-xl opacity-0 group-focus-within:opacity-100 transition duration-500"></div>

                  <div className="relative flex items-center bg-white/70 dark:bg-background/70 backdrop-blur-2xl border border-white dark:border-border shadow-2xl shadow-indigo-900/5 dark:shadow-none rounded-[2.5rem] p-2 focus-within:bg-white/90 dark:focus-within:bg-background/90 transition-all">

                    <button aria-label="Voice input" className="p-4 text-neutral-400 dark:text-muted-foreground hover:text-brand dark:hover:text-brand transition-colors">
                      <Mic className="w-6 h-6" />
                    </button>

                    <textarea
                      value={aiInput}
                      onChange={(e) => setAiInput(e.target.value)}
                      onKeyDown={(e) => {
                        if (e.key === "Enter" && !e.shiftKey) {
                          e.preventDefault();
                          handleAISend();
                        }
                      }}
                      placeholder={t("client.src.tell_ai_what_you_are_looking_for")}
                      className="flex-1 max-h-32 min-h-[60px] bg-transparent border-none focus:ring-0 resize-none py-4 px-2 text-neutral-900 dark:text-white placeholder:text-neutral-400 dark:placeholder:text-muted-foreground font-medium text-[17px]"
                      rows={1}
                    />

                    <button
                      onClick={handleAISend}
                      disabled={!aiInput.trim() || aiIsLoading}
                      aria-label="Send message"
                      className="m-1.5 p-4 bg-gradient-to-br from-brand to-brand hover:from-brand hover:to-brand disabled:from-neutral-300 disabled:to-neutral-300 disabled:text-neutral-500 dark:disabled:from-slate-800 dark:disabled:to-slate-800 dark:disabled:text-muted-foreground text-white rounded-[1.8rem] transition-all shrink-0 shadow-md shadow-indigo-500/25 dark:shadow-none active:scale-95"
                    >
                      <Send className="w-5 h-5 ml-0.5" />
                    </button>
                  </div>
                </div>
                <p className="text-center text-[11px] font-medium text-neutral-400 dark:text-muted-foreground mt-4 tracking-wide uppercase">
                  {t("client.src.reservatior_ai_can_make_mistakes_verify_information")}
                </p>
              </div>
            </div>
          </div>
        )}

        {/* ══════ SUPPORT CHAT MODAL ══════ */}
        {showSupportChat && (
          <div className="fixed bottom-24 right-6 z-[100] w-[380px] h-[500px] bg-card dark:bg-[#0a0a0c] rounded-3xl shadow-2xl overflow-hidden flex flex-col border border-white/60 dark:border-border">
            {/* Header */}
            <div className="flex-none p-4 flex justify-between items-center border-b border-border dark:border-border bg-muted dark:bg-background">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-full bg-gradient-to-br from-blue-500 to-cyan-500 flex items-center justify-center">
                  <Bot className="w-5 h-5 text-white" />
                </div>
                <div>
                  <span className="font-bold text-foreground dark:text-white">AI Support</span>
                  <p className="text-xs text-blue-500 font-medium">● Online</p>
                </div>
              </div>
              <button onClick={() => setShowSupportChat(false)} aria-label="Close support chat" className="p-2 rounded-full hover:bg-muted dark:hover:bg-muted transition-colors">
                <X className="w-5 h-5 text-muted-foreground dark:text-muted-foreground" />
              </button>
            </div>

            {/* Chat Area */}
            <div className="flex-1 overflow-y-auto p-4 space-y-4">
              {supportMessages.length === 0 && (
                <div className="flex flex-col items-center justify-center h-full text-center space-y-4">
                  <div className="w-16 h-16 rounded-full bg-blue-100 dark:bg-blue-900/30 flex items-center justify-center">
                    <Bot className="w-8 h-8 text-brand dark:text-brand" />
                  </div>
                  <div>
                    <p className="font-bold text-foreground dark:text-white">How can I help you?</p>
                    <p className="text-sm text-muted-foreground dark:text-muted-foreground mt-1">Describe your issue, share files</p>
                  </div>
                </div>
              )}

              {supportMessages.map((msg) => (
                <div key={msg.id} className={`flex ${msg.role === "user" ? "justify-end" : "justify-start"}`}>
                  <div className={`max-w-[80%] rounded-2xl p-3 ${
                    msg.role === "user"
                      ? "bg-blue-600 text-white rounded-br-md"
                      : msg.role === "ai"
                      ? "bg-gradient-to-br from-brand to-info text-white rounded-bl-md"
                      : "bg-muted dark:bg-muted text-foreground dark:text-foreground rounded-bl-md"
                  }`}>
                    {msg.role === "ai" && (
                      <div className="flex items-center gap-2 mb-2">
                        <Sparkles className="w-3 h-3" />
                        <span className="text-xs font-bold opacity-80">AI Assistant</span>
                      </div>
                    )}
                    <p className="text-sm">{msg.text}</p>
                    {msg.attachments && msg.attachments.length > 0 && (
                      <div className="mt-2 space-y-1">
                        {msg.attachments.map((url, idx) => (
                          <div key={idx} className="text-xs bg-white/20 rounded px-2 py-1">
                            📎 File attached
                          </div>
                        ))}
                      </div>
                    )}
                  </div>
                </div>
              ))}

              {supportIsLoading && (
                <div className="flex justify-start">
                  <div className="bg-muted dark:bg-muted rounded-2xl rounded-bl-md p-3">
                    <div className="flex gap-1">
                      <div className="w-2 h-2 bg-brand/100 rounded-full animate-bounce" />
                      <div className="w-2 h-2 bg-brand/100 rounded-full animate-bounce delay-100" />
                      <div className="w-2 h-2 bg-brand/100 rounded-full animate-bounce delay-200" />
                    </div>
                  </div>
                </div>
              )}

              <div ref={supportMessagesEndRef} />
            </div>

            {/* Input Area */}
            <div className="flex-none p-4 border-t border-border dark:border-border">
              {attachments.length > 0 && (
                <div className="flex gap-2 mb-2 overflow-x-auto">
                  {attachments.map((url, idx) => (
                    <div key={idx} className="flex items-center gap-1 bg-muted dark:bg-muted rounded-full px-3 py-1 text-xs">
                      <span>📎 File</span>
                      <button onClick={() => setAttachments(prev => prev.filter((_, i) => i !== idx))} className="text-red-500 hover:text-red-700">×</button>
                    </div>
                  ))}
                </div>
              )}
              <div className="flex gap-2">
                <label className="p-2 rounded-full hover:bg-muted dark:hover:bg-muted transition-colors cursor-pointer">
                  <input type="file" onChange={handleFileUpload} className="hidden" />
                  <Paperclip className="w-5 h-5 text-muted-foreground" />
                </label>
                <input
                  type="text"
                  aria-label="Describe your issue"
                  value={supportInput}
                  onChange={(e) => setSupportInput(e.target.value)}
                  onKeyDown={(e) => e.key === "Enter" && handleSupportSend()}
                  placeholder="Describe your issue..."
                  className="flex-1 px-4 py-2 rounded-full border border-slate-300 dark:border-border bg-card dark:bg-card text-foreground dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
                <button
                  onClick={handleSupportSend}
                  disabled={supportIsLoading}
                  aria-label="Send message"
                  className="px-4 py-2 bg-blue-600 hover:bg-brand disabled:bg-muted text-white rounded-full transition-colors"
                >
                  <Send className="w-4 h-4" />
                </button>
              </div>
            </div>
          </div>
        )}

        <FAQPageSchema questions={[
          { question: "What is Reservatior and how does it work?", answer: "Reservatior is an AI-powered real estate platform that enables direct bookings, property management, instant AI valuations, and cinematic virtual tours. It connects property owners, tenants, and agents through a unified dashboard with smart automation tools." },
          { question: "How accurate is the AI property valuation?", answer: "Reservatior's AI valuation engine achieves up to 96% accuracy by analyzing market trends, comparable properties, location data, and over 50 data points per listing. The model is continuously trained on thousands of transactions." },
          { question: "Can I list my property on multiple channels?", answer: "Yes, Reservatior offers multi-channel distribution integration. Your listings can be published across 150+ countries with automatic translation and formatting for each platform, including major booking and real estate portals." },
          { question: "What payment options are available for pricing plans?", answer: "We offer monthly subscription plans ranging from Starter to Enterprise. All plans include AES-256 encryption, RBAC access control, and TLS 1.3 security. Enterprise plans also support custom integrations and dedicated support." },
        ]} />
      </div>
    </>
  );
}
