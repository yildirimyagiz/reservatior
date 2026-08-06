"use client";

import { useState, useEffect } from "react";
import { useSearchParams } from "@/lib/react-router-shim";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Home, Search, Filter, Building, Building2, ShieldCheck, X, MapPin, Zap, TrendingUp, Activity, Layers, Sparkles, ArrowUpRight, Maximize2, Compass, Navigation } from "lucide-react";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { cn } from "@/lib/utils";
import { m, AnimatePresence } from "framer-motion";
import { useTranslation } from "react-i18next";
import { apiClient } from "@/lib/api/client";
interface Property {
  id: string;
  orgId: string;
  type: "DETACHED_HOUSE" | "APARTMENT" | "CONDO" | "TOWNHOUSE" | "VILLA" | "STUDIO" | "LOFT" | "PENTHOUSE";
  name: string;
  region: string;
  currency: string;
  addressLine1: string;
  addressLine2?: string;
  city: string;
  state?: string;
  zip?: string;
  country: string;
  lat?: number;
  lng?: number;
  neighborhoodId?: string;
  bedrooms?: number;
  bathrooms?: number;
  areaSqm?: number;
  yearBuilt?: number;
  propertyCategory: "RESIDENTIAL" | "COMMERCIAL" | "INDUSTRIAL" | "LAND" | "MIXED_USE";
  listingType: "SALE" | "RENT" | "SHORT_TERM_RENTAL" | "LONG_TERM_RENTAL";
  listingStatus: "AVAILABLE" | "PENDING" | "SOLD" | "RENTED" | "OFF_MARKET" | "COMING_SOON";
  listingPrice?: number;
  originalPrice?: number;
  pricePerSqFt?: number;
  mlsNumber?: string;
  daysOnMarket?: number;
  parkingSpaces?: number;
  poolType?: string;
  heatingType?: string;
  coolingType?: string;
  accessibilityCompliance: boolean;
  createdAt: string;
  updatedAt: string;
}
interface SearchFilters {
  search: string;
  propertyTypes: string[];
  categories: string[];
  listingTypes: string[];
  listingStatuses: string[];
  priceRange: [number, number];
  bedrooms: [number, number];
  bathrooms: [number, number];
  areaRange: [number, number];
  sortBy: "price_asc" | "price_desc" | "date_asc" | "date_desc" | "size_asc" | "size_desc" | "rating_desc";
  featuredOnly: boolean;
  verifiedOnly: boolean;
  radius: number;
  mapBounds: {
    north: number;
    south: number;
    east: number;
    west: number;
  };
  promotionType?: string;
}
export default function PropertySearch() {
  const {
    t
  } = useTranslation();
  const searchParams = useSearchParams() || new URLSearchParams();
  const router = useRouter();
  const [properties, setProperties] = useState<Property[]>([]);
  const [filteredProperties, setFilteredProperties] = useState<Property[]>([]);
  const [showFilters, setShowFilters] = useState(false);
  const [showPropertyCards, setShowPropertyCards] = useState(true);
  const [isMapLoading, setIsMapLoading] = useState(true);
  const [isGlobal, setIsGlobal] = useState(false);
  const [filters, setFilters] = useState<SearchFilters>({
    search: searchParams.get("search") || "",
    propertyTypes: searchParams.get("types")?.split(",") || [],
    categories: searchParams.get("categories")?.split(",") || [],
    listingTypes: searchParams.get("listingTypes")?.split(",") || [],
    listingStatuses: searchParams.get("statuses")?.split(",") || [],
    priceRange: [parseInt(searchParams.get("minPrice") || "0"), parseInt(searchParams.get("maxPrice") || "10000000")],
    bedrooms: [parseInt(searchParams.get("minBedrooms") || "0"), parseInt(searchParams.get("maxBedrooms") || "10")],
    bathrooms: [parseInt(searchParams.get("minBathrooms") || "0"), parseInt(searchParams.get("maxBathrooms") || "10")],
    areaRange: [parseInt(searchParams.get("minArea") || "0"), parseInt(searchParams.get("maxArea") || "10000")],
    sortBy: searchParams.get("sort") as any || "date_desc",
    featuredOnly: searchParams.get("featured") === "true",
    verifiedOnly: searchParams.get("verified") === "true",
    radius: parseInt(searchParams.get("radius") || "25"),
    mapBounds: {
      north: parseFloat(searchParams.get("north") || "41.2"),
      south: parseFloat(searchParams.get("south") || "40.8"),
      east: parseFloat(searchParams.get("east") || "29.2"),
      west: parseFloat(searchParams.get("west") || "28.8")
    },
    promotionType: searchParams.get("promotionType") || "ALL"
  });
  useEffect(() => {
    const fetchProperties = async () => {
      setIsMapLoading(true);
      try {
        const endpoint = isGlobal ? '/search/global' : '/properties';
        const params: any = {};
        if (filters.search) params.keyword = filters.search;
        
        const response: any = await apiClient.get(endpoint, params).catch(() => null);
        
        if (response && response.data && response.data.length > 0) {
          setProperties(response.data);
          setFilteredProperties(response.data);
        } else {
          setProperties([]);
          setFilteredProperties([]);
        }
      } catch (err) {
        console.error(err);
      } finally {
        setIsMapLoading(false);
      }
    };
    fetchProperties();
  }, [filters.search, isGlobal]);
  useEffect(() => {
    const params = new URLSearchParams();
    if (filters.search) params.set("search", filters.search);
    if (filters.propertyTypes.length > 0) params.set("types", filters.propertyTypes.join(","));
    if (filters.priceRange[0] > 0) params.set("minPrice", filters.priceRange[0].toString());
    if (filters.priceRange[1] < 10000000) params.set("maxPrice", filters.priceRange[1].toString());
    if (filters.promotionType && filters.promotionType !== "ALL") params.set("promotionType", filters.promotionType);
    router.replace('?' + params.toString());
  }, [filters, router]);
  useEffect(() => {
    let filtered = [...properties];
    if (filters.search) {
      filtered = filtered.filter(p => p.name.toLowerCase().includes(filters.search.toLowerCase()));
    }
    setFilteredProperties(filtered);
  }, [properties, filters]);
  const getPropertyIcon = (type: string) => {
    switch (type) {
      case "APARTMENT":
        return <Building className="w-5 h-5" />;
      case "CONDO":
        return <Building2 className="w-5 h-5" />;
      default:
        return <Home className="w-5 h-5" />;
    }
  };
  const getStatusConfig = (status: string) => {
    switch (status) {
      case "AVAILABLE":
        return {
          label: t("available"),
          color: 'bg-success/10 text-success border-success/20'
        };
      case "PENDING":
        return {
          label: t("financialPayoutsStatusPending"),
          color: 'bg-warning/10 text-orange-400 border-warning/20'
        };
      default:
        return {
          label: t("offline"),
          color: 'bg-muted text-muted-foreground border-slate-500/20'
        };
    }
  };
  const formatPrice = (price: number, currency: string) => {
    return new Intl.NumberFormat("en-US", {
      style: "currency",
      currency,
      minimumFractionDigits: 0
    }).format(price);
  };
  return <div className="h-screen flex flex-col bg-background overflow-hidden">
      {/* Search HUD Header */}
      <div className="bg-card/60 backdrop-blur-3xl border-b border-white/5 z-40 px-8 h-20 flex items-center justify-between shadow-2xl relative">
          <div className="absolute top-0 left-0 w-1/3 h-px bg-gradient-to-r from-brand via-transparent to-transparent opacity-50"></div>
          <div className="flex items-center gap-6 flex-1">
              <div className="flex items-center gap-3">
                 <div className="h-10 w-10 rounded-xl bg-blue-600/20 border border-blue-500/30 flex items-center justify-center">
                    <Compass className="w-5 h-5 text-brand animate-pulse" />
                 </div>
                 <div>
                    <h2 className="text-xl font-black text-white italic tracking-tighter leading-none">{t("propertySearchTitle")}</h2>
                    <p className="text-[9px] font-black text-muted-foreground tracking-widest italic mt-1">{t("propertySearchSubtitle")}</p>
                 </div>
              </div>
              
              <div className="relative group flex-1 max-w-xl ml-4">
                <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-brand transition-colors" />
                <Input placeholder={t("propertySearchPlaceholder")} value={filters.search} onChange={e => setFilters({
            ...filters,
            search: e.target.value
          })} className="bg-black/40 border-white/5 rounded-2xl pl-12 h-14 text-white focus:ring-blue-500/20 focus:border-blue-500/40 transition-all font-medium border-l border-t" />
              </div>
          </div>
          
          <div className="flex items-center gap-4">
              <Select value={filters.promotionType || "ALL"} onValueChange={(val) => setFilters({...filters, promotionType: val})}>
                <SelectTrigger className="w-[180px] h-14 bg-white/5 border-white/5 text-muted-foreground font-black text-[10px] tracking-widest italic rounded-2xl hover:text-white transition-all">
                  <SelectValue placeholder={t("client.src.promotion.title")} />
                </SelectTrigger>
                <SelectContent className="bg-card/95 border-white/10 text-white font-black text-[10px] tracking-widest italic backdrop-blur-3xl rounded-xl">
                  <SelectItem value="ALL">{t("client.src.promotion.all")}</SelectItem>
                  <SelectItem value="FEATURED">{t("client.src.promotion.featured")}</SelectItem>
                  <SelectItem value="URGENT">{t("client.src.promotion.urgent")}</SelectItem>
                  <SelectItem value="PRICE_REDUCED">{t("client.src.promotion.price_reduced")}</SelectItem>
                  <SelectItem value="BEST_DEAL">{t("client.src.promotion.best_deal")}</SelectItem>
                </SelectContent>
              </Select>
              <Button 
    variant="outline" 
    onClick={() => setIsGlobal(!isGlobal)} 
    className={cn("h-14 px-6 rounded-2xl border-white/5 bg-white/5 text-[10px] font-black tracking-widest italic transition-all gap-3 overflow-hidden group", isGlobal ? "bg-orange-600 text-white border-orange-500 shadow-xl shadow-orange-600/20" : "text-muted-foreground hover:text-white")}
  >
    <Activity className="w-4 h-4" />
    {isGlobal ? "GLOBAL SEARCH" : "LOCAL SEARCH"}
  </Button>
  <Button variant="outline" onClick={() => setShowFilters(!showFilters)} className={cn("h-14 px-6 rounded-2xl border-white/5 bg-white/5 text-[10px] font-black  tracking-widest italic transition-all gap-3 overflow-hidden group", showFilters ? "bg-blue-600 text-white border-blue-500 shadow-xl shadow-blue-600/20" : "text-muted-foreground hover:text-white")}>
                <Filter className={cn("w-4 h-4 transition-transform", showFilters && "rotate-180")} />
                {t("tacticalFilters")}
                {showFilters && <div className="absolute inset-0 bg-blue-400/10 animate-pulse" />}
              </Button>
              <div className="h-14 w-px bg-white/5 mx-2" />
              <Button variant="outline" className="h-14 w-14 rounded-2xl border-white/5 bg-white/5 text-muted-foreground hover:text-white transition-all shadow-xl" aria-label={t("common.expand")}>
                 <Maximize2 className="w-5 h-5" />
              </Button>
          </div>
      </div>

      <div className="flex-1 flex overflow-hidden relative">
        {/* Spatial Matrix Sub-HUD (Filters Overlay) */}
        <AnimatePresence>
          {showFilters && <m.div initial={{
          height: 0,
          opacity: 0
        }} animate={{
          height: 'auto',
          opacity: 1
        }} exit={{
          height: 0,
          opacity: 0
        }} className="absolute top-0 left-0 w-full bg-card/90 backdrop-blur-2xl border-b border-white/5 z-30 overflow-hidden shadow-3xl">
              <div className="p-8 grid grid-cols-4 gap-8">
                 <div className="space-y-3">
                    <p className="text-[10px] font-black text-muted-foreground tracking-widest italic flex items-center gap-2">
                       <Layers className="w-3 h-3 text-brand" /> {t("taxonomy")}
                    </p>
                    <div className="grid grid-cols-2 gap-2">
                       {['VILLA', 'APARTMENT', 'CONDO', 'STUDIO'].map(type => <Button key={type} variant="outline" className="h-10 rounded-xl border-white/5 bg-black/20 text-[8px] font-black italic tracking-widest text-muted-foreground hover:text-white hover:bg-white/5 transition-all">
                            {type}
                         </Button>)}
                    </div>
                 </div>
                 
                 <div className="space-y-3">
                    <p className="text-[10px] font-black text-muted-foreground tracking-widest italic flex items-center gap-2">
                       <TrendingUp className="w-3 h-3 text-success" /> {t("fiscalCeiling")}
                    </p>
                    <div className="space-y-4">
                       <div className="h-2 bg-white/5 rounded-full overflow-hidden relative">
                          <div className="absolute inset-y-0 left-0 bg-blue-600 shadow-[0_0_10px_#3b82f6]" style={{
                    width: '60%'
                  }}></div>
                       </div>
                       <div className="flex justify-between items-center text-[10px] font-black text-white italic tracking-tighter">
                          <span>$0</span>
                          <span className="text-brand">$2,450,000</span>
                       </div>
                    </div>
                 </div>

                 <div className="space-y-3">
                    <p className="text-[10px] font-black text-muted-foreground tracking-widest italic flex items-center gap-2">
                       <Activity className="w-3 h-3 text-violet-500" /> {t("structuralSync")}
                    </p>
                    <div className="flex gap-2">
                       {[1, 2, 3, 4, '5+'].map(num => <Button key={num} variant="outline" className="h-10 flex-1 rounded-xl border-white/5 bg-black/20 text-[8px] font-black text-muted-foreground hover:text-white transition-all">
                            {num}{t("client.src.br")}</Button>)}
                    </div>
                 </div>
                 
                 <div className="flex items-end pb-1">
                    <Button className="w-full h-14 rounded-2xl bg-blue-600 hover:bg-brand/100 text-white font-black text-[10px] tracking-widest italic shadow-xl shadow-blue-600/30 gap-2">
                       <Navigation className="w-4 h-4" /> {t("recalibrate")}
                    </Button>
                 </div>
              </div>
            </m.div>}
        </AnimatePresence>

        {/* Global Map Display Node */}
        <div className="flex-1 relative bg-[#0f1013]">
          {isMapLoading ? <div className="w-full h-full flex flex-col items-center justify-center space-y-4">
               <Activity className="w-12 h-12 text-brand animate-spin opacity-50" />
               <p className="text-[10px] font-black text-muted-foreground tracking-widest italic animate-pulse">{t("mappingSync")}</p>
            </div> : <div className="w-full h-full relative overflow-hidden">
               {/* This would be the actual Map Component */}
               <div className="absolute inset-0 bg-gradient-to-br from-[#1a1b1e] to-[#14151a] opacity-40"></div>
               <div className="absolute inset-0 flex items-center justify-center opacity-10 pointer-events-none select-none">
                  <div className="w-[800px] h-[800px] border border-white/5 rounded-full animate-pulse-slow"></div>
                  <div className="absolute w-[600px] h-[600px] border border-white/5 rounded-full"></div>
                  <div className="absolute w-[400px] h-[400px] border border-blue-500/5 rounded-full shadow-[0_0_100px_rgba(37,99,235,0.05)]"></div>
               </div>
               
               {/* Mock Map Markers */}
               {filteredProperties.map((p, i) => <m.div key={p.id} initial={{
            scale: 0,
            opacity: 0
          }} animate={{
            scale: 1,
            opacity: 1
          }} transition={{
            delay: i * 0.1
          }} className="absolute group z-10" style={{
            top: `${40 + i * 20}%`,
            left: `${30 + i * 15}%`
          }}>
                   <div className="relative">
                      <div className="h-8 px-4 rounded-xl bg-blue-600 text-white font-black italic text-[10px] tracking-tighter flex items-center shadow-xl shadow-blue-600/40 cursor-pointer border-t border-l border-white/20 hover:scale-110 transition-transform group">
                         {formatPrice(p.listingPrice || 0, p.currency)}
                      </div>
                      <div className="absolute -bottom-3 left-1/2 -translate-x-1/2 w-0 h-0 border-l-[6px] border-l-transparent border-r-[6px] border-r-transparent border-t-8 border-t-blue-600"></div>
                   </div>
                 </m.div>)}
            </div>}

          {/* Result Hud Overlay */}
          <AnimatePresence>
            {showPropertyCards && !isMapLoading && <m.div initial={{
            y: 50,
            opacity: 0
          }} animate={{
            y: 0,
            opacity: 1
          }} exit={{
            y: 50,
            opacity: 0
          }} className="absolute bottom-8 left-8 right-8 max-w-sm pointer-events-auto">
                <Card className="bg-card/80 backdrop-blur-3xl border-white/5 shadow-[0_0_50px_rgba(0,0,0,0.5)] rounded-[40px] overflow-hidden">
                  <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-brand via-transparent to-transparent opacity-50"></div>
                  <CardHeader className="p-8 pb-4">
                    <div className="flex items-center justify-between">
                      <CardTitle className="text-[10px] font-black text-muted-foreground tracking-widest italic flex items-center gap-2">
                        <Sparkles className="w-3 h-3 text-orange-500" /> {t("signals")}
                      </CardTitle>
                      <Button variant="ghost" className="h-8 w-8 rounded-xl hover:bg-white/5 text-muted-foreground" onClick={() => setShowPropertyCards(false)} aria-label={t("common.close")}>
                        <X className="w-4 h-4" />
                      </Button>
                    </div>
                  </CardHeader>
                  <CardContent className="p-8 pt-0 space-y-6">
                    {filteredProperties.slice(0, 2).map(property => <m.div layout key={property.id} className="group relative bg-background/60 border border-white/5 rounded-3xl p-6 transition-all hover:bg-white/5 hover:border-blue-500/30 overflow-hidden cursor-pointer">
                        <div className="absolute -right-4 -top-4 opacity-5 group-hover:opacity-10 transition-all text-brand">
                           <ShieldCheck className="w-20 h-20 rotate-12" />
                        </div>
                        
                        <div className="flex items-center justify-between mb-4">
                           <div className="flex items-center gap-4">
                              <div className="w-12 h-12 rounded-2xl bg-black/40 border border-white/5 flex items-center justify-center text-brand shadow-inner group-hover:scale-110 transition-all font-black italic">
                                {getPropertyIcon(property.type)}
                              </div>
                              <div>
                                <p className="font-black text-white italic tracking-tighter leading-none">{property.name}</p>
                                <p className="text-[9px] font-bold text-muted-foreground tracking-widest mt-1 italic leading-none">{property.city}, {property.country}</p>
                              </div>
                           </div>
                           <Badge className={cn("text-[8px] font-black  tracking-widest px-2 py-0.5 rounded-full italic border-none shadow-lg", getStatusConfig(property.listingStatus).color)}>
                             {getStatusConfig(property.listingStatus).label}
                           </Badge>
                        </div>

                        <div className="flex items-end justify-between mt-2">
                           <div className="space-y-1">
                              <div className="flex items-center gap-3">
                                 <span className="text-2xl font-black text-white italic tracking-tighter leading-none font-mono">
                                    {formatPrice(property.listingPrice || 0, property.currency)}
                                 </span>
                                 {property.originalPrice && <span className="text-[10px] text-muted-foreground line-through font-bold font-mono">
                                       {formatPrice(property.originalPrice, property.currency)}
                                    </span>}
                              </div>
                              <div className="flex items-center gap-1.5 px-3 py-1 bg-success/10 rounded-full border border-success/20 w-fit">
                                 <ShieldCheck className="w-3 h-3 text-success" />
                                 <span className="text-[8px] font-black text-success tracking-widest italic">{t("shieldActive")}</span>
                              </div>
                           </div>
                           <Button size="sm" className="h-10 rounded-xl bg-blue-600 hover:bg-brand/100 text-white font-black text-[10px] tracking-widest italic shadow-xl shadow-blue-600/20 gap-2 overflow-hidden px-4">
                              {t("scanDetails")} <ArrowUpRight className="w-3 h-3" />
                           </Button>
                        </div>
                      </m.div>)}
                    
                    <Button variant="ghost" className="w-full h-10 rounded-xl text-[9px] font-black text-muted-foreground hover:text-white tracking-widest italic glass border-white/5">
                       {t("propertySearchViewall")}
                    </Button>
                  </CardContent>
                </Card>
              </m.div>}
          </AnimatePresence>
        </div>
      </div>
    </div>;
}