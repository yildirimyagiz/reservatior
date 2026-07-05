"use client";

import { t } from "i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Building, MapPin, Users, DollarSign, Calendar, TrendingUp, Search, MoreHorizontal, Activity, Zap, Edit, Clock, BarChart3, Map, Grid, PlayCircle, Trash2, ShieldCheck, List } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { useQuery } from "@tanstack/react-query";
import { propertiesApi } from "@/lib/api/properties";
import { motion } from "framer-motion";
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
  const [block, setBlock] = useState("ALL");
  const [floor, setFloor] = useState("ALL");
  const [bedrooms, setBedrooms] = useState("ALL");
  const [viewMode, setViewMode] = useState<'grid' | 'list' | 'map'>('grid');
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

  const blocks = Array.from(new Set(properties.map(p => {
    const match = p.addressLine1?.match(/^([A-Z]) Blok/);
    return match ? match[1] : null;
  }).filter(Boolean))).sort();

  const floors = Array.from(new Set(properties.map(p => (p as any).kat?.toString() || (p as any).floor?.toString()).filter(Boolean))).sort((a, b) => parseInt(a as string) - parseInt(b as string));

  const bedroomCounts = Array.from(new Set(properties.map(p => p.bedrooms?.toString()).filter(Boolean))).sort();

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
    const matchesBlock = block === "ALL" || property.addressLine1?.startsWith(`${block} Blok`);
    const propertyFloor = (property as any).kat?.toString() || (property as any).floor?.toString();
    const matchesFloor = floor === "ALL" || propertyFloor === floor;
    const matchesBedrooms = bedrooms === "ALL" || property.bedrooms?.toString() === bedrooms;
    return matchesSearch && matchesListing && matchesType && matchesStatus && matchesBlock && matchesFloor && matchesBedrooms;
  });
  return <MapProviderWrapper>
      <PageShell title={t("client.property.portfolio.title")} description={t("client.property.portfolio.desc")} createLabel={t("client.property.portfolio.add")} onCreateClick={() => navigate("/admin/properties")} searchValue={searchTerm} onSearchChange={setSearchTerm} searchPlaceholder={t("client.property.portfolio.search")} actions={<div className="flex flex-wrap items-center gap-2">
            <Select value={listingType} onValueChange={setListingType}>
              <SelectTrigger className="w-[140px] h-10 bg-white/5 border-white/5 text-slate-400 font-black text-[10px] tracking-widest italic rounded-xl hover:text-white transition-all">
                <SelectValue placeholder={t("client.property.portfolio.filters.listing.placeholder")} />
              </SelectTrigger>
              <SelectContent className="bg-[#1a1b1e]/95 border-white/10 text-white font-black text-[10px] tracking-widest italic backdrop-blur-3xl rounded-xl">
                <SelectItem value="ALL">{t("client.property.portfolio.filters.listing.all")}</SelectItem>
                <SelectItem value="FOR_SALE">{t("client.property.portfolio.filters.listing.forSale")}</SelectItem>
                <SelectItem value="FOR_RENT">{t("client.property.portfolio.filters.listing.forRent")}</SelectItem>
              </SelectContent>
            </Select>

            <Select value={propertyType} onValueChange={setPropertyType}>
              <SelectTrigger className="w-[140px] h-10 bg-white/5 border-white/5 text-slate-400 font-black text-[10px] tracking-widest italic rounded-xl hover:text-white transition-all">
                <SelectValue placeholder={t("client.property.portfolio.filters.type.placeholder")} />
              </SelectTrigger>
              <SelectContent className="bg-[#1a1b1e]/95 border-white/10 text-white font-black text-[10px] tracking-widest italic backdrop-blur-3xl rounded-xl max-h-[400px]">
                <SelectItem value="ALL">{t("client.property.portfolio.filters.type.all")}</SelectItem>
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
                  <SelectItem value="COMMERCIAL">{t("client.property.types.COMMERCIAL")}</SelectItem>
                </SelectGroup>
              </SelectContent>
            </Select>

            <Select value={status} onValueChange={setStatus}>
              <SelectTrigger className="w-[140px] h-10 bg-white/5 border-white/5 text-slate-400 font-black text-[10px] tracking-widest italic rounded-xl hover:text-white transition-all">
                <SelectValue placeholder={t("client.property.portfolio.filters.status.placeholder")} />
              </SelectTrigger>
              <SelectContent className="bg-[#1a1b1e]/95 border-white/10 text-white font-black text-[10px] tracking-widest italic backdrop-blur-3xl rounded-xl">
                <SelectItem value="ALL">{t("client.property.portfolio.filters.status.all")}</SelectItem>
                <SelectItem value="AVAILABLE">{t("client.property.portfolio.filters.status.available")}</SelectItem>
                <SelectItem value="PENDING">{t("client.property.portfolio.filters.status.pending")}</SelectItem>
                <SelectItem value="SOLD">{t("client.property.portfolio.filters.status.sold")}</SelectItem>
                <SelectItem value="RENTED">{t("client.property.portfolio.filters.status.rented")}</SelectItem>
              </SelectContent>
            </Select>

            <Select value={block} onValueChange={setBlock}>
              <SelectTrigger className="w-[100px] h-10 bg-white/5 border-white/5 text-slate-400 font-black text-[10px] tracking-widest italic rounded-xl hover:text-white transition-all">
                <SelectValue placeholder={t("client.property.portfolio.filters.block.placeholder", "Block")} />
              </SelectTrigger>
              <SelectContent className="bg-[#1a1b1e]/95 border-white/10 text-white font-black text-[10px] tracking-widest italic backdrop-blur-3xl rounded-xl">
                <SelectItem value="ALL">{t("client.property.portfolio.filters.block.all", "All Blocks")}</SelectItem>
                {blocks.map(b => (
                  <SelectItem key={b} value={b as string}>{b} {t("client.property.portfolio.filters.block.label", "Block")}</SelectItem>
                ))}
              </SelectContent>
            </Select>

            <Select value={floor} onValueChange={setFloor}>
              <SelectTrigger className="w-[100px] h-10 bg-white/5 border-white/5 text-slate-400 font-black text-[10px] tracking-widest italic rounded-xl hover:text-white transition-all">
                <SelectValue placeholder={t("client.property.portfolio.filters.floor.placeholder", "Floor")} />
              </SelectTrigger>
              <SelectContent className="bg-[#1a1b1e]/95 border-white/10 text-white font-black text-[10px] tracking-widest italic backdrop-blur-3xl rounded-xl max-h-[300px]">
                <SelectItem value="ALL">{t("client.property.portfolio.filters.floor.all", "All Floors")}</SelectItem>
                {floors.map(f => (
                  <SelectItem key={f} value={f as string}>{f}. {t("client.property.portfolio.filters.floor.label", "Floor")}</SelectItem>
                ))}
              </SelectContent>
            </Select>

            <Select value={bedrooms} onValueChange={setBedrooms}>
              <SelectTrigger className="w-[120px] h-10 bg-white/5 border-white/5 text-slate-400 font-black text-[10px] tracking-widest italic rounded-xl hover:text-white transition-all">
                <SelectValue placeholder={t("client.property.portfolio.filters.bedrooms.placeholder", "Bedrooms")} />
              </SelectTrigger>
              <SelectContent className="bg-[#1a1b1e]/95 border-white/10 text-white font-black text-[10px] tracking-widest italic backdrop-blur-3xl rounded-xl">
                <SelectItem value="ALL">{t("client.property.portfolio.filters.bedrooms.all", "All Bed")}</SelectItem>
                {bedroomCounts.map(b => (
                  <SelectItem key={b} value={b as string}>{b}+1 {t("client.property.portfolio.filters.bedrooms.label", "Room")}</SelectItem>
                ))}
              </SelectContent>
            </Select>

            <Select value={promotionType} onValueChange={setPromotionType}>
              <SelectTrigger className="w-[180px] h-10 bg-white/5 border-white/5 text-slate-400 font-black text-[10px] tracking-widest italic rounded-xl hover:text-white transition-all">
                <SelectValue placeholder={t("client.src.promotion.title")} />
              </SelectTrigger>
              <SelectContent className="bg-[#1a1b1e]/95 border-white/10 text-white font-black text-[10px] tracking-widest italic backdrop-blur-3xl rounded-xl">
                <SelectItem value="ALL">{t("client.src.promotion.all")}</SelectItem>
                <SelectItem value="FEATURED">{t("client.src.promotion.featured")}</SelectItem>
                <SelectItem value="URGENT">{t("client.src.promotion.urgent")}</SelectItem>
                <SelectItem value="PRICE_REDUCED">{t("client.src.promotion.price_reduced")}</SelectItem>
                <SelectItem value="BEST_DEAL">{t("client.src.promotion.best_deal")}</SelectItem>
              </SelectContent>
            </Select>
            <Button variant={viewMode === 'grid' ? 'default' : 'outline'} onClick={() => setViewMode('grid')} className="h-10 rounded-xl font-black italic text-[10px] tracking-widest">
              <Grid className="w-4 h-4 mr-2" />
              {t("client.property.portfolio.views.grid")}
            </Button>
            <Button variant={viewMode === 'list' ? 'default' : 'outline'} onClick={() => setViewMode('list')} className="h-10 rounded-xl font-black italic text-[10px] tracking-widest">
              <List className="w-4 h-4 mr-2" />
              {t("client.property.portfolio.views.list", "List")}
            </Button>
            <Button variant={viewMode === 'map' ? 'default' : 'outline'} onClick={() => setViewMode('map')} className="h-10 rounded-xl font-black italic text-[10px] tracking-widest">
              <Map className="w-4 h-4 mr-2" />
              {t("client.property.portfolio.views.map")}
            </Button>
          </div>}>
      <div className="space-y-10 pb-20 p-6">
        

        {/* --- MAIN CONTENT --- */}
        {viewMode === 'grid' ? (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
            {filteredProperties.map((property, idx) => (
              <div key={property.id} className="h-[400px]">
                <PropertyCard property={property} index={idx} />
              </div>
            ))}
          </div>
        ) : viewMode === 'map' ? (
          <div className="h-[600px] rounded-[40px] overflow-hidden border border-white/5 bg-[#14151a]/40 shadow-3xl">
            <GoogleMapView properties={filteredProperties as any} onPropertyClick={property => navigate(`/property/${property.id}`)} height="600px" showControls={true} provider={provider} apiKey={typeof apiKey === 'string' ? apiKey : (apiKey as any).google || ""} />
          </div>
        ) : (
          /* --- LIST / TABLE VIEW --- */
          <div className="bg-[#1a1b1e]/40 border border-white/5 border-l border-t rounded-[40px] overflow-hidden shadow-3xl backdrop-blur-3xl">
            <CardHeader className="bg-white/5 border-b border-white/5 p-8">
              <CardTitle className="text-xl font-black text-white italic tracking-tighter">{t("client.property.portfolio.table.title")}</CardTitle>
            </CardHeader>
            <CardContent className="p-0">
              <div className="overflow-x-auto">
                <Table>
                  <TableHeader className="bg-white/2 border-b border-white/5">
                    <TableRow className="hover:bg-transparent border-none">
                      <TableHead className="text-[10px] font-black text-slate-500 tracking-[0.2em] py-8 px-10 italic">{t("client.property.portfolio.table.assetProfile")}</TableHead>
                      <TableHead className="text-[10px] font-black text-slate-500 tracking-[0.2em] px-10 italic">{t("client.property.portfolio.table.performance")}</TableHead>
                      <TableHead className="text-[10px] font-black text-slate-500 tracking-[0.2em] px-10 italic">{t("client.property.portfolio.table.compliance")}</TableHead>
                      <TableHead className="text-[10px] font-black text-slate-500 tracking-[0.2em] px-10 text-right italic">{t("client.property.portfolio.table.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {loading ? (
                      <TableRow>
                        <TableCell colSpan={4} className="py-32 text-center">
                          <Activity className="w-10 h-10 text-blue-500 animate-spin mx-auto mb-6 opacity-40" />
                          <p className="text-[10px] font-black text-slate-500 tracking-widest italic animate-pulse">{t("loading")}</p>
                        </TableCell>
                      </TableRow>
                    ) : filteredProperties.length === 0 ? (
                      <TableRow>
                        <TableCell colSpan={4} className="py-32 text-center">
                          <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("empty")}</p>
                        </TableCell>
                      </TableRow>
                    ) : (
                      filteredProperties.map(property => (
                        <TableRow key={property.id} className="border-b border-white/5 hover:bg-white/2 transition-all group">
                          <TableCell className="py-10 px-10">
                            <div className="flex items-center gap-8">
                              <div className="w-20 h-20 bg-black/40 border border-white/5 rounded-2xl flex items-center justify-center group-hover:scale-105 transition-all overflow-hidden relative shadow-inner">
                                <Building className="w-10 h-10 text-slate-800" />
                              </div>
                              <div className="space-y-3">
                                <h4 className="text-xl font-black text-white italic tracking-tighter leading-tight group-hover:text-blue-400 transition-colors">{property.name}</h4>
                                <p className="text-[10px] font-black text-slate-500 tracking-widest flex items-center gap-2 leading-none italic">
                                  <MapPin className="w-3.5 h-3.5 text-blue-500" /> {property.city}
                                </p>
                                <div className="flex gap-3 mt-4 flex-wrap">
                                  <Badge className={cn("text-[8px] font-black tracking-widest px-3 py-1 rounded-full border", getStatusColor(property.listingStatus))}>
                                    {property.listingStatus}
                                  </Badge>
                                  {property.agentVideos && property.agentVideos.length > 0 && (
                                    <Badge className="bg-blue-600/10 text-blue-400 border border-blue-500/20 text-[8px] font-black tracking-widest px-3 py-1 rounded-full gap-2 shadow-xl">
                                      <PlayCircle className="w-3.5 h-3.5" /> {t("client.property.portfolio.labels.videoTour")}
                                    </Badge>
                                  )}
                                  {!property.ownershipVerified && (
                                    <Badge className="bg-orange-600/10 text-orange-400 border border-orange-500/20 text-[8px] font-black tracking-widest px-3 py-1 rounded-full gap-2 shadow-xl">
                                      <ShieldCheck className="w-3.5 h-3.5" /> Sahipsiz
                                    </Badge>
                                  )}
                                </div>
                              </div>
                            </div>
                          </TableCell>
                          <TableCell className="px-10">
                            <div className="space-y-4 min-w-[240px]">
                              <div className="flex justify-between items-end">
                                <span className="text-[10px] font-black text-slate-500 tracking-widest italic leading-none">{t("yieldDna")}</span>
                                <span className="text-3xl font-black text-white italic tracking-tighter leading-none">
                                  ${(parseFloat(String(property.listingPrice)) || 0).toLocaleString()}
                                </span>
                              </div>
                              <div className="space-y-2">
                                <div className="flex justify-between items-center">
                                  <span className="text-[9px] font-black text-slate-500 tracking-widest italic">{t("client.property.portfolio.stats.avgOccupancy")}</span>
                                  <span className="text-[9px] font-black text-white tracking-widest">{property.occupancyRate}%</span>
                                </div>
                                <div className="h-1.5 w-full bg-black/40 rounded-full border border-white/5 overflow-hidden shadow-inner">
                                  <div className="h-full bg-blue-600 shadow-[0_0_10px_#2563eb]" style={{
                                    width: `${property.occupancyRate}%`
                                  }}></div>
                                </div>
                              </div>
                            </div>
                          </TableCell>
                          <TableCell className="px-10">
                            <Badge className={cn("text-[8px] font-black tracking-widest px-3 py-1 rounded-full border", property.legalComplianceStatus === 'COMPLIANT' ? 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20' : property.legalComplianceStatus === 'PENDING' ? 'bg-orange-500/10 text-orange-400 border-orange-500/20' : 'bg-red-500/10 text-red-400 border-red-500/20')}>
                              {property.legalComplianceStatus || 'PENDING'}
                            </Badge>
                          </TableCell>
                          <TableCell className="px-10 text-right">
                            <DropdownMenu>
                              <DropdownMenuTrigger asChild>
                                <Button variant="ghost" className="h-14 w-14 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 hover:text-white transition-all shadow-xl">
                                  <MoreHorizontal className="w-6 h-6" />
                                </Button>
                              </DropdownMenuTrigger>
                              <DropdownMenuContent align="end" className="w-56 bg-[#1a1b1e] border border-white/10 p-2 rounded-2xl shadow-3xl text-white backdrop-blur-3xl">
                                <DropdownMenuLabel className="text-[10px] font-black text-slate-500 tracking-widest p-4 pb-2 italic">{t("assetActions")}</DropdownMenuLabel>
                                <DropdownMenuSeparator className="bg-white/5 mx-2" />
                                <DropdownMenuItem onClick={() => navigate(`/property/${property.id}`)} className="focus:bg-white/5 focus:text-blue-400 cursor-pointer rounded-xl h-12 px-4 text-[10px] font-black italic tracking-widest gap-4">
                                  <Activity className="w-4 h-4" />
                                  {t("viewDetails")}
                                </DropdownMenuItem>
                                <DropdownMenuItem className="focus:bg-white/5 focus:text-emerald-400 cursor-pointer rounded-xl h-12 px-4 text-[10px] font-black italic tracking-widest gap-4">
                                  <Edit className="w-4 h-4" />
                                  {t("editAsset")}
                                </DropdownMenuItem>
                                <DropdownMenuItem className="focus:bg-white/5 focus:text-purple-400 cursor-pointer rounded-xl h-12 px-4 text-[10px] font-black italic tracking-widest gap-4">
                                  <BarChart3 className="w-4 h-4" />
                                  {t("client.property.portfolio.table.analytics")}
                                </DropdownMenuItem>
                                <DropdownMenuSeparator className="bg-white/5 mx-2" />
                                <DropdownMenuItem className="focus:bg-red-500/10 focus:text-red-500 cursor-pointer rounded-xl h-12 px-4 text-[10px] font-black italic tracking-widest gap-4">
                                  <Trash2 className="w-4 h-4" />
                                  {t("removeAsset")}
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