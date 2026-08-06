"use client";

import { t } from "i18next";
import { useState, useEffect } from "react";
import { m, AnimatePresence } from "framer-motion";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Progress } from "@/components/ui/progress";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { Search, Filter, Video, Camera, Star, MapPin, Phone, Mail, Globe, Award, Users, MessageSquare, Eye, Clock, ArrowUpRight, ShieldCheck, Zap, Activity, Fingerprint, X } from "lucide-react";
import { useTranslation } from "react-i18next";
import { cn } from "@/lib/utils";
import { PageShell } from "./layout/PageShell";
interface VideoVendor {
  id: string;
  name: string;
  email: string;
  phone: string;
  website: string;
  logoUrl: string;
  description: string;
  address: string;
  serviceAreas: string[];
  specialties: string[];
  tier: string;
  status: string;
  overallRating: number;
  qualityScore: number;
  reliabilityScore: number;
  communicationScore: number;
  pricingScore: number;
  totalReviews: number;
  completedProjects: number;
  averageTurnaroundTime: number;
  pricing: {
    basic: number;
    standard: number;
    premium: number;
    cinematic: number;
  };
  equipment: string[];
  software: string[];
  languages: string[];
  availability: string;
  responseTime: number;
  sampleVideos: string[];
  certifications: string[];
  insurance: boolean;
  insuranceAmount: number;
  createdAt: string;
  updatedAt: string;
}
export default function VideoVendorMarketplace() {
  const {
    t
  } = useTranslation();
  const [vendors, setVendors] = useState<VideoVendor[]>([]);
  const [filteredVendors, setFilteredVendors] = useState<VideoVendor[]>([]);
  const [selectedVendor, setSelectedVendor] = useState<VideoVendor | null>(null);
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedTier, setSelectedTier] = useState("all");
  const [selectedSpecialty, setSelectedSpecialty] = useState("all");
  const [sortBy, setSortBy] = useState("rating");
  const [loading, setLoading] = useState(true);
  useEffect(() => {
    // Mock data
    const mockVendors: VideoVendor[] = [{
      id: "1",
      name: "Premium Video Productions",
      email: "contact@premiumvideo.com",
      phone: "+1-212-555-0101",
      website: "https://premiumvideo.com",
      logoUrl: "",
      description: t("client.src.specializing_in_luxury_real"),
      address: "123 Madison Ave, New York, NY 10016",
      serviceAreas: ["Manhattan", "Brooklyn", "Queens", "Bronx", "Staten Island"],
      specialties: ["Luxury", "Commercial", "Architectural", "Drone"],
      tier: "premium",
      status: "ACTIVE",
      overallRating: 4.9,
      qualityScore: 4.8,
      reliabilityScore: 4.9,
      communicationScore: 4.7,
      pricingScore: 4.2,
      totalReviews: 156,
      completedProjects: 234,
      averageTurnaroundTime: 3,
      pricing: {
        basic: 500,
        standard: 800,
        premium: 1200,
        cinematic: 2000
      },
      equipment: ["4K Camera", "Drone", "Gimbal", "Professional Lighting", "Audio Equipment"],
      software: ["Adobe Premiere Pro", "Final Cut Pro", "DaVinci Resolve", "After Effects"],
      languages: ["English", "Spanish", "Mandarin"],
      availability: "full-time",
      responseTime: 2,
      sampleVideos: ["https://example.com/video1", "https://example.com/video2"],
      certifications: ["FAA Drone Certified", "Professional Videographer Certificate"],
      insurance: true,
      insuranceAmount: 2000000,
      createdAt: "2022-01-15",
      updatedAt: "2024-03-01"
    }, {
      id: "2",
      name: "NYC Video Pros",
      email: "info@nycvideopros.com",
      phone: "+1-718-555-0202",
      website: "https://nycvideopros.com",
      logoUrl: "",
      description: t("client.src.affordable_highquality_real_estate"),
      address: "456 Queens Blvd, Queens, NY 11375",
      serviceAreas: ["Queens", "Brooklyn", "Manhattan"],
      specialties: ["Residential", "Condos", "Apartments", "Virtual Tours"],
      tier: "professional",
      status: "ACTIVE",
      overallRating: 4.6,
      qualityScore: 4.5,
      reliabilityScore: 4.7,
      communicationScore: 4.8,
      pricingScore: 4.9,
      totalReviews: 89,
      completedProjects: 145,
      averageTurnaroundTime: 2,
      pricing: {
        basic: 300,
        standard: 500,
        premium: 750,
        cinematic: 1200
      },
      equipment: ["4K Camera", "Gimbal", "Lighting", "Audio Equipment"],
      software: ["Adobe Premiere Pro", "Final Cut Pro"],
      languages: ["English", "Spanish"],
      availability: "full-time",
      responseTime: 1,
      sampleVideos: ["https://example.com/video3", "https://example.com/video4"],
      certifications: ["Professional Videographer Certificate"],
      insurance: true,
      insuranceAmount: 1000000,
      createdAt: "2022-06-20",
      updatedAt: "2024-02-15"
    }];
    setVendors(mockVendors);
    setFilteredVendors(mockVendors);
    setLoading(false);
  }, []);
  useEffect(() => {
    let filtered = vendors;
    if (searchTerm) {
      filtered = filtered.filter(vendor => vendor.name.toLowerCase().includes(searchTerm.toLowerCase()) || vendor.description.toLowerCase().includes(searchTerm.toLowerCase()) || vendor.specialties.some(s => s.toLowerCase().includes(searchTerm.toLowerCase())));
    }
    if (selectedTier !== "all") {
      filtered = filtered.filter(vendor => vendor.tier === selectedTier);
    }
    if (selectedSpecialty !== "all") {
      filtered = filtered.filter(vendor => vendor.specialties.some(s => s.toLowerCase().includes(selectedSpecialty.toLowerCase())));
    }
    filtered = [...filtered].sort((a, b) => {
      switch (sortBy) {
        case "rating":
          return b.overallRating - a.overallRating;
        case "price":
          return a.pricing.basic - b.pricing.basic;
        case "projects":
          return b.completedProjects - a.completedProjects;
        case "turnaround":
          return a.averageTurnaroundTime - b.averageTurnaroundTime;
        default:
          return 0;
      }
    });
    setFilteredVendors(filtered);
  }, [vendors, searchTerm, selectedTier, selectedSpecialty, sortBy]);
  const getTierColor = (tier: string) => {
    switch (tier) {
      case "premium":
        return "bg-brand/10 text-brand border-brand/20 shadow-[0_0_15px_rgba(168,85,247,0.1)]";
      case "professional":
        return "bg-brand/100/10 text-brand border-blue-500/20";
      case "basic":
        return "bg-muted text-muted-foreground border-white/5";
      default:
        return "bg-success/10 text-success border-success/20";
    }
  };
  const getTierIcon = (tier: string) => {
    switch (tier) {
      case "premium":
        return Award;
      case "professional":
        return Star;
      case "basic":
        return Camera;
      default:
        return Video;
    }
  };
  return <PageShell title={t("videoMarketTitle")} description={t("videoMarketSubtitle")} actions={<Button className="h-12 px-6 rounded-xl bg-card text-black hover:bg-muted font-black italic text-[10px] tracking-widest shadow-xl transition-all">
          <Users className="w-4 h-4 mr-2" />
          {t("partnerships")}
        </Button>}>
      <div className="space-y-12">
        {/* Filters Matrix */}
        <Card className="bg-card/40 border-white/5 border-l border-t rounded-[40px] p-8 backdrop-blur-3xl shadow-3xl">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
            <div className="relative group">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground transition-colors group-focus-within:text-brand" />
              <Input placeholder={t("videoMarketSearch")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="bg-black/40 border-white/5 rounded-2xl h-14 pl-12 text-[10px] font-black italic tracking-widest text-white placeholder:text-muted-foreground focus:border-blue-500/50 transition-all font-mono" />
            </div>
            
            <Select value={selectedTier} onValueChange={setSelectedTier}>
              <SelectTrigger className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic tracking-widest text-white">
                <SelectValue placeholder={t("tier")} />
              </SelectTrigger>
              <SelectContent className="bg-card border-white/10 rounded-2xl">
                {Object.entries(t("tiers", {
                returnObjects: true
              }) as any).map(([key, value]) => <SelectItem key={key} value={key} className="text-[10px] font-black italic tracking-widest">{value as string}</SelectItem>)}
              </SelectContent>
            </Select>

            <Select value={selectedSpecialty} onValueChange={setSelectedSpecialty}>
              <SelectTrigger className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic tracking-widest text-white">
                <SelectValue placeholder={t("specialty")} />
              </SelectTrigger>
              <SelectContent className="bg-card border-white/10 rounded-2xl">
                {Object.entries(t("client.videoMarket.filters.specialties", {
                returnObjects: true
              }) as any).map(([key, value]) => <SelectItem key={key} value={key} className="text-[10px] font-black italic tracking-widest">{value as string}</SelectItem>)}
              </SelectContent>
            </Select>

            <Select value={sortBy} onValueChange={setSortBy}>
              <SelectTrigger className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic tracking-widest text-white">
                <SelectValue placeholder={t("videoMarketSortby")} />
              </SelectTrigger>
              <SelectContent className="bg-card border-white/10 rounded-2xl">
                {Object.entries(t("client.videoMarket.filters.sort", {
                returnObjects: true
              }) as any).map(([key, value]) => <SelectItem key={key} value={key} className="text-[10px] font-black italic tracking-widest">{value as string}</SelectItem>)}
              </SelectContent>
            </Select>
          </div>
        </Card>

        {/* Vendor Grid Matrix */}
        <div className="grid grid-cols-1 lg:grid-cols-2 xl:grid-cols-3 gap-8">
          {filteredVendors.map((vendor, index) => {
          const TierIcon = getTierIcon(vendor.tier);
          return <m.div key={vendor.id} initial={{
            opacity: 0,
            y: 20
          }} animate={{
            opacity: 1,
            y: 0
          }} transition={{
            delay: index * 0.1
          }}>
                <Card className="bg-card/40 border-white/5 border-l border-t rounded-[40px] overflow-hidden group hover:bg-white/5 transition-all shadow-2xl relative">
                  <div className="absolute top-0 left-0 w-full h-full opacity-[0.03] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[40px_40px]"></div>
                  <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-brand/50 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity"></div>
                  
                  <div className="p-10 space-y-8">
                    <div className="flex items-start justify-between">
                      <div className="flex items-center gap-6">
                        <div className="relative group/avatar">
                          <div className="absolute inset-0 bg-blue-600/20 blur-xl group-hover/avatar:bg-blue-600/40 transition-all rounded-full animate-pulse-slow"></div>
                          <Avatar className="h-20 w-20 rounded-[24px] border-2 border-white/10 relative z-10">
                            <AvatarImage src={vendor.logoUrl} />
                            <AvatarFallback className="bg-black/40 text-brand font-black italic">
                              <Video className="w-8 h-8" />
                            </AvatarFallback>
                          </Avatar>
                        </div>
                        <div className="space-y-1">
                          <h3 className="text-2xl font-black text-white italic tracking-tighter leading-none group-hover:text-brand transition-colors">
                            {vendor.name}
                          </h3>
                          <Badge className={cn("px-3 py-1 rounded-full text-[8px] font-black  tracking-widest italic border", getTierColor(vendor.tier))}>
                            <TierIcon className="w-3 h-3 mr-1.5" />
                            {vendor.tier}
                          </Badge>
                        </div>
                      </div>
                    </div>

                    <p className="text-[11px] font-bold text-muted-foreground italic leading-loose line-clamp-2 min-h-[44px]">
                      {vendor.description}
                    </p>

                    <div className="grid grid-cols-2 gap-4">
                      <div className="p-4 rounded-2xl bg-black/40 border border-white/5">
                        <div className="flex items-center gap-2 mb-2">
                           <Star className="w-3 h-3 text-yellow-500 fill-yellow-500" />
                           <span className="text-xl font-black text-white italic leading-none font-mono">{vendor.overallRating}</span>
                        </div>
                        <p className="text-[8px] font-black text-muted-foreground tracking-widest italic">{vendor.totalReviews} {t("reviews")}</p>
                      </div>
                      <div className="p-4 rounded-2xl bg-black/40 border border-white/5">
                        <div className="flex items-center gap-2 mb-2">
                           <Clock className="w-3 h-3 text-brand" />
                           <span className="text-xl font-black text-white italic leading-none font-mono">{vendor.averageTurnaroundTime}D</span>
                        </div>
                        <p className="text-[8px] font-black text-muted-foreground tracking-widest italic">{t("videoMarketTurnaround")}</p>
                      </div>
                    </div>

                    <div className="space-y-4">
                       <div className="flex justify-between items-center text-[9px] font-black italic tracking-widest">
                          <span className="text-muted-foreground">{t("quality")}</span>
                          <span className="text-white">{vendor.qualityScore}/5</span>
                       </div>
                       <div className="h-1.5 w-full bg-black/40 rounded-full overflow-hidden shadow-inner">
                          <m.div initial={{
                      width: 0
                    }} animate={{
                      width: `${vendor.qualityScore * 20}%`
                    }} className="h-full bg-blue-600 shadow-[0_0_10px_#2563eb]" />
                       </div>
                    </div>

                    <div className="pt-6 border-t border-white/5 flex items-center justify-between">
                       <div>
                          <p className="text-[8px] font-black text-muted-foreground tracking-widest italic mb-1">{t("startingAt")}</p>
                          <p className="text-3xl font-black text-white italic tracking-tighter leading-none font-mono">${vendor.pricing.basic}</p>
                       </div>
                       <div className="flex gap-2">
                          <Button variant="outline" size="icon" aria-label={t("common.view")} onClick={() => setSelectedVendor(vendor)} className="h-12 w-12 rounded-xl border-white/5 bg-white/5 text-muted-foreground hover:text-white transition-all shadow-xl">
                             <Eye className="w-5 h-5" />
                          </Button>
                          <Button className="h-12 px-6 rounded-xl bg-blue-600 hover:bg-brand/100 text-white font-black text-[9px] tracking-widest italic shadow-xl shadow-blue-600/20 group/btn">
                             {t("partner")} <ArrowUpRight className="ml-2 w-3 h-3 group-hover:translate-x-0.5 group-hover:-translate-y-0.5 transition-transform" />
                          </Button>
                       </div>
                    </div>
                  </div>
                </Card>
              </m.div>;
        })}
        </div>
      </div>

      {/* Detail HUD Overlay */}
      <AnimatePresence>
        {selectedVendor && <div className="fixed inset-0 bg-black/90 backdrop-blur-xl flex items-center justify-center p-8 z-50">
             <m.div initial={{
          opacity: 0,
          scale: 0.95
        }} animate={{
          opacity: 1,
          scale: 1
        }} exit={{
          opacity: 0,
          scale: 0.95
        }} className="w-full max-w-5xl bg-card border border-white/10 rounded-[60px] overflow-hidden shadow-3xl max-h-[90vh] overflow-y-auto custom-scrollbar">
                <div className="p-16 space-y-16">
                   <header className="flex items-start justify-between">
                      <div className="flex items-center gap-10">
                         <Avatar className="h-32 w-32 rounded-[32px] border-4 border-white/10 shadow-2xl">
                            <AvatarImage src={selectedVendor.logoUrl} />
                            <AvatarFallback className="bg-black/40 text-brand text-4xl font-black italic">
                               <Video className="w-16 h-16" />
                            </AvatarFallback>
                         </Avatar>
                         <div className="space-y-4">
                            <div className="flex items-center gap-4">
                               <h2 className="text-6xl font-black text-white italic tracking-tighter leading-none">{selectedVendor.name}</h2>
                               <Badge className={cn("px-4 py-1.5 rounded-full text-[10px] font-black  tracking-widest italic border", getTierColor(selectedVendor.tier))}>
                                  {selectedVendor.tier}{t("client.src.level")}</Badge>
                            </div>
                            <p className="text-xl font-bold text-muted-foreground italic tracking-tight max-w-2xl">{selectedVendor.description}</p>
                         </div>
                      </div>
                      <Button variant="ghost" onClick={() => setSelectedVendor(null)} className="h-20 w-20 rounded-[32px] bg-white/5 hover:bg-white/10 transition-all" aria-label={t("common.close")}>
                         <X className="w-10 h-10 text-white" />
                      </Button>
                   </header>

                   <div className="grid grid-cols-3 gap-10 py-16 border-y border-white/5">
                      <div className="space-y-10">
                         <h4 className="text-[10px] font-black text-muted-foreground tracking-[0.3em] italic">{t("contactInfo")}</h4>
                         <div className="space-y-8">
                            {[{
                    icon: MapPin,
                    value: selectedVendor.address,
                    color: "text-brand"
                  }, {
                    icon: Phone,
                    value: selectedVendor.phone,
                    color: "text-success"
                  }, {
                    icon: Mail,
                    value: selectedVendor.email,
                    color: "text-brand"
                  }, {
                    icon: Globe,
                    value: selectedVendor.website,
                    color: "text-orange-400"
                  }].map((item, i) => <div key={i} className="flex gap-6 items-center">
                                 <div className="h-14 w-14 rounded-2xl bg-black/40 border border-white/5 flex items-center justify-center">
                                    <item.icon className={cn("w-6 h-6", item.color)} />
                                 </div>
                                 <p className="text-sm font-black text-white italic tracking-tight">{item.value}</p>
                              </div>)}
                         </div>
                      </div>

                      <div className="space-y-10 border-x border-white/5 px-10">
                         <h4 className="text-[10px] font-black text-muted-foreground tracking-[0.3em] italic">{t("videoMarketPerformance")}</h4>
                         <div className="grid grid-cols-2 gap-6">
                            {[{
                    label: t("videoMarketProjects"),
                    value: selectedVendor.completedProjects,
                    icon: Zap,
                    color: "text-brand"
                  }, {
                    label: t("reviewsCount"),
                    value: selectedVendor.totalReviews,
                    icon: Star,
                    color: "text-yellow-400"
                  }, {
                    label: t("videoMarketTurnaround"),
                    value: `${selectedVendor.averageTurnaroundTime}D`,
                    icon: Clock,
                    color: "text-success"
                  }, {
                    label: t("response"),
                    value: `${selectedVendor.responseTime}H`,
                    icon: Activity,
                    color: "text-red-400"
                  }].map((stat, i) => <div key={i} className="p-6 rounded-3xl bg-black/40 border border-white/5 flex flex-col items-center gap-3">
                                 <stat.icon className={cn("w-5 h-5", stat.color)} />
                                 <p className="text-2xl font-black text-white italic font-mono">{stat.value}</p>
                                 <p className="text-[8px] font-black text-muted-foreground tracking-widest italic">{stat.label}</p>
                              </div>)}
                         </div>
                      </div>

                      <div className="space-y-10">
                        <h4 className="text-[10px] font-black text-muted-foreground tracking-[0.3em] italic">{t("pricingPackages")}</h4>
                        <div className="space-y-4">
                           {Object.entries(selectedVendor.pricing).map(([name, price]) => <div key={name} className="p-6 rounded-3xl bg-black/40 border border-white/5 flex items-center justify-between group hover:bg-white/5 transition-all">
                                <span className="text-sm font-black text-muted-foreground italic tracking-widest">{name}</span>
                                <span className="text-2xl font-black text-white italic tracking-tighter font-mono">${price}</span>
                             </div>)}
                        </div>
                      </div>
                   </div>

                   <div className="space-y-10">
                      <h4 className="text-[10px] font-black text-muted-foreground tracking-[0.3em] italic">{t("equipmentSoftware")}</h4>
                      <div className="flex flex-wrap gap-4">
                         {[...selectedVendor.equipment, ...selectedVendor.software].map((item, i) => <Badge key={i} className="bg-white/5 border border-white/10 text-white text-[10px] font-black px-6 py-3 rounded-2xl italic">
                              {item}
                           </Badge>)}
                      </div>
                   </div>

                   <div className="flex gap-6 pt-10">
                      <Button className="flex-1 h-24 rounded-[32px] bg-blue-600 hover:bg-brand/100 text-white font-black italic tracking-widest text-lg shadow-2xl shadow-blue-600/30 gap-4">
                         <Fingerprint className="w-8 h-8" /> {t("requestPartnership")}
                      </Button>
                      <Button variant="outline" className="h-24 px-12 rounded-[32px] border-white/10 bg-white/5 text-white hover:bg-white/10 font-black italic tracking-widest text-sm transition-all gap-4">
                         <MessageSquare className="w-6 h-6" /> {t("sendMessage")}
                      </Button>
                   </div>
                </div>
             </m.div>
          </div>}
      </AnimatePresence>
    </PageShell>;
}