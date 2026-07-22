"use client";


import { VideoObjectSchema } from "@/components/seo/SchemaScript";
import { useTranslation } from "react-i18next";
import { useState, useMemo, useRef } from "react";
import { useQuery } from "@tanstack/react-query";
import { propertyApi } from "@/lib/api/property";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import {
  Play, Heart, MessageCircle, Share2, Sparkles, Eye,
  MapPin, Clock, Search, Star, Circle, Radio, Camera,
  Bot, Filter, Send, Loader2
} from "lucide-react";

import { useRouter } from "next/navigation";
import { Dialog, DialogContent, DialogTitle, DialogDescription } from "@/components/ui/dialog";




import istanbulVideos from "./istanbul-videos.json";

const DEMO_VIDEOS = [
  ...istanbulVideos,
  "/videos/ozak-bg.mp4", 
  "/videos/ozak-dragos-bg.mp4", 
  "/videos/ozak-buyukyali-bg.mp4", 
  "/videos/ozak-duyu-bg.mp4"
];

const FALLBACK_VIDEOS = [
  {
    title: "Özak Büyükyalı — Luxury Coastal Living",
    agency: "Özak GYO", verified: true, price: "From $2,500,000",
    beds: 4, baths: 3, sqft: "3,200", category: "villa",
    location: "Zeytinburnu, Istanbul", views: "125K", time: "NEW", duration: "1:30",
    tags: ["SEAVIEW", "LUXURY", "SMART HOME"],
    rooms: ["videos.rooms.exterior", "videos.rooms.master", "videos.rooms.living", "videos.rooms.kitchen", "videos.rooms.pool"],
    image: "/videos/ozak-buyukyali-bg.mp4",
    videoUrl: "/videos/ozak-buyukyali-bg.mp4",
  },
  {
    title: "Özak Dragos — Panoramic Islands View",
    agency: "Özak GYO", verified: true, price: "From $850,000",
    beds: 3, baths: 2, sqft: "1,800", category: "penthouse",
    location: "Maltepe, Istanbul", views: "82K", time: "PRE-SALE", duration: "2:15",
    tags: ["ISLANDS VIEW", "MODERN", "RESIDENCE"],
    rooms: ["videos.rooms.exterior", "videos.rooms.living", "videos.rooms.master", "videos.rooms.pool"],
    image: "/videos/ozak-dragos-bg.mp4",
    videoUrl: "/videos/ozak-dragos-bg.mp4",
  },
  {
    title: "Özak Duyu — Harmony with Nature",
    agency: "Özak GYO", verified: true, price: "From $1,200,000",
    beds: 5, baths: 4, sqft: "4,100", category: "villa",
    location: "Göktürk, Istanbul", views: "45K", time: "READY TO MOVE", duration: "1:45",
    tags: ["FOREST", "NATURE", "VILLA"],
    rooms: ["videos.rooms.living", "videos.rooms.master", "videos.rooms.kitchen", "videos.rooms.exterior"],
    image: "/videos/ozak-duyu-bg.mp4",
    videoUrl: "/videos/ozak-duyu-bg.mp4",
  },
  {
    title: "Özak GYO — Corporate Vision",
    agency: "Özak GYO", verified: true, price: "-",
    beds: 0, baths: 0, sqft: "-", category: "all",
    location: "Istanbul", views: "210K", time: "FEATURED", duration: "2:00",
    tags: ["CORPORATE", "PORTFOLIO", "VISION"],
    rooms: ["videos.rooms.exterior", "videos.rooms.living", "videos.rooms.master"],
    image: "/videos/ozak-bg.mp4",
    videoUrl: "/videos/ozak-bg.mp4",
  }
];

export default function Videos() {
  const { t, i18n } = useTranslation();
  const router = useRouter();
  const [activeCat] = useState("all");
  const [searchQuery] = useState("");
  const [sortBy, setSortBy] = useState("newest");
  const [listingType, setListingType] = useState("ALL");
  const [promotionType] = useState("ALL");
  const [activeProperty, setActiveProperty] = useState(0);
  const [activeRoom, setActiveRoom] = useState(0);
  const [liked, setLiked] = useState(false);
  const [isAiModalOpen, setIsAiModalOpen] = useState(false);
  const [aiQuery, setAiQuery] = useState("");
  const [isAiSearching, setIsAiSearching] = useState(false);
  
  const handleAISearch = (e?: React.FormEvent) => {
    if (e) e.preventDefault();
    if (!aiQuery.trim()) return;
    
    setIsAiSearching(true);
    // Simulate AI parsing and filtering
    setTimeout(() => {
      const q = aiQuery.toLowerCase();
      if (q.includes("villa")) setPropertyType("VILLA");
      else if (q.includes("apartment")) setPropertyType("APARTMENT");
      else if (q.includes("penthouse")) setPropertyType("PENTHOUSE");
      
      if (q.includes("sale") || q.includes("buy")) setListingType("SALE");
      else if (q.includes("rent")) setListingType("RENT");
      
      if (q.includes("pool")) setPropertyCategory("RESIDENTIAL"); // just mock
      
      if (q.match(/2\\s*m/)) setPriceMax("2000000");
      else if (q.match(/1\\s*m/)) setPriceMax("1000000");
      
      setIsAiSearching(false);
      setShowFilters(true); // show the updated filters
    }, 1500);
  };
  
  // Advanced Filter States
  const [propertyCategory, setPropertyCategory] = useState("ALL");
  const [propertyType, setPropertyType] = useState("ALL");
  const [beds, setBeds] = useState("ALL");
  const [priceMin, setPriceMin] = useState("");
  const [priceMax, setPriceMax] = useState("");
  const scrollRef = useRef<HTMLDivElement>(null);

  // Fetch real data
  const { data: rawResponse } = useQuery({
    queryKey: ["properties", "featured"],
    queryFn: () => propertyApi.getProperties(),
  });
  const response = rawResponse as any;

  // Compute dynamic videos
  const videos = useMemo(() => {
    return DEMO_VIDEOS.map((item: any, i: number) => {
      // Determine if item is an object with details or a raw string URL
      const isObject = typeof item === 'object' && item !== null;
      const videoUrl = isObject ? item.videoUrl : item;
      const fileDetails = isObject ? item.details : null;

      const fallback = FALLBACK_VIDEOS[i % FALLBACK_VIDEOS.length];
      const p = response?.data?.[i] || {};
      const rawImg = p.listings?.[0]?.pricingRules?.[0]?.discountRules?.image;
      const finalImage = (rawImg && typeof rawImg === 'string' && rawImg.length > 10) ? rawImg : fallback.image;
      
      let location = fileDetails?.district ? `${fileDetails.district}, ${fileDetails.city || 'İstanbul'}` : (p.address || fallback.location);
      let title = fileDetails?.projectName || p.name || fallback.title;
      const priceStr = fileDetails?.price || (p.price ? `$${Number(p.price).toLocaleString()}` : fallback.price);
      const roomType = fileDetails?.roomType || null;
      const status = fileDetails?.status || p.listingType || (i % 2 === 0 ? "SALE" : "RENT");
      
      if (!fileDetails && !p.id && videoUrl.includes('/istanbul/')) {
        const parts = videoUrl.split('/');
        // /videos/istanbul/District/...
        if (parts.length > 3) {
          const district = decodeURIComponent(parts[3]).replace(/_/g, ' ');
          location = `${district}, Istanbul`;
          if (parts[4]) title = `${district} - ${decodeURIComponent(parts[4]).replace(/_/g, ' ')}`;
        }
      }
      
      return {
        id: String(p.id || `video-${i}`),
        title: title,
        location: location,
        price: priceStr,
        beds: roomType ? (parseInt(roomType.split('+')[0]) || fallback.beds) : fallback.beds,
        baths: roomType ? (parseInt(roomType.split('+')[1]) || fallback.baths) : fallback.baths,
        sqft: fileDetails?.netArea || fileDetails?.grossArea || fallback.sqft,
        category: p.type ? String(p.type).toLowerCase() : fallback.category,
        listingType: status.toUpperCase() === 'KİRALIK' || status.toUpperCase() === 'KIRALIK' ? 'RENT' : status.toUpperCase() === 'SATILIK' ? 'SALE' : status,
        promotionType: i === 0 ? "FEATURED" : i === 1 ? "URGENT" : i === 2 ? "PRICE_REDUCED" : "ALL",
        agency: fileDetails?.contactName || p.agency || fallback.agency,
        verified: fallback.verified,
        views: fallback.views,
        time: fallback.time,
        duration: fallback.duration,
        tags: fallback.tags,
        rooms: fallback.rooms,
        image: finalImage,
        videoUrl: videoUrl,
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
      <div className="h-full w-full bg-black text-white flex overflow-hidden">

        {/* ═══════ LEFT/MAIN: VIDEO REELS ═══════ */}
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
              <div key={video.id} className="relative w-full h-full shrink-0 snap-start snap-always flex flex-col justify-center items-center overflow-hidden">
                <VideoObjectSchema name={video.title} description={`${video.title} - ${video.location} - ${video.price}`} thumbnailUrl={video.image} />
                
                {/* Video Background */}
                <div className="absolute inset-0">
                    <video
                      autoPlay
                      loop
                      muted
                      playsInline
                      onLoadedMetadata={(e) => { e.currentTarget.currentTime = 2; }}
                      className="w-full h-full object-cover opacity-90"
                    >
                      <source src={`${video.videoUrl}#t=2`} type="video/mp4" />
                    </video>
                    <div className="absolute inset-0 bg-gradient-to-b from-black/50 via-transparent to-transparent h-32" />
                    <div className="absolute inset-0 bg-gradient-to-t from-black/90 via-black/40 to-transparent h-2/3 mt-auto" />
                </div>

                {/* Top Badges */}
                <div className="absolute top-6 left-6 right-6 flex justify-between items-start z-30 pointer-events-none">
                  <div className="flex flex-col gap-2">
                    <Badge className="bg-red-600/90 backdrop-blur-md text-white border-0 px-3 py-1.5 text-xs font-bold tracking-wider gap-1.5 rounded-lg shadow-lg shadow-red-600/30 w-fit">
                      <Radio className="w-3 h-3 animate-pulse" /> {t('videos.live_tour', 'LIVE TOUR')}
                    </Badge>
                    <Badge className="bg-white/10 backdrop-blur-md text-white border-white/10 px-3 py-1.5 text-xs font-medium rounded-lg gap-1.5 w-fit">
                      <Camera className="w-3 h-3" /> {t('videos.cinematic', '8K CINEMATIC')}
                    </Badge>
                  </div>
                  <div className="bg-black/60 backdrop-blur-xl rounded-2xl px-4 py-2.5 border border-white/10 text-right">
                    <div className="text-[9px] text-emerald-400 font-bold tracking-widest uppercase mb-0.5">{video.listingType}</div>
                    <div className="text-xl font-black text-white tracking-tight leading-none">{video.price}</div>
                  </div>
                </div>

                {/* Center Play Button */}
                <div className="absolute inset-0 flex items-center justify-center z-20 pointer-events-none">
                  <div className="w-20 h-20 rounded-full bg-white/10 backdrop-blur-md flex items-center justify-center border border-white/20 cursor-pointer hover:scale-110 hover:bg-white/20 transition-all shadow-2xl pointer-events-auto">
                    <Play className="w-9 h-9 text-white ml-1 opacity-90" />
                  </div>
                </div>

                {/* Bottom Overlay - Instagram Reels Style */}
                <div className="absolute bottom-0 left-0 right-0 p-4 lg:p-6 pb-6 z-30 pointer-events-none">
                  
                  {/* Property Info (Left Side) */}
                  <div className="max-w-[calc(100%-4.5rem)] space-y-4 pointer-events-auto">
                    
                    {/* Current Room Label & Selectors */}
                    <div className="space-y-2">
                      <div className="flex items-center gap-2">
                        <Circle className="w-2 h-2 fill-emerald-400 text-emerald-400 animate-pulse" />
                        <span className="text-[10px] text-emerald-400 font-bold tracking-[0.2em]">{t('videos.now_playing', 'NOW PLAYING')}</span>
                      </div>
                      <h2 className="text-2xl lg:text-3xl font-black text-white tracking-tight drop-shadow-md">
                        {t(video.rooms?.[isActive ? activeRoom : 0] || video.rooms?.[0] || "room", (video.rooms?.[isActive ? activeRoom : 0] || video.rooms?.[0] || "room").split('.').pop() || "") as string}
                      </h2>
                      
                      <div className="flex items-center gap-2 overflow-x-auto scrollbar-hide py-1 -mx-2 px-2 mask-linear-fade">
                        {video.rooms?.map((room: string, i: number) => (
                          <button key={i} onClick={() => setActiveRoom(i)}
                            className={`flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-semibold whitespace-nowrap transition-all border border-transparent
                              ${(isActive ? activeRoom : 0) === i ? "bg-white text-black shadow-lg" : "bg-black/40 text-white/80 hover:bg-black/60 border-white/10 backdrop-blur-md"}`}>
                            {t(room, room.split('.').pop() || "") as string}
                          </button>
                        ))}
                      </div>
                    </div>
 
                    {/* Meta Data */}
                    <div className="space-y-2">
                      <div className="flex items-center gap-2 flex-wrap">
                        {video.tags?.slice(0, 3).map((tag: string, i: number) => (
                          <Badge key={i} className={`text-[9px] font-bold tracking-wider px-2.5 py-0.5 rounded-sm border border-white/10
                            ${i === 0 ? "bg-emerald-500/20 text-emerald-400" : "bg-white/10 text-white/80 backdrop-blur-md"}`}>
                            {i === 0 && <Star className="w-2.5 h-2.5 mr-1" />}
                            {tag}
                          </Badge>
                        ))}
                      </div>
                      <h3 className="text-lg lg:text-xl font-bold text-white tracking-wide leading-snug line-clamp-2 drop-shadow-md">{video.title}</h3>
                      <div className="flex items-center gap-2 text-xs text-slate-300 font-medium">
                        <div className="flex items-center gap-1"><MapPin className="w-3.5 h-3.5" />{video.location}</div>
                        <span>•</span>
                        <div className="flex items-center gap-1"><Clock className="w-3.5 h-3.5" />{video.time}</div>
                      </div>
                    </div>
                    
                    {/* Agency & CTA */}
                    <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pt-2">
                      <div className="flex items-center gap-2">
                        <div className="w-8 h-8 rounded-full bg-gradient-to-br from-indigo-500 to-purple-500 flex items-center justify-center text-white font-bold text-xs shadow-lg shrink-0">
                          {video.agency.charAt(0)}
                        </div>
                        <span className="text-sm font-semibold text-white/90 truncate max-w-[120px] sm:max-w-none">{video.agency}</span>
                      </div>
                      <button 
                        onClick={() => router.push(`/${i18n.language}/client/property/${video.id}`)}
                        className="bg-white text-black px-4 py-2 rounded-xl font-bold text-[10px] sm:text-xs tracking-wider uppercase hover:bg-emerald-400 hover:text-white transition-all shadow-xl shadow-black/20 w-fit shrink-0"
                      >
                        {t('videos.view_details', 'VIEW DETAILS')}
                      </button>
                    </div>
                  </div>
 
                  {/* Floating Action Buttons (Right Side) */}
                  <div className="absolute right-4 bottom-20 lg:bottom-6 z-40 flex flex-col items-center gap-4 pb-4 pointer-events-auto shrink-0">
                    <button onClick={() => setLiked(!liked)} className="flex flex-col items-center gap-1 group">
                      <div className={`w-11 h-11 rounded-full flex items-center justify-center transition-all ${liked ? "bg-red-500 text-white shadow-lg shadow-red-500/40 scale-110" : "bg-black/40 text-white border border-white/10 hover:bg-black/60 backdrop-blur-xl"}`}>
                        <Heart className={`w-5.5 h-5.5 ${liked ? "fill-white" : ""}`} />
                      </div>
                      <span className="text-[10px] text-white font-bold drop-shadow-md">3.2K</span>
                    </button>
                    <button className="flex flex-col items-center gap-1 group">
                      <div className="w-11 h-11 rounded-full bg-black/40 border border-white/10 backdrop-blur-xl text-white flex items-center justify-center hover:bg-black/60 transition-all">
                        <MessageCircle className="w-5.5 h-5.5" />
                      </div>
                      <span className="text-[10px] text-white font-bold drop-shadow-md">{t('videos.support', 'ASK')}</span>
                    </button>
                    <button className="flex flex-col items-center gap-1 group">
                      <div className="w-11 h-11 rounded-full bg-black/40 border border-white/10 backdrop-blur-xl text-white flex items-center justify-center hover:bg-black/60 transition-all">
                        <Share2 className="w-5.5 h-5.5" />
                      </div>
                      <span className="text-[10px] text-white font-bold drop-shadow-md">{t('videos.share', 'SHARE')}</span>
                    </button>
                    <button onClick={() => setIsAiModalOpen(true)} className="flex flex-col items-center gap-1 group mt-1">
                      <div className="w-11 h-11 rounded-full bg-gradient-to-br from-violet-600 to-indigo-600 text-white flex items-center justify-center hover:scale-110 transition-transform shadow-xl shadow-violet-600/40 border border-white/20">
                        <Sparkles className="w-5.5 h-5.5" />
                      </div>
                      <span className="text-[10px] text-white font-bold drop-shadow-md">AI HUB</span>
                    </button>
                  </div>
 
                </div>
              </div>
            );
          })}
        </div>

        {/* ═══════ RIGHT: DISCOVERY PANEL (HIDDEN ON MOBILE, VISIBLE >= LG) ═══════ */}
        <div className="hidden lg:flex w-[420px] bg-card border-l border-border flex-col shrink-0">
          {/* Header */}
          <div className="px-4 pt-24 pb-2 border-b border-border shrink-0 bg-card/95 backdrop-blur-md sticky top-0 z-20">
            <div className="flex items-center justify-between mb-3">
              <div className="flex items-center gap-1.5">
                <Sparkles className="w-4 h-4 text-violet-500 dark:text-violet-400" />
                <div className="text-[11px] font-black text-foreground tracking-widest">{t('videos.search', 'DISCOVER')}</div>
              </div>
              <div className="flex items-center gap-1.5 text-[9px] text-muted-foreground uppercase tracking-widest">
                <Search className="w-3 h-3" />
                <span className="font-semibold">{filtered.length} {t('videos.properties', 'PROPERTIES')}</span>
              </div>
            </div>

            {/* AI Modal Trigger */}
            <button 
              onClick={() => setIsAiModalOpen(true)}
              className="mb-3 w-full relative group overflow-hidden rounded-xl border border-border bg-background p-1"
            >
              <div className="absolute inset-0 bg-gradient-to-r from-blue-500/10 via-violet-500/10 to-fuchsia-500/10 group-hover:opacity-100 transition-opacity opacity-50" />
              <div className="relative flex items-center justify-center gap-2 py-3 px-4 bg-background/80 backdrop-blur-sm rounded-lg hover:bg-background/90 transition-colors shadow-inner">
                <Sparkles className="w-4 h-4 text-violet-500" />
                <span className="text-xs font-bold text-foreground tracking-wider uppercase">AI Search & Filters</span>
              </div>
            </button>
          </div>

          {/* Property Cards List */}
          <div className="flex-1 overflow-y-auto px-4 py-4 space-y-3 scrollbar-hide">
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
                  className={`w-full group text-left relative overflow-hidden rounded-2xl transition-all duration-300 border flex gap-3 p-2.5 
                    ${isActive ? "border-blue-500 bg-blue-500/5 dark:bg-[#1A1B1E] shadow-lg shadow-blue-500/10" : "border-border bg-background hover:bg-accent hover:border-border"}`}>
                  
                  {/* Thumbnail */}
                  <div className="relative w-[140px] h-[90px] rounded-lg overflow-hidden shrink-0 bg-black">
                    <video
                      src={p.image}
                      autoPlay
                      loop
                      muted
                      playsInline
                      className={`w-full h-full object-cover transition-transform duration-700 ${isActive ? 'scale-105' : 'group-hover:scale-105'}`}
                    />
                    <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent" />
                    <div className="absolute top-1.5 left-1.5 bg-black/70 backdrop-blur-sm rounded px-1.5 py-0.5">
                      <span className="text-[10px] font-bold text-white">{p.price}</span>
                    </div>
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
                    <h4 className={`text-xs font-bold leading-tight line-clamp-2 mb-1.5 transition-colors ${isActive ? 'text-foreground' : 'text-muted-foreground group-hover:text-foreground'}`}>{p.title}</h4>
                    <div className="space-y-1.5 mt-1">
                      <div className="flex items-center gap-1">
                        <div className="w-4 h-4 rounded-full bg-gradient-to-br from-blue-500 to-violet-500 flex items-center justify-center shrink-0">
                          <span className="text-[6px] font-bold text-white">{p.agency.charAt(0)}</span>
                        </div>
                        <span className="text-[10px] text-muted-foreground truncate">{p.agency}</span>
                        {p.verified && <Circle className="w-2.5 h-2.5 fill-blue-500 text-blue-500 shrink-0" />}
                      </div>
                      <div className="flex items-center justify-between">
                        <div className="flex items-center gap-2 text-[10px] text-muted-foreground">
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

      {/* AI Search Modal */}
      <Dialog open={isAiModalOpen} onOpenChange={setIsAiModalOpen}>
        <DialogContent className="sm:max-w-[500px] bg-background border-border shadow-2xl overflow-hidden p-0">
          <div className="p-6 pb-4 border-b border-border bg-card/50">
            <DialogTitle className="flex items-center gap-2 text-lg font-black tracking-tight text-foreground">
              <Sparkles className="w-5 h-5 text-violet-500" /> AI HUB
            </DialogTitle>
            <DialogDescription className="text-xs font-medium text-muted-foreground mt-1.5">
              {t('videos.ai_search_description', 'Describe your dream property. Our AI will automatically apply the perfect filters for you.')}
            </DialogDescription>
          </div>
          
          <div className="p-6 bg-card space-y-6">
            {/* AI Chat Search Input */}
            <form onSubmit={handleAISearch} className="relative group">
              <div className="absolute inset-0 bg-gradient-to-r from-blue-500/20 via-violet-500/20 to-fuchsia-500/20 rounded-xl blur-md opacity-0 group-focus-within:opacity-100 transition-opacity duration-500" />
              <div className="relative flex items-center w-full bg-background border border-border group-focus-within:border-violet-500/50 rounded-xl overflow-hidden shadow-inner transition-colors">
                <div className="pl-4 py-4 flex items-center justify-center">
                  {isAiSearching ? (
                    <Loader2 className="w-5 h-5 text-violet-500 animate-spin" />
                  ) : (
                    <Bot className="w-5 h-5 text-violet-500" />
                  )}
                </div>
                <input 
                  type="text" 
                  aria-label="AI search videos"
                  placeholder={t('videos.ai_search_placeholder', 'e.g. "Villas with a pool under $2M"')}
                  value={aiQuery}
                  onChange={(e) => setAiQuery(e.target.value)}
                  disabled={isAiSearching}
                  className="flex-1 bg-transparent border-none h-12 px-3 text-sm text-foreground font-medium placeholder:text-muted-foreground focus:outline-none focus:ring-0 disabled:opacity-50"
                />
                <button 
                  type="submit" 
                  disabled={isAiSearching}
                  aria-label="Submit AI search"
                  className="pr-4 pl-3 py-4 flex items-center justify-center hover:bg-muted transition-colors disabled:opacity-50"
                >
                  <Send className="w-5 h-5 text-muted-foreground hover:text-violet-500 transition-colors" />
                </button>
              </div>
            </form>

            {/* Advanced Filters */}
            <div className="space-y-3">
              <div className="flex items-center gap-2 mb-2">
                <Filter className="w-4 h-4 text-muted-foreground" />
                <h4 className="text-xs font-bold text-foreground uppercase tracking-widest">Active Filters</h4>
              </div>
              <div className="grid grid-cols-2 gap-3">
                 <Select value={listingType} onValueChange={setListingType}>
                    <SelectTrigger className="w-full h-10 bg-background border-border text-muted-foreground font-bold text-[10px] tracking-widest uppercase rounded-lg focus:ring-0 focus:border-blue-500/50">
                      <SelectValue placeholder="LISTING TYPE" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="ALL">ALL</SelectItem>
                      <SelectItem value="SALE">FOR SALE</SelectItem>
                      <SelectItem value="RENT">FOR RENT</SelectItem>
                      <SelectItem value="LEASE">LEASE</SelectItem>
                    </SelectContent>
                 </Select>

                 <Select value={propertyCategory} onValueChange={setPropertyCategory}>
                    <SelectTrigger className="w-full h-10 bg-background border-border text-muted-foreground font-bold text-[10px] tracking-widest uppercase rounded-lg focus:ring-0 focus:border-blue-500/50">
                      <SelectValue placeholder="CATEGORY" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="ALL">ALL CATS</SelectItem>
                      <SelectItem value="RESIDENTIAL">RESIDENTIAL</SelectItem>
                      <SelectItem value="COMMERCIAL">COMMERCIAL</SelectItem>
                      <SelectItem value="LAND">LAND</SelectItem>
                    </SelectContent>
                 </Select>

                 <Select value={propertyType} onValueChange={setPropertyType}>
                    <SelectTrigger className="w-full h-10 bg-background border-border text-muted-foreground font-bold text-[10px] tracking-widest uppercase rounded-lg focus:ring-0 focus:border-blue-500/50">
                      <SelectValue placeholder="PROPERTY TYPE" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="ALL">ALL TYPES</SelectItem>
                      <SelectItem value="DETACHED_HOUSE">HOUSE</SelectItem>
                      <SelectItem value="APARTMENT">APARTMENT</SelectItem>
                      <SelectItem value="VILLA">VILLA</SelectItem>
                      <SelectItem value="PENTHOUSE">PENTHOUSE</SelectItem>
                    </SelectContent>
                 </Select>

                 <Select value={beds} onValueChange={setBeds}>
                    <SelectTrigger className="w-full h-10 bg-background border-border text-muted-foreground font-bold text-[10px] tracking-widest uppercase rounded-lg focus:ring-0 focus:border-blue-500/50">
                      <SelectValue placeholder="BEDROOMS" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="ALL">ANY BEDS</SelectItem>
                      <SelectItem value="1">1+ BEDS</SelectItem>
                      <SelectItem value="2">2+ BEDS</SelectItem>
                      <SelectItem value="3">3+ BEDS</SelectItem>
                      <SelectItem value="4">4+ BEDS</SelectItem>
                    </SelectContent>
                 </Select>

                 <div className="relative">
                    <span className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground text-xs">$</span>
                    <input 
                      type="number" 
                      aria-label="Minimum price"
                      placeholder="MIN PRICE"
                      value={priceMin}
                      onChange={(e) => setPriceMin(e.target.value)}
                      className="w-full h-10 pl-7 pr-3 bg-background border border-border rounded-lg text-xs font-bold text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-blue-500/50"
                    />
                 </div>

                 <div className="relative">
                    <span className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground text-xs">$</span>
                    <input 
                      type="number" 
                      aria-label="Maximum price"
                      placeholder="MAX PRICE"
                      value={priceMax}
                      onChange={(e) => setPriceMax(e.target.value)}
                      className="w-full h-10 pl-7 pr-3 bg-background border border-border rounded-lg text-xs font-bold text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-blue-500/50"
                    />
                 </div>
                 
                 <Select value={sortBy} onValueChange={setSortBy}>
                    <SelectTrigger className="w-full h-10 col-span-2 bg-background border-border text-muted-foreground font-bold text-[10px] tracking-widest uppercase rounded-lg focus:ring-0 focus:border-blue-500/50">
                      <SelectValue placeholder="SORT BY" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="newest">NEWEST</SelectItem>
                      <SelectItem value="price_high">PRICE (HIGH-LOW)</SelectItem>
                      <SelectItem value="price_low">PRICE (LOW-HIGH)</SelectItem>
                      <SelectItem value="views">MOST VIEWED</SelectItem>
                    </SelectContent>
                 </Select>
              </div>
            </div>
            
            <button 
              onClick={() => setIsAiModalOpen(false)}
              className="w-full bg-violet-600 hover:bg-violet-700 text-white font-bold text-xs tracking-widest uppercase h-10 rounded-xl transition-colors"
            >
              Apply & Close
            </button>
          </div>
        </DialogContent>
      </Dialog>
    </>
  );
}
