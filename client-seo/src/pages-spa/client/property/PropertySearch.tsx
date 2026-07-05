"use client";

import { useState, useMemo, useEffect } from "react";
import { useSearchParams, Link } from "@/lib/react-router-shim";
import { useQuery } from "@tanstack/react-query";
import { propertyApi } from "@/lib/api/property";
import { Button } from "@/components/ui/button";
import { Slider } from "@/components/ui/slider";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectGroup, SelectItem, SelectLabel, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { Calendar } from "@/components/ui/calendar";
import { Search, MapPin, Bed, Bath, Maximize2, Filter, ChevronRight, LayoutGrid, Map, Loader2, Home, Key, CalendarClock, ShieldCheck, Zap, Calendar as CalendarIcon, Users, List, Heart, Globe } from "lucide-react";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";
import { format } from "date-fns";
import type { DateRange } from "react-day-picker";
import { motion, AnimatePresence } from "framer-motion";
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from "@/components/ui/carousel";
import Autoplay from "embla-carousel-autoplay";
import { MapContainer, TileLayer, Marker, Popup, useMap } from "react-leaflet";
import "leaflet/dist/leaflet.css";
import L from "leaflet";
import { PropertyCard } from "@/components/property/PropertyCard";
import { AIUpsellBanner } from "@/components/property/AIUpsellBanner";
import Projects from "@/pages-spa/client/projects/Projects";
import { useRegionsStore } from "@/lib/store/regions-store";
import SEOMetadata from "@/components/seo/SEOMetadata";
import React from "react";
import Image from "next/image";

// Fix Leaflet default icon issue
delete (L.Icon.Default.prototype as any)._getIconUrl;
L.Icon.Default.mergeOptions({
  iconRetinaUrl: "https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-icon-2x.png",
  iconUrl: "https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-icon.png",
  shadowUrl: "https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-shadow.png",
});

// Country-based default coordinates for fallback and initial map center
const COUNTRY_CENTERS: Record<string, { lat: number; lng: number; zoom: number }> = {
  TR: { lat: 39.9334, lng: 32.8597, zoom: 6 },    // Turkey (Ankara)
  US: { lat: 39.8283, lng: -98.5795, zoom: 4 },    // USA (center)
  GB: { lat: 51.5074, lng: -0.1278, zoom: 6 },     // UK (London)
  DE: { lat: 51.1657, lng: 10.4515, zoom: 6 },     // Germany
  FR: { lat: 46.2276, lng: 2.2137, zoom: 6 },      // France
  AE: { lat: 25.2048, lng: 55.2708, zoom: 8 },     // UAE (Dubai)
  ES: { lat: 40.4168, lng: -3.7038, zoom: 6 },     // Spain
  DEFAULT: { lat: 39.9334, lng: 32.8597, zoom: 3 }, // World center
};

function getCountryCenter(countryCode: string) {
  return COUNTRY_CENTERS[countryCode] || COUNTRY_CENTERS.DEFAULT;
}

function MapBoundsFit({ properties }: { properties: any[] }) {
  const map = useMap();
  useEffect(() => {
    const validProps = properties.filter((p) => p.lat && p.lng);
    if (validProps.length > 0) {
      const bounds = L.latLngBounds(validProps.map((p) => [p.lat, p.lng]));
      map.fitBounds(bounds, { padding: [50, 50] });
    }
  }, [properties, map]);
  return null;
}

function PropertyListViewCard({ p, idx, selectedRegion }: { p: any, idx: number, selectedRegion: any }) {
  const { t } = useTranslation();
  const autoplayPlugin = React.useRef(
    Autoplay({ delay: 3000 + ((idx % 5) * 500), stopOnInteraction: true })
  );

  const displayImages = p.photos?.length > 0 
    ? p.photos.map((ph: any) => ph.url) 
    : [p.image || "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=800&q=80"];

  const getPromotionBadge = (promo: string) => {
    switch (promo) {
      case "FEATURED": return <Badge className="bg-yellow-500/90 backdrop-blur text-black border-0 shadow-sm font-bold uppercase tracking-widest text-[9px]"><ShieldCheck className="w-3 h-3 mr-1"/> {t("client.src.featured", "FEATURED")}</Badge>;
      case "URGENT": return <Badge className="bg-red-500/90 backdrop-blur text-white border-0 shadow-sm font-bold uppercase tracking-widest text-[9px]"><Zap className="w-3 h-3 mr-1"/> {t("client.src.urgent", "URGENT")}</Badge>;
      case "PRICE_REDUCED": return <Badge className="bg-blue-500/90 backdrop-blur text-white border-0 shadow-sm font-bold uppercase tracking-widest text-[9px]">{t("client.src.price_reduced", "PRICE DROP")}</Badge>;
      case "BEST_DEAL": return <Badge className="bg-emerald-500/90 backdrop-blur text-white border-0 shadow-sm font-bold uppercase tracking-widest text-[9px]">{t("client.src.best_deal", "BEST DEAL")}</Badge>;
      default: return null;
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case "AVAILABLE": return "bg-green-500/90 text-white border-green-400";
      case "UNDER_CONTRACT": return "bg-amber-500/90 text-white border-amber-400";
      case "SOLD": return "bg-red-500/90 text-white border-red-400";
      case "RENTED": return "bg-blue-500/90 text-white border-blue-400";
      case "PENDING_APPROVAL": return "bg-purple-500/90 text-white border-purple-400";
      case "VACANT": return "bg-emerald-500/90 text-white border-emerald-400";
      case "RESERVED": return "bg-indigo-500/90 text-white border-indigo-400";
      case "BOOKED": return "bg-pink-500/90 text-white border-pink-400";
      default: return "bg-black/60 text-white border-white/20";
    }
  };

  return (
    <motion.div initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }} transition={{ delay: idx * 0.05 }} className="group cursor-pointer flex flex-col md:flex-row gap-6 bg-card border border-border/50 rounded-3xl p-4 shadow-sm hover:shadow-lg transition-all">
      <div className="relative w-full md:w-96 h-64 md:h-full shrink-0 rounded-2xl overflow-hidden bg-muted border border-border/40">
        {displayImages.length > 1 ? (
          <Carousel 
            className="w-full h-full"
            plugins={[autoplayPlugin.current]}
            onMouseEnter={() => autoplayPlugin.current.stop()}
            onMouseLeave={() => autoplayPlugin.current.play()}
          >
            <CarouselContent className="h-full ml-0">
              {displayImages.map((img: string, i: number) => (
                <CarouselItem key={i} className="relative w-full h-full pl-0">
                  <Link to={`/property/${p.id}`} className="block w-full h-full">
                    <Image src={img} alt={`${p.name} - ${i + 1}`} fill className="object-cover transition-transform duration-700 group-hover:scale-105" sizes="(max-width: 768px) 100vw, 400px" />
                    <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-black/0 to-transparent opacity-80" />
                  </Link>
                </CarouselItem>
              ))}
            </CarouselContent>
            <CarouselPrevious className="absolute left-4 top-1/2 -translate-y-1/2 h-8 w-8 bg-black/20 hover:bg-black/40 text-white border-0 opacity-0 group-hover:opacity-100 transition-opacity z-20" onClick={(e) => { e.preventDefault(); e.stopPropagation(); }} />
            <CarouselNext className="absolute right-4 top-1/2 -translate-y-1/2 h-8 w-8 bg-black/20 hover:bg-black/40 text-white border-0 opacity-0 group-hover:opacity-100 transition-opacity z-20" onClick={(e) => { e.preventDefault(); e.stopPropagation(); }} />
          </Carousel>
        ) : (
          <Link to={`/property/${p.id}`} className="relative block w-full h-full">
            <Image src={displayImages[0]} alt={p.name} fill className="object-cover transition-transform duration-700 group-hover:scale-105" sizes="(max-width: 768px) 100vw, 400px" />
            <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-black/0 to-transparent opacity-80" />
          </Link>
        )}
        
        <div className="absolute top-3 left-3 flex flex-col gap-2 items-start pointer-events-none">
          {getPromotionBadge(p.promotion)}
          <Badge className="bg-background/90 backdrop-blur text-foreground border-0 font-bold px-3 py-1 shadow-sm tracking-wider text-[10px]">
            {p.listingType === "SALE" ? t("client.src.for_sale") : p.listingType === "RENT" ? t("client.src.for_rent") : t("client.src.booking")}
          </Badge>
        </div>
        <div className="absolute top-3 right-3">
          <Button size="icon" variant="secondary" className="h-8 w-8 rounded-full bg-background/50 backdrop-blur-md hover:bg-background text-foreground border border-border/50 transition-colors">
            <Heart className="w-4 h-4" />
          </Button>
        </div>
      </div>
      
      <div className="flex flex-col justify-between flex-1 py-2 pr-2">
        <div>
          <div className="flex justify-between items-start gap-4 mb-2">
            <div className="space-y-1">
              <Link to={`/property/${p.id}`}><h3 className="font-bold text-2xl leading-tight line-clamp-1 group-hover:text-primary transition-colors">{p.name}</h3></Link>
              <div className="flex items-center text-muted-foreground text-sm gap-1.5">
                <MapPin className="w-4 h-4 shrink-0" />
                <span className="truncate">{p.city}, {p.country} • {p.propertyCategory.replace("_", " ")}</span>
              </div>
            </div>
            <div className="flex flex-col items-end whitespace-nowrap">
              <span className={cn("px-2.5 py-1 mb-2 rounded-full text-[10px] font-bold  tracking-wide border", getStatusColor(p.listingStatus))}>
                {p.listingStatus.replace("_", " ")}
              </span>
              <span className="text-foreground font-black text-2xl tracking-tight">
                {new Intl.NumberFormat('en-US', { style: 'currency', currency: selectedRegion?.currency || p.currency || 'USD', maximumFractionDigits: 0 }).format(p.listingPrice || 0)}
                {p.listingType === "RENT" && <span className="text-sm text-muted-foreground font-normal ml-1">/mo</span>}
              </span>
            </div>
          </div>
          
          <p className="text-muted-foreground text-sm line-clamp-2 mt-4 max-w-xl">
            {p.notes || "Experience luxury and comfort in this stunning property, offering modern amenities, spacious interiors, and breathtaking views."}
          </p>
        </div>

        <div className="flex items-center justify-between mt-6">
          <div className="flex items-center gap-4">
            {p.bedrooms > 0 && (
              <div className="flex items-center gap-1.5 bg-muted/50 px-3 py-1.5 rounded-lg text-sm font-semibold">
                <Bed className="w-4 h-4 text-primary/70"/> {p.bedrooms} <span className="text-xs text-muted-foreground font-medium hidden sm:inline">{t("client.src.beds", "Beds")}</span>
              </div>
            )}
            {p.bathrooms > 0 && (
              <div className="flex items-center gap-1.5 bg-muted/50 px-3 py-1.5 rounded-lg text-sm font-semibold">
                <Bath className="w-4 h-4 text-primary/70"/> {p.bathrooms} <span className="text-xs text-muted-foreground font-medium hidden sm:inline">{t("client.src.baths", "Baths")}</span>
              </div>
            )}
            {p.areaSqm > 0 && (
              <div className="flex items-center gap-1.5 bg-muted/50 px-3 py-1.5 rounded-lg text-sm font-semibold">
                <Maximize2 className="w-4 h-4 text-primary/70"/> {p.areaSqm} <span className="text-xs text-muted-foreground font-medium hidden sm:inline">m²</span>
              </div>
            )}
          </div>
          <Link to={`/property/${p.id}`}>
            <Button variant="default" className="rounded-full px-6 shadow-md hover:shadow-lg transition-all group-hover:bg-primary/90">
              {t("client.src.view_details", "View Details")} <ChevronRight className="w-4 h-4 ml-1" />
            </Button>
          </Link>
        </div>
      </div>
    </motion.div>
  );
}

export default function PropertySearch() {
  const { t } = useTranslation();
  const [searchParams] = useSearchParams();
  const [viewMode, setViewMode] = useState<"grid" | "list" | "map">("grid");
  const [showFilters, setShowFilters] = useState(false);
  const [activeTab, setActiveTab] = useState<"resale" | "projects">("resale");
  
  const [search, setSearch] = useState(searchParams.get("search") || "");
  const [priceRange, setPriceRange] = useState<[number, number]>([0, 50000000]);
  const [listingType, setListingType] = useState<string>("ALL"); // Main Tabs
  const [propertyCategory, setPropertyCategory] = useState<string>("ALL"); // Secondary Tabs
  const [promotionType, setPromotionType] = useState<string>("ALL"); // Monetization Filters
  const [propertyStatus, setPropertyStatus] = useState<string>("ALL");
  const [propertyType, setPropertyType] = useState<string>("ALL");
  const [legalStatus, setLegalStatus] = useState<string>("ALL");
  const [selectedAmenities, setSelectedAmenities] = useState<string[]>([]);
  const [bedrooms, setBedrooms] = useState<string>("ALL");
  const [bathrooms, setBathrooms] = useState<string>("ALL");
  const { selectedRegion } = useRegionsStore();
  const searchRegion = selectedRegion?.countryCode || "GLOBAL";
  const [dateRange, setDateRange] = useState<DateRange | undefined>(undefined);
  const [guests, setGuests] = useState<number>(1);
  const [sortBy, setSortBy] = useState<string>("DEFAULT");
  const [visibleCount, setVisibleCount] = useState<number>(12);
  const [isUpsellDismissed, setIsUpsellDismissed] = useState(false);
  
  // TR Specific Filters
  const [trTapuStatus, setTrTapuStatus] = useState<string>("ALL");
  const [trFinanceStatus, setTrFinanceStatus] = useState<string>("ALL");
  const [trHeatingType, setTrHeatingType] = useState<string>("ALL");

  const { data: response, isLoading } = useQuery({
    queryKey: ["properties", searchRegion],
    queryFn: () => propertyApi.getProperties(),
  });

  const { data: b2bResponse, isLoading: isB2BLoading } = useQuery({
    queryKey: ["b2b-hotels", search, dateRange?.from, dateRange?.to, guests],
    queryFn: async () => {
      if (listingType !== "BOOKING" || search.length < 3) return { data: [] };
      const checkIn = dateRange?.from ? format(dateRange.from, "yyyy-MM-dd") : "2024-07-01";
      const checkOut = dateRange?.to ? format(dateRange.to, "yyyy-MM-dd") : "2024-07-07";
      const res = await fetch(`/b2b-hotels/search?destination=${search}&checkIn=${checkIn}&checkOut=${checkOut}&guests=${guests}`);
      return res.json();
    },
    enabled: listingType === "BOOKING" || listingType === "ALL",
  });

  const { data: upsellResponse } = useQuery({
    queryKey: ["ai-upsell", search, dateRange?.from, dateRange?.to, guests, listingType],
    queryFn: async () => {
      if (search.length < 3) return { data: { hasUpsell: false } };
      const checkIn = dateRange?.from ? format(dateRange.from, "yyyy-MM-dd") : format(new Date(), "yyyy-MM-dd");
      const checkOut = dateRange?.to ? format(dateRange.to, "yyyy-MM-dd") : format(new Date(Date.now() + 5 * 86400000), "yyyy-MM-dd");
      const res = await fetch(`/ai-arbitrage/upsell?destination=${encodeURIComponent(search)}&checkIn=${checkIn}&checkOut=${checkOut}&guests=${guests}`);
      return res.json();
    },
    enabled: (listingType === "BOOKING" || listingType === "ALL") && search.length >= 3,
    staleTime: 60000,
  });

  const countryCenter = getCountryCenter(searchRegion);

  const properties = useMemo(() => {
    const base = (response as any)?.data || [];
    const b2b = (b2bResponse as any)?.data || [];
    
    const center = getCountryCenter(searchRegion);
    
    const dbProps = base.map((p: any) => {
      return {
        ...p,
        lat: p.lat ?? null,
        lng: p.lng ?? null,
        listingStatus: p.listingStatus || p.status || "AVAILABLE",
        propertyCategory: p.propertyCategory || "RESIDENTIAL",
        features: p.features || p.smartHomeFeatures || [],
        promotion: p.promotion || null,
        image: p.image || p.listings?.[0]?.pricingRules?.[0]?.discountRules?.image || p.photos?.[0]?.url || "https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800&q=80"
      };
    });

    const b2bProps = b2b.map((hotel: any) => ({
      id: hotel.id,
      name: hotel.name,
      description: hotel.description,
      notes: hotel.description,
      city: hotel.city,
      country: hotel.country,
      lat: hotel.lat,
      lng: hotel.lng,
      listingType: "BOOKING",
      listingStatus: "AVAILABLE",
      propertyCategory: "HOTEL",
      promotion: "BEST_DEAL",
      image: hotel.photos?.[0] || "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800&q=80",
      photos: hotel.photos?.map((url: string) => ({ url })) || [],
      listingPrice: hotel.grossPrice,
      currency: hotel.currency,
      features: hotel.amenities,
      isB2B: true,
      b2bProvider: hotel.provider,
      bedrooms: 1,
      bathrooms: 1,
      areaSqm: 45
    }));

    return [...dbProps, ...b2bProps];
  }, [response, b2bResponse, searchRegion]);

  const filteredProperties = useMemo(() => {
    return properties.filter((p: any) => {
      const matchSearch = p.name?.toLowerCase().includes(search.toLowerCase()) || p.city?.toLowerCase().includes(search.toLowerCase());
      const matchPrice = (!p.listingPrice) || (p.listingPrice >= priceRange[0] && p.listingPrice <= priceRange[1]);
      const matchListing = listingType === "ALL" || p.listingType === listingType;
      const matchCategory = propertyCategory === "ALL" || p.propertyCategory === propertyCategory;
      const matchStatus = propertyStatus === "ALL" || p.listingStatus === propertyStatus;
      const matchType = propertyType === "ALL" || p.type === propertyType;
      const matchLegal = legalStatus === "ALL" || p.legalComplianceStatus === legalStatus;
      const matchPromotion = promotionType === "ALL" || p.promotion === promotionType;
      const matchBedrooms = bedrooms === "ALL" || p.bedrooms >= parseInt(bedrooms);
      const matchBathrooms = bathrooms === "ALL" || p.bathrooms >= parseInt(bathrooms);
      
      const pAmenities = p.features || [];
      const matchAmenities = selectedAmenities.length === 0 || selectedAmenities.every((a: string) => pAmenities.includes(a));
      
      const matchTapu = trTapuStatus === "ALL" || p.tapuStatus === trTapuStatus || p.features?.includes(trTapuStatus);
      const matchFinance = trFinanceStatus === "ALL" || p.financeStatus === trFinanceStatus || p.features?.includes(trFinanceStatus);
      const matchHeating = trHeatingType === "ALL" || p.heatingType === trHeatingType || p.features?.includes(trHeatingType);
      
      return matchSearch && matchPrice && matchListing && matchCategory && matchStatus && matchType && matchLegal && matchPromotion && matchBedrooms && matchBathrooms && matchAmenities && matchTapu && matchFinance && matchHeating;
    });
  }, [properties, search, priceRange, listingType, propertyCategory, propertyStatus, propertyType, legalStatus, promotionType, bedrooms, bathrooms, selectedAmenities, trTapuStatus, trFinanceStatus, trHeatingType]);

  const sortedProperties = useMemo(() => {
    const props = [...filteredProperties];
    if (sortBy === "PRICE_ASC") props.sort((a, b) => (a.listingPrice || 0) - (b.listingPrice || 0));
    else if (sortBy === "PRICE_DESC") props.sort((a, b) => (b.listingPrice || 0) - (a.listingPrice || 0));
    else if (sortBy === "NEWEST") props.sort((a, b) => new Date(b.createdAt || 0).getTime() - new Date(a.createdAt || 0).getTime());
    else if (sortBy === "AREA_DESC") props.sort((a, b) => (b.areaSqm || 0) - (a.areaSqm || 0));
    return props;
  }, [filteredProperties, sortBy]);

  const paginatedProperties = useMemo(() => {
    return sortedProperties.slice(0, visibleCount);
  }, [sortedProperties, visibleCount]);

  const groupedSections = useMemo(() => {
    const out = [];
    const featured = paginatedProperties.filter((p: any) => p.promotion === "FEATURED");
    const urgent = paginatedProperties.filter((p: any) => p.promotion === "URGENT");
    const priceReduced = paginatedProperties.filter((p: any) => p.promotion === "PRICE_REDUCED");
    const bestDeal = paginatedProperties.filter((p: any) => p.promotion === "BEST_DEAL");
    const standard = paginatedProperties.filter((p: any) => !p.promotion);

    if (featured.length > 0) out.push({ id: "featured", title: t("client.src.featured_properties", "🌟 Featured Properties"), items: featured });
    if (urgent.length > 0) out.push({ id: "urgent", title: "🔥 Urgent Sales", items: urgent });
    if (priceReduced.length > 0) out.push({ id: "price_reduced", title: "📉 Price Reduced", items: priceReduced });
    if (bestDeal.length > 0) out.push({ id: "best_deal", title: "💎 Best Deals", items: bestDeal });
    if (standard.length > 0) out.push({ id: "standard", title: t("client.src.all_properties", "All Properties"), items: standard });
    
    return out;
  }, [paginatedProperties, t]);

  const listingTypes = [
    { id: "ALL", label: t("client.src.all_properties"), icon: LayoutGrid },
    { id: "SALE", label: t("client.src.for_sale"), icon: Home },
    { id: "RENT", label: t("client.src.for_rent"), icon: Key },
    { id: "BOOKING", label: t("client.src.booking"), icon: CalendarClock },
  ];

  const categories = ["ALL", "RESIDENTIAL", "COMMERCIAL", "INDUSTRIAL", "MIXED_USE", "AGRICULTURAL", "SPECIAL_PURPOSE"];
  
  const getStatusColor = (status: string) => {
    switch (status) {
      case "AVAILABLE": return "bg-green-500/10 text-green-500 border-green-500/20";
      case "UNDER_CONTRACT": return "bg-amber-500/10 text-amber-500 border-amber-500/20";
      case "SOLD": return "bg-red-500/10 text-red-500 border-red-500/20";
      case "RENTED": return "bg-blue-500/10 text-blue-500 border-blue-500/20";
      case "PENDING_APPROVAL": return "bg-purple-500/10 text-purple-500 border-purple-500/20";
      case "VACANT": return "bg-emerald-500/10 text-emerald-500 border-emerald-500/20";
      case "RESERVED": return "bg-indigo-500/10 text-indigo-500 border-indigo-500/20";
      case "BOOKED": return "bg-pink-500/10 text-pink-500 border-pink-500/20";
      case "WILL_BE_AVAILABLE": return "bg-indigo-500/10 text-indigo-500 border-indigo-500/20";
      case "MAINTENANCE": return "bg-orange-500/10 text-orange-500 border-orange-500/20";
      case "DRAFT": return "bg-slate-500/10 text-slate-500 border-slate-500/20";
      case "ARCHIVED": return "bg-zinc-500/10 text-zinc-500 border-zinc-500/20";
      default: return "bg-muted text-muted-foreground border-border";
    }
  };

  const AMENITIES_GROUPS = [
    {
      title: t("client.src.property_amenities", "Property / Unit Features"),
      items: [
        { id: "AIR_CONDITIONING", label: t("client.src.air_conditioning", "Air Conditioning") },
        { id: "UNDERFLOOR_HEATING", label: t("client.src.underfloor_heating", "Underfloor Heating") },
        { id: "FIREPLACE", label: t("client.src.fireplace", "Fireplace") },
        { id: "FIBER_INTERNET", label: t("client.src.fiber_internet", "Fiber Internet") },
        { id: "FURNISHED", label: t("client.src.furnished", "Furnished") },
        { id: "ENSUITE_BATHROOM", label: t("client.src.ensuite_bathroom", "En-suite Bathroom") },
        { id: "BUILT_IN_APPLIANCES", label: t("client.src.built_in_appliances", "Built-in Appliances") },
        { id: "SMART_HOME", label: t("client.src.smart_home", "Smart Home") },
        { id: "BALCONY", label: t("client.src.balcony", "Balcony") },
      ]
    },
    {
      title: t("client.src.building_amenities", "Building / Facility"),
      items: [
        { id: "SWIMMING_POOL", label: t("client.src.swimming_pool", "Swimming Pool") },
        { id: "GYM", label: t("client.src.gym", "Gym / Fitness") },
        { id: "SPA_SAUNA", label: t("client.src.spa_sauna", "Spa & Sauna") },
        { id: "TURKISH_BATH", label: t("client.src.turkish_bath", "Turkish Bath (Hammam)") },
        { id: "PLAYGROUND", label: t("client.src.playground", "Playground") },
        { id: "GARDEN", label: t("client.src.garden", "Garden") },
        { id: "ELEVATOR", label: t("client.src.elevator", "Elevator") },
        { id: "PARKING", label: t("client.src.parking", "Parking") },
        { id: "INDOOR_PARKING", label: t("client.src.indoor_parking", "Indoor Parking") },
        { id: "GENERATOR", label: t("client.src.generator", "Generator") },
        { id: "SECURITY", label: t("client.src.security", "24/7 Security") },
        { id: "CONCIERGE", label: t("client.src.concierge", "Concierge") },
      ]
    },
    {
      title: t("client.src.location_amenities", "Location / View"),
      items: [
        { id: "SEA_VIEW", label: t("client.src.sea_view", "Sea View") },
        { id: "CITY_VIEW", label: t("client.src.city_view", "City View") },
        { id: "NATURE_VIEW", label: t("client.src.nature_view", "Nature / Forest View") },
        { id: "NEAR_METRO", label: t("client.src.near_metro", "Near Metro") },
        { id: "NEAR_BEACH", label: t("client.src.near_beach", "Near Beach") },
      ]
    }
  ];

  const toggleAmenity = (id: string) => {
    setSelectedAmenities(prev => 
      prev.includes(id) ? prev.filter(a => a !== id) : [...prev, id]
    );
  };

  const getPromotionBadge = (promo: string) => {
    switch (promo) {
      case "FEATURED": return <Badge className="bg-yellow-500 text-black border-0 shadow-sm"><ShieldCheck className="w-3 h-3 mr-1"/> {t("client.src.featured")}</Badge>;
      case "URGENT": return <Badge className="bg-red-500 text-white border-0 shadow-sm"><Zap className="w-3 h-3 mr-1"/> {t("client.src.urgent")}</Badge>;
      case "PRICE_REDUCED": return <Badge className="bg-blue-500 text-white border-0 shadow-sm">{t("client.src.price_reduced")}</Badge>;
      case "BEST_DEAL": return <Badge className="bg-green-500 text-white border-0 shadow-sm">{t("client.src.best_deal")}</Badge>;
      default: return null;
    }
  };

  const promotionOptions = [
    { id: "ALL", label: t("client.src.all_deals"), icon: null, color: "text-muted-foreground" },
    { id: "FEATURED", label: t("client.src.featured"), icon: ShieldCheck, color: "text-yellow-500" },
    { id: "URGENT", label: t("client.src.urgent"), icon: Zap, color: "text-red-500" },
    { id: "PRICE_REDUCED", label: t("client.src.price_reduced"), icon: null, color: "text-blue-500" },
    { id: "BEST_DEAL", label: t("client.src.best_deal"), icon: null, color: "text-green-500" },
  ];

  return (
    <div className="min-h-screen bg-background relative overflow-hidden text-foreground flex flex-col font-sans">
      <SEOMetadata data={{
        type: 'LISTING',
        title: search ? `${search} Sonuçları | ` : 'Oteller ve Rezidanslar | ',
        description: 'Toptancı fiyatlarıyla otelleri ve %35 tasarruf sağlayan lüks rezidansları (Arbitraj) anında kiralayın. En ucuz direkt rezervasyon garantisi.',
        url: typeof window !== 'undefined' ? window.location.href : 'https://reservatior.com/search',
        amenities: ['Direct Booking', 'Best Price Guarantee', 'AI Arbitrage', 'No Hidden Fees']
      }} />
      {/* Subtle Premium Background Glows */}
      <div className="absolute top-0 left-0 w-[40vw] h-[40vw] bg-primary/5 rounded-full blur-[100px] -z-10 pointer-events-none translate-x-[-20%] translate-y-[-20%]" />
      <div className="absolute top-1/3 right-0 w-[30vw] h-[30vw] bg-blue-500/5 rounded-full blur-[100px] -z-10 pointer-events-none translate-x-[20%]" />
      <div className="absolute bottom-0 left-1/4 w-[50vw] h-[50vw] bg-purple-500/5 rounded-full blur-[120px] -z-10 pointer-events-none translate-y-[30%]" />

      <div className="sticky top-0 z-40 bg-background/60 backdrop-blur-2xl border-b border-border/40 pb-4 pt-6 px-4 md:px-6 2xl:px-12 flex flex-col gap-6 transition-all shadow-sm">
        {/* Master Navigation Tabs */}
        <div className="flex items-center justify-between -mt-2 w-full">
          <div className="flex-1" />
          <div className="bg-muted/50 p-1 rounded-full border border-border/50 shadow-inner inline-flex justify-center mx-auto">
            <Button 
              variant="ghost" 
              onClick={() => setActiveTab("resale")} 
              className={cn("rounded-full px-8 h-11 font-bold transition-all text-sm", activeTab === "resale" ? "bg-background shadow-md text-foreground" : "text-muted-foreground hover:text-foreground")}
            >
              {t("client.src.second_hand_resale", "Second Hand / Resale")}
            </Button>
            <Button 
              variant="ghost" 
              onClick={() => setActiveTab("projects")} 
              className={cn("rounded-full px-8 h-11 font-bold transition-all text-sm", activeTab === "projects" ? "bg-background shadow-md text-foreground" : "text-muted-foreground hover:text-foreground")}
            >
              {t("client.src.new_developments", "New Developments")}
            </Button>
          </div>
          <div className="flex-1 flex justify-end">
            {/* Region selection is now managed by the global Navbar RegionSelector */}
          </div>
        </div>

        {/* Main Header / Search (Only for Resale) */}
        {activeTab === "resale" && (
          <>
          <div className="max-w-[1600px] mx-auto w-full flex flex-col md:flex-row items-center justify-between gap-6">
          <div className="flex-1 w-full max-w-3xl relative group">
            <div className="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
              <Search className="h-5 w-5 text-muted-foreground group-focus-within:text-primary transition-colors" />
            </div>
            <input
              type="text"
              placeholder={t("client.src.search_destinations_properties_or")}
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="w-full pl-12 pr-4 py-4 bg-muted/30 border border-border/50 rounded-full text-sm font-medium focus:outline-none focus:ring-2 focus:ring-primary/30 focus:border-primary/50 focus:bg-background transition-all shadow-sm group-hover:shadow-md"
            />
            
            <div className="absolute inset-y-0 right-2 flex items-center gap-1">
              <Button onClick={() => setShowFilters(!showFilters)} variant="ghost" className="rounded-full h-10 px-4 text-xs font-semibold gap-2">
                <Filter className="w-4 h-4" /> {t("client.src.filters")}
              </Button>
            </div>
          </div>
          <div className="flex bg-muted/50 p-1 rounded-full border border-border/50 shadow-inner">
            <Button variant="ghost" onClick={() => setViewMode("grid")} className={cn("rounded-full px-6 h-10 text-xs font-bold transition-all", viewMode === "grid" ? "bg-background shadow-sm text-foreground" : "text-muted-foreground hover:text-foreground")}>
              <LayoutGrid className="w-4 h-4 mr-2" /> {t("client.src.grid")}
            </Button>
            <Button variant="ghost" onClick={() => setViewMode("list")} className={cn("rounded-full px-6 h-10 text-xs font-bold transition-all", viewMode === "list" ? "bg-background shadow-sm text-foreground" : "text-muted-foreground hover:text-foreground")}>
              <List className="w-4 h-4 mr-2" /> {t("client.src.list")}
            </Button>
            <Button variant="ghost" onClick={() => setViewMode("map")} className={cn("rounded-full px-6 h-10 text-xs font-bold transition-all", viewMode === "map" ? "bg-background shadow-sm text-foreground" : "text-muted-foreground hover:text-foreground")}>
              <Map className="w-4 h-4 mr-2" /> {t("client.src.map")}
            </Button>
          </div>
        </div>

        {/* Unified Filter Toolbar */}
        <div className="max-w-[1600px] mx-auto w-full flex flex-wrap items-center gap-3 pt-2">
          
          {/* 1. Listing Type */}
          <Select value={listingType} onValueChange={setListingType}>
            <SelectTrigger className="w-auto h-10 px-4 rounded-full bg-background border-border shadow-sm text-sm font-semibold gap-2 whitespace-nowrap">
              <SelectValue placeholder={t("client.src.listing_type")} />
            </SelectTrigger>
            <SelectContent>
              {listingTypes.map(t => (
                <SelectItem key={t.id} value={t.id}>
                  <div className="flex items-center gap-2 font-medium"><t.icon className="w-4 h-4 text-primary"/> {t.label}</div>
                </SelectItem>
              ))}
            </SelectContent>
          </Select>

          {/* 2. Property Category */}
          <Select value={propertyCategory} onValueChange={setPropertyCategory}>
            <SelectTrigger className="w-auto h-10 px-4 rounded-full bg-background border-border shadow-sm text-sm font-semibold whitespace-nowrap">
              <SelectValue placeholder={t("client.src.category")} />
            </SelectTrigger>
            <SelectContent>
              {categories.map(cat => (
                <SelectItem key={cat} value={cat}>
                  <span className="font-medium">{cat === "ALL" ? t("client.src.all_categories", "All Categories") : t(`client.src.${cat.toLowerCase()}`, cat.replace("_", " "))}</span>
                </SelectItem>
              ))}
            </SelectContent>
          </Select>

          {/* 3. Property Type */}
          <Select value={propertyType} onValueChange={setPropertyType}>
            <SelectTrigger className="w-auto h-10 px-4 rounded-full bg-background border-border shadow-sm text-sm font-semibold whitespace-nowrap">
              <SelectValue placeholder={t("client.src.property_type", "Property Type")} />
            </SelectTrigger>
            <SelectContent className="max-h-[400px]">
              <SelectItem value="ALL">{t("client.src.any_type", "Any Type")}</SelectItem>
              <SelectGroup>
                <SelectLabel className="text-slate-500 font-bold uppercase tracking-widest text-[9px] px-2 py-1">{t("client.property.portfolio.filters.type.residential")} - HOUSES</SelectLabel>
                <SelectItem value="DETACHED_HOUSE">{t("client.property.types.DETACHED_HOUSE")}</SelectItem>
                <SelectItem value="SEMI_DETACHED_HOUSE">{t("client.property.types.SEMI_DETACHED_HOUSE")}</SelectItem>
                <SelectItem value="TERRACED_HOUSE">{t("client.property.types.TERRACED_HOUSE")}</SelectItem>
                <SelectItem value="TOWNHOUSE">{t("client.property.types.TOWNHOUSE")}</SelectItem>
                <SelectItem value="SINGLE_FAMILY">{t("client.property.types.SINGLE_FAMILY")}</SelectItem>
                <SelectItem value="MULTI_FAMILY">{t("client.property.types.MULTI_FAMILY")}</SelectItem>
                <SelectItem value="BUNGALOW">{t("client.property.types.BUNGALOW")}</SelectItem>
                <SelectItem value="COTTAGE">{t("client.property.types.COTTAGE")}</SelectItem>
                <SelectItem value="VILLA">{t("client.property.types.VILLA")}</SelectItem>
                <SelectItem value="CABIN_TINY_HOUSE">{t("client.property.types.CABIN_TINY_HOUSE")}</SelectItem>
                <SelectItem value="ADU_GUEST_HOUSE">{t("client.property.types.ADU_GUEST_HOUSE")}</SelectItem>
                <SelectItem value="COMPOUND">{t("client.property.types.COMPOUND")}</SelectItem>
              </SelectGroup>
              <SelectGroup>
                <SelectLabel className="text-slate-500 font-bold uppercase tracking-widest text-[9px] px-2 py-1 mt-2">{t("client.property.portfolio.filters.type.residential")} - APARTMENTS</SelectLabel>
                <SelectItem value="APARTMENT">{t("client.property.types.APARTMENT")}</SelectItem>
                <SelectItem value="CONDO_APARTMENT">{t("client.property.types.CONDO_APARTMENT")}</SelectItem>
                <SelectItem value="FLAT_MAISONETTE">{t("client.property.types.FLAT_MAISONETTE")}</SelectItem>
                <SelectItem value="STUDIO">{t("client.property.types.STUDIO")}</SelectItem>
                <SelectItem value="PENTHOUSE">{t("client.property.types.PENTHOUSE")}</SelectItem>
              </SelectGroup>
              <SelectGroup>
                <SelectLabel className="text-slate-500 font-bold uppercase tracking-widest text-[9px] px-2 py-1 mt-2">{t("client.property.portfolio.filters.type.commercial")}</SelectLabel>
                <SelectItem value="OFFICE">{t("client.property.types.OFFICE")}</SelectItem>
                <SelectItem value="RETAIL">{t("client.property.types.RETAIL")}</SelectItem>
                <SelectItem value="COMMERCIAL_SPACE">{t("client.property.types.COMMERCIAL_SPACE")}</SelectItem>
              </SelectGroup>
            </SelectContent>
          </Select>

          {/* 4. Promotions */}
          <Select value={promotionType} onValueChange={setPromotionType}>
            <SelectTrigger className="w-auto h-10 px-4 rounded-full bg-background border-border shadow-sm text-sm font-semibold whitespace-nowrap">
              <SelectValue placeholder={t("client.src.promotions")} />
            </SelectTrigger>
            <SelectContent>
              {promotionOptions.map(promo => (
                <SelectItem key={promo.id} value={promo.id}>
                  <div className={cn("flex items-center gap-2 font-medium", promo.color !== "text-muted-foreground" ? promo.color : "text-foreground")}>
                    {promo.icon && <promo.icon className="w-4 h-4"/>} {promo.label}
                  </div>
                </SelectItem>
              ))}
            </SelectContent>
          </Select>

          {/* 4. Price Quick Filter */}
          <Popover>
            <PopoverTrigger asChild>
              <Button variant="outline" className="w-auto h-10 px-4 rounded-full bg-background border-border shadow-sm text-sm font-semibold whitespace-nowrap gap-2">
                {t("client.src.price")} {(priceRange[0] > 0 || priceRange[1] < 50000000) && <span className="bg-primary text-primary-foreground text-[10px] px-1.5 py-0.5 rounded-full ml-1 font-bold">1</span>}
              </Button>
            </PopoverTrigger>
            <PopoverContent className="w-80 p-4" align="start">
              <div className="space-y-4">
                <h4 className="text-sm font-bold">{t("client.src.price_range")}</h4>
                <Slider defaultValue={[0, 50000000]} value={priceRange} min={0} max={50000000} step={10000} onValueChange={(val: any) => setPriceRange(val)} className="py-4" />
                <div className="flex items-center justify-between gap-4">
                  <div className="flex-1 space-y-1">
                    <span className="text-xs text-muted-foreground font-medium">{t("client.src.min_price")}</span>
                    <div className="p-2 bg-muted rounded-md text-sm font-bold border border-border/50">${priceRange[0].toLocaleString()}</div>
                  </div>
                  <div className="flex-1 space-y-1">
                    <span className="text-xs text-muted-foreground font-medium">{t("client.src.max_price")}</span>
                    <div className="p-2 bg-muted rounded-md text-sm font-bold border border-border/50">{priceRange[1] >= 50000000 ? t("client.src.any") : `$${priceRange[1].toLocaleString()}`}</div>
                  </div>
                </div>
              </div>
            </PopoverContent>
          </Popover>

          {/* 5. Rooms Quick Filter */}
          <Popover>
            <PopoverTrigger asChild>
              <Button variant="outline" className="w-auto h-10 px-4 rounded-full bg-background border-border shadow-sm text-sm font-semibold whitespace-nowrap gap-2">
                {t("client.src.rooms")} {(bedrooms !== "ALL" || bathrooms !== "ALL") && <span className="bg-primary text-primary-foreground text-[10px] px-1.5 py-0.5 rounded-full ml-1 font-bold">{(bedrooms !== "ALL" ? 1 : 0) + (bathrooms !== "ALL" ? 1 : 0)}</span>}
              </Button>
            </PopoverTrigger>
            <PopoverContent className="w-72 p-4" align="start">
              <div className="space-y-6">
                <div className="space-y-3">
                  <h4 className="text-sm font-bold flex items-center gap-2"><Bed className="w-4 h-4"/> {t("client.src.bedrooms")}</h4>
                  <div className="flex flex-wrap gap-2">
                    {["ALL", "1", "2", "3", "4", "5+"].map(b => (
                      <Button key={b} variant={bedrooms === (b === "5+" ? "5" : b) ? "default" : "outline"} onClick={() => setBedrooms(b === "5+" ? "5" : b)} className="h-8 px-3 text-xs rounded-full">
                        {b === "ALL" ? t("client.src.any") : b}
                      </Button>
                    ))}
                  </div>
                </div>
                <div className="space-y-3">
                  <h4 className="text-sm font-bold flex items-center gap-2"><Bath className="w-4 h-4"/> {t("client.src.bathrooms")}</h4>
                  <div className="flex flex-wrap gap-2">
                    {["ALL", "1", "2", "3", "4+"].map(b => (
                      <Button key={b} variant={bathrooms === (b === "4+" ? "4" : b) ? "default" : "outline"} onClick={() => setBathrooms(b === "4+" ? "4" : b)} className="h-8 px-3 text-xs rounded-full">
                        {b === "ALL" ? t("client.src.any") : b}
                      </Button>
                    ))}
                  </div>
                </div>
              </div>
            </PopoverContent>
          </Popover>

          {/* Dates & Guests (For RENT/BOOKING) */}
          <AnimatePresence>
            {(listingType === "RENT" || listingType === "BOOKING") && (
              <motion.div initial={{ opacity: 0, scale: 0.95, width: 0 }} animate={{ opacity: 1, scale: 1, width: "auto" }} exit={{ opacity: 0, scale: 0.95, width: 0 }} className="flex items-center gap-3 overflow-hidden">
                <Popover>
                  <PopoverTrigger asChild>
                    <Button variant="outline" className="h-10 px-4 rounded-full bg-background border-border shadow-sm text-sm font-semibold gap-2 whitespace-nowrap">
                      <CalendarIcon className="w-4 h-4 text-primary" />
                      {dateRange?.from ? (
                        dateRange.to ? `${format(dateRange.from, "LLL dd")} - ${format(dateRange.to, "LLL dd")}` : format(dateRange.from, "LLL dd")
                      ) : t("client.src.dates")}
                    </Button>
                  </PopoverTrigger>
                  <PopoverContent className="w-auto p-0" align="start">
                    <Calendar initialFocus mode="range" defaultMonth={dateRange?.from} selected={dateRange} onSelect={setDateRange} numberOfMonths={2} />
                  </PopoverContent>
                </Popover>
                
                <Popover>
                  <PopoverTrigger asChild>
                    <Button variant="outline" className="h-10 px-4 rounded-full bg-background border-border shadow-sm text-sm font-semibold gap-2 whitespace-nowrap">
                      <Users className="w-4 h-4 text-primary" />
                      {guests} {t("client.src.guests")}
                    </Button>
                  </PopoverTrigger>
                  <PopoverContent className="w-48 p-4" align="start">
                    <div className="flex items-center justify-between">
                      <span className="text-sm font-semibold">{t("client.src.guests")}</span>
                      <div className="flex items-center gap-3">
                        <Button variant="outline" size="icon" className="h-8 w-8 rounded-full" onClick={() => setGuests(Math.max(1, guests - 1))}>-</Button>
                        <span className="font-bold w-4 text-center">{guests}</span>
                        <Button variant="outline" size="icon" className="h-8 w-8 rounded-full" onClick={() => setGuests(guests + 1)}>+</Button>
                      </div>
                    </div>
                  </PopoverContent>
                </Popover>
              </motion.div>
            )}
          </AnimatePresence>

          {/* More Filters Toggle */}
          <div className="ml-auto flex items-center gap-4">
            <Select value={sortBy} onValueChange={setSortBy}>
              <SelectTrigger className="w-auto h-10 px-4 rounded-full bg-background border-border shadow-sm text-sm font-semibold whitespace-nowrap">
                <SelectValue placeholder={t("client.src.sort_by", "Sort by...")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="DEFAULT">{t("client.src.default", "Default")}</SelectItem>
                <SelectItem value="PRICE_ASC">{t("client.src.price_low_high", "Price: Low to High")}</SelectItem>
                <SelectItem value="PRICE_DESC">{t("client.src.price_high_low", "Price: High to Low")}</SelectItem>
                <SelectItem value="NEWEST">{t("client.src.newest", "Newest")}</SelectItem>
                <SelectItem value="AREA_DESC">{t("client.src.largest_area", "Largest Area")}</SelectItem>
              </SelectContent>
            </Select>
            <span className="text-xs font-bold text-muted-foreground whitespace-nowrap hidden lg:block bg-muted px-3 py-1.5 rounded-full">
              {filteredProperties.length} {t("client.src.results")}
            </span>
          </div>
        </div>

        {/* Advanced Filters */}
        <AnimatePresence>
          {showFilters && (
            <motion.div initial={{ height: 0, opacity: 0 }} animate={{ height: "auto", opacity: 1 }} exit={{ height: 0, opacity: 0 }} className="max-w-[1600px] mx-auto w-full overflow-hidden">
              <div className="py-6 border-t border-border/40 mt-4 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-8">
                <div className="space-y-4">
                  <h4 className="text-sm font-bold text-foreground">{t("client.src.listing_status", "Listing Status")}</h4>
                  <Select value={propertyStatus} onValueChange={setPropertyStatus}>
                    <SelectTrigger className="w-full bg-muted/50 border-border/50"><SelectValue placeholder={t("client.src.any_status", "Any Status")} /></SelectTrigger>
                    <SelectContent>
                      <SelectItem value="ALL">{t("client.src.any_status", "Any Status")}</SelectItem>
                      <SelectItem value="AVAILABLE">{t("client.src.available", "Available")}</SelectItem>
                      <SelectItem value="UNDER_CONTRACT">{t("client.src.under_contract", "Under Contract")}</SelectItem>
                      <SelectItem value="SOLD">{t("client.src.sold", "Sold")}</SelectItem>
                      <SelectItem value="RENTED">{t("client.src.rented", "Rented")}</SelectItem>
                      <SelectItem value="PENDING_APPROVAL">{t("client.src.pending_approval", "Pending Approval")}</SelectItem>
                      <SelectItem value="VACANT">{t("client.src.vacant", "Vacant")}</SelectItem>
                      <SelectItem value="RESERVED">{t("client.src.reserved", "Reserved")}</SelectItem>
                      <SelectItem value="BOOKED">{t("client.src.booked", "Booked")}</SelectItem>
                      <SelectItem value="WILL_BE_AVAILABLE">{t("client.src.will_be_available", "Will Be Available")}</SelectItem>
                      <SelectItem value="MAINTENANCE">{t("client.src.maintenance", "Maintenance")}</SelectItem>
                      <SelectItem value="DRAFT">{t("client.src.draft", "Draft")}</SelectItem>
                      <SelectItem value="ARCHIVED">{t("client.src.archived", "Archived")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-4">
                  <h4 className="text-sm font-bold text-foreground">{t("client.src.legal_compliance", "Legal Compliance")}</h4>
                  <Select value={legalStatus} onValueChange={setLegalStatus}>
                    <SelectTrigger className="w-full bg-muted/50 border-border/50"><SelectValue placeholder={t("client.src.any_status", "Any Status")} /></SelectTrigger>
                    <SelectContent>
                      <SelectItem value="ALL">{t("client.src.any_status", "Any Status")}</SelectItem>
                      <SelectItem value="UNVERIFIED">{t("client.src.unverified", "Unverified")}</SelectItem>
                      <SelectItem value="PENDING">{t("client.src.pending", "Pending")}</SelectItem>
                      <SelectItem value="VERIFIED">{t("client.src.verified", "Verified")}</SelectItem>
                      <SelectItem value="EXPIRED">{t("client.src.expired", "Expired")}</SelectItem>
                      <SelectItem value="REVOKED">{t("client.src.revoked", "Revoked")}</SelectItem>
                      <SelectItem value="BLOCKLISTED">{t("client.src.blocklisted", "Blocklisted")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>

                {/* Region Specific Filters */}
                {searchRegion === "TR" && (
                  <>
                    <div className="space-y-4">
                      <h4 className="text-sm font-bold text-foreground">Tapu Durumu</h4>
                      <Select value={trTapuStatus} onValueChange={setTrTapuStatus}>
                        <SelectTrigger className="w-full bg-muted/50 border-border/50"><SelectValue placeholder="Farketmez" /></SelectTrigger>
                        <SelectContent>
                          <SelectItem value="ALL">Farketmez</SelectItem>
                          <SelectItem value="KAT_MULKIYETI">Kat Mülkiyeti</SelectItem>
                          <SelectItem value="KAT_IRTIFAKI">Kat İrtifakı</SelectItem>
                          <SelectItem value="ARSA_TAPUSU">Arsa Tapusu (Hisseli)</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                    <div className="space-y-4">
                      <h4 className="text-sm font-bold text-foreground">Finans & Kredi</h4>
                      <Select value={trFinanceStatus} onValueChange={setTrFinanceStatus}>
                        <SelectTrigger className="w-full bg-muted/50 border-border/50"><SelectValue placeholder="Farketmez" /></SelectTrigger>
                        <SelectContent>
                          <SelectItem value="ALL">Farketmez</SelectItem>
                          <SelectItem value="ELIGIBLE">Krediye Uygun</SelectItem>
                          <SelectItem value="NOT_ELIGIBLE">Krediye Uygun Değil</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                    <div className="space-y-4">
                      <h4 className="text-sm font-bold text-foreground">Isıtma Tipi</h4>
                      <Select value={trHeatingType} onValueChange={setTrHeatingType}>
                        <SelectTrigger className="w-full bg-muted/50 border-border/50"><SelectValue placeholder="Farketmez" /></SelectTrigger>
                        <SelectContent>
                          <SelectItem value="ALL">Farketmez</SelectItem>
                          <SelectItem value="KOMBİ">Kombi (Doğalgaz)</SelectItem>
                          <SelectItem value="MERKEZİ">Merkezi Sistem</SelectItem>
                          <SelectItem value="YERDEN">Yerden Isıtma</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                  </>
                )}
                {searchRegion === "USA" && (
                  <>
                    <div className="space-y-4">
                      <h4 className="text-sm font-bold text-foreground">HOA Fee (Max)</h4>
                      <Select defaultValue="ALL">
                        <SelectTrigger className="w-full bg-muted/50 border-border/50"><SelectValue placeholder="Any" /></SelectTrigger>
                        <SelectContent>
                          <SelectItem value="ALL">Any</SelectItem>
                          <SelectItem value="NO_HOA">No HOA</SelectItem>
                          <SelectItem value="UNDER_100">Under $100/mo</SelectItem>
                          <SelectItem value="UNDER_300">Under $300/mo</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                    <div className="space-y-4">
                      <h4 className="text-sm font-bold text-foreground">Basement</h4>
                      <Select defaultValue="ALL">
                        <SelectTrigger className="w-full bg-muted/50 border-border/50"><SelectValue placeholder="Any" /></SelectTrigger>
                        <SelectContent>
                          <SelectItem value="ALL">Any</SelectItem>
                          <SelectItem value="FINISHED">Finished</SelectItem>
                          <SelectItem value="UNFINISHED">Unfinished</SelectItem>
                          <SelectItem value="NONE">None</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                    <div className="space-y-4">
                      <h4 className="text-sm font-bold text-foreground">Lot Size</h4>
                      <Select defaultValue="ALL">
                        <SelectTrigger className="w-full bg-muted/50 border-border/50"><SelectValue placeholder="Any Size" /></SelectTrigger>
                        <SelectContent>
                          <SelectItem value="ALL">Any Size</SelectItem>
                          <SelectItem value="1_ACRE">1+ Acres</SelectItem>
                          <SelectItem value="5_ACRES">5+ Acres</SelectItem>
                          <SelectItem value="10_ACRES">10+ Acres</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                  </>
                )}
                {searchRegion === "EU" && (
                  <>
                    <div className="space-y-4">
                      <h4 className="text-sm font-bold text-foreground">Energy Rating (EPC)</h4>
                      <Select defaultValue="ALL">
                        <SelectTrigger className="w-full bg-muted/50 border-border/50"><SelectValue placeholder="Any" /></SelectTrigger>
                        <SelectContent>
                          <SelectItem value="ALL">Any</SelectItem>
                          <SelectItem value="A">Class A</SelectItem>
                          <SelectItem value="B">Class B or better</SelectItem>
                          <SelectItem value="C">Class C or better</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                    <div className="space-y-4">
                      <h4 className="text-sm font-bold text-foreground">Tenure</h4>
                      <Select defaultValue="ALL">
                        <SelectTrigger className="w-full bg-muted/50 border-border/50"><SelectValue placeholder="Any" /></SelectTrigger>
                        <SelectContent>
                          <SelectItem value="ALL">Any</SelectItem>
                          <SelectItem value="FREEHOLD">Freehold</SelectItem>
                          <SelectItem value="LEASEHOLD">Leasehold</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                  </>
                )}
              </div>
              
              <div className="py-6 border-t border-border/40 mt-6 space-y-8">
                {AMENITIES_GROUPS.map(group => {
                  const isAllSelected = group.items.every(a => selectedAmenities.includes(a.id));
                  return (
                    <div key={group.title}>
                      <div className="flex items-center justify-between mb-4">
                        <h4 className="text-sm font-bold text-foreground">{group.title}</h4>
                        <Button 
                          variant="ghost" 
                          size="sm" 
                          className="h-8 text-xs font-semibold text-muted-foreground hover:text-foreground"
                          onClick={() => {
                            if (isAllSelected) {
                              setSelectedAmenities(prev => prev.filter(id => !group.items.find(a => a.id === id)));
                            } else {
                              const newItems = group.items.map(a => a.id).filter(id => !selectedAmenities.includes(id));
                              setSelectedAmenities(prev => [...prev, ...newItems]);
                            }
                          }}
                        >
                          {isAllSelected ? t("client.src.deselect_all", "Deselect All") : t("client.src.select_all", "Select All")}
                        </Button>
                      </div>
                      <div className="flex flex-wrap gap-2">
                        {group.items.map((amenity) => {
                          const isSelected = selectedAmenities.includes(amenity.id);
                          return (
                            <Badge
                              key={amenity.id}
                              variant={isSelected ? "default" : "outline"}
                              className={cn(
                                "cursor-pointer px-4 py-2 text-xs font-semibold rounded-full transition-all duration-300 border shadow-sm",
                                isSelected 
                                  ? "bg-gradient-to-r from-primary to-primary/80 text-primary-foreground border-transparent shadow-md scale-105" 
                                  : "bg-muted/30 border-border/40 text-muted-foreground hover:bg-muted/80 hover:text-foreground"
                              )}
                              onClick={() => toggleAmenity(amenity.id)}
                            >
                              {amenity.label}
                            </Badge>
                          );
                        })}
                      </div>
                    </div>
                  );
                })}
                
                <div className="mt-8 flex items-center justify-end">
                  <Button variant="outline" onClick={() => {setPropertyStatus("ALL"); setPropertyType("ALL"); setLegalStatus("ALL"); setSelectedAmenities([]); setTrTapuStatus("ALL"); setTrFinanceStatus("ALL"); setTrHeatingType("ALL");}} className="h-10 bg-background/40 border-border/50 text-muted-foreground hover:text-foreground rounded-full px-6 shadow-sm">
                    {t("client.src.clear_advanced_filters", "Clear Advanced Filters")}
                  </Button>
                </div>
              </div>
            </motion.div>
          )}
        </AnimatePresence>
        </>
      )}
      </div>

      {activeTab === "projects" ? (
        <div className="px-4 md:px-6 2xl:px-12 pt-8">
          <Projects standalone={true} />
        </div>
      ) : (
        <div className={cn("flex-1 max-w-[1600px] mx-auto w-full", viewMode === "map" ? "p-0" : "px-6 md:px-12 py-8")}>
          {isLoading ? (
          <div className="flex flex-col items-center justify-center h-64 space-y-4">
            <Loader2 className="w-8 h-8 animate-spin text-primary" />
            <p className="text-sm font-medium text-muted-foreground">{t("client.src.discovering_properties", "Discovering properties...")}</p>
          </div>
        ) : filteredProperties.length === 0 ? (
          <div className="flex flex-col items-center justify-center h-96 space-y-4">
            <div className="w-20 h-20 bg-primary/10 rounded-full flex items-center justify-center mb-2 shadow-inner"><Search className="w-10 h-10 text-primary" /></div>
            <h3 className="text-2xl font-black bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/60">{t("client.src.no_properties_found_1", "No properties found")}</h3>
            <p className="text-sm text-muted-foreground">{t("client.src.try_adjusting_filters", "Try adjusting your filters.")}</p>
            <Button variant="outline" onClick={() => {setSearch(""); setPriceRange([0,50000000]); setPropertyCategory("ALL"); setListingType("ALL"); setBedrooms("ALL"); setBathrooms("ALL"); setPropertyStatus("ALL"); setPropertyType("ALL"); setLegalStatus("ALL"); setSelectedAmenities([]); setTrTapuStatus("ALL"); setTrFinanceStatus("ALL"); setTrHeatingType("ALL");}} className="mt-4 rounded-full">{t("client.src.clear_all_filters", "Clear all filters")}</Button>
          </div>
        ) : viewMode === "grid" ? (
          <div className="flex flex-col gap-12">
            {!isUpsellDismissed && upsellResponse?.data?.hasUpsell && (
              <AIUpsellBanner data={upsellResponse.data.upsell} onClose={() => setIsUpsellDismissed(true)} />
            )}
            {groupedSections.map((section) => (
              <div key={section.id} className="flex flex-col gap-6">
                <h2 className="text-3xl font-black bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{section.title}</h2>
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
                  {section.items.map((p: any, idx: number) => (
                    <PropertyCard key={p.id} property={p} index={idx} />
                  ))}
                </div>
              </div>
            ))}
            {visibleCount < sortedProperties.length && (
              <div className="py-8 flex justify-center w-full">
                <Button onClick={() => setVisibleCount(v => v + 12)} variant="outline" className="rounded-full px-8 h-12 text-sm font-bold shadow-sm hover:shadow-md transition-all">
                  {t("client.src.load_more", "Load More Properties")}
                </Button>
              </div>
            )}
          </div>
        ) : viewMode === "list" ? (
          <div className="flex flex-col gap-16 max-w-full">
            {!isUpsellDismissed && upsellResponse?.data?.hasUpsell && (
              <AIUpsellBanner data={upsellResponse.data.upsell} onClose={() => setIsUpsellDismissed(true)} />
            )}
            {groupedSections.map((section) => (
              <div key={section.id} className="flex flex-col gap-6">
                <h2 className="text-3xl font-black bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{section.title}</h2>
                <div className="flex flex-col gap-6">
                  {section.items.map((p: any, idx: number) => (
                    <PropertyListViewCard key={p.id} p={p} idx={idx} selectedRegion={selectedRegion} />
                  ))}
                </div>
              </div>
            ))}
            {visibleCount < sortedProperties.length && (
              <div className="py-8 flex justify-center w-full">
                <Button onClick={() => setVisibleCount(v => v + 12)} variant="outline" className="rounded-full px-8 h-12 text-sm font-bold shadow-sm hover:shadow-md transition-all">
                  {t("client.src.load_more", "Load More Properties")}
                </Button>
              </div>
            )}
          </div>
        ) : (
          <div className="w-full h-[calc(100vh-200px)] md:rounded-3xl overflow-hidden relative shadow-sm border border-border/50">
             <MapContainer center={[countryCenter.lat, countryCenter.lng]} zoom={countryCenter.zoom} className="w-full h-full z-0">
               <TileLayer
                 url="https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png"
                 attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>'
               />
               <MapBoundsFit properties={filteredProperties} />
               {filteredProperties.filter((p: any) => p.lat && p.lng).map((p: any) => (
                 <Marker key={p.id} position={[p.lat, p.lng]}>
                   <Popup className="rounded-2xl overflow-hidden shadow-lg p-0 border-0" closeButton={false}>
                     <div className="flex flex-col w-[240px] font-sans">
                        <div className="relative h-[140px] w-full">
                           <Image src={p.photos?.[0]?.url || p.image || "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=800&q=80"} alt="" fill className="object-cover" sizes="240px" />
                          <div className="absolute top-2 left-2 flex flex-col gap-1 items-start">
                            {getPromotionBadge(p.promotion)}
                            <Badge className="bg-background/90 text-xs text-foreground border-0 shadow-sm">{p.listingType === "SALE" ? t("client.src.for_sale") : p.listingType === "RENT" ? t("client.src.for_rent") : t("client.src.booking")}</Badge>
                          </div>
                        </div>
                       <div className="p-3 bg-background flex flex-col gap-1">
                         <strong className="text-sm truncate text-foreground">{p.name}</strong>
                         <span className="text-xs text-muted-foreground truncate">{p.city}, {p.country}</span>
                         <span className="font-bold text-base mt-1 text-foreground">{selectedRegion?.currencySymbol || p.currency || "$"}{(p.listingPrice || 0).toLocaleString()}</span>
                         <Link to={`/property/${p.id}`} className="mt-2 text-xs font-semibold bg-primary text-primary-foreground text-center py-1.5 rounded-md hover:bg-primary/90 transition-colors">
                           {t("client.src.view_details", "View Details")}
                         </Link>
                       </div>
                     </div>
                   </Popup>
                 </Marker>
               ))}
             </MapContainer>
          </div>
        )}
      </div>
      )}
    </div>
  );
}
