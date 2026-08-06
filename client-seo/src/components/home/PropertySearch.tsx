import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { useNavigate } from "@/lib/react-router-shim";
import { Search, MapPin, Home, DollarSign, Square, Filter, X, ChevronDown, ChevronUp } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Checkbox } from "@/components/ui/checkbox";
import { Slider } from "@/components/ui/slider";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import { propertiesApi } from "@/lib/api/properties";
import { Video } from "lucide-react";
import { agenciesApi } from "@/lib/api/agencies";
import { agentsApi } from "@/lib/api/agents";
import { vacationRentalsApi } from "@/lib/api/vacation-rentals";
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Building2, UserCircle, Umbrella } from "lucide-react";

// Property types from schema
const PROPERTY_TYPES = [{
  value: "DETACHED_HOUSE",
  label: t("client.src.detached_house")
}, {
  value: "ATTACHED_HOUSE",
  label: t("client.src.attached_house")
}, {
  value: "APARTMENT",
  label: t("client.src.apartment")
}, {
  value: "CONDO",
  label: t("client.src.condominium")
}, {
  value: "TOWNHOUSE",
  label: t("client.src.townhouse")
}, {
  value: "VILLA",
  label: t("client.src.villa")
}, {
  value: "STUDIO",
  label: t("client.src.studio")
}, {
  value: "LOFT",
  label: t("client.src.loft")
}, {
  value: "PENTHOUSE",
  label: t("client.src.penthouse")
}, {
  value: "MOBILE_HOME",
  label: t("client.src.mobile_home")
}];
const REGIONS = [{
  value: "NORTHEAST",
  label: t("client.src.northeast")
}, {
  value: "SOUTHEAST",
  label: t("client.src.southeast")
}, {
  value: "MIDWEST",
  label: t("client.src.midwest")
}, {
  value: "SOUTHWEST",
  label: t("client.src.southwest")
}, {
  value: "WEST",
  label: t("client.src.west")
}, {
  value: "PACIFIC",
  label: t("client.src.pacific")
}];
const LISTING_TYPES = [{
  value: "SALE",
  label: t("client.src.for_sale")
}, {
  value: "RENT",
  label: t("client.src.for_rent")
}, {
  value: "LEASE",
  label: t("client.src.for_lease")
}, {
  value: "AUCTION",
  label: t("client.src.auction")
}];
const AMENITIES = ["Pool", "Garage", "Air Conditioning", "Heating", "Fireplace", "Garden", "Balcony", "Elevator", "Security System", "Smart Home", "Gym", "Parking", "Storage", "Laundry", "Dishwasher", "Microwave"];
interface SearchFilters {
  query: string;
  propertyType: string;
  region: string;
  listingType: string;
  priceRange: number[];
  bedrooms: number[];
  bathrooms: number[];
  areaRange: number[];
  amenities: string[];
  yearBuilt: number[];
  hasGarage: boolean;
  hasPool: boolean;
  hasAirConditioning: boolean;
  hasFireplace: boolean;
  hasVideo: boolean;
}
type SearchCategory = "property" | "agency" | "agent" | "vacation";
export function PropertySearch() {
  const {
    t
  } = useTranslation();
  const navigate = useNavigate();
  const [searchCategory, setSearchCategory] = useState<SearchCategory>("property");
  const [filters, setFilters] = useState<SearchFilters>({
    query: "",
    propertyType: "all",
    region: "all",
    listingType: "all",
    priceRange: [0, 2000000],
    bedrooms: [0, 10],
    bathrooms: [0, 5],
    areaRange: [0, 5000],
    amenities: [],
    yearBuilt: [1950, 2024],
    hasGarage: false,
    hasPool: false,
    hasAirConditioning: false,
    hasFireplace: false,
    hasVideo: false
  });
  const [showAdvanced, setShowAdvanced] = useState(false);
  const [recentSearches, setRecentSearches] = useState<string[]>(["3 bedroom house in Miami", "Luxury condos in New York", "Beachfront properties California"]);
  const updateFilter = (key: keyof SearchFilters, value: any) => {
    setFilters(prev => ({
      ...prev,
      [key]: value
    }));
  };
  const handleSearch = async () => {
    // Add to recent searches
    if (filters.query && !recentSearches.includes(filters.query)) {
      setRecentSearches(prev => [filters.query, ...prev.slice(0, 2)]);
    }
    try {
      if (searchCategory === "property") {
        const queryParams = new URLSearchParams();
        if (filters.query) queryParams.set("query", filters.query);
        if (filters.propertyType !== "all") queryParams.set("type", filters.propertyType);
        if (filters.region !== "all") queryParams.set("region", filters.region);
        navigate(`/properties?${queryParams.toString()}`);
        return;
      }
      let results;
      switch (searchCategory) {
        case "agency":
          results = await agenciesApi.getAll({
            name: filters.query
          });
          break;
        case "agent":
          results = await agentsApi.getAll({
            name: filters.query
          });
          break;
        case "vacation":
          results = await vacationRentalsApi.getAll({
            query: filters.query
          });
          break;
      }
      console.log(`${searchCategory} search results:`, results);
    } catch (error) {
      console.error(`${searchCategory} search failed:`, error);
    }
  };
  const clearFilters = () => {
    setFilters({
      query: "",
      propertyType: "all",
      region: "all",
      listingType: "all",
      priceRange: [0, 2000000],
      bedrooms: [0, 10],
      bathrooms: [0, 5],
      areaRange: [0, 5000],
      amenities: [],
      yearBuilt: [1950, 2024],
      hasGarage: false,
      hasPool: false,
      hasAirConditioning: false,
      hasFireplace: false,
      hasVideo: false
    });
  };
  const formatPrice = (price: number) => {
    return new Intl.NumberFormat("en-US", {
      style: "currency",
      currency: "USD",
      maximumFractionDigits: 0
    }).format(price);
  };
  return <section className="py-16 px-4 md:px-6 bg-gradient-to-b from-background to-secondary/20">
      <div className="container mx-auto">
        <div className="text-center mb-12">
          <h2 className="text-3xl md:text-4xl font-bold mb-4">{t("client.src.aipowered_property_search")}</h2>
          <p className="text-muted-foreground text-lg max-w-2xl mx-auto">{t("client.src.search_from_thousands_of")}</p>
        </div>

        <Card className="max-w-5xl mx-auto shadow-lg">
          <CardHeader className="pb-4">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
              <CardTitle className="flex items-center gap-2">
                <Search className="w-5 h-5" />{t("client.src.find_your_perfect")}{searchCategory.charAt(0).toUpperCase() + searchCategory.slice(1)}
              </CardTitle>
              
              <Tabs value={searchCategory} onValueChange={v => setSearchCategory(v as SearchCategory)} className="w-full md:w-auto">
                <TabsList className="grid grid-cols-4 w-full md:w-[500px]">
                  <TabsTrigger value="property" className="text-xs md:text-sm gap-2">
                    <Home className="w-3 h-3 md:w-4 md:h-4" />{t("common.property")}</TabsTrigger>
                  <TabsTrigger value="agency" className="text-xs md:text-sm gap-2">
                    <Building2 className="w-3 h-3 md:w-4 md:h-4" />{t("common.agency")}</TabsTrigger>
                  <TabsTrigger value="agent" className="text-xs md:text-sm gap-2">
                    <UserCircle className="w-3 h-3 md:w-4 md:h-4" />{t("common.agent")}</TabsTrigger>
                  <TabsTrigger value="vacation" className="text-xs md:text-sm gap-2">
                    <Umbrella className="w-3 h-3 md:w-4 md:h-4" />{t("client.src.vacation")}</TabsTrigger>
                </TabsList>
              </Tabs>
            </div>
          </CardHeader>
          <CardContent className="space-y-6">
            {/* Main Search Bar */}
            <div className="flex flex-col lg:flex-row gap-4">
              <div className="flex-1">
                <div className="relative">
                  <Search className="absolute left-4 top-1/2 transform -translate-y-1/2 text-muted-foreground w-4 h-4" />
                  <Input aria-label="Search properties" placeholder={searchCategory === "property" ? "Search by address, city, zip code, or keywords..." : searchCategory === "agency" ? "Search by agency name, location, or license..." : searchCategory === "agent" ? "Search by agent name, specialty, or area..." : "Search for vacation rentals, villas, or cabins..."} value={filters.query} onChange={e => updateFilter("query", e.target.value)} className="pl-11 h-14 text-lg rounded-xl shadow-xs border-primary/10 focus-visible:ring-primary/20" />
                </div>
              </div>

              {searchCategory === "property" && <div className="flex gap-2">
                  <Select value={filters.propertyType} onValueChange={value => updateFilter("propertyType", value)}>
                    <SelectTrigger className="w-48 h-14 rounded-xl">
                      <SelectValue placeholder={t("client.src.property_type")} />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="all">{t("common.all_types")}</SelectItem>
                      {PROPERTY_TYPES.map(type => <SelectItem key={type.value} value={type.value}>
                          {type.label}
                        </SelectItem>)}
                    </SelectContent>
                  </Select>

                  <Select value={filters.listingType} onValueChange={value => updateFilter("listingType", value)}>
                    <SelectTrigger className="w-32 h-14 rounded-xl">
                      <SelectValue placeholder={t("common.type")} />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="all">{t("common.all")}</SelectItem>
                      {LISTING_TYPES.map(type => <SelectItem key={type.value} value={type.value}>
                          {type.label}
                        </SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>}
              
              <Button onClick={handleSearch} className="h-14 px-8 bg-primary hover:bg-primary/90 text-lg font-bold rounded-xl shadow-lg shadow-primary/20 transition-all active:scale-95">
                <Search className="w-5 h-5 mr-2" />{t("common.search")}</Button>
            </div>

            {/* Quick Filters */}
            <div className="flex flex-wrap gap-2 items-center">
              <span className="text-sm text-muted-foreground">{t("client.src.quick_filters")}</span>
              <Badge variant="outline" className="cursor-pointer hover:bg-secondary">
                <MapPin className="w-3 h-3 mr-1" />{t("client.src.near_me")}</Badge>
              <Badge variant="outline" className="cursor-pointer hover:bg-secondary">
                <DollarSign className="w-3 h-3 mr-1" />{t("client.src.best_value")}</Badge>
              <Badge variant="outline" className="cursor-pointer hover:bg-secondary">
                <Home className="w-3 h-3 mr-1" />{t("client.src.new_listings")}</Badge>
              <Badge variant="outline" className="cursor-pointer hover:bg-secondary">
                <Square className="w-3 h-3 mr-1" />{t("client.src.open_house")}</Badge>
            <Badge variant={filters.hasVideo ? "default" : "outline"} className="cursor-pointer hover:bg-secondary" onClick={() => updateFilter("hasVideo", !filters.hasVideo)}>
                <Video className="w-3 h-3 mr-1" />{t("client.src.ai_video_tours")}</Badge>
            </div>

            {/* Advanced Filters */}
            <Collapsible open={showAdvanced} onOpenChange={setShowAdvanced}>
              <CollapsibleTrigger asChild>
                <Button variant="ghost" className="w-full justify-between">
                  <span className="flex items-center gap-2">
                    <Filter className="w-4 h-4" />{t("client.src.advanced_filters")}</span>
                  {showAdvanced ? <ChevronUp className="w-4 h-4" /> : <ChevronDown className="w-4 h-4" />}
                </Button>
              </CollapsibleTrigger>

              <CollapsibleContent className="space-y-6 pt-6">
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                  {/* Price Range */}
                  <div className="space-y-2">
                    <Label className="text-sm font-medium">{t("client.src.price_range")}</Label>
                    <div className="px-2">
                      <Slider value={filters.priceRange} onValueChange={value => updateFilter("priceRange", value)} max={5000000} step={50000} className="w-full" />
                    </div>
                    <div className="flex justify-between text-sm text-muted-foreground">
                      <span>{formatPrice(filters.priceRange[0])}</span>
                      <span>{formatPrice(filters.priceRange[1])}</span>
                    </div>
                  </div>

                  {/* Bedrooms */}
                  <div className="space-y-2">
                    <Label className="text-sm font-medium">{t("client.src.bedrooms")}</Label>
                    <div className="px-2">
                      <Slider value={filters.bedrooms} onValueChange={value => updateFilter("bedrooms", value)} max={10} step={1} className="w-full" />
                    </div>
                    <div className="flex justify-between text-sm text-muted-foreground">
                      <span>{filters.bedrooms[0]}{t("client.src.beds")}</span>
                      <span>{filters.bedrooms[1]}{t("client.src.beds")}</span>
                    </div>
                  </div>

                  {/* Bathrooms */}
                  <div className="space-y-2">
                    <Label className="text-sm font-medium">{t("client.src.bathrooms")}</Label>
                    <div className="px-2">
                      <Slider value={filters.bathrooms} onValueChange={value => updateFilter("bathrooms", value)} max={5} step={0.5} className="w-full" />
                    </div>
                    <div className="flex justify-between text-sm text-muted-foreground">
                      <span>{filters.bathrooms[0]}{t("client.src.baths")}</span>
                      <span>{filters.bathrooms[1]}{t("client.src.baths")}</span>
                    </div>
                  </div>

                  {/* Area Range */}
                  <div className="space-y-2">
                    <Label className="text-sm font-medium">{t("client.src.square_feet")}</Label>
                    <div className="px-2">
                      <Slider value={filters.areaRange} onValueChange={value => updateFilter("areaRange", value)} max={10000} step={100} className="w-full" />
                    </div>
                    <div className="flex justify-between text-sm text-muted-foreground">
                      <span>{filters.areaRange[0]}{t("client.src.sq_ft")}</span>
                      <span>{filters.areaRange[1]}{t("client.src.sq_ft")}</span>
                    </div>
                  </div>

                  {/* Year Built */}
                  <div className="space-y-2">
                    <Label className="text-sm font-medium">{t("client.src.year_built")}</Label>
                    <div className="px-2">
                      <Slider value={filters.yearBuilt} onValueChange={value => updateFilter("yearBuilt", value)} min={1900} max={2024} step={1} className="w-full" />
                    </div>
                    <div className="flex justify-between text-sm text-muted-foreground">
                      <span>{filters.yearBuilt[0]}</span>
                      <span>{filters.yearBuilt[1]}</span>
                    </div>
                  </div>

                  {/* Region */}
                  <div className="space-y-2">
                    <Label className="text-sm font-medium">{t("client.src.region")}</Label>
                    <Select value={filters.region} onValueChange={value => updateFilter("region", value)}>
                      <SelectTrigger>
                        <SelectValue placeholder={t("client.src.select_region")} />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="all">{t("client.src.all_regions")}</SelectItem>
                        {REGIONS.map(region => <SelectItem key={region.value} value={region.value}>
                            {region.label}
                          </SelectItem>)}
                      </SelectContent>
                    </Select>
                  </div>
                </div>

                {/* Amenities */}
                <div className="space-y-3">
                  <Label className="text-sm font-medium">{t("client.src.amenities")}</Label>
                  <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-3">
                    {AMENITIES.slice(0, 12).map(amenity => <div key={amenity} className="flex items-center space-x-2">
                        <Checkbox id={amenity} checked={filters.amenities.includes(amenity)} onCheckedChange={checked => {
                      if (checked) {
                        updateFilter("amenities", [...filters.amenities, amenity]);
                      } else {
                        updateFilter("amenities", filters.amenities.filter(a => a !== amenity));
                      }
                    }} />
                        <Label htmlFor={amenity} className="text-sm cursor-pointer">
                          {amenity}
                        </Label>
                      </div>)}
                  </div>
                </div>

                {/* Action Buttons */}
                <div className="flex justify-between items-center pt-4 border-t">
                  <Button variant="outline" onClick={clearFilters}>
                    <X className="w-4 h-4 mr-2" />{t("client.src.clear_all_filters")}</Button>
                  <Button onClick={handleSearch} className="bg-primary hover:bg-primary/90">
                    <Search className="w-4 h-4 mr-2" />{t("client.src.apply_filters_search")}</Button>
                </div>
              </CollapsibleContent>
            </Collapsible>

            {/* Recent Searches */}
            {recentSearches.length > 0 && <div className="pt-4 border-t">
                <div className="flex items-center justify-between mb-3">
                  <span className="text-sm text-muted-foreground">{t("client.src.recent_searches")}</span>
                </div>
                <div className="flex flex-wrap gap-2">
                  {recentSearches.map((search, index) => <Button key={index} variant="outline" size="sm" onClick={() => updateFilter("query", search)} className="text-xs">
                      <Search className="w-3 h-3 mr-1" />
                      {search}
                    </Button>)}
                </div>
              </div>}
          </CardContent>
        </Card>
      </div>
    </section>;
}