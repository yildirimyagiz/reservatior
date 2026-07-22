"use client";

import Image from "next/image";
import { useState } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Building, MapPin, Search, MoreHorizontal, Activity, Edit, BarChart3, Map, Grid, PlayCircle, Trash2, ShieldCheck, List, SlidersHorizontal, Sparkles, Home, Briefcase, Percent, X } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { useQuery } from "@tanstack/react-query";
import { propertiesApi } from "@/lib/api/properties";
import { m } from "framer-motion";
import { cn } from "@/lib/utils";
import { useNavigate } from "@/lib/react-router-shim";
import { Select, SelectContent, SelectGroup, SelectItem, SelectLabel, SelectTrigger, SelectValue } from "@/components/ui/select";
import GoogleMapView from "@/components/map/GoogleMapView";
import { MapProviderWrapper, useMapProvider } from "@/components/map/MapProvider";
import { Property as BaseProperty } from "@/lib/api/properties";
import { useTranslation } from "react-i18next";
import { useRegionsStore } from "@/lib/store/regions-store";
import { PropertyCard } from "@/components/property/PropertyCard";
export type Property = BaseProperty & {
  occupancyRate?: number;
  revenue?: number;
  agentVideos?: any[];
  legalComplianceStatus?: string;
  ownershipVerified?: boolean;
  arbitrageOpportunity?: boolean;
  managementOpportunity?: boolean;
  balcony?: boolean;
  garden?: boolean;
  parking?: boolean;
  furnished?: boolean;
  country?: string;
  state?: string;
  region?: string;
  qualityScore?: number;
  price?: any;
  image?: string;
};
export default function Properties() {
  const {
    t
  } = useTranslation();
  const { toast } = useToast();
  const navigate = useNavigate();
  const { selectedRegion } = useRegionsStore();
  const [searchTerm, setSearchTerm] = useState("");
  const [promotionType, setPromotionType] = useState("ALL");
  const [listingType, setListingType] = useState("ALL");
  const [propertyType, setPropertyType] = useState("ALL");
  const [status, setStatus] = useState("ALL");
  const [floor, setFloor] = useState("ALL");
  const [bedrooms, setBedrooms] = useState("ALL");
  const [viewMode, setViewMode] = useState<'grid' | 'list' | 'map'>('grid');
  const [propertyCategory, setPropertyCategory] = useState("ALL");
  const [arbitrageOpportunity, setArbitrageOpportunity] = useState<boolean | 'ALL'>('ALL');
  const [managementOpportunity, setManagementOpportunity] = useState<boolean | 'ALL'>('ALL');
  const [balcony, setBalcony] = useState<boolean | 'ALL'>('ALL');
  const [garden, setGarden] = useState<boolean | 'ALL'>('ALL');
  const [parking, setParking] = useState<boolean | 'ALL'>('ALL');
  const [furnished, setFurnished] = useState<boolean | 'ALL'>('ALL');
  const [showAdvanced, setShowAdvanced] = useState(false);

  const [countryFilter, setCountryFilter] = useState("ALL");
  const [stateFilter, setStateFilter] = useState("ALL");
  const [cityFilter, setCityFilter] = useState("ALL");
  const [sortBy, setSortBy] = useState("DEFAULT");
  const [aiQuery, setAiQuery] = useState("");
  const [searchModalOpen, setSearchModalOpen] = useState(false);
  const [chatMessages, setChatMessages] = useState<Array<{ sender: 'user' | 'assistant', text: string }>>([
    { sender: 'assistant', text: "Hello! I am your AI assistant. Tell me what you're looking for (e.g. 'villa with 3 bedrooms and garden' or 'commercial office for rent') and I will configure the filters for you instantly in the background!" }
  ]);
  const [chatInput, setChatInput] = useState("");

  const {
    provider,
    apiKey
  } = useMapProvider();

  const { data: rawProperties = [], isLoading: loading } = useQuery({
    queryKey: ['properties', selectedRegion?.countryCode],
    queryFn: () => propertiesApi.getAll({ limit: 1000 })
  });

  const properties = (rawProperties || []).map((p: any) => ({
    ...p,
    orgId: p.orgId || "org-123",
    region: p.region || "NY",
    currency: p.currency || "USD",
    country: p.country || "USA",
    occupancyRate: Math.floor(Math.random() * 40) + 60,
    revenue: Math.floor(Math.random() * 50000) + 10000,
    lat: p.lat || 40.7128 + (Math.random() - 0.5) * 0.1,
    lng: p.lng || -74.0060 + (Math.random() - 0.5) * 0.1,
    agentVideos: p.videos || (Math.random() > 0.7 ? [{
      id: `vid-${p.id}`,
      videoUrl: `https://example.com/video/${p.id}.mp4`,
      thumbnailUrl: "",
      title: `${p.name} Tour`
    }] : [])
  })) as Property[];

  const countries = Array.from(new Set(properties.map(p => p.country).filter(Boolean))).sort();
  const states = Array.from(new Set(properties.filter(p => countryFilter === 'ALL' || p.country === countryFilter).map(p => p.state || p.region).filter(Boolean))).sort();
  const cities = Array.from(new Set(properties.filter(p => (countryFilter === 'ALL' || p.country === countryFilter) && (stateFilter === 'ALL' || p.state === stateFilter || p.region === stateFilter)).map(p => p.city).filter(Boolean))).sort();

  const floors = Array.from(new Set(properties.map(p => (p as any).kat?.toString() || (p as any).floor?.toString()).filter(Boolean))).sort((a, b) => parseInt(a as string) - parseInt(b as string));
  const bedroomCounts = Array.from(new Set(properties.map(p => p.bedrooms?.toString()).filter(Boolean))).sort();

  const correctTypos = (text: string): string => {
    let corrected = text.toLowerCase();
    
    // Typo mapping (keys are regex patterns, values are corrected words)
    const typoMap: Record<string, string> = {
      // English typos
      "vila+": "villa",
      "ap+a+rt+ment+": "apartment",
      "ap+rt+ment+": "apartment",
      "bed+room+s*": "bedroom",
      "gar+d+en+": "garden",
      "par+k+ing+": "parking",
      "fur+nis+hed+": "furnished",
      "pen+t+hous+e*": "penthouse",
      "of+ic+e*": "office",
      // Turkish typos
      "kiral+ı*k": "kiralık",
      "satıl+ı*k": "satılık",
      "bah[cç]e*": "bahçe",
      "otop+ar+k+": "otopark",
      "esyalı+": "eşyalı",
      "mobilyal+ı+": "mobilyalı",
      "da+ir+e+": "daire",
      "yo+ne+ti+m+": "yönetim",
      "ar+bi+t+ra+j+": "arbitraj"
    };

    Object.keys(typoMap).forEach(pattern => {
      const regex = new RegExp(`\\b${pattern}\\w*\\b`, 'g');
      corrected = corrected.replace(regex, typoMap[pattern]);
    });

    return corrected;
  };

  const handleAISearch = (query: string, skipChat = false) => {
    setAiQuery(query);
    if (!query.trim()) return [];

    const correctedQuery = correctTypos(query);
    const lowerQuery = correctedQuery.toLowerCase();
    const detected: string[] = [];

    // 1. Bedrooms
    const bedMatch = lowerQuery.match(/(\d+)\s*(?:bed|bedroom|oda|yatak)/);
    if (bedMatch) {
      setBedrooms(bedMatch[1]);
      detected.push(`${bedMatch[1]} Bedrooms`);
    }

    // 2. Listing Type
    if (lowerQuery.includes("sale") || lowerQuery.includes("satılık") || lowerQuery.includes("buy")) {
      setListingType("SALE");
      detected.push("For Sale");
    } else if (lowerQuery.includes("rent") || lowerQuery.includes("kiralık")) {
      setListingType("RENT");
      detected.push("For Rent");
    } else if (lowerQuery.includes("booking") || lowerQuery.includes("rezervasyon")) {
      setListingType("BOOKING");
      detected.push("For Booking");
    }

    // 3. Property Type / Category
    if (lowerQuery.includes("villa")) {
      setPropertyType("VILLA");
      setPropertyCategory("RESIDENTIAL");
      detected.push("Villa");
    } else if (lowerQuery.includes("apartment") || lowerQuery.includes("daire") || lowerQuery.includes("flat")) {
      setPropertyType("APARTMENT");
      setPropertyCategory("RESIDENTIAL");
      detected.push("Apartment");
    } else if (lowerQuery.includes("penthouse")) {
      setPropertyType("PENTHOUSE");
      setPropertyCategory("RESIDENTIAL");
      detected.push("Penthouse");
    } else if (lowerQuery.includes("office") || lowerQuery.includes("ofis")) {
      setPropertyType("OFFICE");
      setPropertyCategory("COMMERCIAL");
      detected.push("Office");
    } else if (lowerQuery.includes("commercial") || lowerQuery.includes("ticari")) {
      setPropertyCategory("COMMERCIAL");
      detected.push("Commercial");
    } else if (lowerQuery.includes("residential") || lowerQuery.includes("konut")) {
      setPropertyCategory("RESIDENTIAL");
      detected.push("Residential");
    }

    // 4. Features/Amenities
    if (lowerQuery.includes("balcony") || lowerQuery.includes("balkon")) {
      setBalcony(true);
      detected.push("Balcony");
    }
    if (lowerQuery.includes("garden") || lowerQuery.includes("bahçe")) {
      setGarden(true);
      detected.push("Garden");
    }
    if (lowerQuery.includes("parking") || lowerQuery.includes("otopark") || lowerQuery.includes("garaj")) {
      setParking(true);
      detected.push("Parking");
    }
    if (lowerQuery.includes("furnished") || lowerQuery.includes("eşyalı") || lowerQuery.includes("mobilyalı")) {
      setFurnished(true);
      detected.push("Furnished");
    }

    // 5. Opportunities
    if (lowerQuery.includes("arbitrage") || lowerQuery.includes("arbitraj")) {
      setArbitrageOpportunity(true);
      detected.push("Arbitrage Opportunity");
    }
    if (lowerQuery.includes("management") || lowerQuery.includes("yönetim")) {
      setManagementOpportunity(true);
      detected.push("Management Opportunity");
    }

    if (!skipChat) {
      toast({
        title: "AI Filter Processed",
        description: `Updated search settings for: "${query}"`,
      });
    }

    return detected;
  };

  const handleChatSubmit = (msg: string) => {
    if (!msg.trim()) return;

    // Add user message
    setChatMessages(prev => [...prev, { sender: 'user', text: msg }]);
    setChatInput("");

    // Run the AI search parser (updates filters)
    const detected = handleAISearch(msg, true);

    // AI Assistant response builder
    let reply = "";
    if (detected.length > 0) {
      reply = `I've updated the property listing filters in the background for you! I detected and applied: ${detected.join(", ")}. Do you want to add more requirements (like location, price range, or status)?`;
    } else {
      reply = `I've registered your search query "${msg}". If there are any specific requirements like number of bedrooms, villa/apartment type, or garden/parking amenities, just let me know!`;
    }

    setTimeout(() => {
      setChatMessages(prev => [...prev, { sender: 'assistant', text: reply }]);
    }, 600);
  };

  const getStatusColor = (status: string) => {
    switch (status?.toUpperCase()) {
      case 'AVAILABLE':
        return 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20';
      case 'SOLD':
        return 'bg-slate-500/10 text-slate-400 border-slate-500/20';
      case 'PENDING':
        return 'bg-orange-500/10 text-orange-400 border-orange-500/20';
      case 'RENTED':
        return 'bg-blue-500/10 text-blue-400 border-blue-500/20';
      default:
        return 'bg-slate-500/10 text-slate-400 border-slate-500/20';
    }
  };

  const filteredProperties = properties.filter(property => {
    const matchesSearch = (property.name || "").toLowerCase().includes(searchTerm.toLowerCase()) || (property.city || "").toLowerCase().includes(searchTerm.toLowerCase());
    const matchesListing = listingType === "ALL" || property.listingType === listingType;
    const matchesType = propertyType === "ALL" || property.type === propertyType;
    const matchesStatus = status === "ALL" || property.listingStatus === status;
    const propertyFloor = (property as any).kat?.toString() || (property as any).floor?.toString();
    const matchesFloor = floor === "ALL" || propertyFloor === floor;
    const matchesBedrooms = bedrooms === "ALL" || property.bedrooms?.toString() === bedrooms;
    const matchesCategory = propertyCategory === "ALL" || property.propertyCategory === propertyCategory;
    const matchesArbitrage = arbitrageOpportunity === 'ALL' || property.arbitrageOpportunity === arbitrageOpportunity;
    const matchesManagement = managementOpportunity === 'ALL' || property.managementOpportunity === managementOpportunity;
    const matchesBalcony = balcony === 'ALL' || property.balcony === balcony;
    const matchesGarden = garden === 'ALL' || property.garden === garden;
    const matchesParking = parking === 'ALL' || property.parking === parking;
    const matchesFurnished = furnished === 'ALL' || property.furnished === furnished;
    const matchesCountry = countryFilter === "ALL" || property.country === countryFilter;
    const matchesState = stateFilter === "ALL" || property.state === stateFilter || property.region === stateFilter;
    const matchesCity = cityFilter === "ALL" || property.city === cityFilter;
    return matchesSearch && matchesListing && matchesType && matchesStatus && matchesFloor && matchesBedrooms && matchesCategory && matchesArbitrage && matchesManagement && matchesBalcony && matchesGarden && matchesParking && matchesFurnished && matchesCountry && matchesState && matchesCity;
  });

  const sortedProperties = [...filteredProperties].sort((a, b) => {
    if (sortBy === "PRICE_ASC") {
      const priceA = parseFloat(a.listingPrice?.toString() || a.price?.toString() || "0");
      const priceB = parseFloat(b.listingPrice?.toString() || b.price?.toString() || "0");
      return priceA - priceB;
    }
    if (sortBy === "PRICE_DESC") {
      const priceA = parseFloat(a.listingPrice?.toString() || a.price?.toString() || "0");
      const priceB = parseFloat(b.listingPrice?.toString() || b.price?.toString() || "0");
      return priceB - priceA;
    }
    if (sortBy === "SCORE_DESC") {
      return (b.qualityScore || 0) - (a.qualityScore || 0);
    }
    if (sortBy === "NAME_ASC") {
      return (a.name || "").localeCompare(b.name || "");
    }
    return 0; // Default
  });

  const activeFiltersList = [
    { key: "aiQuery", label: `AI: "${aiQuery}"`, active: aiQuery.trim() !== "", clear: () => { setAiQuery(""); clearAllFilters(); } },
    { key: "search", label: `Search: "${searchTerm}"`, active: searchTerm !== "", clear: () => setSearchTerm("") },
    { key: "listingType", label: `Listing: ${listingType}`, active: listingType !== "ALL", clear: () => setListingType("ALL") },
    { key: "category", label: `Category: ${propertyCategory}`, active: propertyCategory !== "ALL", clear: () => setPropertyCategory("ALL") },
    { key: "type", label: `Type: ${propertyType}`, active: propertyType !== "ALL", clear: () => setPropertyType("ALL") },
    { key: "status", label: `Status: ${status}`, active: status !== "ALL", clear: () => setStatus("ALL") },
    { key: "floor", label: `Floor: ${floor}`, active: floor !== "ALL", clear: () => setFloor("ALL") },
    { key: "bedrooms", label: `Bedrooms: ${bedrooms}`, active: bedrooms !== "ALL", clear: () => setBedrooms("ALL") },
    { key: "arbitrage", label: `Arbitrage: Yes`, active: arbitrageOpportunity === true, clear: () => setArbitrageOpportunity('ALL') },
    { key: "management", label: `Management: Yes`, active: managementOpportunity === true, clear: () => setManagementOpportunity('ALL') },
    { key: "balcony", label: `Balcony: Yes`, active: balcony === true, clear: () => setBalcony('ALL') },
    { key: "garden", label: `Garden: Yes`, active: garden === true, clear: () => setGarden('ALL') },
    { key: "parking", label: `Parking: Yes`, active: parking === true, clear: () => setParking('ALL') },
    { key: "furnished", label: `Furnished: Yes`, active: furnished === true, clear: () => setFurnished('ALL') },
    { key: "country", label: `Country: ${countryFilter}`, active: countryFilter !== "ALL", clear: () => setCountryFilter("ALL") },
    { key: "state", label: `State: ${stateFilter}`, active: stateFilter !== "ALL", clear: () => setStateFilter("ALL") },
    { key: "city", label: `City: ${cityFilter}`, active: cityFilter !== "ALL", clear: () => setCityFilter("ALL") },
  ].filter(f => f.active);

  const clearAllFilters = () => {
    setAiQuery("");
    setSearchTerm("");
    setListingType("ALL");
    setPropertyCategory("ALL");
    setPropertyType("ALL");
    setStatus("ALL");
    setFloor("ALL");
    setBedrooms("ALL");
    setArbitrageOpportunity('ALL');
    setManagementOpportunity('ALL');
    setBalcony('ALL');
    setGarden('ALL');
    setParking('ALL');
    setFurnished('ALL');
    setCountryFilter("ALL");
    setStateFilter("ALL");
    setCityFilter("ALL");
  };

  return <MapProviderWrapper>
      <PageShell 
        title={t("client.property.portfolio.title")} 
        description={t("client.property.portfolio.desc")} 
        createLabel={t("client.property.portfolio.add")} 
        onCreateClick={() => navigate("/admin/properties")} 
        actions={
          <div className="flex items-center p-1 bg-muted/50 backdrop-blur-md rounded-2xl border border-border/50">
            <Button variant={viewMode === 'grid' ? 'default' : 'ghost'} onClick={() => setViewMode('grid')} className={cn("h-9 rounded-xl font-bold tracking-widest text-[10px] uppercase transition-all", viewMode === 'grid' ? "bg-background text-foreground shadow-sm" : "text-muted-foreground")}>
              <Grid className="w-4 h-4 mr-2" />
              {t("client.property.portfolio.views.grid")}
            </Button>
            <Button variant={viewMode === 'list' ? 'default' : 'ghost'} onClick={() => setViewMode('list')} className={cn("h-9 rounded-xl font-bold tracking-widest text-[10px] uppercase transition-all", viewMode === 'list' ? "bg-background text-foreground shadow-sm" : "text-muted-foreground")}>
              <List className="w-4 h-4 mr-2" />
              {t("client.property.portfolio.views.list", "List")}
            </Button>
            <Button variant={viewMode === 'map' ? 'default' : 'ghost'} onClick={() => setViewMode('map')} className={cn("h-9 rounded-xl font-bold tracking-widest text-[10px] uppercase transition-all", viewMode === 'map' ? "bg-background text-foreground shadow-sm" : "text-muted-foreground")}>
              <Map className="w-4 h-4 mr-2" />
              {t("client.property.portfolio.views.map")}
            </Button>
          </div>
        }
      >
      <div className="space-y-8 pb-20 p-6">
        
        {/* Compact Combined Filter Dashboard */}
        <div className="flex flex-col gap-4 p-4 rounded-[2rem] bg-background/40 border border-border/50 backdrop-blur-xl shadow-sm">
          {/* Top Row: Search, Tabs, Sort & Advanced Toggle */}
          <div className="flex flex-col lg:flex-row gap-3 justify-between items-stretch lg:items-center">
            {/* Search Input */}
            <div className="relative flex-1 group">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-primary transition-colors" />
              <input
                placeholder="Search properties, cities, or type AI query..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                onClick={() => setSearchModalOpen(true)}
                className="w-full h-10 pl-10 pr-4 bg-background/50 border border-border/50 rounded-xl text-xs focus:outline-none focus:ring-1 focus:ring-primary transition-all font-medium text-foreground placeholder:text-muted-foreground"
              />
            </div>

            {/* Listing Type tabs */}
            <div className="flex items-center p-0.5 bg-muted/40 rounded-xl border border-border/40 shrink-0">
              {[
                { val: 'ALL', label: 'All' },
                { val: 'SALE', label: 'Sale' },
                { val: 'RENT', label: 'Rent' },
                { val: 'BOOKING', label: 'Booking' }
              ].map(tab => (
                <button
                  key={tab.val}
                  onClick={() => setListingType(tab.val)}
                  className={cn(
                    "px-3 py-1.5 rounded-lg text-[10px] font-black uppercase tracking-wider transition-all",
                    listingType === tab.val
                      ? "bg-primary text-primary-foreground shadow-sm"
                      : "text-muted-foreground hover:text-foreground"
                  )}
                >
                  {tab.label}
                </button>
              ))}
            </div>

            {/* Sort & Advanced Controls */}
            <div className="flex items-center gap-2 shrink-0">
              <Select value={sortBy} onValueChange={setSortBy}>
                <SelectTrigger className="w-[130px] h-10 bg-background/60 border-border/50 text-foreground font-bold text-[10px] tracking-widest uppercase rounded-xl hover:bg-muted/50 transition-all">
                  <SelectValue placeholder="Sort By" />
                </SelectTrigger>
                <SelectContent className="rounded-xl">
                  <SelectItem value="DEFAULT">Sort: Default</SelectItem>
                  <SelectItem value="PRICE_ASC">Price: Low-High</SelectItem>
                  <SelectItem value="PRICE_DESC">Price: High-Low</SelectItem>
                  <SelectItem value="SCORE_DESC">Score: High-Low</SelectItem>
                  <SelectItem value="NAME_ASC">Name: A-Z</SelectItem>
                </SelectContent>
              </Select>

              <button
                onClick={() => setShowAdvanced(!showAdvanced)}
                className={cn(
                  "flex items-center gap-1.5 px-3 h-10 rounded-xl text-[10px] font-black uppercase tracking-wider border transition-all",
                  showAdvanced 
                    ? "bg-primary text-primary-foreground border-primary" 
                    : "bg-background/60 text-muted-foreground border-border/50 hover:bg-muted/50"
                )}
              >
                <SlidersHorizontal className="w-3.5 h-3.5" />
                Advanced
              </button>
            </div>
          </div>

          {/* Bottom Row: Quick Filters & Categories */}
          <div className="flex flex-wrap items-center gap-3 pt-2 border-t border-border/20">
            {/* Category pills */}
            <div className="flex items-center gap-1.5 mr-auto">
              {[
                { val: 'ALL', label: 'All Categories', icon: Building },
                { val: 'RESIDENTIAL', label: 'Residential', icon: Home },
                { val: 'COMMERCIAL', label: 'Commercial', icon: Briefcase }
              ].map(tab => {
                const Icon = tab.icon;
                return (
                  <button
                    key={tab.val}
                    onClick={() => setPropertyCategory(tab.val)}
                    className={cn(
                      "flex items-center gap-1.5 px-3 py-1.5 rounded-full text-[9px] font-black uppercase tracking-wider border transition-all",
                      propertyCategory === tab.val
                        ? "bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 border-emerald-500/30"
                        : "bg-background/40 text-muted-foreground border-border/50 hover:bg-muted/30"
                    )}
                  >
                    <Icon className="w-3 h-3" />
                    {tab.label}
                  </button>
                );
              })}
            </div>

            {/* Quick dropdowns */}
            <Select value={propertyType} onValueChange={setPropertyType}>
              <SelectTrigger className="w-auto min-w-[130px] h-8 bg-background/60 border-border/50 text-foreground font-bold text-[10px] tracking-widest uppercase rounded-lg hover:bg-muted/50 transition-all">
                <SelectValue placeholder="Type" />
              </SelectTrigger>
              <SelectContent className="rounded-lg max-h-[300px]">
                <SelectItem value="ALL">All Types</SelectItem>
                <SelectItem value="DETACHED_HOUSE">Detached House</SelectItem>
                <SelectItem value="SEMI_DETACHED_HOUSE">Semi-Detached</SelectItem>
                <SelectItem value="APARTMENT">Apartment</SelectItem>
                <SelectItem value="STUDIO">Studio</SelectItem>
                <SelectItem value="VILLA">Villa</SelectItem>
              </SelectContent>
            </Select>

            <Select value={status} onValueChange={setStatus}>
              <SelectTrigger className="w-auto min-w-[130px] h-8 bg-background/60 border-border/50 text-foreground font-bold text-[10px] tracking-widest uppercase rounded-lg hover:bg-muted/50 transition-all">
                <SelectValue placeholder="Status" />
              </SelectTrigger>
              <SelectContent className="rounded-lg">
                <SelectItem value="ALL">All Status</SelectItem>
                <SelectItem value="AVAILABLE">Available</SelectItem>
                <SelectItem value="PENDING">Pending</SelectItem>
                <SelectItem value="SOLD">Sold</SelectItem>
                <SelectItem value="RENTED">Rented</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>

        {/* Search Modal Dropdown (AI + Geo Location filters) */}
        {searchModalOpen && (
          <m.div 
            initial={{ opacity: 0, y: -10 }} 
            animate={{ opacity: 1, y: 0 }} 
            className="p-6 rounded-[2.5rem] bg-background/60 border border-border/40 backdrop-blur-2xl shadow-xl space-y-6 relative z-30"
          >
            <div className="flex justify-between items-center pb-4 border-b border-border/40">
              <h3 className="text-sm font-black uppercase tracking-widest text-foreground flex items-center gap-2">
                <Sparkles className="w-4 h-4 text-primary animate-pulse" />
                AI & Location Search
              </h3>
              <button 
                onClick={() => setSearchModalOpen(false)} 
                className="text-xs font-bold text-muted-foreground hover:text-foreground transition-colors"
              >
                Close (ESC)
              </button>
            </div>

            {/* AI Conversational Chat Assistant */}
            <div className="space-y-4">
              <label className="text-[10px] font-black uppercase tracking-widest text-muted-foreground">AI Search Assistant</label>
              
              {/* Chat history */}
              <div className="h-[200px] overflow-y-auto p-4 bg-black/20 border border-border/40 rounded-2xl space-y-3 scrollbar-hide flex flex-col">
                {chatMessages.map((msg, i) => (
                  <div 
                    key={i} 
                    className={cn(
                      "max-w-[80%] rounded-2xl p-3 text-xs leading-relaxed",
                      msg.sender === 'user'
                        ? "bg-primary text-primary-foreground ml-auto rounded-tr-none"
                        : "bg-muted/60 text-foreground mr-auto rounded-tl-none border border-border/25"
                    )}
                  >
                    <p>{msg.text}</p>
                  </div>
                ))}
              </div>

              {/* Quick Suggestion Bubbles */}
              <div className="flex flex-wrap gap-2 pt-1">
                {[
                  "3 Bed Villa with Garden",
                  "Furnished Apartment for Rent",
                  "Office for Sale",
                  "Penthouse with Balcony"
                ].map((sug, i) => (
                  <button
                    key={i}
                    onClick={() => {
                      handleChatSubmit(sug);
                    }}
                    className="px-2.5 py-1 bg-primary/10 border border-primary/20 text-primary text-[9px] font-bold rounded-full hover:bg-primary/20 transition-all flex items-center gap-1 shadow-sm"
                  >
                    <span>💡</span> {sug}
                  </button>
                ))}
              </div>

              {/* Chat Input */}
              <div className="flex gap-2">
                <input
                  placeholder="Ask me: 'villa with garden and 3 bedrooms' or 'rented commercial flats'..."
                  value={chatInput}
                  onChange={(e) => setChatInput(e.target.value)}
                  onKeyDown={(e) => e.key === 'Enter' && handleChatSubmit(chatInput)}
                  className="flex-1 h-10 px-4 bg-background/40 border border-border/50 rounded-xl text-sm focus:outline-none focus:ring-1 focus:ring-primary transition-all text-foreground"
                />
                <Button 
                  onClick={() => handleChatSubmit(chatInput)}
                  className="h-10 bg-primary border border-primary text-primary-foreground hover:bg-primary/95 rounded-xl font-bold text-xs px-4"
                >
                  <Sparkles className="w-4 h-4 mr-2" /> Send
                </Button>
              </div>
            </div>

            {/* Cascading Geo Filters */}
            <div className="space-y-2 pt-2">
              <label className="text-[10px] font-black uppercase tracking-widest text-muted-foreground">Location Filter</label>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                {/* Country */}
                <div className="flex flex-col gap-1.5">
                  <span className="text-[9px] font-bold text-muted-foreground uppercase">Country</span>
                  <Select value={countryFilter} onValueChange={(val) => { setCountryFilter(val); setStateFilter("ALL"); setCityFilter("ALL"); }}>
                    <SelectTrigger className="bg-background/40 border-border/50 rounded-xl text-xs h-10">
                      <SelectValue placeholder="All Countries" />
                    </SelectTrigger>
                    <SelectContent className="rounded-xl">
                      <SelectItem value="ALL">All Countries</SelectItem>
                      {countries.map(c => <SelectItem key={c} value={c}>{c}</SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>

                {/* State/Region */}
                <div className="flex flex-col gap-1.5">
                  <span className="text-[9px] font-bold text-muted-foreground uppercase">State / Region</span>
                  <Select value={stateFilter} onValueChange={(val) => { setStateFilter(val); setCityFilter("ALL"); }} disabled={countryFilter === 'ALL' && states.length === 0}>
                    <SelectTrigger className="bg-background/40 border-border/50 rounded-xl text-xs h-10">
                      <SelectValue placeholder="All States" />
                    </SelectTrigger>
                    <SelectContent className="rounded-xl">
                      <SelectItem value="ALL">All States</SelectItem>
                      {states.map(s => <SelectItem key={s} value={s}>{s}</SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>

                {/* City */}
                <div className="flex flex-col gap-1.5">
                  <span className="text-[9px] font-bold text-muted-foreground uppercase">City</span>
                  <Select value={cityFilter} onValueChange={setCityFilter} disabled={stateFilter === 'ALL' && cities.length === 0}>
                    <SelectTrigger className="bg-background/40 border-border/50 rounded-xl text-xs h-10">
                      <SelectValue placeholder="All Cities" />
                    </SelectTrigger>
                    <SelectContent className="rounded-xl">
                      <SelectItem value="ALL">All Cities</SelectItem>
                      {cities.map(ci => <SelectItem key={ci} value={ci}>{ci}</SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
              </div>
            </div>

            {/* Quick Reset */}
            <div className="flex justify-end pt-2">
              <Button 
                variant="ghost" 
                onClick={() => {
                  setCountryFilter("ALL");
                  setStateFilter("ALL");
                  setCityFilter("ALL");
                  setAiQuery("");
                  toast({ title: "Filters Reset", description: "Location filters have been cleared." });
                }}
                className="text-xs text-muted-foreground hover:text-foreground font-bold"
              >
                Clear Location & AI Filters
              </Button>
            </div>
          </m.div>
        )}

        {/* Collapsible Advanced Filters panel */}
        {showAdvanced && (
          <m.div 
            initial={{ opacity: 0, y: -10 }} 
            animate={{ opacity: 1, y: 0 }} 
            className="p-6 rounded-[2rem] bg-background/20 border border-border/40 backdrop-blur-xl shadow-md space-y-6"
          >
            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-4">
              <div className="flex flex-col gap-2">
                <label className="text-[10px] font-black uppercase tracking-widest text-muted-foreground">Floor</label>
                <Select value={floor} onValueChange={setFloor}>
                  <SelectTrigger className="bg-background/50 border-border/50 rounded-xl text-xs font-bold h-10">
                    <SelectValue placeholder="Floor" />
                  </SelectTrigger>
                  <SelectContent className="rounded-xl">
                    <SelectItem value="ALL">All Floors</SelectItem>
                    {floors.map(f => (
                      <SelectItem key={f} value={f as string}>{f}. Floor</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div className="flex flex-col gap-2">
                <label className="text-[10px] font-black uppercase tracking-widest text-muted-foreground">Bedrooms</label>
                <Select value={bedrooms} onValueChange={setBedrooms}>
                  <SelectTrigger className="bg-background/50 border-border/50 rounded-xl text-xs font-bold h-10">
                    <SelectValue placeholder="Bedrooms" />
                  </SelectTrigger>
                  <SelectContent className="rounded-xl">
                    <SelectItem value="ALL">All Bed</SelectItem>
                    {bedroomCounts.map(b => (
                      <SelectItem key={b} value={b as string}>{b}+1 Room</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div className="flex flex-col gap-2">
                <label className="text-[10px] font-black uppercase tracking-widest text-muted-foreground">Promotion</label>
                <Select value={promotionType} onValueChange={setPromotionType}>
                  <SelectTrigger className="bg-background/50 border-border/50 rounded-xl text-xs font-bold h-10">
                    <SelectValue placeholder={t("client.src.promotion.title")} />
                  </SelectTrigger>
                  <SelectContent className="rounded-xl">
                    <SelectItem value="ALL">{t("client.src.promotion.all")}</SelectItem>
                    <SelectItem value="FEATURED">{t("client.src.promotion.featured")}</SelectItem>
                    <SelectItem value="URGENT">{t("client.src.promotion.urgent")}</SelectItem>
                    <SelectItem value="PRICE_REDUCED">{t("client.src.promotion.price_reduced")}</SelectItem>
                    <SelectItem value="BEST_DEAL">{t("client.src.promotion.best_deal")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>

            {/* AI Opportunities & Special Tags */}
            <div className="pt-4 border-t border-border/40 flex flex-wrap gap-4">
              <div className="flex items-center gap-4">
                <button
                  onClick={() => setArbitrageOpportunity(arbitrageOpportunity === 'ALL' ? true : arbitrageOpportunity === true ? false : 'ALL')}
                  className={cn(
                    "flex items-center gap-2 px-4 py-2 rounded-xl text-[10px] font-black uppercase tracking-wider border transition-all",
                    arbitrageOpportunity === true 
                      ? "bg-rose-500/10 text-rose-500 border-rose-500/30 shadow-sm animate-pulse" 
                      : arbitrageOpportunity === false 
                      ? "bg-slate-500/10 text-slate-400 border-slate-500/30"
                      : "bg-background/40 text-muted-foreground border-border/50"
                  )}
                >
                  <Percent className="w-3.5 h-3.5" />
                  Arbitrage Opportunity: {arbitrageOpportunity === 'ALL' ? 'ALL' : arbitrageOpportunity ? 'YES' : 'NO'}
                </button>

                <button
                  onClick={() => setManagementOpportunity(managementOpportunity === 'ALL' ? true : managementOpportunity === true ? false : 'ALL')}
                  className={cn(
                    "flex items-center gap-2 px-4 py-2 rounded-xl text-[10px] font-black uppercase tracking-wider border transition-all",
                    managementOpportunity === true 
                      ? "bg-orange-500/10 text-orange-500 border-orange-500/30 shadow-sm" 
                      : managementOpportunity === false 
                      ? "bg-slate-500/10 text-slate-400 border-slate-500/30"
                      : "bg-background/40 text-muted-foreground border-border/50"
                  )}
                >
                  <Sparkles className="w-3.5 h-3.5" />
                  Management Opportunity: {managementOpportunity === 'ALL' ? 'ALL' : managementOpportunity ? 'YES' : 'NO'}
                </button>
              </div>

              {/* Boolean features */}
              <div className="flex flex-wrap items-center gap-2">
                {[
                  { label: 'Balcony', state: balcony, setter: setBalcony },
                  { label: 'Garden', state: garden, setter: setGarden },
                  { label: 'Parking', state: parking, setter: setParking },
                  { label: 'Furnished', state: furnished, setter: setFurnished }
                ].map(tag => (
                  <button
                    key={tag.label}
                    onClick={() => tag.setter(tag.state === 'ALL' ? true : tag.state === true ? false : 'ALL')}
                    className={cn(
                      "px-3 py-1.5 rounded-lg text-[10px] font-bold uppercase tracking-wider border transition-all",
                      tag.state === true
                        ? "bg-primary/10 text-primary border-primary/30"
                        : tag.state === false
                        ? "bg-muted text-muted-foreground/40 border-muted"
                        : "bg-background/20 text-muted-foreground border-border/50"
                    )}
                  >
                    {tag.label}: {tag.state === 'ALL' ? 'ALL' : tag.state ? 'YES' : 'NO'}
                  </button>
                ))}
              </div>
            </div>
          </m.div>
        )}



        {activeFiltersList.length > 0 && (
          <div className="flex flex-wrap items-center gap-2 p-3 bg-muted/20 border border-border/40 rounded-2xl mb-6 backdrop-blur-md">
            <span className="text-[10px] font-bold text-muted-foreground uppercase tracking-wider mr-2">Active Filters:</span>
            {activeFiltersList.map(filter => (
              <Badge key={filter.key} className="bg-primary/10 text-primary border-primary/20 text-[9px] font-bold px-2 py-0.5 rounded-md flex items-center gap-1.5 shadow-sm">
                {filter.label}
                <button onClick={filter.clear} aria-label="Remove filter" className="hover:text-foreground transition-colors ml-1">
                  <X className="w-2.5 h-2.5" />
                </button>
              </Badge>
            ))}
            <Button variant="ghost" onClick={clearAllFilters} className="ml-auto text-[9px] font-black uppercase tracking-wider h-7 px-2.5 hover:bg-rose-500/10 hover:text-rose-500 rounded-lg">
              Clear All
            </Button>
          </div>
        )}

        {/* --- MAIN CONTENT --- */}
        {viewMode === 'grid' ? (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
            {sortedProperties.map((property, idx) => (
              <div key={property.id} className="h-[400px]">
                <PropertyCard property={property} index={idx} />
              </div>
            ))}
          </div>
        ) : viewMode === 'map' ? (
          <div className="h-[600px] rounded-[40px] overflow-hidden border border-white/5 bg-[#14151a]/40 shadow-3xl">
            <GoogleMapView properties={sortedProperties as any} onPropertyClick={property => navigate(`/property/${property.id}`)} height="600px" showControls={true} provider={provider} apiKey={typeof apiKey === 'string' ? apiKey : (apiKey as any).google || ""} />
          </div>
        ) : (
          /* --- LIST / TABLE VIEW --- */
          <div className="bg-background/40 border border-border/50 rounded-[2rem] overflow-hidden shadow-lg backdrop-blur-xl">
            <CardHeader className="bg-muted/20 border-b border-border/40 p-6">
              <CardTitle className="text-lg font-black text-foreground tracking-tight">{t("client.property.portfolio.table.title")}</CardTitle>
            </CardHeader>
            <CardContent className="p-0">
              <div className="overflow-x-auto">
                <Table>
                  <TableHeader className="bg-muted/10 border-b border-border/40">
                    <TableRow className="hover:bg-transparent border-none">
                      <TableHead className="text-[10px] font-black text-muted-foreground tracking-[0.2em] py-5 px-6 uppercase">{t("client.property.portfolio.table.assetProfile")}</TableHead>
                      <TableHead className="text-[10px] font-black text-muted-foreground tracking-[0.2em] px-6 uppercase">{t("client.property.portfolio.table.performance")}</TableHead>
                      <TableHead className="text-[10px] font-black text-muted-foreground tracking-[0.2em] px-6 uppercase">{t("client.property.portfolio.table.compliance")}</TableHead>
                      <TableHead className="text-[10px] font-black text-muted-foreground tracking-[0.2em] px-6 text-right uppercase">{t("client.property.portfolio.table.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {loading ? (
                      <TableRow>
                        <TableCell colSpan={4} className="py-20 text-center">
                          <Activity className="w-8 h-8 text-primary animate-spin mx-auto mb-4 opacity-60" />
                          <p className="text-[10px] font-black text-muted-foreground tracking-widest uppercase animate-pulse">{t("loading")}</p>
                        </TableCell>
                      </TableRow>
                    ) : sortedProperties.length === 0 ? (
                      <TableRow>
                        <TableCell colSpan={4} className="py-20 text-center">
                          <p className="text-[10px] font-black text-muted-foreground tracking-widest uppercase">{t("empty")}</p>
                        </TableCell>
                      </TableRow>
                    ) : (
                      sortedProperties.map(property => (
                        <TableRow key={property.id} className="border-b border-border/40 hover:bg-muted/20 transition-all group">
                          <TableCell className="py-6 px-6">
                            <div className="flex items-center gap-6">
                              <div className="w-16 h-16 bg-muted/40 border border-border/50 rounded-xl flex items-center justify-center group-hover:scale-105 transition-all overflow-hidden relative shadow-inner">
                                {property.photos?.[0]?.url || property.image ? (
                                   <Image src={property.photos?.[0]?.url || property.image} alt="" fill loading="lazy" className="object-cover" sizes="80px" />
                                ) : (
                                  <Building className="w-8 h-8 text-muted-foreground/60" />
                                )}
                              </div>
                              <div className="space-y-1.5">
                                <h4 className="text-base font-bold text-foreground leading-tight group-hover:text-primary transition-colors">{property.name}</h4>
                                <p className="text-[10px] font-medium text-muted-foreground flex items-center gap-1 leading-none">
                                  <MapPin className="w-3 h-3 text-primary" /> {property.city}
                                </p>
                                <div className="flex gap-2 mt-2 flex-wrap">
                                  <Badge className={cn("text-[8px] font-black tracking-widest px-2 py-0.5 rounded-md border", getStatusColor(property.listingStatus))}>
                                    {property.listingStatus}
                                  </Badge>
                                  {property.agentVideos && property.agentVideos.length > 0 && (
                                    <Badge className="bg-blue-500/10 text-blue-500 border border-blue-500/20 text-[8px] font-black tracking-widest px-2 py-0.5 rounded-md gap-1">
                                      <PlayCircle className="w-3 h-3" /> Video Tour
                                    </Badge>
                                  )}
                                </div>
                              </div>
                            </div>
                          </TableCell>
                          <TableCell className="px-6">
                            <div className="space-y-2 min-w-[200px]">
                              <div className="flex justify-between items-end">
                                <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase leading-none">Price</span>
                                <span className="text-lg font-bold text-foreground tracking-tight leading-none">
                                  ${(parseFloat(String(property.listingPrice || property.price)) || 0).toLocaleString()}
                                </span>
                              </div>
                              <div className="space-y-1">
                                <div className="flex justify-between items-center">
                                  <span className="text-[8px] font-bold text-muted-foreground uppercase tracking-wider">Avg Occupancy</span>
                                  <span className="text-[8px] font-bold text-foreground">{property.occupancyRate}%</span>
                                </div>
                                <div className="h-1 w-full bg-muted/40 rounded-full border border-border/30 overflow-hidden shadow-inner">
                                  <div className="h-full bg-primary" style={{
                                    width: `${property.occupancyRate}%`
                                  }}></div>
                                </div>
                              </div>
                            </div>
                          </TableCell>
                          <TableCell className="px-6">
                            <Badge className={cn("text-[8px] font-black tracking-widest px-2.5 py-0.5 rounded-md border", property.legalComplianceStatus === 'COMPLIANT' ? 'bg-emerald-500/10 text-emerald-500 border-emerald-500/20' : property.legalComplianceStatus === 'PENDING' ? 'bg-orange-500/10 text-orange-500 border-orange-500/20' : 'bg-rose-500/10 text-rose-500 border-rose-500/20')}>
                              {property.legalComplianceStatus || 'PENDING'}
                            </Badge>
                          </TableCell>
                          <TableCell className="px-6 text-right">
                            <DropdownMenu>
                              <DropdownMenuTrigger asChild>
                                <Button variant="ghost" className="h-10 w-10 rounded-xl bg-muted/20 border border-border/30 hover:bg-muted/40 text-muted-foreground hover:text-foreground transition-all">
                                  <MoreHorizontal className="w-5 h-5" />
                                </Button>
                              </DropdownMenuTrigger>
                              <DropdownMenuContent align="end" className="w-48 bg-background border border-border/40 p-1.5 rounded-xl shadow-lg text-foreground">
                                <DropdownMenuLabel className="text-[9px] font-black text-muted-foreground tracking-widest px-3 py-1.5 uppercase">Actions</DropdownMenuLabel>
                                <DropdownMenuSeparator className="bg-border/40 mx-1" />
                                <DropdownMenuItem onClick={() => navigate(`/property/${property.id}`)} className="cursor-pointer rounded-lg h-9 px-3 text-[10px] font-bold tracking-wider gap-3 focus:bg-primary/10 focus:text-primary">
                                  <Activity className="w-3.5 h-3.5" />
                                  View Details
                                </DropdownMenuItem>
                                <DropdownMenuItem className="cursor-pointer rounded-lg h-9 px-3 text-[10px] font-bold tracking-wider gap-3 focus:bg-primary/10 focus:text-primary">
                                  <Edit className="w-3.5 h-3.5" />
                                  Edit Asset
                                </DropdownMenuItem>
                                <DropdownMenuItem className="cursor-pointer rounded-lg h-9 px-3 text-[10px] font-bold tracking-wider gap-3 focus:bg-primary/10 focus:text-primary">
                                  <BarChart3 className="w-3.5 h-3.5" />
                                  Analytics
                                </DropdownMenuItem>
                                <DropdownMenuSeparator className="bg-border/40 mx-1" />
                                <DropdownMenuItem className="cursor-pointer rounded-lg h-9 px-3 text-[10px] font-bold tracking-wider gap-3 focus:bg-rose-500/10 focus:text-rose-500">
                                  <Trash2 className="w-3.5 h-3.5" />
                                  Remove Asset
                                </DropdownMenuItem>
                              </DropdownMenuContent>
                            </DropdownMenu>
                          </TableCell>
                        </TableRow>
                      ))
                    )}
                  </TableBody>
                </Table>
              </div>
            </CardContent>
          </div>
        )}
      </div>
      </PageShell>
    </MapProviderWrapper>
}