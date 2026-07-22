"use client";

import Image from "next/image";
import { useState, useEffect } from "react";
import {
  Clock,
  CheckCircle2,
  Search,
  Plus,
  Eye,
  TrendingUp,
  MapPin,
  MoreVertical,
  Edit3,
  Trash2,
  ArrowLeft,
  Zap,
  Activity,
  Fingerprint
} from "lucide-react";
import { Card, CardContent, CardFooter } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { propertiesApi } from "@/lib/api/properties";
import { Link, useNavigate } from "@/lib/react-router-shim";
import { useTranslation } from "react-i18next";
import { m, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";

export default function MyListings() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const [listings, setListings] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState("");

  useEffect(() => {
    loadListings();
  }, []);

  const loadListings = async () => {
    try {
      setLoading(true);
      const data = await propertiesApi.searchProperties("");
      setListings(data || []);
    } catch (error) {
      console.error("Failed to load listings:", error);
      setListings([]);
    } finally {
      setLoading(false);
    }
  };

  const getStatusBadge = (status: string) => {
    switch (status?.toUpperCase()) {
      case "ACTIVE":
        return <Badge className="bg-emerald-500/10 text-emerald-400 border-emerald-500/20 text-[8px] font-black italic tracking-widest px-3 py-1 rounded-full">{t('active')}</Badge>;
      case "PENDING":
        return <Badge className="bg-amber-500/10 text-amber-400 border-amber-500/20 text-[8px] font-black italic tracking-widest px-3 py-1 rounded-full">{t('myListingsStatusPending')}</Badge>;
      case "SOLD":
        return <Badge className="bg-slate-500/10 text-slate-400 border-slate-500/20 text-[8px] font-black italic tracking-widest px-3 py-1 rounded-full">{t('myListingsStatusSold')}</Badge>;
      default:
        return <Badge className="bg-white/5 text-slate-500 border-white/5 text-[8px] font-black italic tracking-widest px-3 py-1 rounded-full">{t('draft')}</Badge>;
    }
  };

  const filteredListings = listings.filter(l => 
    l.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
    l.address?.toLowerCase().includes(searchQuery.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-[#14151a] p-8 relative overflow-hidden">
      {/* Background Cybernetic Elements */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-0 right-0 w-[800px] h-[800px] bg-blue-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute bottom-0 left-0 w-[600px] h-[600px] bg-purple-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute top-0 left-0 w-full h-full opacity-[0.03] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[40px_40px]"></div>
      </div>

      <div className="max-w-7xl mx-auto space-y-12 relative z-10">
        {/* Header HUD */}
        <m.div 
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex flex-col md:flex-row md:items-center justify-between gap-8"
        >
          <div className="flex items-center gap-8">
            <Button
              variant="ghost"
              size="sm"
              onClick={() => navigate(-1)}
              className="h-14 px-8 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 font-black italic text-[10px] tracking-[0.25em] transition-all group"
            >
              <ArrowLeft className="w-4 h-4 mr-3 group-hover:-translate-x-1 transition-transform" />
              {t('back')}
            </Button>
            <div className="h-14 w-px bg-white/10 hidden md:block" />
            <div className="space-y-1">
              <h1 className="text-4xl font-black italic tracking-tighter leading-none text-white">{t('myListingsTitle')}</h1>
              <p className="text-[10px] font-black text-slate-500 tracking-[0.3em] italic">{t('myListingsSubtitle')}</p>
            </div>
          </div>

          <div className="flex gap-4 w-full md:w-auto">
            <div className="relative flex-1 md:w-80 group">
              <div className="absolute inset-0 bg-blue-500/10 blur-xl opacity-0 group-focus-within:opacity-100 transition-opacity rounded-2xl" />
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-500 w-4 h-4 group-focus-within:text-blue-400 transition-colors" />
              <Input 
                placeholder={t('searchPlaceholder')} 
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="h-14 pl-12 pr-6 rounded-2xl bg-[#1a1b1e]/60 border-white/5 focus:border-blue-500/50 text-[10px] font-black italic tracking-widest text-white shadow-inner"
              />
            </div>
            <Link to="/listings/create">
              <Button className="h-14 px-8 bg-blue-600 hover:bg-blue-500 text-white font-black italic tracking-widest text-[10px] rounded-2xl transition-all shadow-xl shadow-blue-600/20 group/plus">
                <Plus className="w-4 h-4 mr-3 group-hover:rotate-90 transition-transform" />
                {t('myListingsNewlisting')}
              </Button>
            </Link>
          </div>
        </m.div>

        {/* Stats Matrix */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          {[
            { label: t('totalViews'), value: "1,284", icon: Eye, color: "text-blue-500", bg: "bg-blue-500/5" },
            { label: t('activeLeads'), value: "24", icon: TrendingUp, color: "text-emerald-500", bg: "bg-emerald-500/5" },
            { label: t('avgResponse'), value: "2.4H", icon: Clock, color: "text-purple-500", bg: "bg-purple-500/5" },
            { label: t('approveRate'), value: "98%", icon: CheckCircle2, color: "text-amber-500", bg: "bg-amber-500/5" },
          ].map((stat, i) => (
            <m.div
               key={i}
               initial={{ opacity: 0, scale: 0.95 }}
               animate={{ opacity: 1, scale: 1 }}
               transition={{ delay: i * 0.05 }}
            >
              <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[32px] overflow-hidden backdrop-blur-3xl group hover:bg-white/5 transition-all">
                <CardContent className="p-8 flex items-center justify-between">
                  <div className="space-y-2">
                    <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{stat.label}</p>
                    <p className="text-3xl font-black text-white italic tracking-tighter">{stat.value}</p>
                  </div>
                  <div className={cn("p-4 rounded-2xl border border-white/5 shadow-2xl transition-all group-hover:scale-110", stat.bg, stat.color)}>
                    <stat.icon className="w-6 h-6" />
                  </div>
                </CardContent>
              </Card>
            </m.div>
          ))}
        </div>

        {loading ? (
          <div className="space-y-6">
             {[1, 2, 3].map(i => (
               <div key={i} className="h-32 bg-white/5 animate-pulse rounded-[32px] border border-white/5"></div>
             ))}
          </div>
        ) : filteredListings.length > 0 ? (
          <div className="space-y-6">
            <AnimatePresence mode="popLayout">
              {filteredListings.map((listing, index) => (
                <m.div
                  key={listing.id}
                  layout
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  exit={{ opacity: 0, x: 20 }}
                  transition={{ delay: index * 0.05 }}
                >
                  <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[32px] overflow-hidden backdrop-blur-3xl group hover:border-blue-500/30 transition-all hover:shadow-2xl relative">
                    <div className="absolute top-0 left-0 w-full h-full opacity-[0.01] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[20px_20px]"></div>
                    
                    <div className="flex flex-col md:flex-row h-full">
                      <div className="w-full md:w-60 aspect-video md:aspect-square overflow-hidden relative">
                        <Image 
                          src={listing.images?.[0] || 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=800&q=80'} 
                          alt={listing.title}
                          fill
                          loading="lazy"
                          className="object-cover group-hover:scale-110 transition-transform duration-700 brightness-75 group-hover:brightness-100"
                          sizes="240px"
                        />
                        <div className="absolute inset-x-0 bottom-0 p-4 bg-gradient-to-t from-black/80 to-transparent flex justify-center">
                           {getStatusBadge("ACTIVE")}
                        </div>
                      </div>

                      <CardContent className="flex-1 p-8 flex flex-col md:flex-row md:items-center justify-between gap-8 relative z-10">
                        <div className="min-w-0 space-y-4">
                          <div className="space-y-1">
                            <h3 className="text-2xl font-black text-white italic tracking-tighter line-clamp-1 group-hover:text-blue-400 transition-colors">{listing.title}</h3>
                            <div className="flex flex-wrap items-center gap-6">
                              <div className="flex items-center text-slate-500 text-[10px] font-black italic tracking-widest gap-2">
                                <MapPin className="w-3.5 h-3.5 text-blue-500/60" />
                                <span className="truncate">{listing.address || 'NEURAL_LOCATION_HIDDEN'}</span>
                              </div>
                              <div className="flex items-center text-slate-500 text-[10px] font-black italic tracking-widest gap-2">
                                <Activity className="w-3.5 h-3.5 text-emerald-500/60" />
                                <span>{t('viewsToday', { count: 24 })}</span>
                              </div>
                            </div>
                          </div>
                        </div>
                        
                        <div className="flex items-center gap-10">
                          <div className="text-right hidden xl:block space-y-1">
                            <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{t('price')}</p>
                            <p className="text-2xl font-black text-white italic tracking-tighter">${(listing.price || 0).toLocaleString()}</p>
                          </div>
                          
                          <div className="flex items-center gap-3">
                            <Link to={`/property/${listing.id}`}>
                              <Button variant="outline" className="h-12 px-6 rounded-xl border-white/10 bg-white/5 text-white hover:bg-white/10 font-black italic tracking-widest text-[9px] gap-2">
                                <Eye className="w-4 h-4 text-blue-500" />
                                {t('view')}
                              </Button>
                            </Link>
                            
                            <DropdownMenu>
                              <DropdownMenuTrigger asChild>
                                <Button variant="ghost" size="icon" className="h-12 w-12 rounded-xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400">
                                  <MoreVertical className="w-5 h-5" />
                                </Button>
                              </DropdownMenuTrigger>
                              <DropdownMenuContent align="end" className="w-48 bg-[#1a1b1e] border-white/5 p-2 rounded-2xl shadow-3xl text-white">
                                <DropdownMenuItem className="focus:bg-white/5 focus:text-blue-400 cursor-pointer rounded-xl h-11 px-4 text-[10px] font-black italic tracking-widest gap-3">
                                  <Edit3 className="w-4 h-4" />
                                  {t('edit')}
                                </DropdownMenuItem>
                                <DropdownMenuItem className="focus:bg-white/5 focus:text-purple-400 cursor-pointer rounded-xl h-11 px-4 text-[10px] font-black italic tracking-widest gap-3">
                                  <Activity className="w-4 h-4" />
                                  {t('myListingsActionsAnalytics')}
                                </DropdownMenuItem>
                                <DropdownMenuSeparator className="bg-white/5" />
                                <DropdownMenuItem className="focus:bg-red-500/10 focus:text-red-500 cursor-pointer rounded-xl h-11 px-4 text-[10px] font-black italic tracking-widest gap-3">
                                  <Trash2 className="w-4 h-4" />
                                  {t('delete')}
                                </DropdownMenuItem>
                              </DropdownMenuContent>
                            </DropdownMenu>
                          </div>
                        </div>
                      </CardContent>
                    </div>
                  </Card>
                </m.div>
              ))}
            </AnimatePresence>
          </div>
        ) : (
          <m.div 
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            className="text-center py-32 bg-[#1a1b1e]/40 rounded-[64px] border-2 border-dashed border-white/5 backdrop-blur-3xl"
          >
            <div className="inline-flex items-center justify-center w-24 h-24 rounded-[32px] bg-white/5 border border-white/5 mb-8 text-slate-600">
              <Zap className="w-10 h-10" />
            </div>
            <h2 className="text-2xl font-black text-white italic tracking-tighter mb-4">{t('client.myListings.empty.title', { defaultValue: 'NO LISTINGS FOUND' })}</h2>
            <p className="text-[10px] font-black text-slate-500 tracking-widest italic max-w-sm mx-auto mb-10 leading-loose">
              {t('client.myListings.empty.desc', { defaultValue: "You haven't posted any property nodes yet. Ready to initialize your first entry?" })}
            </p>
            <Button className="h-16 px-10 bg-white text-black hover:bg-slate-200 font-black italic text-xs tracking-widest rounded-2xl transition-all shadow-xl hover:scale-105 gap-3">
              <Plus className="w-4 h-4" />
              {t('myListingsNewlisting')}
            </Button>
          </m.div>
        )}
      </div>
    </div>
  );
}
