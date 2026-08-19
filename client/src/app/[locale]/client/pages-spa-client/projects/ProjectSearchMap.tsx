"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { useSearchParams } from "@/lib/react-router-shim";
import { resolveMediaUrl } from "@/lib/utils";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Checkbox } from "@/components/ui/checkbox";
import { Label } from "@/components/ui/label";
import { Slider } from "@/components/ui/slider";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Home, Search, Filter, Bed, Bath, Square, Building, Building2, Map, Clock, Calendar, ChevronDown, ChevronUp, Layers, X, MapPin, FilterX, Maximize2, Minimize2, List, LayoutGrid, ZoomIn, ZoomOut, Wifi, Car, Dumbbell, Shield, Wind, ArrowUpDown, Sun, Flame, Waves, Utensils, Users } from "lucide-react";
import { Separator } from "@/components/ui/separator";
import { useQuery } from "@tanstack/react-query";
import { propertiesApi } from "@/lib/api/properties";
import { useAuth } from "@/lib/auth/hooks";
import GoogleMapView from "@/components/map/GoogleMapView";
import { useMapProvider } from "@/components/map/MapProvider";
import { type Property } from "@/lib/api/properties";
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
  const searchParams = useSearchParams() || new URLSearchParams();
  const {
    provider
  } = useMapProvider();
  const [showFilters, setShowFilters] = useState(false);
  const [viewMode, setViewMode] = useState<'map' | 'grid' | 'list'>('grid');
  const [selectedProperty, setSelectedProperty] = useState<Property | null>(null);
  const [filters, setFilters] = useState<SearchFilters>({
    search: searchParams.get('search') || '',
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
    queryFn: () => propertiesApi.getAll({ sortBy: filters.sortBy })
  });

  const updateFilters = (key: keyof SearchFilters, value: any) => {
    setFilters(prev => ({
      ...prev,
      [key]: value
    }));
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
  const propertiesWithMockedTags = properties.map(property => {
    const p = { ...property } as any;
    p.uiTags = p.uiTags || [];
    if (p.listingPrice && p.listingPrice < 900000 && !p.uiTags.includes('firsat')) p.uiTags.push('firsat');
    if (p.name.toLowerCase().includes('acil')) p.uiTags.push('acil');
    if (p.listingPrice && p.listingPrice > 900000 && p.listingPrice < 960000) p.uiTags.push('fiyati_dusen');

    return p as Property;
  });

  const filteredProperties = propertiesWithMockedTags.filter(property => {
    // Project specific filter: show properties that look like projects
    // (have project notes, facility blocks, multiple units, etc.) or match known project names
    const notes = (property.notes || '').toLowerCase();
    const hasProjectData = notes.includes('"project"') || notes.includes('"blocks"') || notes.includes('"totalUnits"');
    const isKnownProject = property.name.toLowerCase().includes('proje') || 
                           property.name.toLowerCase().includes('city') || 
                           property.name.toLowerCase().includes('göktürk') || 
                           property.name.toLowerCase().includes('büyükyalı') ||
                           property.name.toLowerCase().includes('delta') ||
                           property.name.toLowerCase().includes('almond') ||
                           property.name.toLowerCase().includes('avrupa') ||
                           property.name.toLowerCase().includes('güneşli') ||
                           property.name.toLowerCase().includes('hayat') ||
                           property.name.toLowerCase().includes('konut') ||
                           property.name.toLowerCase().includes('residence') ||
                           property.name.toLowerCase().includes('court') ||
                           property.name.toLowerCase().includes('uphill') ||
                           property.name.toLowerCase().includes('upcity') ||
                           property.name.toLowerCase().includes('sinpaş') ||
                           property.name.toLowerCase().includes('queen');
    if (!hasProjectData && !isKnownProject) return false;

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
  }).sort((a, b) => {
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
  return <div className="h-[100dvh] flex flex-col overflow-hidden bg-slate-50 dark:bg-[#0a0b0d] pt-[90px]">
      {/* Header */}
      <div className="bg-white/60 dark:bg-background/60 backdrop-blur-xl border-b border-slate-200 dark:border-white/5">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <h1 className="text-2xl font-black text-slate-900 dark:text-white italic tracking-tighter">Yeni Projeler</h1>
              <Badge className="bg-brand/20 text-brand border-blue-500/20">
                {filteredProperties.length}{t("client.src.properties_found")}</Badge>
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
              <Label className="dark:text-slate-900 dark:text-white text-slate-900">AI Fırsat & Hukuki</Label>
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
                    <Label htmlFor={tag.value} className="text-sm font-bold text-slate-800 dark:text-slate-900 dark:text-white">
                      {tag.label}
                    </Label>
                  </div>
                ))}
              </div>
            </div>

            {/* Özellikler (Amenities) */}
            <div className="space-y-3">
              <Label className="dark:text-slate-900 dark:text-white text-slate-900">Özellikler (Amenities)</Label>
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
        <div className="flex-1 relative">
          {/* Toggle Filters Button */}
          <Button variant="outline" className="absolute top-4 left-4 z-10 bg-background/80 backdrop-blur-xl border-slate-200 dark:border-white/5 rounded-xl" onClick={() => setShowFilters(!showFilters)}>
            <Filter className="w-4 h-4 mr-2" />
            {showFilters ? 'Hide' : 'Show'}{t("client.src.filters")}</Button>

          {/* Map View */}
          {viewMode === 'map' && <div className="h-full w-full flex-1 relative min-h-[500px]">
              <GoogleMapView properties={filteredProperties} onPropertyClick={setSelectedProperty} height="100%" showControls={true} provider={provider} showClusters={true} enableHeatmap={filters.featuredOnly} apiKey={process.env.NEXT_PUBLIC_GOOGLE_MAPS_API_KEY || ""} />
              
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

          {/* Grid View */}
          {viewMode === 'grid' && <div className="h-full overflow-y-auto p-6">
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                {filteredProperties.map(property => <Card key={property.id} className="bg-background/40 border-slate-200 dark:border-white/5 rounded-2xl overflow-hidden hover:border-white/10 transition-all cursor-pointer group">
                    <div className="h-56 bg-gradient-to-br from-slate-800 to-slate-900 relative overflow-hidden">
                      {/* Image or Video rendering — photos first */}
                      {(property as any).photos && (property as any).photos.length > 0 ? (
                        <img 
                          src={resolveMediaUrl((property as any).photos[0].url) || (property as any).photos[0].url} 
                          alt={property.name} 
                          className="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-105" 
                        />
                      ) : (property as any).videoUrl ? (
                         <video 
                           src={(property as any).videoUrl}
                           className="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-105"
                           autoPlay loop muted playsInline
                         />
                      ) : (
                        <div className="absolute inset-0 flex items-center justify-center">
                          <Building className="w-16 h-16 text-muted-foreground opacity-50" />
                        </div>
                      )}
                      
                      {/* Gradient Overlay for Text Readability */}
                      <div className="absolute inset-0 bg-gradient-to-t from-[#0a0b0d] via-[#0a0b0d]/20 to-transparent pointer-events-none" />

                      {/* Top Right Badges */}
                      <div className="absolute top-3 right-3 flex flex-col gap-2 items-end">
                        <Badge className="bg-success/90 text-slate-900 dark:text-white border-none shadow-lg">
                          {property.listingStatus}
                        </Badge>
                        {/* Advanced Tags Badges */}
                        {(property as any).uiTags?.includes('acil') && (
                          <Badge className="bg-red-500 text-slate-900 dark:text-white border-none shadow-lg animate-pulse">🚨 Acil Satılık</Badge>
                        )}
                        {(property as any).uiTags?.includes('fiyati_dusen') && (
                          <Badge className="bg-orange-500 text-slate-900 dark:text-white border-none shadow-lg">📉 Fiyatı Düşen</Badge>
                        )}
                        {(property as any).uiTags?.includes('firsat') && (
                          <Badge className="bg-brand text-slate-900 dark:text-white border-none shadow-lg">💎 Fırsat</Badge>
                        )}
                      </div>
                    </div>
                    <CardContent className="p-5">
                      <h3 className="font-black text-slate-900 dark:text-white text-lg tracking-tight mb-2 truncate">{property.name}</h3>
                      <p className="text-xs text-slate-400 mb-4 truncate flex items-center">
                        <MapPin className="w-3 h-3 mr-1" />
                        {property.addressLine1 || property.city}
                      </p>
                      
                      <div className="flex items-center gap-4 text-xs font-semibold text-slate-300 mb-5 bg-white/5 p-3 rounded-xl">
                        <span className="flex items-center gap-1.5"><Bed className="w-4 h-4 text-slate-400" />{property.bedrooms}</span>
                        <span className="flex items-center gap-1.5"><Bath className="w-4 h-4 text-slate-400" />{property.bathrooms}</span>
                        <span className="flex items-center gap-1.5"><Square className="w-4 h-4 text-slate-400" />{property.areaSqm}m²</span>
                      </div>
                      
                      <div className="flex flex-wrap gap-2 mb-4">
                        {((property as any).amenities || ['Yüzme Havuzu', 'Otopark (Kapalı)']).slice(0, 3).map((am: string, i: number) => (
                           <span key={i} className="text-[10px] bg-slate-100 dark:bg-white/10 text-slate-600 dark:text-slate-300 px-2 py-1 rounded-md">{am}</span>
                        ))}
                      </div>

                      <div className="flex items-center justify-between">
                        <div className="flex flex-col">
                          <span className="text-[10px] text-slate-500 font-bold uppercase tracking-wider mb-0.5">Fiyat</span>
                          <span className="text-xl font-black text-slate-900 dark:text-white tracking-tighter">
                            ${property.listingPrice?.toLocaleString()}
                          </span>
                        </div>
                        <Button size="sm" className="bg-violet-600 text-slate-900 dark:text-white hover:bg-violet-700 rounded-xl font-bold px-4" onClick={() => window.open(`/projects/${property.id}`, '_blank')}>
                          Projeyi İncele
                        </Button>
                      </div>
                    </CardContent>
                  </Card>)}
              </div>
            </div>}

          {/* List View */}
          {viewMode === 'list' && <div className="h-full overflow-y-auto p-6">
              <div className="flex flex-col gap-4">
                {filteredProperties.map(property => <Card key={property.id} className="bg-background/40 border-slate-200 dark:border-white/5 rounded-2xl overflow-hidden hover:border-white/10 transition-all cursor-pointer group flex flex-col sm:flex-row h-auto sm:h-48">
                    <div className="sm:w-72 h-48 sm:h-full bg-gradient-to-br from-slate-800 to-slate-900 relative overflow-hidden shrink-0">
                      {/* Image or Video rendering — photos first */}
                      {(property as any).photos && (property as any).photos.length > 0 ? (
                        <img 
                          src={resolveMediaUrl((property as any).photos[0].url) || (property as any).photos[0].url} 
                          alt={property.name} 
                          className="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-105" 
                        />
                      ) : (property as any).videoUrl ? (
                         <video 
                           src={(property as any).videoUrl}
                           className="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-105"
                           autoPlay loop muted playsInline
                         />
                      ) : (
                        <div className="absolute inset-0 flex items-center justify-center">
                          <Building className="w-12 h-12 text-muted-foreground opacity-50" />
                        </div>
                      )}
                      
                      {/* Top Right Badges */}
                      <div className="absolute top-3 right-3 flex flex-col gap-2 items-end">
                        <Badge className="bg-success/90 text-slate-900 dark:text-white border-none shadow-lg">
                          {property.listingStatus}
                        </Badge>
                      </div>
                    </div>
                    <CardContent className="p-5 flex-1 flex flex-col justify-between">
                      <div>
                        <div className="flex justify-between items-start">
                          <div>
                            <h3 className="font-black text-slate-900 dark:text-white text-xl tracking-tight mb-1 truncate">{property.name}</h3>
                            <p className="text-xs text-slate-400 mb-3 truncate flex items-center">
                              <MapPin className="w-3 h-3 mr-1" />
                              {property.addressLine1 || property.city}
                            </p>
                          </div>
                          
                          <div className="flex gap-2">
                            {/* Advanced Tags Badges */}
                            {(property as any).uiTags?.includes('acil') && (
                              <Badge className="bg-red-500 text-slate-900 dark:text-white border-none">🚨 Acil</Badge>
                            )}
                            {(property as any).uiTags?.includes('fiyati_dusen') && (
                              <Badge className="bg-orange-500 text-slate-900 dark:text-white border-none">📉 Fiyatı Düşen</Badge>
                            )}
                          </div>
                        </div>
                        
                        <div className="flex items-center gap-5 text-sm font-semibold text-slate-300">
                          <span className="flex items-center gap-1.5"><Bed className="w-4 h-4 text-slate-400" />{property.bedrooms} Bed</span>
                          <span className="flex items-center gap-1.5"><Bath className="w-4 h-4 text-slate-400" />{property.bathrooms} Bath</span>
                          <span className="flex items-center gap-1.5"><Square className="w-4 h-4 text-slate-400" />{property.areaSqm}m²</span>
                        </div>
                        <div className="flex flex-wrap gap-2 mb-4 mt-2">
                          {((property as any).amenities || ['Yüzme Havuzu', 'Otopark (Kapalı)']).slice(0, 3).map((am: string, i: number) => (
                             <span key={i} className="text-[10px] bg-slate-100 dark:bg-white/10 text-slate-600 dark:text-slate-300 px-2 py-1 rounded-md">{am}</span>
                          ))}
                        </div>
                      </div>
                      
                      <div className="flex items-center justify-between mt-4">
                        <div className="flex flex-col">
                          <span className="text-2xl font-black text-slate-900 dark:text-white tracking-tighter">
                            ${property.listingPrice?.toLocaleString()}
                          </span>
                        </div>
                        <Button size="sm" className="bg-violet-600 text-slate-900 dark:text-white hover:bg-violet-700 rounded-xl font-bold px-4" onClick={() => window.open(`/projects/${property.id}`, '_blank')}>
                          Projeyi İncele
                        </Button>
                      </div>
                    </CardContent>
                  </Card>)}
              </div>
            </div>}
        </div>
      </div>
    </div>;
}