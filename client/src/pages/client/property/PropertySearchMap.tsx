import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { useSearchParams } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Checkbox } from "@/components/ui/checkbox";
import { Label } from "@/components/ui/label";
import { Slider } from "@/components/ui/slider";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Home, Search, Filter, Bed, Bath, Square, Building, Building2, Map, Clock, Calendar, ChevronDown, ChevronUp, Layers, X, MapPin, FilterX, Maximize2, Minimize2, List, ZoomIn, ZoomOut } from "lucide-react";
import { Separator } from "@/components/ui/separator";
import { useQuery } from "@tanstack/react-query";
import { propertiesApi } from "@/lib/api/properties";
import { useAuth } from "@/lib/auth/hooks";
import GoogleMapView from "@/components/map/GoogleMapView";
import { useMapProvider } from "@/components/map/MapProvider";
import { type Property } from "@/lib/api/properties";
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
  value: "LAND",
  label: t("client.src.land")
}, {
  value: "MIXED_USE",
  label: t("client.src.mixed_use")
}];
const LISTING_TYPES = [{
  value: "SALE",
  label: t("client.src.for_sale")
}, {
  value: "RENT",
  label: t("client.src.for_rent")
}, {
  value: "SHORT_TERM_RENTAL",
  label: t("client.src.short_term_rental")
}, {
  value: "LONG_TERM_RENTAL",
  label: t("client.src.long_term_rental")
}];
const LISTING_STATUSES = [{
  value: "AVAILABLE",
  label: t("client.src.available")
}, {
  value: "PENDING",
  label: t("client.src.pending")
}, {
  value: "SOLD",
  label: t("client.src.sold")
}, {
  value: "RENTED",
  label: t("client.src.rented")
}, {
  value: "OFF_MARKET",
  label: t("client.src.off_market")
}, {
  value: "COMING_SOON",
  label: t("client.src.coming_soon")
}];
const SORT_OPTIONS = [{
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
export default function PropertySearch() {
  const {
    t
  } = useTranslation();
  const [searchParams, setSearchParams] = useSearchParams();
  const {
    provider
  } = useMapProvider();
  const { data: properties = [], isLoading: loading } = useQuery({
    queryKey: ['properties'],
    queryFn: () => propertiesApi.getAll()
  });
  const [showFilters, setShowFilters] = useState(false);
  const [viewMode, setViewMode] = useState<'map' | 'list'>('map');
  const [selectedProperty, setSelectedProperty] = useState<Property | null>(null);
  const [filters, setFilters] = useState<SearchFilters>({
    search: searchParams.get('search') || '',
    propertyTypes: [],
    categories: [],
    listingTypes: [],
    listingStatuses: ['AVAILABLE', 'PENDING'],
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
      listingStatuses: ['AVAILABLE', 'PENDING'],
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
  };
  const filteredProperties = properties.filter(property => {
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
  });
  return <div className="min-h-screen bg-[#0a0b0d]">
      {/* Header */}
      <div className="bg-[#14151a]/60 backdrop-blur-xl border-b border-white/5">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <h1 className="text-2xl font-black text-white italic tracking-tighter">{t("client.src.property_search")}</h1>
              <Badge className="bg-blue-500/20 text-blue-400 border-blue-500/20">
                {filteredProperties.length}{t("client.src.properties_found")}</Badge>
            </div>
            <div className="flex items-center gap-2">
              <Button variant={viewMode === 'map' ? 'default' : 'outline'} onClick={() => setViewMode('map')} className="h-10 rounded-xl">
                <Map className="w-4 h-4 mr-2" />{t("client.src.map_view")}</Button>
              <Button variant={viewMode === 'list' ? 'default' : 'outline'} onClick={() => setViewMode('list')} className="h-10 rounded-xl">
                <List className="w-4 h-4 mr-2" />{t("client.src.list_view")}</Button>
            </div>
          </div>
        </div>
      </div>

      <div className="flex h-[calc(100vh-80px)]">
        {/* Filters Sidebar */}
        <div className={`bg-[#14151a]/60 backdrop-blur-xl border-r border-white/5 transition-all duration-300 ${showFilters ? 'w-80' : 'w-0'} overflow-hidden`}>
          <div className="p-6 space-y-6">
            <div className="flex items-center justify-between">
              <h2 className="text-lg font-black text-white italic tracking-tighter">{t("client.src.filters")}</h2>
              <Button variant="ghost" size="sm" onClick={clearFilters}>
                <FilterX className="w-4 h-4 mr-2" />{t("client.src.clear_all")}</Button>
            </div>

            {/* Search */}
            <div className="space-y-2">
              <Label>{t("client.src.search")}</Label>
              <div className="relative">
                <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-slate-400 w-4 h-4" />
                <Input placeholder={t("client.src.search_by_name_address")} value={filters.search} onChange={e => updateFilters('search', e.target.value)} className="pl-10 bg-[#0a0b0d] border-white/5 rounded-xl" />
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
                    <Label htmlFor={type.value} className="text-sm text-slate-300">
                      {type.label}
                    </Label>
                  </div>)}
              </div>
            </div>

            {/* Price Range */}
            <div className="space-y-3">
              <Label>{t("client.src.price_range")}</Label>
              <div className="space-y-2">
                <Slider value={filters.priceRange} onValueChange={value => updateFilters('priceRange', value as [number, number])} max={1000000} step={10000} className="w-full" />
                <div className="flex justify-between text-sm text-slate-400">
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
                <div className="flex justify-between text-sm text-slate-400">
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
                <div className="flex justify-between text-sm text-slate-400">
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
                <div className="flex justify-between text-sm text-slate-400">
                  <span>{filters.areaRange[0]}</span>
                  <span>{filters.areaRange[1]}</span>
                </div>
              </div>
            </div>

            {/* Sort By */}
            <div className="space-y-2">
              <Label>{t("client.src.sort_by")}</Label>
              <Select value={filters.sortBy} onValueChange={value => updateFilters('sortBy', value)}>
                <SelectTrigger className="bg-[#0a0b0d] border-white/5 rounded-xl">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent className="bg-[#14151a] border-white/5">
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
          <Button variant="outline" className="absolute top-4 left-4 z-10 bg-[#14151a]/80 backdrop-blur-xl border-white/5 rounded-xl" onClick={() => setShowFilters(!showFilters)}>
            <Filter className="w-4 h-4 mr-2" />
            {showFilters ? 'Hide' : 'Show'}{t("client.src.filters")}</Button>

          {/* Map View */}
          {viewMode === 'map' && <div className="h-full">
              <GoogleMapView properties={filteredProperties} onPropertyClick={setSelectedProperty} height="100%" showControls={true} provider={provider} showClusters={true} enableHeatmap={filters.featuredOnly} apiKey="dummy-key" />
              
              {/* Selected Property Card */}
              {selectedProperty && <Card className="absolute bottom-4 right-4 w-80 bg-[#14151a]/95 backdrop-blur-xl border-white/5 rounded-2xl shadow-2xl">
                  <CardContent className="p-4">
                    <div className="flex justify-between items-start mb-3">
                      <h3 className="font-black text-white italic tracking-tighter">{selectedProperty.name}</h3>
                      <Button variant="ghost" size="sm" onClick={() => setSelectedProperty(null)}>
                        <X className="w-4 h-4" />
                      </Button>
                    </div>
                    <div className="space-y-2">
                      <p className="text-sm text-slate-300">{selectedProperty.addressLine1}</p>
                      <p className="text-sm text-slate-300">{selectedProperty.city}, {selectedProperty.state}</p>
                      <div className="flex items-center gap-4 text-sm">
                        <span className="text-slate-400">
                          <Bed className="w-4 h-4 inline mr-1" />
                          {selectedProperty.bedrooms}
                        </span>
                        <span className="text-slate-400">
                          <Bath className="w-4 h-4 inline mr-1" />
                          {selectedProperty.bathrooms}
                        </span>
                        <span className="text-slate-400">
                          <Square className="w-4 h-4 inline mr-1" />
                          {selectedProperty.areaSqm}{t("client.src.m")}</span>
                      </div>
                      <div className="flex items-center justify-between">
                        <span className="text-xl font-black text-white italic tracking-tighter">
                          ${selectedProperty.listingPrice?.toLocaleString()}
                        </span>
                        <Badge className="bg-emerald-500/20 text-emerald-400 border-emerald-500/20">
                          {selectedProperty.listingStatus}
                        </Badge>
                      </div>
                      <Button className="w-full mt-3" onClick={() => window.open(`/property/${selectedProperty.id}`, '_blank')}>{t("client.src.view_details")}</Button>
                    </div>
                  </CardContent>
                </Card>}
            </div>}

          {/* List View */}
          {viewMode === 'list' && <div className="h-full overflow-y-auto p-6">
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                {filteredProperties.map(property => <Card key={property.id} className="bg-[#14151a]/40 border-white/5 rounded-2xl overflow-hidden hover:border-white/10 transition-all cursor-pointer">
                    <div className="h-48 bg-linear-to-br from-slate-800 to-slate-900 relative">
                      <div className="absolute inset-0 flex items-center justify-center">
                        <Building className="w-16 h-16 text-slate-600" />
                      </div>
                      <div className="absolute top-2 right-2">
                        <Badge className="bg-emerald-500/20 text-emerald-400 border-emerald-500/20">
                          {property.listingStatus}
                        </Badge>
                      </div>
                    </div>
                    <CardContent className="p-4">
                      <h3 className="font-black text-white italic tracking-tighter mb-2">{property.name}</h3>
                      <p className="text-sm text-slate-300 mb-3">{property.addressLine1}</p>
                      <div className="flex items-center gap-3 text-sm text-slate-400 mb-3">
                        <span><Bed className="w-4 h-4 inline mr-1" />{property.bedrooms}</span>
                        <span><Bath className="w-4 h-4 inline mr-1" />{property.bathrooms}</span>
                        <span><Square className="w-4 h-4 inline mr-1" />{property.areaSqm}{t("client.src.m")}</span>
                      </div>
                      <div className="flex items-center justify-between">
                        <span className="text-lg font-black text-white italic tracking-tighter">
                          ${property.listingPrice?.toLocaleString()}
                        </span>
                        <Button size="sm" onClick={() => window.open(`/property/${property.id}`, '_blank')}>{t("client.src.view")}</Button>
                      </div>
                    </CardContent>
                  </Card>)}
              </div>
            </div>}
        </div>
      </div>
    </div>;
}