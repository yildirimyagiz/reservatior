"use client";

import { Helmet } from "react-helmet-async";
import { VideoObjectSchema } from "@/components/seo/SchemaScript";
import { useTranslation } from "react-i18next";
import { useState, useMemo, useRef } from "react";
import { useQuery } from "@tanstack/react-query";
import { Property, propertyApi } from "@/lib/api/property";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import {
  Play, Heart, MessageCircle, Share2, Sparkles, Eye,
  ChevronRight, MapPin, Clock, Search, Star, Circle, Radio, Camera
} from "lucide-react";
import Image from "next/image";


/* ───── Category Data ───── */
const CATEGORIES = [
  { id: "all", key: "videos.cat.all", fallback: "ALL" },
  { id: "villa", key: "videos.cat.villa", fallback: "VILLA" },
  { id: "penthouse", key: "videos.cat.penthouse", fallback: "PENTHOUSE" },
  { id: "smart", key: "videos.cat.smart", fallback: "SMART HOME" },
  { id: "mountain", key: "videos.cat.mountain", fallback: "MOUNTAIN" },
  { id: "loft", key: "videos.cat.loft", fallback: "LOFT" },
];

/* ───── Fallback Data ───── */
const FALLBACK_VIDEOS = [
  {
    title: "The Glass Pavilion — Coastal Malibu Architectural Masterpiece",
    agency: "Aura Luxury Properties", verified: true, price: "$28,500,000",
    beds: 6, baths: 8, sqft: "12,400", category: "villa",
    location: "MALIBU", views: "24K", time: "2 DAYS AGO", duration: "2:14",
    tags: ["EXCLUSIVE LISTING", "MODERN"],
    rooms: ["videos.rooms.exterior", "videos.rooms.master", "videos.rooms.living", "videos.rooms.kitchen", "videos.rooms.pool"],
    image: "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=1920&q=80",
  },
  {
    title: "Monolithic Concrete Dream — Brutalist Beverly Hills Penthouse",
    agency: "Vance & Partners", verified: true, price: "$16,200,000",
    beds: 4, baths: 6, sqft: "8,900", category: "penthouse",
    location: "BEVERLY HILLS", views: "18K", time: "5 DAYS AGO", duration: "1:48",
    tags: ["PENTHOUSE", "MODERN"],
    rooms: ["videos.rooms.exterior", "videos.rooms.living", "videos.rooms.master", "videos.rooms.pool"],
    image: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=1920&q=80",
  },
  {
    title: "Neo-Tokyo Cyber Loft — High-Tech Shinjuku Smart Penthouse",
    agency: "Ren Tanaka Realty", verified: true, price: "¥1,850,000,000",
    beds: 3, baths: 3, sqft: "5,400", category: "smart",
    location: "SHIBUYA", views: "42K", time: "1 WEEK AGO", duration: "2:05",
    tags: ["SMART HOME", "TECH ENABLED"],
    rooms: ["videos.rooms.living", "videos.rooms.master", "videos.rooms.kitchen", "videos.rooms.exterior"],
    image: "https://images.unsplash.com/photo-1600607687931-cebf585140bb?w=1920&q=80",
  },
];

export default function Videos() {
  const { t } = useTranslation();
  const [activeCat, setActiveCat] = useState("all");
  const [searchQuery, setSearchQuery] = useState("");
  const [sortBy, setSortBy] = useState("newest");
  const [listingType, setListingType] = useState("ALL");
  const [promotionType, setPromotionType] = useState("ALL");
  const [activeProperty, setActiveProperty] = useState(0);
  const [activeRoom, setActiveRoom] = useState(0);
  const [liked, setLiked] = useState(false);
  const scrollRef = useRef<HTMLDivElement>(null);

  // Fetch real data
  const { data: rawResponse } = useQuery({
    queryKey: ["properties", "featured"],
    queryFn: () => propertyApi.getProperties(),
  });
  const response = rawResponse as any;

  // Compute dynamic videos
  const videos = useMemo(() => {
    if (!response?.data) return FALLBACK_VIDEOS.map((v, i) => ({ ...v, id: String(i) }));
    return response.data.slice(0, 15).map((p: any, i: number) => {
      const fallback = FALLBACK_VIDEOS[i % FALLBACK_VIDEOS.length];
      const rawImg = p.listings?.[0]?.pricingRules?.[0]?.discountRules?.image;
      const finalImage = (rawImg && typeof rawImg === 'string' && rawImg.length > 10) ? rawImg : fallback.image;
      
      return {
        id: String(p.id || i),
        title: p.name || fallback.title,
        location: p.address || fallback.location,
        price: p.price ? `$${Number(p.price).toLocaleString()}` : fallback.price,
        beds: fallback.beds,
        baths: fallback.baths,
        sqft: fallback.sqft,
        category: p.type ? String(p.type).toLowerCase() : fallback.category,
        listingType: p.listingType || (i % 2 === 0 ? "SALE" : "RENT"),
        promotionType: i === 0 ? "FEATURED" : i === 1 ? "URGENT" : i === 2 ? "PRICE_REDUCED" : "ALL",
        agency: fallback.agency,
        verified: fallback.verified,
        views: fallback.views,
        time: fallback.time,
        duration: fallback.duration,
        tags: fallback.tags,
        rooms: fallback.rooms,
        image: finalImage,
      };
    });
  }, [response]);

  const filtered = videos.filter((p: any) => {
    const matchesCat = activeCat === "all" || p.category === activeCat;
    const matchesListing = listingType === "ALL" || p.listingType === listingType;
    const matchesPromo = promotionType === "ALL" || p.promotionType === promotionType;
    const searchLower = searchQuery.toLowerCase();
    const matchesSearch = !searchQuery || 
      p.title.toLowerCase().includes(searchLower) || 
      p.location.toLowerCase().includes(searchLower) ||
      p.agency.toLowerCase().includes(searchLower);
    return matchesCat && matchesListing && matchesPromo && matchesSearch;
  }).sort((a: any, b: any) => {
    if (sortBy === "price_high") {
       return parseInt(b.price.replace(/\D/g, '')) - parseInt(a.price.replace(/\D/g, ''));
    }
    if (sortBy === "price_low") {
       return parseInt(a.price.replace(/\D/g, '')) - parseInt(b.price.replace(/\D/g, ''));
    }
    if (sortBy === "views") {
       const parseViews = (v: string) => parseFloat(v.replace(/K/i, '000').replace(/M/i, '000000')) || 0;
       return parseViews(b.views) - parseViews(a.views);
    }
    return 0;
  });
  // Ensure active property is valid after filter
  const prop = videos[activeProperty] || filtered[0] || videos[0];

  return (
    <>
      <Helmet>
        <title>{t('videos.title', 'Property Video Tours - AI-Powered Virtual Tours')} | Reservatior</title>
        <meta name="description" content="Browse AI-powered property video tours with ML-enhanced virtual walkthroughs of premium real estate listings. Cinematic 4K virtual tours of luxury properties." />
        <meta property="og:title" content={t('videos.title', 'Property Video Tours - AI-Powered Virtual Tours') + ' | Reservatior'} />
        <meta property="og:description" content="Browse AI-powered property video tours with ML-enhanced virtual walkthroughs of premium real estate listings." />
        <meta property="og:type" content="website" />
        <meta property="og:url" content={window.location.href} />
        <meta name="twitter:card" content="summary_large_image" />
        <meta name="twitter:title" content={t('videos.title', 'Property Video Tours - AI-Powered Virtual Tours') + ' | Reservatior'} />
        <meta name="twitter:description" content="Browse AI-powered property video tours with ML-enhanced virtual walkthroughs of premium real estate listings." />
        <link rel="canonical" href={window.location.href} />
      </Helmet>

      <div className="h-[calc(100vh-64px)] bg-[#0A0B0F] text-white flex overflow-hidden">

        {/* ═══════ LEFT: VIDEO REELS ═══════ */}
        <div ref={scrollRef} className="flex-1 relative flex flex-col min-w-0 bg-black overflow-y-scroll snap-y snap-mandatory scrollbar-hide"
          onScroll={(e) => {
            const container = e.currentTarget;
            const index = Math.round(container.scrollTop / container.clientHeight);
            const newActiveProp = videos.findIndex((v: any) => v.id === filtered[index]?.id);
            if (newActiveProp !== -1 && newActiveProp !== activeProperty) {
              setActiveProperty(newActiveProp);
              setActiveRoom(0);
            }
          }}
        >
          {filtered.map((video: any) => {
            const isActive = videos.findIndex((v: any) => v.id === video.id) === activeProperty;
            return (
              <div key={video.id} className="relative w-full h-full shrink-0 snap-start snap-always flex flex-col">
                <VideoObjectSchema name={video.title} description={`${video.title} - ${video.location} - ${video.price}`} thumbnailUrl={video.image} />
                {/* Video Area */}
                <div className="flex-1 relative overflow-hidden bg-black flex items-center justify-center">
                  {/* Real Background Image simulating Video Thumbnail */}
                  <div className="absolute inset-0">
                     <Image src={video.image} alt={video.title} fill className="object-cover opacity-80" sizes="100vw" />
                     <div className="absolute inset-0 bg-gradient-to-t from-[#0E0F15] via-black/40 to-transparent" />
                     <div className="absolute inset-0 bg-black/10" />
                  </div>

                  {/* Live & Quality Badges */}
                  <div className="absolute top-5 left-5 z-20 flex items-center gap-3">
                    <Badge className="bg-red-600 text-white border-0 px-3 py-1.5 text-xs font-bold tracking-wider gap-1.5 rounded-lg shadow-lg shadow-red-600/30">
                      <Radio className="w-3 h-3 animate-pulse" /> {t('videos.live_tour', 'LIVE TOUR')}
                    </Badge>
                    <Badge className="bg-white/10 backdrop-blur-md text-white border-white/10px-3 py-1.5 text-xs font-medium rounded-lg gap-1.5">
                      <Camera className="w-3 h-3" /> {t('videos.cinematic', '8K CINEMATIC')}
                    </Badge>
                  </div>

                  {/* Price Badge */}
                  <div className="absolute top-5 right-5 z-20">
                    <div className="bg-black/80 backdrop-blur-xl rounded-2xl px-5 py-3 border border-white/10">
                      <div className="text-[10px] text-slate-400 font-semibold tracking-widest">{t('videos.exclusive', 'EXCLUSIVE LISTING')}</div>
                      <div className="text-2xl font-black text-white tracking-tight">{video.price}</div>
                    </div>
                  </div>

                  {/* Center Play Button */}
                  <div className="absolute inset-0 flex items-center justify-center z-10 pointer-events-none">
                    <div className="w-20 h-20 rounded-full bg-white/10 backdrop-blur-md flex items-center justify-center border border-white/20 cursor-pointer hover:scale-110 hover:bg-white/20 transition-all shadow-2xl pointer-events-auto">
                      <Play className="w-9 h-9 text-white ml-1" />
                    </div>
                  </div>

                  {/* Current Room Label */}
                  <div className="absolute bottom-24 left-6 z-20">
                    <p className="text-[10px] text-emerald-400 font-bold tracking-[0.2em] mb-1">{t('videos.now_playing', 'NOW PLAYING')}</p>
                    <h2 className="text-3xl lg:text-4xl font-black text-white tracking-tight">{t(video.rooms[isActive ? activeRoom : 0] || video.rooms[0], (video.rooms[isActive ? activeRoom : 0] || video.rooms[0]).split('.').pop() || "") as string}</h2>
                  </div>

                  {/* Room Selector Pills */}
                  <div className="absolute bottom-5 left-6 right-20 z-20 flex items-center gap-2 overflow-x-auto scrollbar-hide">
                    {video.rooms.map((room: string, i: number) => (
                      <button key={i} onClick={() => setActiveRoom(i)}
                        className={`flex items-center gap-2 px-4 py-2 rounded-full text-xs font-semibold whitespace-nowrap transition-all
                          ${(isActive ? activeRoom : 0) === i ? "bg-blue-600 text-white shadow-lg shadow-blue-600/30" : "bg-white/10 text-white/60 hover:bg-white/20 backdrop-blur-sm"}`}>
                        {t(room, room.split('.').pop() || "") as string}
                        {(isActive ? activeRoom : 0) === i && <span className="w-5 h-5 rounded-full bg-white/20 flex items-center justify-center"><ChevronRight className="w-3 h-3" /></span>}
                      </button>
                    ))}
                  </div>

                  {/* Right Side Social Buttons */}
                  <div className="absolute right-5 top-1/2 -translate-y-1/2 z-20 flex flex-col items-center gap-5">
                    <button onClick={() => setLiked(!liked)} className="flex flex-col items-center gap-1 group">
                      <div className={`w-11 h-11 rounded-full flex items-center justify-center transition-all ${liked ? "bg-red-500 text-white" : "bg-white/10 text-white hover:bg-white/20 backdrop-blur-md"}`}>
                        <Heart className={`w-5 h-5 ${liked ? "fill-white" : ""}`} />
                      </div>
                      <span className="text-[10px] text-white/80 font-semibold">3.2K</span>
                    </button>
                    <button className="flex flex-col items-center gap-1 group">
                      <div className="w-11 h-11 rounded-full bg-white/10 backdrop-blur-md text-white flex items-center justify-center hover:bg-white/20 transition-all">
                        <MessageCircle className="w-5 h-5" />
                      </div>
                      <span className="text-[10px] text-white/80 font-semibold">{t('videos.support', 'SUPPORT')}</span>
                    </button>
                    <button className="flex flex-col items-center gap-1 group">
                      <div className="w-11 h-11 rounded-full bg-white/10 backdrop-blur-md text-white flex items-center justify-center hover:bg-white/20 transition-all">
                        <Share2 className="w-5 h-5" />
                      </div>
                      <span className="text-[10px] text-white/80 font-semibold">{t('videos.share', 'SHARE')}</span>
                    </button>
                    <button className="flex flex-col items-center gap-1 group mt-4">
                      <div className="w-11 h-11 rounded-full bg-gradient-to-br from-violet-600 to-blue-600 text-white flex items-center justify-center hover:scale-110 transition-all shadow-lg shadow-violet-600/30">
                        <Sparkles className="w-5 h-5" />
                      </div>
                      <span className="text-[10px] text-white/80 font-semibold">AI HUB</span>
                    </button>
                  </div>
                </div>

                {/* Property Info Bar */}
                <div className="bg-[#0E0F15] border-t border-white/10 px-6 py-4 space-y-3 shrink-0">
                  {/* Tags */}
                  <div className="flex items-center gap-2 overflow-x-auto scrollbar-hide">
                    {video.tags.map((tag: string, i: number) => (
                      <Badge key={i} className={`text-[10px] font-bold tracking-wider px-3 py-1 rounded-full border-0 shrink-0
                        ${i === 0 ? "bg-emerald-500/20 text-emerald-400" : "bg-white/10 text-white/50"}`}>
                        {i === 0 && <Star className="w-3 h-3 mr-1" />}
                        {tag}
                      </Badge>
                    ))}
                  </div>
                  {/* Title & Location */}
                  <h3 className="text-lg font-black text-white tracking-wide leading-tight line-clamp-2">{video.title}</h3>
                  <div className="flex items-center gap-1.5 text-xs text-slate-400">
                    <MapPin className="w-3.5 h-3.5 text-blue-400" />
                    <span className="font-semibold">{video.location}</span>
                  </div>
                </div>
              </div>
            );
          })}
        </div>

        {/* ═══════ RIGHT: DISCOVERY PANEL ═══════ */}
        <div className="w-full lg:w-[420px] bg-[#0E0F15] border-l border-white/10 flex flex-col shrink-0">
          {/* Header */}
          <div className="px-3 pt-3 pb-1 border-b border-white/10 shrink-0">
            <div className="flex items-center justify-between mb-2">
              <div className="flex items-center gap-1.5">
                <Sparkles className="w-3 h-3 text-violet-400" />
                <div className="text-[10px] font-black text-white tracking-widest">{t('videos.search', 'SEARCH')}</div>
              </div>
              <div className="flex items-center gap-1.5 text-[8px] text-slate-500">
                <Search className="w-2.5 h-2.5" />
                <span className="font-semibold">{filtered.length} {t('videos.properties', 'PROPERTIES')}</span>
              </div>
            </div>
            {/* Search Input */}
            <div className="mb-2 relative">
              <Search className="absolute left-2.5 top-1/2 -translate-y-1/2 w-3 h-3 text-slate-400" />
              <input 
                type="text" 
                placeholder={t('videos.search_placeholder', 'SEARCH BY TITLE OR LOCATION...')}
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="w-full bg-white/5 border border-white/10 rounded-lg h-8 pl-8 pr-2 text-[8px] text-white font-black italic tracking-widest placeholder:text-slate-500 focus:outline-none focus:border-blue-500/50 focus:ring-1 focus:ring-blue-500/20 transition-all shadow-inner"
              />
            </div>
            {/* Advanced Filters */}
            <div className="grid grid-cols-2 gap-1.5 mb-1">
               <Select value={listingType} onValueChange={setListingType}>
                  <SelectTrigger className="w-full h-8 bg-white/5 border-white/5 text-[#94a3b8] font-black text-[8px] tracking-widest italic rounded-lg hover:text-white transition-all focus:ring-0 focus:border-blue-500/50 shadow-inner">
                    <SelectValue placeholder={t('client.property.listings.dialog.type', 'LISTING TYPE')} />
                  </SelectTrigger>
                  <SelectContent className="bg-[#1A1B1E]/95 border-white/10 text-white font-black text-[8px] tracking-widest italic backdrop-blur-3xl rounded-lg shadow-2xl">
                    <SelectItem value="ALL" className="focus:bg-white/10 cursor-pointer h-7">{t('client.property.listings.all', 'ALL')}</SelectItem>
                    <SelectItem value="SALE" className="focus:bg-white/10 cursor-pointer h-7">{t('client.property.listings.dialog.forSale', 'FOR SALE')}</SelectItem>
                    <SelectItem value="RENT" className="focus:bg-white/10 cursor-pointer h-7">{t('forRent', 'FOR RENT')}</SelectItem>
                    <SelectItem value="LEASE" className="focus:bg-white/10 cursor-pointer h-7">{t('lease', 'LEASE')}</SelectItem>
                  </SelectContent>
               </Select>

               <Select value={promotionType} onValueChange={setPromotionType}>
                  <SelectTrigger className="w-full h-8 bg-white/5 border-white/5 text-[#94a3b8] font-black text-[8px] tracking-widest italic rounded-lg hover:text-white transition-all focus:ring-0 focus:border-blue-500/50 shadow-inner">
                    <SelectValue placeholder={t('client.src.promotion.title', 'PROMOTION')} />
                  </SelectTrigger>
                  <SelectContent className="bg-[#1A1B1E]/95 border-white/10 text-white font-black text-[8px] tracking-widest italic backdrop-blur-3xl rounded-lg shadow-2xl">
                    <SelectItem value="ALL" className="focus:bg-white/10 cursor-pointer h-7">{t('client.src.promotion.all', 'ALL PROMOTIONS')}</SelectItem>
                    <SelectItem value="FEATURED" className="focus:bg-white/10 cursor-pointer h-7">{t('client.src.promotion.featured', 'FEATURED')}</SelectItem>
                    <SelectItem value="URGENT" className="focus:bg-white/10 cursor-pointer h-7">{t('client.src.promotion.urgent', 'URGENT')}</SelectItem>
                    <SelectItem value="PRICE_REDUCED" className="focus:bg-white/10 cursor-pointer h-7">{t('client.src.promotion.price_reduced', 'PRICE REDUCED')}</SelectItem>
                    <SelectItem value="BEST_DEAL" className="focus:bg-white/10 cursor-pointer h-7">{t('client.src.promotion.best_deal', 'BEST DEAL')}</SelectItem>
                  </SelectContent>
               </Select>

               <Select value={activeCat} onValueChange={setActiveCat}>
                  <SelectTrigger className="w-full h-8 bg-white/5 border-white/5 text-[#94a3b8] font-black text-[8px] tracking-widest italic rounded-lg hover:text-white transition-all focus:ring-0 focus:border-blue-500/50 shadow-inner">
                    <SelectValue placeholder={t('videos.category', 'CATEGORY')} />
                  </SelectTrigger>
                  <SelectContent className="bg-[#1A1B1E]/95 border-white/10 text-white font-black text-[8px] tracking-widest italic backdrop-blur-3xl rounded-lg shadow-2xl">
                    {CATEGORIES.map(cat => (
                      <SelectItem key={cat.id} value={cat.id} className="focus:bg-white/10 cursor-pointer h-7">{t(cat.key, cat.fallback)}</SelectItem>
                    ))}
                  </SelectContent>
               </Select>

               <Select value={sortBy} onValueChange={setSortBy}>
                  <SelectTrigger className="w-full h-8 bg-white/5 border-white/5 text-[#94a3b8] font-black text-[8px] tracking-widest italic rounded-lg hover:text-white transition-all focus:ring-0 focus:border-blue-500/50 shadow-inner">
                    <SelectValue placeholder={t('videos.sort_by', 'SORT BY')} />
                  </SelectTrigger>
                  <SelectContent className="bg-[#1A1B1E]/95 border-white/10 text-white font-black text-[8px] tracking-widest italic backdrop-blur-3xl rounded-lg shadow-2xl">
                    <SelectItem value="newest" className="focus:bg-white/10 cursor-pointer h-7">{t('videos.sort.newest', 'NEWEST')}</SelectItem>
                    <SelectItem value="price_high" className="focus:bg-white/10 cursor-pointer h-7">{t('videos.sort.price_high', 'PRICE (HIGH-LOW)')}</SelectItem>
                    <SelectItem value="price_low" className="focus:bg-white/10 cursor-pointer h-7">{t('videos.sort.price_low', 'PRICE (LOW-HIGH)')}</SelectItem>
                    <SelectItem value="views" className="focus:bg-white/10 cursor-pointer h-7">{t('videos.sort.views', 'MOST VIEWED')}</SelectItem>
                  </SelectContent>
               </Select>
            </div>
          </div>

          {/* Property Cards List */}
          <div className="flex-1 overflow-y-auto px-3 py-3 space-y-2 scrollbar-hide">
            {filtered.map((p: any, i: number) => {
              const isActive = p.id === prop.id;
              return (
                <button key={p.id} onClick={() => { 
                    const newActiveProp = videos.findIndex((v: any) => v.id === p.id);
                    setActiveProperty(newActiveProp); 
                    setActiveRoom(0); 
                    if (scrollRef.current) {
                      scrollRef.current.scrollTo({ top: i * scrollRef.current.clientHeight, behavior: 'smooth' });
                    }
                  }}
                  className={`w-full flex gap-3 p-2.5 rounded-xl text-left transition-all group
                    ${isActive ? "bg-blue-600/10 border border-blue-500/20" : "hover:bg-white/10 border border-transparent"}`}>
                  {/* Thumbnail */}
                  <div className="relative w-[140px] h-[90px] rounded-lg overflow-hidden shrink-0 bg-black">
                    <Image src={p.image} alt={p.title} fill className="object-cover opacity-90 group-hover:scale-105 transition-transform duration-700" sizes="140px" />
                    <div className="absolute inset-0 bg-black/20" />
                    {/* Price overlay */}
                    <div className="absolute top-1.5 left-1.5 bg-black/70 backdrop-blur-sm rounded px-1.5 py-0.5">
                      <span className="text-[10px] font-bold text-white">{p.price}</span>
                    </div>
                    {/* Category badge */}
                    <div className="absolute top-1.5 right-1.5">
                      <Badge className="text-[8px] bg-violet-600 text-white border-0 px-1.5 py-0 font-bold">{p.category}</Badge>
                    </div>
                    {/* Play icon */}
                    <div className="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity">
                      <div className="w-8 h-8 rounded-full bg-white/10 backdrop-blur-sm flex items-center justify-center">
                        <Play className="w-4 h-4 text-white ml-0.5" />
                      </div>
                    </div>
                    {/* Duration */}
                    <div className="absolute bottom-1.5 right-1.5 bg-black/80 rounded px-1.5 py-0.5">
                      <span className="text-[10px] font-mono text-white">{p.duration}</span>
                    </div>
                  </div>

                  {/* Info */}
                  <div className="flex-1 min-w-0 py-0.5 flex flex-col justify-between">
                    <h4 className="text-xs font-bold text-white line-clamp-2 leading-snug group-hover:text-blue-400 transition-colors">{p.title}</h4>
                    <div className="space-y-1.5 mt-1">
                      <div className="flex items-center gap-1">
                        <div className="w-4 h-4 rounded-full bg-gradient-to-br from-blue-500 to-violet-500 flex items-center justify-center shrink-0">
                          <span className="text-[6px] font-bold text-white">{p.agency.charAt(0)}</span>
                        </div>
                        <span className="text-[10px] text-slate-400 truncate">{p.agency}</span>
                        {p.verified && <Circle className="w-2.5 h-2.5 fill-blue-500 text-blue-500 shrink-0" />}
                      </div>
                      <div className="flex items-center justify-between">
                        <div className="flex items-center gap-2 text-[10px] text-slate-500">
                          <span className="flex items-center gap-0.5"><Eye className="w-3 h-3" /> {p.views}</span>
                          <span className="flex items-center gap-0.5"><Clock className="w-3 h-3" /> {p.time}</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </button>
              );
            })}
          </div>

          {/* Premium Search CTA */}
          <div className="p-4 border-t border-white/10 shrink-0">
            <div className="flex items-center gap-3 p-3 rounded-xl bg-gradient-to-r from-violet-600/10 to-blue-600/10 border border-violet-500/10 cursor-pointer hover:bg-white/10 transition-colors">
              <div className="w-10 h-10 rounded-full bg-gradient-to-br from-violet-600 to-blue-600 flex items-center justify-center shrink-0 shadow-lg shadow-violet-600/20">
                <Sparkles className="w-5 h-5 text-white" />
              </div>
              <div>
                <div className="text-xs font-bold text-white">{t('videos.premium_search', 'PREMIUM SEARCH')}</div>
                <div className="text-[10px] text-slate-400">RESERVATIOR EXCLUSIVE</div>
              </div>
              <div className="ml-auto w-3 h-3 rounded-full bg-emerald-500 animate-pulse" />
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
