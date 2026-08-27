"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect, useRef, useCallback } from "react";
import { getPropertyCoverMedia } from "@/lib/project-media";
import { formatPropertyName } from "@/lib/property-formatter";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Checkbox } from "@/components/ui/checkbox";
import { Label } from "@/components/ui/label";
import { Slider } from "@/components/ui/slider";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Home, Search, Filter, Bed, Bath, Square, Building, Building2, Map, Clock, Calendar, ChevronDown, ChevronUp, Layers, X, MapPin, FilterX, Maximize2, Minimize2, List, LayoutGrid, ZoomIn, ZoomOut, Wifi, Car, Dumbbell, Shield, Wind, ArrowUpDown, Sun, Moon, Flame, Waves, Utensils, Users } from "lucide-react";
import { Separator } from "@/components/ui/separator";
import { useQuery } from "@tanstack/react-query";
import { propertiesApi } from "@/lib/api/properties";
import { useAuth } from "@/lib/auth/hooks";
import GoogleMapView from "@/components/map/GoogleMapView";
import { PropertyCard } from "@/components/ui/property-card";
import { PropertyCardSkeleton } from "@/components/ui/property-card-skeleton";
import { EmptySearchState } from "@/components/ui/empty-search-state";
import { useMapProvider } from "@/components/map/MapProvider";
import { type Property } from "@/lib/api/properties";
import { Sheet, SheetContent, SheetHeader, SheetTitle, SheetTrigger } from "@/components/ui/sheet";
type SortOption = "price_asc" | "price_desc" | "date_asc" | "date_desc" | "size_asc" | "size_desc" | "recommended" | "fast_rental" | "lowest_vacancy" | "ai_recommended";
interface SearchFilters {
  search: string;
  propertyTypes: string[];
  categories: string[];
  listingTypes: string[];
  listingStatuses: string[];
  advancedTags: string[];
  amenities: string[];
  opportunityTiers: string[];
  acquisitionUrgencies: string[];
  legalComplianceStatuses: string[];
  priceRange: [number, number];
  bedrooms: [number, number];
  bathrooms: [number, number];
  areaRange: [number, number];
  sortBy: SortOption;
  featuredOnly: boolean;
  verifiedOnly: boolean;
  radius: number;
  mapBounds: {
    north: number;
    south: number;
    east: number;
    west: number;
  };
}
const PROPERTY_TYPES = [{
  value: "DETACHED_HOUSE",
  label: t("client.property.types.DETACHED_HOUSE"),
  icon: Home
}, {
  value: "SEMI_DETACHED_HOUSE",
  label: t("client.property.types.SEMI_DETACHED_HOUSE"),
  icon: Home
}, {
  value: "TERRACED_HOUSE",
  label: t("client.property.types.TERRACED_HOUSE"),
  icon: Home
}, {
  value: "TOWNHOUSE",
  label: t("client.property.types.TOWNHOUSE"),
  icon: Home
}, {
  value: "SINGLE_FAMILY",
  label: t("client.property.types.SINGLE_FAMILY"),
  icon: Home
}, {
  value: "MULTI_FAMILY",
  label: t("client.property.types.MULTI_FAMILY"),
  icon: Building2
}, {
  value: "BUNGALOW",
  label: t("client.property.types.BUNGALOW"),
  icon: Home
}, {
  value: "COTTAGE",
  label: t("client.property.types.COTTAGE"),
  icon: Home
}, {
  value: "VILLA",
  label: t("client.property.types.VILLA"),
  icon: Home
}, {
  value: "CABIN_TINY_HOUSE",
  label: t("client.property.types.CABIN_TINY_HOUSE"),
  icon: Home
}, {
  value: "ADU_GUEST_HOUSE",
  label: t("client.property.types.ADU_GUEST_HOUSE"),
  icon: Home
}, {
  value: "COMPOUND",
  label: t("client.property.types.COMPOUND"),
  icon: Building2
}, {
  value: "APARTMENT",
  label: t("client.property.types.APARTMENT"),
  icon: Building
}, {
  value: "CONDO_APARTMENT",
  label: t("client.property.types.CONDO_APARTMENT"),
  icon: Building
}, {
  value: "FLAT_MAISONETTE",
  label: t("client.property.types.FLAT_MAISONETTE"),
  icon: Building
}, {
  value: "STUDIO",
  label: t("client.property.types.STUDIO"),
  icon: Home
}, {
  value: "PENTHOUSE",
  label: t("client.property.types.PENTHOUSE"),
  icon: Building
}, {
  value: "OFFICE",
  label: t("client.property.types.OFFICE"),
  icon: Building2
}, {
  value: "RETAIL",
  label: t("client.property.types.RETAIL"),
  icon: Building2
}, {
  value: "COMMERCIAL_SPACE",
  label: t("client.property.types.COMMERCIAL_SPACE"),
  icon: Building2
}, {
  value: "COMMERCIAL",
  label: t("client.property.types.COMMERCIAL"),
  icon: Building2
}];
const PROPERTY_CATEGORIES = [{
  value: "RESIDENTIAL",
  label: t("client.src.residential")
}, {
  value: "COMMERCIAL",
  label: t("client.src.commercial")
}, {
  value: "INDUSTRIAL",
  label: t("client.src.industrial")
}, {
  value: "MIXED_USE",
  label: t("client.src.mixed_use")
}, {
  value: "AGRICULTURAL",
  label: "Tarımsal"
}, {
  value: "SPECIAL_PURPOSE",
  label: "Özel Amaçlı"
}];
const LISTING_TYPES = [{
  value: "SALE",
  label: t("client.src.for_sale")
}, {
  value: "RENT",
  label: t("client.src.for_rent")
}, {
  value: "BOOKING",
  label: "Konaklama (Booking)"
}];
const LISTING_STATUSES = [{
  value: "AVAILABLE",
  label: t("client.src.available")
}, {
  value: "RESERVED",
  label: "Rezerve"
}, {
  value: "SOLD",
  label: t("client.src.sold")
}, {
  value: "RENTED",
  label: t("client.src.rented")
}, {
  value: "BOOKED",
  label: "Dolu (Booked)"
}, {
  value: "WILL_BE_AVAILABLE",
  label: "Yakında"
}, {
  value: "MAINTENANCE",
  label: "Bakımda"
}, {
  value: "ARCHIVED",
  label: "Arşivlendi"
}];
const SORT_OPTIONS = [{
  value: "recommended",
  label: "AI Recommended"
}, {
  value: "fast_rental",
  label: "Fast Rental"
}, {
  value: "lowest_vacancy",
  label: "Lowest Vacancy"
}, {
  value: "price_asc",
  label: t("client.src.price_low_to_high")
}, {
  value: "price_desc",
  label: t("client.src.price_high_to_low")
}, {
  value: "date_asc",
  label: t("client.src.date_oldest_first")
}, {
  value: "date_desc",
  label: t("client.src.date_newest_first")
}, {
  value: "size_asc",
  label: t("client.src.size_small_to_large")
}, {
  value: "size_desc",
  label: t("client.src.size_large_to_small")
}];
export default function ProjectSearch() {
  const {
    t
  } = useTranslation();
  const searchParams = typeof window !== 'undefined' ? new URLSearchParams(window.location.search) : new URLSearchParams();
  const {
    provider
  } = useMapProvider();
  const [showFilters, setShowFilters] = useState(false);
  const [viewMode, setViewMode] = useState<'map' | 'grid' | 'list'>('grid');
  const [selectedProperty, setSelectedProperty] = useState<Property | null>(null);
  const [hoveredPropertyId, setHoveredPropertyId] = useState<string | null>(null);
  
  const [visibleCount, setVisibleCount] = useState(12);
  const observerTarget = useRef<HTMLDivElement>(null);

  const [filters, setFilters] = useState<SearchFilters>({
    search: searchParams.get('search') || '',
    propertyTypes: [],
    categories: [],
    listingTypes: [],
    listingStatuses: [],
    advancedTags: [],
    amenities: [],
    opportunityTiers: [],
    acquisitionUrgencies: [],
    legalComplianceStatuses: [],
    priceRange: [0, 1000000000],
    bedrooms: [0, 20],
    bathrooms: [0, 20],
    areaRange: [0, 50000],
    sortBy: 'date_desc',
    featuredOnly: false,
    verifiedOnly: false,
    radius: 50,
    mapBounds: {
      north: 0,
      south: 0,
      east: 0,
      west: 0
    }
  });
  const { data: properties = [], isLoading: loading } = useQuery({
    queryKey: ['properties', filters.sortBy],
    queryFn: () => propertiesApi.getAll({ sortBy: filters.sortBy, limit: 1000 })
  });

  const [searchAsIMove, setSearchAsIMove] = useState(true);
  const [mapBounds, setMapBounds] = useState<{north: number, south: number, east: number, west: number} | null>(null);
  

  const updateFilters = (key: keyof SearchFilters, value: any) => {
    setFilters(prev => ({
      ...prev,
      [key]: value
    }));
    setVisibleCount(12); // Reset pagination on filter change
  };
  const clearFilters = () => {
    setFilters({
      search: '',
      propertyTypes: [],
      categories: [],
      listingTypes: [],
      listingStatuses: ['AVAILABLE', 'WILL_BE_AVAILABLE', 'RESERVED'],
      advancedTags: [],
      amenities: [],
      opportunityTiers: [],
      acquisitionUrgencies: [],
      legalComplianceStatuses: [],
      priceRange: [0, 1000000],
      bedrooms: [0, 10],
      bathrooms: [0, 10],
      areaRange: [0, 5000],
    sortBy: 'recommended',
      featuredOnly: false,
      verifiedOnly: false,
      radius: 50,
      mapBounds: {
        north: 0,
        south: 0,
        east: 0,
        west: 0
      }
    });
  };
  const rawProperties = Array.isArray(properties) ? properties : (properties as any)?.data || [];
  const processedProperties = rawProperties.map((property: Property) => {
    const p = { ...property } as any;
    p.name = formatPropertyName(p);
    return p as Property;
  });

  const filteredProperties = processedProperties.filter((property: Property) => {
    // Map bounds filter
    if (searchAsIMove && viewMode === 'map' && mapBounds && property.lat && property.lng) {
      if (
        property.lat > mapBounds.north ||
        property.lat < mapBounds.south ||
        property.lng > mapBounds.east ||
        property.lng < mapBounds.west
      ) {
        return false;
      }
    }

    // Advanced Tags Filter
    const pTags = (property as any).uiTags || [];
    if (filters.advancedTags.length > 0) {
      if (!filters.advancedTags.some(tag => pTags.includes(tag))) return false;
    }

    // Search filter
    if (filters.search && !property.name.toLowerCase().includes(filters.search.toLowerCase()) && !property.addressLine1.toLowerCase().includes(filters.search.toLowerCase()) && !property.city.toLowerCase().includes(filters.search.toLowerCase())) {
      return false;
    }

    // Property type filter
    if (filters.propertyTypes.length > 0 && !filters.propertyTypes.includes(property.type)) {
      return false;
    }

    // Category filter
    if (filters.categories.length > 0 && !filters.categories.includes(property.propertyCategory)) {
      return false;
    }

    // AI & Advanced filters
    if (filters.opportunityTiers.length > 0 && property.aiOpportunityTier && !filters.opportunityTiers.includes(property.aiOpportunityTier)) {
      return false;
    }
    if (filters.acquisitionUrgencies.length > 0 && property.aiAcquisitionUrgency && !filters.acquisitionUrgencies.includes(property.aiAcquisitionUrgency)) {
      return false;
    }
    if (filters.legalComplianceStatuses.length > 0 && property.legalComplianceStatus && !filters.legalComplianceStatuses.includes(property.legalComplianceStatus)) {
      return false;
    }
    
    // Amenities filter
    if (filters.amenities.length > 0) {
      const propertyAmenities = (property as any).amenities || [];
      if (!filters.amenities.every(a => propertyAmenities.includes(a))) {
        return false;
      }
    }

    // Listing type filter
    if (filters.listingTypes.length > 0 && !filters.listingTypes.includes(property.listingType)) {
      return false;
    }

    // Listing status filter
    if (filters.listingStatuses.length > 0 && !filters.listingStatuses.includes(property.listingStatus)) {
      return false;
    }

    // Price range filter
    if (property.listingPrice && (property.listingPrice < filters.priceRange[0] || property.listingPrice > filters.priceRange[1])) {
      return false;
    }

    // Bedrooms filter
    if (property.bedrooms && (property.bedrooms < filters.bedrooms[0] || property.bedrooms > filters.bedrooms[1])) {
      return false;
    }

    // Bathrooms filter
    if (property.bathrooms && (property.bathrooms < filters.bathrooms[0] || property.bathrooms > filters.bathrooms[1])) {
      return false;
    }

    // Area filter
    if (property.areaSqm && (property.areaSqm < filters.areaRange[0] || property.areaSqm > filters.areaRange[1])) {
      return false;
    }
    return true;
  }).sort((a: Property, b: Property) => {
    switch (filters.sortBy) {
      case "price_asc":
        return (a.listingPrice || 0) - (b.listingPrice || 0);
      case "price_desc":
        return (b.listingPrice || 0) - (a.listingPrice || 0);
      case "date_asc":
        return new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime();
      case "date_desc":
        return new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime();
      case "size_asc":
        return (a.areaSqm || 0) - (b.areaSqm || 0);
      case "size_desc":
        return (b.areaSqm || 0) - (a.areaSqm || 0);
      case "fast_rental":
        return ((a as any).vacancyDays || 999) - ((b as any).vacancyDays || 999);
      case "lowest_vacancy":
        return ((a as any).vacancyDays || 999) - ((b as any).vacancyDays || 999);
      case "ai_recommended":
        return ((b as any).rankingScore || 0) - ((a as any).rankingScore || 0);
      default:
        return ((b as any).rankingScore || 0) - ((a as any).rankingScore || 0);
    }
  });

  const visibleProperties = filteredProperties.slice(0, visibleCount);

  // Intersection Observer for infinite scrolling
  useEffect(() => {
    const observer = new IntersectionObserver(
      (entries) => {
        if (entries[0].isIntersecting && visibleCount < filteredProperties.length) {
          // Load more when scrolled to bottom
          setVisibleCount((prev) => Math.min(prev + 12, filteredProperties.length));
        }
      },
      { threshold: 0.1, rootMargin: '100px' }
    );

    if (observerTarget.current) {
      observer.observe(observerTarget.current);
    }

    return () => {
      if (observerTarget.current) {
        observer.unobserve(observerTarget.current);
      }
    };
  }, [observerTarget, visibleCount, filteredProperties.length]);

  return <div className="h-[100dvh] flex flex-col overflow-hidden bg-slate-50 dark:bg-[#0a0b0d] pt-[72px]">
      {/* Header */}
      <div className="bg-white/60 dark:bg-background/60 backdrop-blur-xl border-b border-slate-200 dark:border-white/5">
        <div className="w-full px-4 sm:px-6 lg:px-8 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <h1 className="text-2xl font-black text-slate-900 dark:text-white italic tracking-tighter">Yeni Projeler</h1>
              <Badge className="bg-brand/20 text-brand border-blue-500/20">
                {filteredProperties.length}{t("client.src.properties_found")}</Badge>
              <Button variant="outline" size="sm" className="hidden md:flex ml-2 bg-background/80 backdrop-blur-xl border-slate-200 dark:border-white/5 rounded-xl" onClick={() => setShowFilters(!showFilters)}>
                <Filter className="w-4 h-4 mr-2" />
                {showFilters ? 'Gizle' : 'Filtreler'}
              </Button>
              {/* Mobile filter button with bottom sheet drawer */}
              <Sheet>
                <SheetTrigger asChild>
                  <Button variant="outline" size="sm" className="md:hidden ml-2 bg-background/80 backdrop-blur-xl border-slate-200 dark:border-white/5 rounded-xl">
                    <Filter className="w-4 h-4 mr-1" />
                    Filtrele
                  </Button>
                </SheetTrigger>
                <SheetContent side="bottom" className="h-[85vh] rounded-t-[2.5rem] bg-background/95 backdrop-blur-2xl border-t border-border overflow-y-auto px-6 py-6">
                  <SheetHeader className="mb-4">
                    <div className="flex items-center justify-between">
                      <SheetTitle className="text-xl font-black italic tracking-tighter">{t("client.src.filters")}</SheetTitle>
                      <Button variant="ghost" size="sm" onClick={clearFilters}>
                        <FilterX className="w-4 h-4 mr-2" />{t("client.src.clear_all")}
                      </Button>
                    </div>
                  </SheetHeader>
                  <div className="space-y-6 pb-12">
                    {/* Search */}
                    <div className="space-y-2">
                      <Label>{t("common.search")}</Label>
                      <div className="relative">
                        <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-muted-foreground w-4 h-4" />
                        <Input placeholder={t("client.src.search_by_name_address")} value={filters.search} onChange={e => updateFilters('search', e.target.value)} className="pl-10 bg-slate-50 dark:bg-[#0a0b0d] border-slate-200 dark:border-white/5 rounded-xl" />
                      </div>
                    </div>

                    {/* Property Types */}
                    <div className="space-y-3">
                      <Label>{t("client.src.property_type")}</Label>
                      <div className="grid grid-cols-2 gap-2">
                        {PROPERTY_TYPES.map(type => <div key={type.value} className="flex items-center space-x-2 p-2 rounded-xl bg-slate-50 dark:bg-white/5">
                            <Checkbox id={`proj-mob-${type.value}`} checked={filters.propertyTypes.includes(type.value)} onCheckedChange={checked => {
                          if (checked) {
                            updateFilters('propertyTypes', [...filters.propertyTypes, type.value]);
                          } else {
                            updateFilters('propertyTypes', filters.propertyTypes.filter(t => t !== type.value));
                          }
                        }} />
                            <Label htmlFor={`proj-mob-${type.value}`} className="text-xs font-semibold">
                              {type.label}
                            </Label>
                          </div>)}
                      </div>
                    </div>

                    {/* Price Range */}
                    <div className="space-y-3">
                      <Label>{t("client.src.price_range")}</Label>
                      <div className="space-y-2">
                        <Slider value={filters.priceRange} onValueChange={value => updateFilters('priceRange', value as [number, number])} max={10000000} step={10000} className="w-full" />
                        <div className="flex justify-between text-xs text-muted-foreground font-bold">
                          <span>${filters.priceRange[0].toLocaleString()}</span>
                          <span>${filters.priceRange[1].toLocaleString()}</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </SheetContent>
              </Sheet>
            </div>
            


            <div className="flex items-center gap-2">
              <Button variant={viewMode === 'map' ? 'default' : 'outline'} onClick={() => setViewMode('map')} className="h-10 rounded-xl">
                <Map className="w-4 h-4 mr-2" />{t("client.src.map_view")}</Button>
              <Button variant={viewMode === 'grid' ? 'default' : 'outline'} onClick={() => setViewMode('grid')} className="h-10 rounded-xl">
                <LayoutGrid className="w-4 h-4 mr-2" />Kare</Button>
              <Button variant={viewMode === 'list' ? 'default' : 'outline'} onClick={() => setViewMode('list')} className="h-10 rounded-xl">
                <List className="w-4 h-4 mr-2" />Liste</Button>
            </div>
          </div>
        </div>
      </div>

      <div className="flex-1 flex overflow-hidden">
        {/* Filters Sidebar */}
        <div className={`bg-white/60 dark:bg-background/60 backdrop-blur-xl border-r border-slate-200 dark:border-white/5 transition-all duration-300 ${showFilters ? 'w-80' : 'w-0'} overflow-hidden`}>
          <div className="p-6 space-y-6">
            <div className="flex items-center justify-between">
              <h2 className="text-lg font-black text-slate-900 dark:text-white italic tracking-tighter">{t("client.src.filters")}</h2>
              <Button variant="ghost" size="sm" onClick={clearFilters}>
                <FilterX className="w-4 h-4 mr-2" />{t("client.src.clear_all")}</Button>
            </div>

            {/* Search */}
            <div className="space-y-2">
              <Label>{t("common.search")}</Label>
              <div className="relative">
                <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-muted-foreground w-4 h-4" />
                <Input placeholder={t("client.src.search_by_name_address")} value={filters.search} onChange={e => updateFilters('search', e.target.value)} className="pl-10 bg-slate-50 dark:bg-[#0a0b0d] border-slate-200 dark:border-white/5 rounded-xl" />
              </div>
            </div>

            {/* Property Types */}
            <div className="space-y-3">
              <Label>{t("client.src.property_type")}</Label>
              <div className="space-y-2 max-h-40 overflow-y-auto">
                {PROPERTY_TYPES.map(type => <div key={type.value} className="flex items-center space-x-2">
                    <Checkbox id={type.value} checked={filters.propertyTypes.includes(type.value)} onCheckedChange={checked => {
                  if (checked) {
                    updateFilters('propertyTypes', [...filters.propertyTypes, type.value]);
                  } else {
                    updateFilters('propertyTypes', filters.propertyTypes.filter(t => t !== type.value));
                  }
                }} />
                    <Label htmlFor={type.value} className="text-sm text-muted-foreground">
                      {type.label}
                    </Label>
                  </div>)}
              </div>
            </div>

            {/* Advanced Tags Filter */}
            <div className="space-y-3">
              <Label>Gelişmiş Etiketler</Label>
              <div className="space-y-2">
                {[
                  { value: 'acil', label: '🚨 Acil Satılık' },
                  { value: 'fiyati_dusen', label: '📉 Fiyatı Düşenler' },
                  { value: 'firsat', label: '💎 Fırsat' }
                ].map(tag => (
                  <div key={tag.value} className="flex items-center space-x-2">
                    <Checkbox id={tag.value} checked={filters.advancedTags.includes(tag.value)} onCheckedChange={checked => {
                      if (checked) {
                        updateFilters('advancedTags', [...filters.advancedTags, tag.value]);
                      } else {
                        updateFilters('advancedTags', filters.advancedTags.filter(t => t !== tag.value));
                      }
                    }} />
                    <Label htmlFor={tag.value} className="text-sm font-bold text-slate-900 dark:text-white">
                      {tag.label}
                    </Label>
                  </div>
                ))}
              </div>
            </div>

            {/* AI & Gelişmiş Filtreler */}
            <div className="space-y-3">
              <Label className="text-slate-900 dark:text-white">AI Fırsat & Hukuki</Label>
              <div className="space-y-2">
                {[
                  { value: 'HIGH_YIELD', label: 'Yüksek Getiri (Fırsat)' },
                  { value: 'UNDERVALUED', label: 'Değerinin Altında' },
                  { value: 'HIGH', label: 'Acil Alım Önerisi' },
                  { value: 'APPROVED', label: 'Hukuki Onaylı' }
                ].map(tag => (
                  <div key={tag.value} className="flex items-center space-x-2">
                    <Checkbox id={tag.value} checked={filters.opportunityTiers.includes(tag.value) || filters.acquisitionUrgencies.includes(tag.value) || filters.legalComplianceStatuses.includes(tag.value)} onCheckedChange={checked => {
                      if (tag.value === 'HIGH_YIELD' || tag.value === 'UNDERVALUED') {
                        if (checked) updateFilters('opportunityTiers', [...filters.opportunityTiers, tag.value]);
                        else updateFilters('opportunityTiers', filters.opportunityTiers.filter(t => t !== tag.value));
                      } else if (tag.value === 'HIGH') {
                        if (checked) updateFilters('acquisitionUrgencies', [...filters.acquisitionUrgencies, tag.value]);
                        else updateFilters('acquisitionUrgencies', filters.acquisitionUrgencies.filter(t => t !== tag.value));
                      } else {
                        if (checked) updateFilters('legalComplianceStatuses', [...filters.legalComplianceStatuses, tag.value]);
                        else updateFilters('legalComplianceStatuses', filters.legalComplianceStatuses.filter(t => t !== tag.value));
                      }
                    }} />
                    <Label htmlFor={tag.value} className="text-sm font-bold text-slate-800 dark:text-white">
                      {tag.label}
                    </Label>
                  </div>
                ))}
              </div>
            </div>

            {/* Özellikler (Amenities) */}
            <div className="space-y-3">
              <Label className="text-slate-900 dark:text-white">Özellikler (Amenities)</Label>
              <div className="space-y-2 max-h-40 overflow-y-auto">
                {[
                  { value: 'Yüzme Havuzu', label: 'Havuz', icon: Waves },
                  { value: 'Otopark (Kapalı)', label: 'Kapalı Otopark', icon: Car },
                  { value: 'Spor Salonu', label: 'Spor Salonu', icon: Dumbbell },
                  { value: 'Akıllı Ev Sistemi', label: 'Akıllı Ev', icon: Shield }
                ].map(amenity => (
                  <div key={amenity.value} className="flex items-center space-x-2">
                    <Checkbox id={`am-${amenity.value}`} checked={filters.amenities.includes(amenity.value)} onCheckedChange={checked => {
                      if (checked) updateFilters('amenities', [...filters.amenities, amenity.value]);
                      else updateFilters('amenities', filters.amenities.filter(a => a !== amenity.value));
                    }} />
                    <Label htmlFor={`am-${amenity.value}`} className="text-sm text-slate-600 dark:text-slate-300 flex items-center">
                      <amenity.icon className="w-3 h-3 mr-1" /> {amenity.label}
                    </Label>
                  </div>
                ))}
              </div>
            </div>
            <div className="space-y-3">
              <Label>{t("client.src.price_range")}</Label>
              <div className="space-y-2">
                <Slider value={filters.priceRange} onValueChange={value => updateFilters('priceRange', value as [number, number])} max={1000000} step={10000} className="w-full" />
                <div className="flex justify-between text-sm text-muted-foreground">
                  <span>${filters.priceRange[0].toLocaleString()}</span>
                  <span>${filters.priceRange[1].toLocaleString()}</span>
                </div>
              </div>
            </div>

            {/* Bedrooms */}
            <div className="space-y-3">
              <Label>{t("client.src.bedrooms")}</Label>
              <div className="space-y-2">
                <Slider value={filters.bedrooms} onValueChange={value => updateFilters('bedrooms', value as [number, number])} max={10} step={1} className="w-full" />
                <div className="flex justify-between text-sm text-muted-foreground">
                  <span>{filters.bedrooms[0]}</span>
                  <span>{filters.bedrooms[1]}</span>
                </div>
              </div>
            </div>

            {/* Bathrooms */}
            <div className="space-y-3">
              <Label>{t("client.src.bathrooms")}</Label>
              <div className="space-y-2">
                <Slider value={filters.bathrooms} onValueChange={value => updateFilters('bathrooms', value as [number, number])} max={10} step={1} className="w-full" />
                <div className="flex justify-between text-sm text-muted-foreground">
                  <span>{filters.bathrooms[0]}</span>
                  <span>{filters.bathrooms[1]}</span>
                </div>
              </div>
            </div>

            {/* Area */}
            <div className="space-y-3">
              <Label>{t("client.src.area_sq_ft")}</Label>
              <div className="space-y-2">
                <Slider value={filters.areaRange} onValueChange={value => updateFilters('areaRange', value as [number, number])} max={5000} step={100} className="w-full" />
                <div className="flex justify-between text-sm text-muted-foreground">
                  <span>{filters.areaRange[0]}</span>
                  <span>{filters.areaRange[1]}</span>
                </div>
              </div>
            </div>

            {/* Sort By */}
            <div className="space-y-2">
              <Label>{t("client.src.sort_by")}</Label>
              <Select value={filters.sortBy} onValueChange={value => updateFilters('sortBy', value)}>
                <SelectTrigger className="bg-slate-50 dark:bg-[#0a0b0d] border-slate-200 dark:border-white/5 rounded-xl">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent className="bg-background border-slate-200 dark:border-white/5">
                  {SORT_OPTIONS.map(option => <SelectItem key={option.value} value={option.value}>
                      {option.label}
                    </SelectItem>)}
                </SelectContent>
              </Select>
            </div>
          </div>
        </div>

        {/* Main Content */}
        <div className="flex-1 relative bg-slate-50 dark:bg-[#0a0b0d]">

          {/* Map View */}
          {viewMode === 'map' && <div className="h-full w-full flex-1 relative min-h-[500px]">
              {/* Search as I move */}
              <div className="absolute top-4 left-1/2 -translate-x-1/2 z-20">
                <label className="flex items-center gap-2 bg-white dark:bg-slate-900 shadow-xl px-4 py-2 rounded-full cursor-pointer hover:scale-105 transition-transform border border-slate-200 dark:border-white/10">
                  <input 
                    type="checkbox" 
                    className="accent-black w-4 h-4 cursor-pointer"
                    checked={searchAsIMove}
                    onChange={(e) => setSearchAsIMove(e.target.checked)}
                  />
                  <span className="text-sm font-bold text-slate-900 dark:text-white">
                    {t("client.src.search_as_i_move") || "Haritayı hareket ettirdikçe ara"}
                  </span>
                </label>
              </div>

              <GoogleMapView 
                properties={filteredProperties} 
                onPropertyClick={setSelectedProperty} 
                height="100%" 
                showControls={true} 
                provider={provider} 
                showClusters={true} 
                enableHeatmap={filters.featuredOnly} 


                apiKey={process.env.NEXT_PUBLIC_GOOGLE_MAPS_API_KEY || ""} 
              />
              
              {/* Selected Property Card */}
              {selectedProperty && <Card className="absolute bottom-4 right-4 w-80 bg-background/95 backdrop-blur-xl border-slate-200 dark:border-white/5 rounded-2xl shadow-2xl">
                  <CardContent className="p-4">
                    <div className="flex justify-between items-start mb-3">
                      <h3 className="font-black text-slate-900 dark:text-white italic tracking-tighter">{selectedProperty.name}</h3>
                      <Button variant="ghost" size="sm" onClick={() => setSelectedProperty(null)} aria-label={t("common.close")}>
                        <X className="w-4 h-4" />
                      </Button>
                    </div>
                    <div className="space-y-2">
                      <p className="text-sm text-muted-foreground">{selectedProperty.addressLine1}</p>
                      <p className="text-sm text-muted-foreground">{selectedProperty.city}, {selectedProperty.state}</p>
                      <div className="flex items-center gap-4 text-sm">
                        <span className="text-muted-foreground">
                          <Bed className="w-4 h-4 inline mr-1" />
                          {selectedProperty.bedrooms}
                        </span>
                        <span className="text-muted-foreground">
                          <Bath className="w-4 h-4 inline mr-1" />
                          {selectedProperty.bathrooms}
                        </span>
                        <span className="text-muted-foreground">
                          <Square className="w-4 h-4 inline mr-1" />
                          {selectedProperty.areaSqm}{t("client.src.m")}</span>
                      </div>
                      <div className="flex items-center justify-between">
                        <span className="text-xl font-black text-slate-900 dark:text-white italic tracking-tighter">
                          ${selectedProperty.listingPrice?.toLocaleString()}
                        </span>
                        <Badge className="bg-success/20 text-success border-success/20">
                          {selectedProperty.listingStatus}
                        </Badge>
                      </div>
                      <Button className="w-full mt-3 bg-violet-600 hover:bg-violet-700" onClick={() => window.open(`/projects/${selectedProperty.id}`, '_blank')}>Satış Ofisi Ziyareti Planla</Button>
                    </div>
                  </CardContent>
                </Card>}
            </div>}

          {viewMode === 'grid' && <div className="h-full overflow-y-auto relative w-full">
            <div className="w-full px-4 sm:px-6 lg:px-8 py-6">
              {!loading && visibleProperties.length === 0 ? (
                <EmptySearchState onClearFilters={clearFilters} />
              ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                  {loading ? Array.from({ length: 8 }).map((_, i) => (
                    <PropertyCardSkeleton key={i} viewMode="grid" />
                  )) : visibleProperties.map((property: Property) => {
                    return (
                      <PropertyCard 
                        key={property.id} 
                      property={property} 
                      viewMode="grid" 
                      onHover={setHoveredPropertyId}
                      onClick={setSelectedProperty}
                    />
                  );
                })}
                </div>
              )}
              
              {/* Infinite Scroll Trigger */}
              {visibleCount < filteredProperties.length && (
                <div ref={observerTarget} className="w-full py-8 flex justify-center items-center">
                  <div className="relative w-10 h-10 animate-[spin_3s_linear_infinite]">
                    {/* Sun side (Left 50%) */}
                    <div className="absolute inset-0 flex items-center justify-center overflow-hidden" style={{ clipPath: 'inset(0 50% 0 0)' }}>
                      <Sun className="w-10 h-10 text-yellow-500 fill-yellow-500/20" />
                    </div>
                    {/* Moon side (Right 50%) */}
                    <div className="absolute inset-0 flex items-center justify-center overflow-hidden" style={{ clipPath: 'inset(0 0 0 50%)' }}>
                      <Moon className="w-10 h-10 text-slate-700 dark:text-slate-300 fill-slate-700/20 dark:fill-slate-300/20" />
                    </div>
                  </div>
                </div>
              )}
            </div>
          </div>}

          {viewMode === 'list' && <div className="h-full overflow-y-auto relative w-full">
            <div className="w-full px-4 sm:px-6 lg:px-8 py-6">
              {!loading && visibleProperties.length === 0 ? (
                <EmptySearchState onClearFilters={clearFilters} />
              ) : (
                <div className="flex flex-col gap-4 max-w-5xl mx-auto">
                  {loading ? Array.from({ length: 5 }).map((_, i) => (
                    <PropertyCardSkeleton key={i} viewMode="list" />
                  )) : visibleProperties.map((property: Property) => {
                    return (
                      <PropertyCard 
                        key={property.id} 
                      property={property} 
                      viewMode="list" 
                      onHover={setHoveredPropertyId}
                      onClick={setSelectedProperty}
                    />
                  );
                })}
                </div>
              )}
              
              {/* Infinite Scroll Trigger */}
              {visibleCount < filteredProperties.length && (
                <div ref={observerTarget} className="w-full py-8 flex justify-center items-center">
                  <div className="relative w-10 h-10 animate-[spin_3s_linear_infinite]">
                    {/* Sun side (Left 50%) */}
                    <div className="absolute inset-0 flex items-center justify-center overflow-hidden" style={{ clipPath: 'inset(0 50% 0 0)' }}>
                      <Sun className="w-10 h-10 text-yellow-500 fill-yellow-500/20" />
                    </div>
                    {/* Moon side (Right 50%) */}
                    <div className="absolute inset-0 flex items-center justify-center overflow-hidden" style={{ clipPath: 'inset(0 0 0 50%)' }}>
                      <Moon className="w-10 h-10 text-slate-700 dark:text-slate-300 fill-slate-700/20 dark:fill-slate-300/20" />
                    </div>
                  </div>
                </div>
              )}
            </div>
          </div>}
        </div>
      </div>
    </div>;
}