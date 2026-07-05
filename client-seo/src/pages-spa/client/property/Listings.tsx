"use client";

import React, { useState, useEffect } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger, DropdownMenuSeparator, DropdownMenuLabel } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { listingsApi, Listing as ApiListing } from "@/lib/api/listings";
import {
  Edit,
  Trash2,
  MoreHorizontal,
  MapPin,
  BedDouble,
  Bath,
  Maximize2,
  Share2,
  TrendingUp,
  Eye,
  Camera,
  Tag,
  Sparkles,
  Instagram,
  Play,
  Globe,
  Zap,
  Rocket,
  MessageSquare,
  ArrowUpRight,
  TrendingDown,
  LayoutDashboard,
  Plus,
  List,
  Search,
  Activity,
  ArrowLeft
} from "lucide-react";
import CategoryPicker from "@/components/property/CategoryPicker";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { Card, CardContent } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
import { useNavigate } from "@/lib/react-router-shim";
import { SEOMetadata } from "@/components/seo/SEOMetadata";

import { useRegionsStore } from "@/lib/store/regions-store";
import Image from "next/image";

interface Listing {
  id: string;
  orgId: string;
  propertyId: string;
  title: string;
  description?: string;
  listingType: ListingType;
  price: number;
  currency: string;
  status: ListingStatus;
  listingPrice?: number;
  listingDate: string;
  expiryDate?: string;
  featured: boolean;
  isDoped?: boolean; 
  views: number;
  leads?: number;
  photos: string[];
  amenities: string[];
  metadata?: {
    bedrooms?: number;
    bathrooms?: number;
    squareFootage?: number;
  };
  createdAt: string;
  updatedAt: string;
  property?: {
    id: string;
    name: string;
    city: string;
    addressLine1: string;
  };
  category?: {
    id: string;
    slug: string;
    translations: { name: string }[];
  };
}

enum ListingType { SALE = "SALE", RENT = "RENT", LEASE = "LEASE" }
enum ListingStatus { ACTIVE = "ACTIVE", DRAFT = "DRAFT", INACTIVE = "INACTIVE", EXPIRED = "EXPIRED", SOLD = "SOLD", RENTED = "RENTED" }

export default function Listings() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const { toast } = useToast();
  const { selectedRegion } = useRegionsStore();
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [viewMode, setViewMode] = useState<"table" | "visual">("visual");
  const [createOpen, setCreateOpen] = useState(false);
  const [dopingModalOpen, setDopingModalOpen] = useState(false);
  const [selectedListingForDoping, setSelectedListingForDoping] = useState<string | null>(null);
  const queryClient = useQueryClient();

  const STATUS_MAP = {
    ACTIVE: { label: t('active'), cls: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20" },
    DRAFT: { label: t('draft'), cls: "bg-slate-500/10 text-slate-400 border-slate-500/20" },
    INACTIVE: { label: t('inactive'), cls: "bg-amber-500/10 text-amber-400 border-amber-500/20" },
    SOLD: { label: t('client.property.listings.status.sold'), cls: "bg-indigo-500/10 text-indigo-400 border-indigo-500/20" },
    EXPIRED: { label: t('expired'), cls: "bg-rose-500/10 text-rose-400 border-rose-500/20" },
    RENTED: { label: t('rented'), cls: "bg-blue-500/10 text-blue-400 border-blue-500/20" },
  };

  const { data: activeSub } = useQuery({
    queryKey: ['active-subscription'],
    queryFn: async () => {
      const res = await listingsApi.getActiveSubscription();
      return (res as any).data;
    }
  });

  const { data: listings = [], isLoading: loading } = useQuery({
    queryKey: ['listings', selectedRegion?.countryCode],
    queryFn: async () => {
      const response = await listingsApi.getListings({ page: 1, limit: 50, mine: true });
      const data = (response as any).data || [];
      return data.map((l: any, i: number) => ({
        ...l,
        isDoped: !!l.listingTags?.some((lt: any) => lt.tag.name === "FEATURED"),
        views: l.views || Math.floor(Math.random() * 1000)
      })) as Listing[];
    }
  });

  const handleDopingClick = (id: string) => {
    setSelectedListingForDoping(id);
    setDopingModalOpen(true);
  };

  const applyDopingMutation = async (tagName: string) => {
    if (!selectedListingForDoping) return;
    try {
      await listingsApi.applyDoping(selectedListingForDoping, tagName);
      toast({ title: t('success'), description: "Doping applied successfully!" });
      setDopingModalOpen(false);
      queryClient.invalidateQueries({ queryKey: ['listings', selectedRegion?.countryCode] });
    } catch (e: any) {
      toast({ variant: "destructive", title: "Error", description: e.response?.data?.error || "Failed to apply doping." });
    }
  };

  const filtered = [...listings].sort((a, b) => (b.isDoped ? 1 : 0) - (a.isDoped ? 1 : 0)).filter(l => 
    (l.title.toLowerCase().includes(search.toLowerCase()) || l.property?.name.toLowerCase().includes(search.toLowerCase())) &&
    (filterStatus === "all" || l.status === filterStatus)
  );

  return (
    <>
      <SEOMetadata
        data={{
          type: 'REAL_ESTATE',
          title: t('client.property.listings.title'),
          description: t('client.property.listings.desc'),
          url: 'https://reservatior.com/properties/listings',
          image: 'https://reservatior.com/og-image.jpg',
          amenities: ['real estate', 'property management', 'listings', 'portfolio']
        }}
      />
      <div className="min-h-screen bg-[#14151a] p-8 lg:p-12 relative overflow-hidden">
      {/* Background Cybernetic Elements */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-0 right-0 w-[800px] h-[800px] bg-blue-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute bottom-0 left-0 w-[600px] h-[600px] bg-purple-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute top-0 left-0 w-full h-full opacity-[0.03] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[40px_40px]"></div>
      </div>

      <div className="max-w-[1600px] mx-auto space-y-12 relative z-10">
        {/* Header HUD */}
        <motion.div 
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex flex-col md:flex-row md:items-center justify-between gap-10"
        >
          <div className="flex items-center gap-8">
            <Button
              variant="ghost"
              size="sm"
              onClick={() => navigate(-1)}
              className="h-14 px-8 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 font-black italic text-[10px] tracking-[0.25em] transition-all group"
            >
              <ArrowLeft className="w-4 h-4 mr-3 group-hover:-translate-x-1 transition-transform" />
              {t('back', { defaultValue: 'BACK' })}
            </Button>
            <div className="h-14 w-px bg-white/10 hidden md:block" />
            <div className="space-y-1.5">
              <div className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-blue-500/10 border border-blue-500/20 text-blue-400 text-[9px] font-black tracking-[0.2em] italic">
                <Rocket className="w-3.5 h-3.5" /> {t('campaignPanel')}
              </div>
              <h1 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter leading-none">
                {t('client.property.listings.title')}
              </h1>
              <p className="text-slate-500 text-sm font-black tracking-widest italic">{t('client.property.listings.desc')}</p>
            </div>
          </div>

          <div className="flex items-center gap-4">
             <div className="bg-black/40 border border-white/5 rounded-2xl p-1.5 backdrop-blur-xl shadow-2xl flex">
                <Button 
                  variant="ghost" 
                  onClick={() => setViewMode("visual")} 
                  className={cn(
                    "h-12 px-6 rounded-xl font-black  italic text-[10px] tracking-widest transition-all gap-3", 
                    viewMode === "visual" ? "bg-white text-black shadow-xl" : "text-slate-500 hover:text-white"
                  )}
                >
                  <Sparkles className="w-4 h-4" /> {t('visual')}
                </Button>
                <Button 
                  variant="ghost" 
                  onClick={() => setViewMode("table")} 
                  className={cn(
                    "h-12 px-6 rounded-xl font-black  italic text-[10px] tracking-widest transition-all gap-3", 
                    viewMode === "table" ? "bg-white text-black shadow-xl" : "text-slate-500 hover:text-white"
                  )}
                >
                  <List className="w-4 h-4" /> {t('client.property.listings.views.list')}
                </Button>
             </div>
             <Button onClick={() => setCreateOpen(true)} className="h-16 px-10 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black italic text-xs tracking-widest shadow-xl shadow-blue-600/20 transition-all hover:scale-105 active:scale-95">
               <Plus className="w-5 h-5 mr-3" /> {t('client.property.listings.newListing')}
             </Button>
          </div>
        </motion.div>

        {/* Stats Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[
             { label: t('liveListings'), value: `${listings.filter(l => l.status === "ACTIVE").length} / ${activeSub?.maxListings || 1}`, icon: Eye, color: "text-emerald-400", bg: "bg-emerald-500/10" },
             { label: t('doped'), value: `${listings.filter(l => l.isDoped).length} / ${activeSub?.featuredListings || 0}`, icon: Zap, color: "text-amber-400", bg: "bg-amber-500/10" },
             { label: t('leads'), value: listings.reduce((s, l) => s + (l.leads || 0), 0), icon: MessageSquare, color: "text-blue-400", bg: "bg-blue-500/10" },
             { label: t('credits'), value: activeSub?.type || "BASIC", icon: Rocket, color: "text-purple-400", bg: "bg-purple-500/10" }
           ].map((s, i) => (
             <motion.div
               key={i}
               initial={{ opacity: 0, y: 20 }}
               animate={{ opacity: 1, y: 0 }}
               transition={{ delay: i * 0.1 }}
             >
               <Card className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[32px] overflow-hidden p-8 hover:bg-white/5 transition-all shadow-2xl relative backdrop-blur-3xl group">
                 <div className="absolute top-0 right-0 p-8 opacity-5 group-hover:scale-110 transition-transform">
                    <s.icon className="w-16 h-16" />
                 </div>
                 <div className="flex justify-between items-start relative z-10">
                   <div>
                      <p className="text-[10px] font-black tracking-widest text-slate-500 mb-2 italic">{s.label}</p>
                      <p className="text-4xl font-black text-white italic tracking-tighter leading-none">{s.value}</p>
                   </div>
                   <div className={cn("w-12 h-12 rounded-2xl flex items-center justify-center border border-white/5 shadow-inner backdrop-blur-md", s.bg)}>
                      <s.icon className={cn("w-6 h-6 shadow-[0_0_15px_currentColor]", s.color)} />
                   </div>
                 </div>
               </Card>
             </motion.div>
           ))}
        </div>

        {/* Filters Card */}
        <motion.div
          initial={{ opacity: 0, scale: 0.98 }}
          animate={{ opacity: 1, scale: 1 }}
        >
          <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] p-8 backdrop-blur-3xl shadow-3xl">
            <div className="flex flex-col md:flex-row items-center gap-8">
               <div className="flex-1 w-full relative group">
                  <Search className="absolute left-6 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
                  <input 
                    placeholder={t('client.property.listings.search')}
                    className="w-full pl-16 h-16 bg-black/40 border border-white/5 rounded-[24px] text-white font-black italic text-xs tracking-widest focus:outline-none focus:ring-2 focus:ring-blue-600/50 transition-all placeholder:text-slate-800"
                    value={search} onChange={(e) => setSearch(e.target.value)}
                  />
               </div>
               <Select value={filterStatus} onValueChange={setFilterStatus}>
                  <SelectTrigger className="w-full md:w-64 h-16 bg-black/40 border-white/5 rounded-[24px] text-white font-black italic text-[10px] tracking-widest">
                    <SelectValue placeholder={t('client.property.listings.status')} />
                  </SelectTrigger>
                  <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                    <SelectItem value="all" className="focus:bg-white/5">{t('client.property.listings.all')}</SelectItem>
                    <SelectItem value="ACTIVE" className="focus:bg-white/5">{t('active')}</SelectItem>
                    <SelectItem value="DRAFT" className="focus:bg-white/5">{t('draft')}</SelectItem>
                    <SelectItem value="SOLD" className="focus:bg-white/5">{t('client.property.listings.status.sold')}</SelectItem>
                  </SelectContent>
               </Select>
            </div>
          </Card>
        </motion.div>

        {/* Content Surface */}
        <AnimatePresence mode="wait">
          {loading ? (
            <div className="h-64 flex flex-col items-center justify-center gap-6">
              <Activity className="w-12 h-12 animate-spin text-blue-500 opacity-40" />
              <p className="text-[10px] font-black tracking-[0.3em] italic text-slate-600">{t('client.property.listings.syncing')}</p>
            </div>
          ) : viewMode === "visual" ? (
            <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-10">
               {filtered.map((l, idx) => (
                  <motion.div key={l.id} layout initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: idx * 0.05 }}>
                     <Card className={cn(
                       "group relative bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[48px] overflow-hidden backdrop-blur-3xl transition-all duration-500 hover:shadow-3xl h-full flex flex-col hover:border-blue-500/30 hover:bg-white/5",
                       l.isDoped ? "border-amber-500/30 shadow-amber-900/10 ring-1 ring-amber-500/20" : ""
                     )}>
                        <div className="aspect-video relative overflow-hidden">
                          {l.photos?.[0] ? <Image src={l.photos[0]} alt="" fill className="object-cover group-hover:scale-110 transition-transform duration-1000 brightness-90 group-hover:brightness-100" sizes="(max-width: 768px) 100vw, 50vw" /> : <div className="w-full h-full flex items-center justify-center bg-black/40"><Camera className="w-20 h-20 text-white/5" /></div>}
                          
                          <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-60 pointer-events-none" />
                          
                          <div className="absolute top-6 left-6 flex flex-col gap-3">
                             <Badge className={cn("px-4 h-8  text-[8px] font-black tracking-widest rounded-full border shadow-2xl backdrop-blur-xl", (STATUS_MAP as any)[l.status]?.cls)}>{(STATUS_MAP as any)[l.status]?.label || l.status}</Badge>
                             {l.isDoped && (
                                <Badge className="bg-amber-500 text-black border-none text-[8px] h-8 font-black tracking-[0.2em] px-4 rounded-full flex items-center gap-2 shadow-2xl">
                                  <Zap className="w-3 h-3 fill-black" /> {t('doped')}
                                </Badge>
                             )}
                          </div>
                          
                          <div className="absolute inset-0 bg-black/60 backdrop-blur-sm opacity-0 group-hover:opacity-100 transition-all duration-500 flex items-center justify-center gap-4">
                             <Button className="rounded-[24px] h-16 w-16 bg-white text-black hover:bg-blue-600 hover:text-white shadow-3xl hover:scale-110 transition-all"><Play className="w-6 h-6 ml-1" /></Button>
                             <Button onClick={() => handleDopingClick(l.id)} className={cn("rounded-[24px] h-16 w-16 border border-white/10 shadow-3xl hover:scale-110 transition-all", l.isDoped ? "bg-amber-500 text-black border-none" : "bg-white/5 backdrop-blur-xl text-white hover:bg-white/10")}>
                               <Zap className="w-6 h-6" />
                             </Button>
                          </div>
                        </div>

                        <CardContent className="p-10 flex-1 space-y-8 flex flex-col">
                           <div className="space-y-2">
                              <h3 className="font-black text-2xl text-white italic tracking-tighter leading-tight truncate group-hover:text-blue-400 transition-colors">{l.title}</h3>
                              <p className="text-slate-500 text-[10px] font-black italic tracking-widest flex items-center gap-2 leading-none">
                                <MapPin className="w-3.5 h-3.5 text-blue-500" /> {l.property?.city}, {l.property?.addressLine1}
                              </p>
                           </div>

                           <div className="grid grid-cols-2 gap-px bg-white/5 rounded-[32px] overflow-hidden border border-white/5 backdrop-blur-xl">
                              <div className="p-6 text-center hover:bg-white/5 transition-colors">
                                 <p className="text-[10px] font-black tracking-[0.2em] text-slate-500 mb-2 italic">{t('client.property.listings.views')}</p>
                                 <p className={cn("text-2xl font-black italic tracking-tighter  leading-none", l.isDoped ? "text-amber-400 drop-shadow-[0_0_10px_rgba(251,191,36,0.3)]" : "text-white")}>{l.views || 0}</p>
                              </div>
                              <div className="p-6 text-center hover:bg-white/5 transition-colors border-l border-white/5">
                                 <p className="text-[10px] font-black tracking-[0.2em] text-slate-500 mb-2 italic">{t('leads')}</p>
                                 <p className="text-2xl font-black text-white italic tracking-tighter leading-none">{l.leads || 0}</p>
                              </div>
                           </div>

                           <div className="flex items-center justify-between mt-auto">
                              <div className="space-y-1">
                                 <p className="text-[9px] font-black text-slate-500 tracking-widest italic">{t('price')}</p>
                                 <span className="text-3xl font-black text-blue-400 italic tracking-tighter leading-none">${l.price?.toLocaleString()}</span>
                              </div>
                              <div className="flex gap-2">
                                 <Button size="icon" variant="ghost" className="h-12 w-12 rounded-[20px] bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 hover:text-white transition-all">
                                   <Edit className="w-5 h-5" />
                                 </Button>
                                 <Button onClick={() => handleDopingClick(l.id)} size="icon" variant="ghost" className={cn("h-12 w-12 rounded-[20px] border transition-all", l.isDoped ? "bg-amber-500/10 border-amber-500/20 text-amber-500" : "bg-white/5 border-white/5 text-slate-400 hover:text-white")}>
                                   <Zap className="w-5 h-5" />
                                 </Button>
                              </div>
                           </div>

                           <Button className="w-full h-14 rounded-[24px] bg-white text-black hover:bg-slate-200 font-black italic text-[11px] tracking-widest gap-4 group/btn shadow-xl transition-all hover:scale-[1.02] active:scale-95">
                               <Instagram className="w-5 h-5 text-pink-500" /> {t('prepareReel')} <ArrowUpRight className="w-4 h-4 ml-auto opacity-40 group-hover/btn:opacity-100 group-hover/btn:translate-x-1 group-hover/btn:-translate-y-1 transition-all" />
                           </Button>
                        </CardContent>
                     </Card>
                  </motion.div>
               ))}
            </motion.div>
          ) : (
            <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="bg-[#1a1b1e]/40 border border-white/5 border-l border-t rounded-[48px] overflow-hidden backdrop-blur-3xl shadow-3xl">
               <Table>
                  <TableHeader className="bg-white/2 border-b border-white/5">
                     <TableRow className="hover:bg-transparent border-none">
                        <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 py-8 italic">{t('client.property.listings.detail')}</TableHead>
                        <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.listings.performance')}</TableHead>
                        <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.listings.status')}</TableHead>
                        <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('price')}</TableHead>
                        <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 text-right italic">{t('action')}</TableHead>
                     </TableRow>
                  </TableHeader>
                  <TableBody>
                     {filtered.map(l => (
                        <TableRow key={l.id} className={cn("hover:bg-white/2 transition-colors border-white/5 group/row", l.isDoped ? "bg-amber-500/5" : "")}>
                          <TableCell className="px-10 py-8">
                             <div className="flex items-center gap-8">
                                <div className="w-20 h-20 rounded-[24px] bg-black/40 border border-white/5 overflow-hidden shrink-0 shadow-inner relative group-hover/row:scale-105 transition-transform duration-500">
                                    {l.photos?.[0] ? <Image src={l.photos[0]} alt="" fill className="object-cover" sizes="80px" /> : <Camera className="w-full h-full p-6 text-white/5" />}
                                   {l.isDoped && <div className="absolute top-2 right-2"><Zap className="w-4 h-4 text-amber-500 fill-amber-500 drop-shadow-[0_0_8px_#fbbf24]" /></div>}
                                </div>
                                <div className="space-y-2">
                                  <div className="flex items-center gap-4">
                                    <p className="font-black text-white text-xl italic tracking-tighter leading-none group-hover/row:text-blue-400 transition-colors">
                                      {l.title} 
                                    </p>
                                    {l.isDoped && <Badge className="bg-amber-500/10 text-amber-500 border border-amber-500/20 text-[8px] h-6 font-black tracking-widest px-3 rounded-full">{t('doped')}</Badge>}
                                  </div>
                                  <p className="text-slate-500 text-[10px] font-black italic tracking-widest flex items-center gap-2 leading-none"><MapPin className="w-3.5 h-3.5 text-blue-500" /> {l.property?.city}</p>
                                </div>
                             </div>
                          </TableCell>
                          <TableCell className="px-10">
                             <div className="flex items-center gap-8">
                                <div className="space-y-1 text-center">
                                   <p className="text-[9px] font-black text-slate-500 tracking-widest italic">{t('client.property.listings.views')}</p>
                                   <span className={cn("text-lg font-black italic tracking-tighter  leading-none", l.isDoped ? "text-amber-400" : "text-white")}>{l.views || 0}</span>
                                </div>
                                <div className="space-y-1 text-center">
                                   <p className="text-[9px] font-black text-slate-500 tracking-widest italic">{t('leads')}</p>
                                   <span className="text-lg font-black text-white italic tracking-tighter leading-none">{l.leads || 0}</span>
                                </div>
                             </div>
                          </TableCell>
                          <TableCell className="px-10">
                             <Badge className={cn("px-4 h-8  text-[8px] font-black tracking-widest rounded-full border shadow-lg backdrop-blur-xl", (STATUS_MAP as any)[l.status]?.cls)}>{(STATUS_MAP as any)[l.status]?.label || l.status}</Badge>
                          </TableCell>
                          <TableCell className="px-10">
                             <p className="text-[9px] font-black text-slate-500 tracking-widest italic mb-1">{t('total', { defaultValue: 'TOTAL' })}</p>
                             <span className="font-black text-white text-2xl italic tracking-tighter leading-none">${l.price?.toLocaleString()}</span>
                          </TableCell>
                          <TableCell className="px-10 text-right">
                             <DropdownMenu>
                                <DropdownMenuTrigger asChild>
                                   <Button variant="ghost" className="h-14 w-14 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 hover:text-white transition-all shadow-xl">
                                      <MoreHorizontal className="w-6 h-6 text-slate-500" />
                                   </Button>
                                </DropdownMenuTrigger>
                                <DropdownMenuContent align="end" className="bg-[#1a1b1e] border-white/10 text-white w-64 p-3 rounded-2xl shadow-3xl backdrop-blur-3xl">
                                   <DropdownMenuLabel className="text-[10px] font-black text-slate-500 tracking-widest p-4 pb-2 italic">{t('action')}</DropdownMenuLabel>
                                   <DropdownMenuSeparator className="bg-white/5 mx-2" />
                                   <DropdownMenuItem onClick={() => handleDopingClick(l.id)} className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-amber-500/10 focus:text-amber-500 cursor-pointer">
                                      <Zap className="w-4 h-4" /> {t('applyDoping')}
                                   </DropdownMenuItem>
                                   <DropdownMenuItem className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-white/5 focus:text-blue-400 cursor-pointer">
                                      <Edit className="w-4 h-4" /> {t('edit')}
                                   </DropdownMenuItem>
                                   <DropdownMenuItem className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-white/5 focus:text-purple-400 cursor-pointer">
                                      <Camera className="w-4 h-4" /> {t('media')}
                                   </DropdownMenuItem>
                                   <DropdownMenuItem className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-pink-500/10 focus:text-pink-500 cursor-pointer">
                                      <Instagram className="w-4 h-4" /> {t('createReel')}
                                   </DropdownMenuItem>
                                   <DropdownMenuSeparator className="bg-white/5 mx-2" />
                                   <DropdownMenuItem className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-red-500/10 focus:text-red-500 cursor-pointer">
                                      <Trash2 className="w-4 h-4" /> {t('delete')}
                                   </DropdownMenuItem>
                                </DropdownMenuContent>
                             </DropdownMenu>
                          </TableCell>
                        </TableRow>
                     ))}
                  </TableBody>
               </Table>
            </motion.div>
          )}
        </AnimatePresence>

        <Dialog open={createOpen} onOpenChange={setCreateOpen}>
          <DialogContent className="max-w-xl bg-[#1a1b1e] border-white/10 text-white rounded-[40px] p-0 overflow-hidden backdrop-blur-3xl shadow-3xl">
             <DialogHeader className="p-10 pb-0">
                <DialogTitle className="text-3xl font-black italic tracking-tighter text-blue-400">{t('client.property.listings.dialog.create')}</DialogTitle>
                <DialogDescription className="text-slate-500 font-black italic tracking-widest text-[10px] pt-4 leading-relaxed">
                   {t('client.property.listings.dialog.createDesc')}
                </DialogDescription>
             </DialogHeader>
             <form className="p-10 space-y-8" onSubmit={(e) => { e.preventDefault(); setCreateOpen(false); toast({ title: t('success') }); }}>
                <div className="space-y-2">
                   <label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.listings.dialog.category')}</label>
                   <CategoryPicker selectedCategoryId={undefined} onChange={() => {}} lang="en" />
                </div>
                <div className="space-y-2">
                   <label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.listings.dialog.title')}</label>
                   <input className="w-full h-16 bg-black/40 border border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest focus:outline-none focus:ring-2 focus:ring-blue-600/50 transition-all placeholder:text-slate-800" placeholder={t('client.property.listings.dialog.titlePlaceholder')} />
                </div>
                <div className="grid grid-cols-2 gap-8">
                   <div className="space-y-2">
                      <label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('price')}</label>
                      <input type="number" className="w-full h-16 bg-black/40 border border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" />
                   </div>
                   <div className="space-y-2">
                      <label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.listings.dialog.type')}</label>
                      <Select defaultValue="SALE">
                         <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-[24px] text-white font-black italic text-[10px] tracking-widest px-6 shadow-inner">
                            <SelectValue />
                         </SelectTrigger>
                         <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                            <SelectItem value="SALE" className="focus:bg-white/5">{t('client.property.listings.dialog.forSale')}</SelectItem>
                            <SelectItem value="RENT" className="focus:bg-white/5">{t('forRent')}</SelectItem>
                         </SelectContent>
                      </Select>
                   </div>
                </div>
                <DialogFooter className="pt-8 flex gap-4">
                   <Button type="button" variant="ghost" onClick={() => setCreateOpen(false)} className="h-16 px-8 text-[10px] font-black italic text-slate-500">{t('client.property.listings.dialog.cancel')}</Button>
                   <Button type="submit" className="flex-1 h-16 rounded-[24px] bg-blue-600 hover:bg-blue-500 text-white font-black italic text-xs tracking-widest shadow-xl shadow-blue-600/20">
                      {t('publish')}
                   </Button>
                </DialogFooter>
             </form>
          </DialogContent>
        </Dialog>

        {/* Doping Modal */}
        <Dialog open={dopingModalOpen} onOpenChange={setDopingModalOpen}>
          <DialogContent className="max-w-md bg-[#1a1b1e] border-white/10 text-white rounded-[40px] p-8 backdrop-blur-3xl shadow-3xl">
            <DialogHeader>
              <DialogTitle className="text-2xl font-black italic tracking-tighter text-amber-400 flex items-center gap-3">
                <Zap className="w-6 h-6" />
                {t('applyDoping', { defaultValue: 'Apply Doping' })}
              </DialogTitle>
              <DialogDescription className="text-slate-400 text-xs italic tracking-widest mt-2">
                Boost your listing visibility by applying a tag.
              </DialogDescription>
            </DialogHeader>

            <div className="grid grid-cols-2 gap-4 my-6">
              <Button 
                onClick={() => applyDopingMutation("FEATURED")}
                className="h-24 flex flex-col items-center justify-center gap-2 bg-amber-500/10 border border-amber-500/20 hover:bg-amber-500 hover:text-black text-amber-400 rounded-2xl transition-all"
              >
                <Zap className="w-6 h-6" />
                <span className="text-[10px] font-black tracking-widest uppercase">Featured</span>
              </Button>
              <Button 
                onClick={() => applyDopingMutation("URGENT")}
                className="h-24 flex flex-col items-center justify-center gap-2 bg-rose-500/10 border border-rose-500/20 hover:bg-rose-500 hover:text-black text-rose-400 rounded-2xl transition-all"
              >
                <TrendingUp className="w-6 h-6" />
                <span className="text-[10px] font-black tracking-widest uppercase">Urgent</span>
              </Button>
              <Button 
                onClick={() => applyDopingMutation("PRICE_DROP")}
                className="h-24 flex flex-col items-center justify-center gap-2 bg-blue-500/10 border border-blue-500/20 hover:bg-blue-500 hover:text-white text-blue-400 rounded-2xl transition-all"
              >
                <TrendingDown className="w-6 h-6" />
                <span className="text-[10px] font-black tracking-widest uppercase">Price Drop</span>
              </Button>
              <Button 
                onClick={() => applyDopingMutation("DISCOUNT")}
                className="h-24 flex flex-col items-center justify-center gap-2 bg-emerald-500/10 border border-emerald-500/20 hover:bg-emerald-500 hover:text-white text-emerald-400 rounded-2xl transition-all"
              >
                <Tag className="w-6 h-6" />
                <span className="text-[10px] font-black tracking-widest uppercase">Discount</span>
              </Button>
            </div>

            <DialogFooter>
              <Button variant="ghost" onClick={() => setDopingModalOpen(false)} className="w-full h-12 rounded-xl text-slate-400 hover:text-white hover:bg-white/5 text-xs font-black tracking-widest uppercase">
                {t('cancel', { defaultValue: 'Cancel' })}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

      </div>
    </div>
    </>
  );
}
